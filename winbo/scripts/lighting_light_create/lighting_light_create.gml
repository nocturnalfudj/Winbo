/// @function lighting_light_create
/// @summary Spawn a light instance with standard properties.
/// @param _type LightType constant.
/// @param _layer Layer name.
/// @param {real} _x X position.
/// @param {real} _y Y position.
/// @param {real} _scale_x Horizontal scale.
/// @param {real} _scale_y Vertical scale.
/// @param _colour Blend colour.
/// @param {real} _alpha Image alpha.
/// @returns {instance} The light instance created.
function lighting_light_create(_type, _layer, _x, _y, _scale_x, _scale_y, _colour, _alpha) {
	var _id;

	switch(_type) {
		case LightType.spotlight: _id = instance_create_layer(_x,_y,_layer,o_light_spotlight); break;
		case LightType.torch: _id = instance_create_layer(_x,_y,_layer,o_light_torch); break;
		case LightType.rotating: _id = instance_create_layer(_x,_y,_layer,o_light_rotating); break;
		case LightType.sine: _id = instance_create_layer(_x,_y,_layer,o_light_sine); break;
	}

	with(_id) {
		image_xscale = _scale_x;
		image_yscale = _scale_y;
		image_blend = _colour;
		image_alpha = _alpha;
	}

	return(_id);
}