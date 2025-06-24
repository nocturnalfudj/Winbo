if !instance_exists(target)
{
	exit;
}

var targetX = target.x 
var targetY = target.y

camera_set_view_pos(camera, targetX - 960, targetY - 540)