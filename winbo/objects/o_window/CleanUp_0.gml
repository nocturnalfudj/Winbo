//Inherit UI Object Parent
event_inherited();

//Surface Destroy
if(surface_exists(surface)){
	surface_free(surface);
}

//Surface Draw List Destroy
if(ds_exists(surface_draw,ds_type_list)){
	ds_list_destroy(surface_draw);
}