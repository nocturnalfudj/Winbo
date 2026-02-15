// o_actor.Create allocates a unique path per instance; delete it to avoid leaking path resources.
if (path_exists(path_finding_path)) {
	path_delete(path_finding_path);
}
