import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";

const environmentSource = readFileSync(
  new URL(
    "../scripts/director_environment_data_setup/director_environment_data_setup.gml",
    import.meta.url,
  ),
  "utf8",
);
const backgroundDrawSource = readFileSync(
  new URL("../objects/o_director/Draw_72.gml", import.meta.url),
  "utf8",
);

const tutorialSource = environmentSource.match(
  /#region Tutorial(?<body>[\s\S]*?)#endregion/,
)?.groups?.body;

assert.ok(tutorialSource, "Tutorial environment configuration was not found");

const layerPattern =
  /\{mode: "(?<mode>[^"]+)", sprite: spr_bg_tutorial_layer_(?<layer>\d), parallax_x: (?<parallaxX>[\d.]+), parallax_y: _gameplay_bg_parallax_y\((?<parallaxYInput>[\d.]+)\), offset_y: (?<offsetY>-?[\d.]+|_new_bg_offset_y), repeat_x: true, clamp_top: (?<clampTop>true|false), clamp_bottom: (?<clampBottom>true|false)\}/g;

const layers = [...tutorialSource.matchAll(layerPattern)].map(({ groups }) => ({
  mode: groups.mode,
  layer: Number(groups.layer),
  parallaxX: Number(groups.parallaxX),
  parallaxY: Math.min(
    0.8,
    Math.max(0.6, 0.4 + 0.4 * Number(groups.parallaxYInput)),
  ),
  offsetY:
    groups.offsetY === "_new_bg_offset_y" ? -120 : Number(groups.offsetY),
  clampTop: groups.clampTop === "true",
  clampBottom: groups.clampBottom === "true",
}));

const roomHeight = 10_000;
const spriteHeight = 4_320;
const cameraHeight = 2_160;
const cameraBottomY = roomHeight - cameraHeight;

function screenY(layer, cameraY) {
  let baseY;
  if (layer.mode === "room_bottom") {
    baseY =
      roomHeight -
      spriteHeight +
      layer.offsetY +
      (cameraY - cameraBottomY) * layer.parallaxY;
  } else {
    baseY = cameraY * layer.parallaxY + layer.offsetY;
    if (layer.clampBottom) {
      baseY = Math.max(baseY, cameraY + cameraHeight - spriteHeight);
    }
    if (layer.clampTop) {
      baseY = Math.min(baseY, cameraY);
    }
  }
  return baseY - cameraY;
}

test("tutorial layers stay aligned and move continuously on the vertical axis", () => {
  assert.equal(layers.length, 4);
  assert.match(
    backgroundDrawSource,
    /case "room_bottom":[\s\S]*?director_draw_parallax_layer\([\s\S]*?room_height\s*\);/,
    "the room-bottom mode must be wired into the background draw pass",
  );
  assert.deepEqual(
    layers.map(({ layer, parallaxX }) => [layer, parallaxX]),
    [
      [4, 1],
      [3, 0.85],
      [2, 0.7],
      [1, 0.55],
    ],
    "horizontal parallax must remain unchanged",
  );

  const startPositions = layers.map((layer) =>
    screenY(layer, cameraBottomY),
  );
  assert.deepEqual(
    startPositions,
    [-cameraHeight, -cameraHeight, -cameraHeight, -cameraHeight],
    "the authored layer canvases must align at the tutorial start",
  );

  const raisedCameraY = cameraBottomY - 500;
  const movement = layers.map(
    (layer, index) => screenY(layer, raisedCameraY) - startPositions[index],
  );
  assert.deepEqual(
    movement,
    [100, 130, 160, 190],
    "vertical movement must follow the authored parallax factors without clamp latching",
  );
});

// Gameplay levels anchor every layer at the camera framing the authored start.
const startViewBottom = (playerStartY) => playerStartY - 250 + (2160 * 0.9) / 2;

