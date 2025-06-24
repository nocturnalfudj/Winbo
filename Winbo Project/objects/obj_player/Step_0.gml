//Get Player Input
var xDirection = keyboard_check(vk_right) - keyboard_check(vk_left);
var keyJump = keyboard_check_pressed(vk_up);
var keyJumpReleased = keyboard_check_released(vk_up)
var Grounded = place_meeting (x, y +1, obj_wall)

//Calculate Movement
xMove = xDirection * spd
yMove += grav

//Falling Death
if y >= 950
{
	x = xstart
	y = ystart
	global.xLives -=1
}

//Game Over
if global.xLives < 1
{
	show_message("Game Over")
	global.xLives = 5
	room_goto(Room1)
	global.coins = 0
}

//Jump & Coyote Time
if Grounded
{
	coyoteTime = coyoteTimeMax
}

if !Grounded 
{
	coyoteTime --
}

if keyJump and (Grounded or coyoteTime > 0)
{
	yMove += jumpsp
	coyoteTime = 0
}

if keyJumpReleased
{
	yMove = yMove / 4
}

//Collisions
if place_meeting(x + xMove, y, obj_wall)
{
	while !place_meeting(x + sign(xMove), y, obj_wall)
	{
		x = x+sign(xMove)
	}
	xMove = 0
}

x += xMove

if place_meeting(x, y + yMove, obj_wall)
{
	while !place_meeting(x, y +sign(yMove), obj_wall)
	{
		y = y+sign(yMove)
	}
	yMove = 0
}

y += yMove
