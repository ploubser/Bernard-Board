var popup = 0; //show popup = false
var lastTarget = ""; //last clicked item

//Allows for ajax pagination with the will_paginate plugin
function bindPaginate(){
	jQuery('.pagination a').click(function(e) {
		new Ajax.Request(jQuery(this).attr('href'), {method: 'get'});
		e.preventDefault();
	});
}

jQuery(document).ready(function() {

	bindPaginate();
	jQuery('.options').draggable({'revert' : false, 'zindex' : 350})
	jQuery('.minimise').dblclick(function() {
		jQuery('.optionscontents').toggle();
		}
	)
	jQuery(document).keypress(function(e){
		if(e.keyCode==27 && popup==1){
			disablePopup();
		}
	});
	jQuery(".popupClose").click(function(){
		disablePopup();
	});
	
	jQuery(".vmenuitem").hover(
		function(e) {
			jQuery(this).css(
				"background-color", "#CDB79E"
			)
		},
		function(e) {
			jQuery(this).css(
				"background-color", "black"
			);
		}
	);
	jQuery('#type').change(); //Need the onchange event on page load to load a form for the initial selected plugin type

	jQuery("#deleteitem").click(function(e){
		jQuery(lastTarget).remove();	
		jQuery("#vmenu").toggle();
		jQuery('#results-content').empty();
	});

	jQuery("#edititem").click(function(e){
		centerPopup('popup');
		loadPopup('popup');
		form = document.getElementById('select_form');
		type = jQuery(lastTarget).data('data').type
		for(var i=0; i < form.type.length; i++){
			if(form.type[i].value == type.capitalize()){
				form.type[i].selected = true;
			}
		}
		type = document.getElementById(form.type.id)
		jQuery(type).change();
		alert("Loading item ->" + jQuery(lastTarget).data('data').title);
		jQuery('.create').hide();
		jQuery('.update').show();
		jQuery('#form_for input[name=title]').val(jQuery(lastTarget).data('data').title);
		jQuery('#form_for input[name=height]').val(jQuery(lastTarget).height());
		jQuery('#form_for input[name=width]').val(jQuery(lastTarget).width());
		jQuery('#form_for input[name=refresh_rate]').val(jQuery(lastTarget).data('data').refresh_rate);
		var paramArray = jQuery(lastTarget).data('data').params.split(";");

		for(var i = 0; i < paramArray.length; i++) {
			var ithParam = paramArray[i].split(":");
			jQuery('#form_for input[name=' + ithParam[0] + ']').val(ithParam[1]);
		}
	
	}); 

	jQuery(document).click(function() {
		jQuery("#vmenu").hide();
	});


})

function loadPopup(div){
	divid = document.getElementById(div)
	if(popup ==0){
		jQuery(divid).fadeIn("slow");
		popup = 1;
	}
}

function disablePopup(){
	if(popup == 1){
		jQuery("#popup").fadeOut("slow", function() {
			jQuery('.create').show();
			jQuery('.update').hide();
		});
		jQuery("#save").fadeOut("slow");
		jQuery("#load").fadeOut("slow");
		popup = 0;
	}
}

function centerPopup(div){
	divid = document.getElementById(div)
	var windowWidth = document.documentElement.clientWidth; 
	var windowHeight = document.documentElement.clientHeight; 
	var popupHeight = jQuery(divid).height(); 
	var popupWidth = jQuery(divid).width();
	jQuery(divid).css({
		"position" : "absolute",
		"top" : windowHeight / 2 - popupHeight / 2,
		"left": windowWidth / 2 - popupWidth / 2
	})
}

function open_popup(div) {
	centerPopup(div);
	loadPopup(div);
}

function open_config(item) {
	centerPopup();
	loadPopup();
}

//Item details in config pane.
function enableEvents(e) {
	item = document.getElementById(e)
	display = document.getElementById('results-content')
	
	display.innerHTML = 'x-axis : ' + jQuery(item).offset().left + '<br>'
	+ 'y-axis : ' + jQuery(item).offset().top + '<br>'
	+ 'Height : ' + (Element.getHeight(item)  - 4) + '<br>' 
	+ 'Width : ' + (Element.getWidth(item) - 4) + '<br>'

	jQuery(item).mouseup(function(){
					jQuery(item).css({"border-color" : "white"})
				}
	)
	
	jQuery(item).mousedown(function(){ 
					jQuery(item).css({"border-color" : "red"})
				}
	)

}

