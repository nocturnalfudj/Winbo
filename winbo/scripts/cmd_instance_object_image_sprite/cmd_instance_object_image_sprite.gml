/// @function cmd_instance_object_image_sprite
/// @summary Change an instance's image sprite via console command.
/// @param _subject The instance whose sprite will change.
/// @param _argument_list [sprite_asset]
/// @returns {void}
function cmd_instance_object_image_sprite(_subject,_argument_list) {
	var _sprite;
	_sprite = _argument_list[| 0];
	
	_sprite = asset_get_index(_sprite);
	if(_sprite == -1){
		sdm("Sprite asset not found",LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"image")){
			image_set_sprite(image,_sprite);
			
			sdm("Image sprite of instance " + string(id) + " set to " + string(_sprite),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have image system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}