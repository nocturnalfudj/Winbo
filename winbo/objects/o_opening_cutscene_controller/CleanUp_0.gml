if(instance_number(o_player) > 0) {
	var _player;
	_player = instance_find(o_player,0);
	_player.visible = true;
}
if(instance_number(o_camera) > 0) o_camera.lighting_enable = lighting_was_enabled;
