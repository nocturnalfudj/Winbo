/// @function shop_system_draw_cost
/// @summary Draw the shop item's cost UI elements.
function shop_system_draw_cost(){
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x;
	_y = y;
	_angle = image_angle;
	_colour = cost_title_colour;
	_alpha = image_alpha;
	_scale_x = 1;
	_scale_y = 1;
		
	//Position
	_x = x + (cost_title_x - cost_title_x_sep) * _scale_x;
	_y = y + (cost_title_y - cost_title_y_sep) * _scale_y;
		
	//Text Format
	draw_set_font(cost_title_font);
	draw_set_halign(cost_title_halign);
	draw_set_valign(cost_title_valign);
		
	var _cost,_cost_title_string,_cost_icon,_cost_icon_scale;
	var _cost_icon_x,_cost_icon_y;
		
	//Costs
	for(var _i=0;_i<Resource.SIZE;_i++){
		_cost = shop_item_data.cost[_i];
		_cost *= shop_cost_factor[_i];
		_cost_icon = cost_title_icon[_i];
		_cost_icon_scale = cost_title_icon_scale[_i];
		_cost_title_string = cost_title_string[_i];
		if(_cost > 0){
			//Cash Sign
			if((_i == Resource.cash) && (!free))
				_cost_title_string = "$" + _cost_title_string;
				
			//Position
			_x = _x + cost_title_x_sep * _scale_x;
			_y = _y + cost_title_y_sep * _scale_y;
		
			//Shadow
			if(cost_title_shadow_enable){
				//Shadow Position
				var _shadow_x,_shadow_y;
				_shadow_x = _x + cost_title_shadow_x * _scale_x;
				_shadow_y = _y + cost_title_shadow_y * _scale_y;
				
				//Shadow Alpha
				if(cost_title_shadow_alpha != 1)
					draw_set_alpha(_alpha * cost_title_shadow_alpha);
				
				draw_set_color(cost_title_shadow_colour);
				draw_text_transformed(_shadow_x,_shadow_y,_cost_title_string,_scale_x,_scale_y,_angle);
			}
					
			//Colour
			if(cost_title_colour_cant_afford_team == noone){
				_colour = cost_title_colour_can_afford[_i];
			}
			else{
				if(cost_can_afford[_i][cost_title_colour_cant_afford_team])
					_colour = cost_title_colour_can_afford[_i];
				else
					_colour = cost_title_colour_cant_afford;
			}
			
			
			
			draw_set_color(_colour);
					
			//Title Text
			draw_set_alpha(_alpha);
			draw_text_transformed(_x,_y,_cost_title_string,_scale_x,_scale_y,_angle);
				
			#region Icon
				//Position
				_cost_icon_x = _x - 0 * _scale_x;
				_cost_icon_y = _y + 50 * _scale_y;
					
				//Draw Sprite
				draw_sprite_ext(_cost_icon,0,_cost_icon_x,_cost_icon_y,_scale_x*_cost_icon_scale,_scale_y*_cost_icon_scale,_angle,c_white,_alpha);
			#endregion
		}
	}
}