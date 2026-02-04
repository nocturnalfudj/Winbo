/// @func MultiClientGetAdditionalParameters
/// @desc Retrieves any custom command line parameters used for launching multiple clients
// feather ignore all
function MultiClientGetAdditionalParameters() {
    __MultiClientExtensionTest();
    return string_split(extension_get_option_value("MultiClient", "Additional_Parameters"), " ", true);
}