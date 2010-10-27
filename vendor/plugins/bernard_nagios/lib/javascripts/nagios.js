function validateNagios(){
	if(jQuery('#form_for input[name=uri]').val() == ""){
		alert("Uri field cannot be empty");
		return false;
	}
	else if(jQuery('#form_for input[name=username]').val() == ""){
		alert("Username field cannot be empty");
		return false;
	}
	else if(jQuery('#form_for input[name=password]').val() == ""){
		alert("Password field cannot be empty");
		return false;
	}

	return true;
}
