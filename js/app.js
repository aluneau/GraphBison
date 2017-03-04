var ctx = $("#myChart");
var chart;
var equation ="y=0;";
var x_min = -10.5;
var x_max = 10.5;

var y_min = null;
var y_max = null;

var graphMax = 400;
var graphMin = -400;
var autoState=0;

$(document).ready(function(){
  getData();
});


function showError(textError){
  new PNotify({
    title: 'Oh No!',
    text: textError,
    type: 'error',
    delay:1000
  });
}
function getData() {
  // strUrl is whatever URL you need to call
  var strUrl = "", jsonReturn = "";

  jQuery.ajax({
    type: "POST",
    url: "calculus.php",
    data: {"calculus" : equation, "x_min" : x_min, "x_max" : x_max, "step" : (x_max-x_min)* 0.00025},
    success: function(values) {
      jsonReturn = values;
      if(jsonReturn.error){
        showError(jsonReturn.error);
        return [];
      }
      chartUpdate(jsonReturn);
    },
  });
}

var chartUpdate = function(values){
  if(values!=[] && values[0]!=undefined){
    var lines = [];
    var labels = ['x'];
    for (let i=0; i < values.length; i++){
      labels.push(values[i].name);
    }
    for (let i=0; i < values[0].array.length; i++){
      var rows = [];
      rows.push(values[0].array[i][0]);
      for (let j=0; j < values.length; j++){
        rows.push(values[j].array[i][1]);
      }
      lines.push(rows);
    }
    valueRange = [y_min, y_max];

    var g = new Dygraph(document.getElementById("myChart"), lines,
                            {
                              drawPoints: false,
                              showRoller: true,
                              valueRange: valueRange,
                              labels: labels
                            });
  }else{
    showError("Something went wrong with your entry");
  }
};


function update(){
  equation = document.getElementById("equation").value;
  getData();
}

var slider = document.getElementById('slider');

noUiSlider.create(slider, {
	start: [x_min, x_max],
  step : 0.1,
	tooltips: [ wNumb({ decimals: 1 }), true ],
	range: {
		'min': -100,
		'max': 100
	}
});

// var slider2 = document.getElementById('slider2');
// noUiSlider.create(slider2, {
//   start:[graphMin, graphMax],
//   step: 1,
//   tooltips: [wNumb({decimals : 1}), true],
//   range : {
//     'min': graphMin,
//     'max': graphMax
//   }
// })
//
// slider2.noUiSlider.on('change', function(values){
//   if(values[0] == graphMin){
//     y_min = null;
//   }else{
//     y_min = values[0];
//   }
//   if(values[1] == graphMax){
//     y_max = null;
//   }else{
//     y_max = values[1];
//   }
//   chartUpdate(getData());
// });

slider.noUiSlider.on('change', function(values){
  x_min = values[0];
  x_max = values[1];
  getData();
});

function auto(){
  if(autoState==0){
    document.getElementById("number1").disabled="";
    document.getElementById("number2").disabled="";
    y_min = document.getElementById("number1").value;
    y_max = document.getElementById("number2").value;
    autoState=1;
  }else{
    document.getElementById("number1").disabled="disable";
    document.getElementById("number2").disabled="disable";
    y_min = null;
    y_max = null;
    autoState = 0;
  }
  getData();
}

function changeY(){
  y_min = document.getElementById("number1").value;
  y_max = document.getElementById("number2").value;
  getData();
}
