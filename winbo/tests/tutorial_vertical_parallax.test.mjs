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
    /case "room_bottom":[\s\S]*?director_draw_parallax_layer\([\s\S]*?true\s*\);/,
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
