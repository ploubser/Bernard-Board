function validateImage(){
	if(jQuery('#form_for input[name=remote]').attr("checked") == true && jQuery('#form_for input[name=url]').val() == ""){	
		alert("Url field cannot be empty");
		return false;
	}
	else if(jQuery('#form_for input[name=image]').val() == ""){ 
		alert("Image Location field cannot be empty");
		return false;
	}
	return true;

}