function gameplayLevel(regionName) {
  const body = environmentSource.match(
    new RegExp(`#region ${regionName}(?<body>[\\s\\S]*?)#endregion`),
  )?.groups?.body;
  assert.ok(body, `${regionName} environment configuration was not found`);
  const anchorStartY = body.match(
    /parallax_anchor_bottom_y = _start_view_bottom_y\((?<y>\d+)\);/,
  )?.groups?.y;
  assert.ok(anchorStartY, `${regionName} must anchor to its authored start`);
  const layers = [...body.matchAll(/\{[^{}]*sprite:[^{}]*\}/g)].map(([block]) => {
    const field = (name) => block.match(new RegExp(`${name}: ([^,\\s}]+)`))[1];
    return {
      sprite: field("sprite"),
      parallaxY: Math.min(
        0.8,
        Math.max(
          0.6,
          0.4 + 0.4 * Number(block.match(/_gameplay_bg_parallax_y\(([\d.]+)\)/)[1]),
        ),
      ),
      offsetY: Number(field("offset_y")),
      clampTop: field("clamp_top") === "true",
      clampBottom: field("clamp_bottom") === "true",
    };
  });
  return { startY: Number(anchorStartY), anchor: startViewBottom(Number(anchorStartY)), layers };
}

function anchoredScreenY(layer, anchor, cameraY, viewHeight) {
  const cameraBottomY = cameraY + viewHeight;
  let baseY =
    cameraBottomY - spriteHeight + layer.offsetY +
    (anchor - cameraBottomY) * (1 - layer.parallaxY);
  if (layer.clampBottom) baseY = Math.max(baseY, cameraBottomY - spriteHeight);
  if (layer.clampTop) baseY = Math.min(baseY, cameraY);
  return baseY - cameraY;
}

const round = (value) => Math.round(value * 1000) / 1000;

for (const [regionName, levelRoomHeight] of [["Level 1", 15_000], ["Level 2", 27_500]]) {
  test(`${regionName} layers compose at the authored start and parallax across traversal`, () => {
    const { startY, anchor, layers } = gameplayLevel(regionName);
    assert.ok(layers.length >= 6);
    assert.match(
      backgroundDrawSource,
      /case "normal":[\s\S]*?_environment_data\.parallax_anchor_bottom_y/,
    );

    for (const viewHeight of [1944, 2160, 2245]) {
      const startCameraY = startY - 250 - viewHeight / 2;
      assert.deepEqual(
        layers.map((layer) => anchoredScreenY(layer, anchor, startCameraY, viewHeight)),
        layers.map(() => viewHeight - spriteHeight),
        `authored canvases must align at the start for a ${viewHeight}px view`,
      );

      for (let cameraY = 0; cameraY <= levelRoomHeight - viewHeight; cameraY += 25) {
        for (const layer of layers) {
          const top = anchoredScreenY(layer, anchor, cameraY, viewHeight);
          assert.ok(top + spriteHeight >= viewHeight, `${layer.sprite} leaves a band at y ${cameraY}`);
          if (layer.sprite.endsWith("_sky")) {
            assert.ok(top <= 0, `sky leaves a band at y ${cameraY}`);
          }
        }
      }
    }

    const startCameraY = anchor - 1944;
    assert.deepEqual(
      layers.map((layer) =>
        round(
          anchoredScreenY(layer, anchor, startCameraY - 500, 1944) -
            anchoredScreenY(layer, anchor, startCameraY, 1944),
        ),
      ),
      layers.map((layer) => round(500 * (1 - layer.parallaxY))),
      "climbing from the start must follow the authored parallax factors",
    );
  });
}

test("Level 2 shore stays seated on the river while the river is on screen", () => {
  const { anchor, layers } = gameplayLevel("Level 2");
  const shore = layers.find(({ sprite }) => sprite === "spr_bg_l2_layer_2_shore");
  const river = layers.find(({ sprite }) => sprite === "spr_bg_l2_layer_1_river");
  const shoreBottomRow = 3_872;
  const riverTopRow = 3_826;
  for (let cameraY = 0; cameraY <= 27_500 - 1944; cameraY += 25) {
    const riverTop = anchoredScreenY(river, anchor, cameraY, 1944) + riverTopRow;
    if (riverTop >= 1944) continue;
    assert.ok(
      anchoredScreenY(shore, anchor, cameraY, 1944) + shoreBottomRow >= riverTop,
      `a gap opens between shore and river at y ${cameraY}`,
    );
  }
});
