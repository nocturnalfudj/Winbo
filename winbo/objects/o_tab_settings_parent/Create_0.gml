// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.menu,id);
ui_group_set(UIGroup.tab_settings,id);

//Child of Menu Anchor
transform_parent = o_tab_settings.transform_child[transform_parent_anchor_child_id];

#region Scroll
	scroll = new Scroll(0,0);
	scroll.transform_parent = transform_child[0];
#endregion