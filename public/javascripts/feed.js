/* 	Feed plugin javascript functions
	Pieter Loubser
	October 2010
	Version 0.03
*/

var lastTarget = "";

//Update feed item periodically.
// - currently hardcoded at 10s.
function update_feed(size){
	jQuery('#feed0').show();
	var feedSize = size;
	var currentFeed = 0;
	var container = null;
	var interval = setInterval(function(){
		jQuery('.feed').hide();
		jQuery('#feed' + currentFeed).show();
		container = jQuery('#feed' + currentFeed).parent().parent();
		//This deals with the sudden descruction of the item container
		//Implemented to handle delete from rightclick menu
		if(jQuery(container).attr("id") == null){
			clearInterval(interval);
		}
		else{
			resizeText(container, currentFeed);
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
function resizeText(container, currentFeed){ 
	var max = 12; //Default max font size. Might change. #Issue 6
	jQuery('#feed-description' + currentFeed).wrapInner('<div id="fontfit' + currentFeed + '"></div>');
	var dheight = jQuery(container).height() - jQuery('#feed-header' + currentFeed).height();
	var cheight = jQuery("#fontfit" + currentFeed).height();
	var fsize = ((jQuery('#feed-description' + currentFeed).css("font-size")).slice(0,-2))*1; 
	while(cheight<dheight-jQuery(container).css("borderWidth").slice(0,-2)*2 && fsize<max) {
		fsize+=1;
		jQuery('#feed-description' + currentFeed).css("font-size",fsize+"px"); 
		cheight = jQuery("#fontfit" + currentFeed).height();
	}
	while(cheight>dheight-jQuery(container).css("borderWidth").slice(0,-2)*2 || fsize>max && fsize > 1) {
		fsize-=1;
		jQuery('#feed-description' + currentFeed).css("font-size",fsize+"px");
		cheight = jQuery("#fontfit"+ currentFeed).height();
	}
}
