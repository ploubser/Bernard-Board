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
