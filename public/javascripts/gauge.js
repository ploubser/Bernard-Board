var gaugeArray = new Object;
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


function drawChart(_height, _width, value, div, title) {
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
};

//Custom redraw function
function redrawGauge(value, div){
	gaugeArray[div]['data'].setValue(0,0,value);
	gaugeArray[div].draw(gaugeArray[div]['data'], gaugeOptions);
}
