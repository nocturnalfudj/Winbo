// Room Start follows every room instance's Create and creation code. Rebuild
// once here; runtime additions join through the existing count-change check.
if(id == instance_find(o_volume_liquid, 0)) volume_liquid_body_rebuild();
