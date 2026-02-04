/// @function epoch_second_span
/// @summary Seconds elapsed since the epoch datetime.
function epoch_second_span() {
	return round(date_second_span(global.datetime_epoch,date_current_datetime()));
}

/// @function epoch_update
/// @summary Update the stored epoch time if the date has changed.
function epoch_update() {
	exit;
	if((date_get_year(date_current_datetime()) > epoch_year()) || ((date_get_year(date_current_datetime()) == epoch_year()) && (date_get_month(date_current_datetime()) > epoch_month()))){epoch_check();
	}
}