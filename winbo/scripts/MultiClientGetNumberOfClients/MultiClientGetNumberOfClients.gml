/// @function MultiClientGetNumberOfClients
/// @summary Reads the total number of clients specified in the extension options.
/// @returns {real} Configured client count.
// feather ignore all
function MultiClientGetNumberOfClients() {
    __MultiClientExtensionTest();
    return extension_get_option_value("MultiClient", "Number_Of_Clients");
}