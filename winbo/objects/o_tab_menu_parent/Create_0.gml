// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.menu,id);

//Child of Menu Anchor
transform_parent = o_anchor_menu.transform_child[transform_parent_anchor_child_id];

#region Scroll
	scroll = new Scroll(0,0);
	scroll.transform_parent = transform_child[0];
#endregion