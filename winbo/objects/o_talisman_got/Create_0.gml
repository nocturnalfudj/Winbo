// "Talisman Got" sequence. Created by pickup_collect_talisman with talisman_id
// already set; it owns the frozen cutscene state until the room changes.
enum TalismanGotPhase{
	fade_to_white,
	play,
	exit_to_door,
	exit_in_place
}

#macro TALISMAN_GOT_FPS 30
#macro TALISMAN_GOT_FADE_TIME (SECOND * 0.9)
// Andy's talisman sequences start on frame 17 of the background video and loop 112-193.
#macro TALISMAN_GOT_FIRST_FRAME 17
#macro TALISMAN_GOT_LOOP_START 112
#macro TALISMAN_GOT_LOOP_END 193
// The background loops from the end of its first sparkle set (frame 101) to its last frame.
#macro TALISMAN_GOT_VIDEO_LOOP_MS (101 * 1000 / TALISMAN_GOT_FPS)
#macro TALISMAN_GOT_VIDEO_PATH "video/talisman_got_bg.mp4"

talisman_sprites = [
	spr_talisman_got_0, spr_talisman_got_1, spr_talisman_got_2, spr_talisman_got_3,
	spr_talisman_got_4, spr_talisman_got_5, spr_talisman_got_6, spr_talisman_got_7,
	spr_talisman_got_8, spr_talisman_got_9, spr_talisman_got_10, spr_talisman_got_11,
	spr_talisman_got_12, spr_talisman_got_13
];
talisman_sprite = talisman_sprites[talisman_id];
texture_group = "talisman_got_" + string(talisman_id);

phase = TalismanGotPhase.fade_to_white;
fade_time = 0;
video_opened = false;
play_time = 0;
video_chroma_sampler = shader_get_sampler_index(sh_video_yuv, "v_chroma");