function saveDetails(item, params, type, refresh_rate, title, height, width){
	data = {"itemname" : item,
		"params" : params,
		"type" : type,
		"refresh_rate" : refresh_rate,
		"title" : title,
		"height" : height,
		"width" : width
	       };
	item_in_dom = document.getElementById(item);
	jQuery(item_in_dom).data('data', data);

}

//Finding it easier to generate a json string instead of stringifying an object. Might change this in a future version
function json(auth_token, board_name, board_height, board_width) {
 var AUTH_TOKEN = auth_token;
        items = jQuery('.item')
        var message = '{' 
        var num = 0 

        jQuery.each(items, function() {
                 if(num != 0){ 
                        message = message + ',' 
                 }
                message = message + '"' + jQuery(this).attr('id') + '": {'
                message = message + '"type" : "' + (jQuery(this).data('data').type) + '",'
                message = message + '"height" : "' + jQuery(this).height() + '",'
                message = message + '"width" : "' + jQuery(this).width() + '",'
                message = message + '"left" : "' + (jQuery(this).offset().left) + '",'
                message = message + '"refresh_rate" : "' + (jQuery(this).data('data').refresh_rate) + '",'
                message = message + '"params" : "' + (encodeURIComponent(jQuery(this).data('data').params)) + '",'
                message = message + '"title" : "' + (jQuery(this).data('data').title) + '",'
                message = message + '"top" : "' + (jQuery(this).offset().top) + '"}'
                num = num + 1 
        })
        message = message + '}'
	disablePopup();
        jQuery.post('save_state', 'json=' + message + '&' + 'authenticity_token=' + AUTH_TOKEN + '&' + 'board_name=' + jQuery(board_name).val() + '&' + 'board_height=' + jQuery(board_height).val() + '&' + 'board_width=' + jQuery(board_width).val());
}

//We do not want items to be draggable or resizable when state is in view mode. 
function initItems(item, content, type, state) {
	if(state == "config") {
		e = document.getElementById(item)
		jQuery(e).draggable({revert: 'invalid', 
				     containment: jQuery('.container'),

		});
		jQuery('#container').droppable({accept : '.item',tolerance : 'fit'});

		jQuery(e).resizable({ handles: 'nw, ne, sw,se' , 
				      containment: jQuery('.container'), 
				   }					
				     
		);

		jQuery(".item").bind("contextmenu", function(e) {
			jQuery("#vmenu").css({
				top: e.pageY + 'px',
				left: e.pageX + 'px'
			}).show();
			return false;
		});

		jQuery(".item").mousedown(function(e) {
			if(e.which == 3){
				lastTarget = this;
			}
		});
		
	}
	else {
		jQuery('.options').hide();
	}
}

//Need this to reposition items after a state has been reloaded
function positionItem(item, x, y){
	i = document.getElementById(item)
	jQuery(i).offset({top : y, left : x })
}

//Validate general form fields.
//Try find a way around using an eval 
function validateForm(){
	var returnVal = true;

	if(jQuery('#form_for input[name=title]').val() == ""){
		alert("Title field cannot be empty");
		returnVal = false;
	}
	else if(jQuery('#form_for input[name=height]').val() == ""){
		alert("Height field cannot be empty");
		returnVal = false;
	}
	else if(jQuery('#form_for input[name=width]').val() == ""){
		alert("Width field cannot be empty");
		returnVal = false;
	}
	else if (jQuery('#form_for input[name=refresh_rate]').val() == ""){
		alert("Refresh rate cannot be empty. (If you do not want the plugin to refresh, set rate to 0)");
		returnVal = false;
	}

	if(isNaN(jQuery('#form_for input[name=width]').val())){
		alert("Width must be an integer value.");
		returnVal = false;
	}
	if(isNaN(jQuery('#form_for input[name=height]').val())){ 
		alert("Height must be an integer value.");
		returnVal = false; 
	}
	if(isNaN(jQuery('#form_for input[name=refresh_rate]').val())){
		alert("Refresh Rate must be an integer value.");
		returnVal = false;
	}

	if(returnVal != false){
		returnVal = eval("validate" + jQuery('#type').val() + "();")
	}

	return returnVal;

}
