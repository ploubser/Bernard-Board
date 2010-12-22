var gaugeArray = new Object;
var refresh_rate = 0;
google.load('visualization', '1', {packages:['gauge']}); 

function validateGauge(){
	if(jQuery('#form_for input[name=remote]').attr("checked") == true && jQuery('#form_for input[name=url]').val() == ""){
			alert("Url field cannot be empty");
			return false;
	}
	else if(jQuery('#form_for input[name=path]').val() == ""){
		alert("Path field cannot be empty");
		return false;
	}
	return true;
}


function drawChart(_height, _width, div, title, remote, path, rate) {
	refresh_rate = rate * 1000
	gaugeArray[div] = new google.visualization.Gauge(document.getElementById(div));
	gaugeArray[div]['data'] = new google.visualization.DataTable();
	gaugeArray[div]['data'].addColumn('number', title);
	gaugeArray[div]['data'].addRows(1);
	gaugeArray[div]['data'].setCell(0,0,100);

	gaugeOptions = {
		min: 0,
		max: 100,
		yellowFrom: 70,
		yellowTo: 90, 
		redFrom: 90,
		redTo: 100
	};
	gaugeArray[div].draw(gaugeArray[div]['data'], gaugeOptions);
	redrawGauge(0, div, remote, path)
	
};

//Custom redraw function
function redrawGauge(point, div, remote, path){
	if(remote == ""){
		var url = path
		var data = "";
	}
	else
	{
		var url = "get_gaugejson"
		var data = "url=" +path
	}
	jQuery.ajax({
		url: url,
		data: data,
		dataType: 'json',
		success: function(point) {
			gaugeArray[div]['data'].setValue(0,0,point);
			gaugeArray[div].draw(gaugeArray[div]['data'], gaugeOptions);
			timeout = setTimeout(function(){
				if(jQuery(document.getElementById(div)).attr("id") == null){
					 clearTimeout(timeout);
				}
				else{
					redrawGauge(point, div, remote, path)
				}
			}, refresh_rate);
		}, cache: false
	});
}
