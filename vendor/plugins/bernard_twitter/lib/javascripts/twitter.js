function validateTwitter(){
	if(jQuery('#form_for input[name=uri]').val() == ""){ 
		alert("Feed Uri field cannot be empty");
		return false;
	}
	return true;
}

function update_twitterfeed(size){
	 jQuery('#twitterfeed0').show();
	 var feedSize = size;
	 var currentFeed = 0;
	 var interval = setInterval(function(){ 
	 	jQuery('.twitterfeed').hide();
		jQuery('#twitterfeed' + currentFeed).show(); 
		//This deals with the sudden destruction of the dom object 
		//Implemented to handle delete from rightclick menu
		if(jQuery('#twitterfeed' + currentFeed).attr("id") == null){ 
			clearInterval(interval);
		}
		if(currentFeed < feedSize -1){
			currentFeed++;
		}
		else{
			currentFeed = 0;
		}
	}, 10000);
}
