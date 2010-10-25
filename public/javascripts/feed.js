//Update feed item periodically.
// - currently hardcoded at 10s.
function update_feed(size, id){
	alert(id);
	jQuery('#feed0' + id).show();
	var feedSize = size;
	var currentFeed = 0;
	var container = null;
	var interval = setInterval(function(){
		jQuery('.feed'+ id).hide();
		jQuery('#feed' + currentFeed + id).show();
		container = jQuery('#feed' + currentFeed + id).parent().parent();
		//This deals with the sudden descruction of the item container
		//Implemented to handle delete from rightclick menu
		if(jQuery(container).attr("id") == null){
			clearInterval(interval);
		}
		else{
			resizeText(container, currentFeed, id);
		}

		if(currentFeed < feedSize -1){
			currentFeed++;
		}
		else{
			currentFeed = 0;
		}
	}, 10000);
}

//Resize feed story text to fit in container
function resizeText(container, currentFeed, id){ 
	var max = 12; //Default max font size. Might change. #Issue 6
	jQuery('#feed-description' + currentFeed + id).wrapInner('<div id="fontfit' + currentFeed + id + '"></div>');
	var dheight = jQuery(container).height() - jQuery('#feed-header' + currentFeed + id).height();
	var cheight = jQuery("#fontfit" + currentFeed + id).height();
	var fsize = ((jQuery('#feed-description' + currentFeed + id).css("font-size")).slice(0,-2))*1; 
	while(cheight<dheight-jQuery(container).css("borderWidth").slice(0,-2)*2 && fsize<max) {
		fsize+=1;
		jQuery('#feed-description' + currentFeed + id).css("font-size",fsize+"px"); 
		cheight = jQuery("#fontfit" + currentFeed + id).height();
	}
	while(cheight>dheight-jQuery(container).css("borderWidth").slice(0,-2)*2 || fsize>max && fsize > 1) {
		fsize-=1;
		jQuery('#feed-description' + currentFeed + id).css("font-size",fsize+"px");
		cheight = jQuery("#fontfit"+ currentFeed + id).height();
	}
}

function validateFeed(){
	if(jQuery('#form_for input[name=uri]').val() == ""){
		alert("RSS url field cannot be empty");
		return false;
	}
	return true;
}
