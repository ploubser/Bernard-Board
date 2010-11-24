function validateCalendar() {
	if(jQuery('#form_for input[name=usrname]').val() == ""){
		alert("Username field cannot be empty");
		return false;
	}
	else if (jQuery('#form_for input[name=passwrd]').val() ==""){
		alert("Password field cannot be empty");
		return false;
	}
	return true;
}

function update_calendar(size, id, toShow){
	for(i = 0; i < toShow; i++){
		jQuery('#calevent' + i + id).show();
	}
	var currentEvent = 0;
	var container = null;
	var interval = setInterval(function(){
		jQuery('.calevent' + id).hide();
		for(i = currentEvent; i < currentEvent + toShow; i++){
			jQuery('#calevent' + i + id).show();
		}
		container = jQuery('#calevent' + currentEvent + id).parent().parent();
		if(jQuery(container).attr("id") == null){
			clearInterval(interval);
		}
		if((currentEvent + toShow) < size){
			currentEvent++;
		}
		else{
			currentEvent = 0;
		}
	},5000);
}
