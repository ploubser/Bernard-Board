function validateTwitter(){
	if(jQuery('#form_for input[name=uri]').val() == ""){ 
		alert("Feed Uri field cannot be empty");
		return false;
	}
	return true;
}

function update_twitterfeed(size, id){
	 jQuery('#twitterfeed0' + id).show();
	 var feedSize = size;
	 var currentFeed = 0;
	 var interval = setInterval(function(){ 
	 	jQuery('.twitterfeed' + id).hide();
		jQuery('#twitterfeed' + currentFeed + id).show(); 
		//This deals with the sudden destruction of the dom object 
		//Implemented to handle delete from rightclick menu
		if(jQuery('#twitterfeed' + currentFeed + id).attr("id") == null){ 
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
