//"use strict"

var position = 0;

var direction = 1;      // 1: forward, 0: reverse


/*Objects Aggregates*/
var Aggregate = function(tablecontent){
    this.tablecontent = tablecontent;
    this.reported_aggregate =0;
    this.registered_aggregate=0;
    this.printed_aggregate =0;
    this.verified_aggregate =0;
    this.re_printed_aggregate = 0;
    this.incomplete_aggregate = 0;
    this.supected_duplicates_aggregate = 0;
    this.amendement_request_aggregate =0;
}
Aggregate.prototype.setAggregates = function(){
    for(var i in this.tablecontent){
        this.reported_aggregate = this.reported_aggregate + array_sum(this.tablecontent[i].reported);
        this.registered_aggregate = this.registered_aggregate + array_sum(this.tablecontent[i].registered);
        this.printed_aggregate =this.printed_aggregate+this.tablecontent[i].printed;
        this.verified_aggregate =this.verified_aggregate+this.tablecontent[i].verified;
        this.re_printed_aggregate = this.re_printed_aggregate+this.tablecontent[i].re_printed;
        this.incomplete_aggregate = this.incomplete_aggregate+this.tablecontent[i].incomplete;
        this.supected_duplicates_aggregate = this.supected_duplicates_aggregate+this.tablecontent[i].supected_duplicates;
        this.amendement_request_aggregate = this.amendement_request_aggregate+this.tablecontent[i].amendement_request;
    }
}
function __$(id) {
    return document.getElementById(id);
}

function resize() {

    if (__$("main")) {
        __$("scroll").style.height = (window.innerHeight - 80) + "px";    
        __$("main").style.height = (window.innerHeight - 0) + "px";

    }

}
/* HighChart Function**/
function drawMiniGraph(id, reported, registered){
   $(id).highcharts({
        chart:{
            spacingBottom: 0,
            spacingTop: 0,
            spacingLeft: 0,
            spacingRight: 0,
            width: 150,
            height: 45
        },
        title: {
            text: ''
            //center
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'],
            labels: {
                     enabled: false
            },
            title:{
                    enabled:false
            },
            axis:{
                    enabled:false
            }

        },
        yAxis: {
            title: {
                text: ''
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }],
             labels: {
                     enabled: false
            },
            title:{
                    enabled:false
            },
            axis:{
                    enabled:false
            }
            ,
            min: 0
        },
        legend: {
            enabled:false
        }
         ,
        tooltip: {
            enabled: false
        }
        ,
        series: [{
            name: 'Reported',

            color : '#729fcf',
            data: registered
        } ]
    });

}

function drawReportToRegisterChart(id,registered,reported){

        $(function () {
                var percent_registered = (registered/reported) * 100;
                $(id).highcharts({

                    chart:{
                        type:"bar",
                        spacingBottom: 0,
                        spacingTop: 0,
                        spacingLeft: 0,
                        spacingRight: 0,
                        width: 150,
                        height: 45,
                        margin: [0, 0, 0, 0]

                    },
                    title: {
                            text: ''
                    }
                    ,
                    xAxis:{
                          labels: {
                            enabled: false
                        }
                    },
                    yAxis:{
                        labels: {
                            enabled: false
                        },
                        title:{
                            enabled:false
                        },
                        axis:{
                            enabled:false
                        },
                        min: 0,
                        max: 100

                    },

                    legend: {
                                enabled: false
                     }
                    ,

                    tooltip: {
                            enabled: false
                    },
                    plotOptions: {
                            bar: {
                                grouping: false,
                                shadow: false,
                                borderWidth: 0
                            }
                        }
                    ,
                     series: [{
                                    name: 'reported ',
                                    color: '#cfe7f8',
                                    data: [100],
                                    pointPadding: -0.09
                                },
                                {
                                    name: 'registered',
                                    color:'#729fcf',
                                    data : [percent_registered],
                                    pointPadding: 0.25
                                }
                            ]

                });
        });
    }


function drawPieChart(ever_registered, ever_reported,ever_printed){

            var total = ever_registered + ever_reported + ever_printed;
            ever_registered_percent = (ever_registered/total)*100;

            ever_registered_percent = ever_registered_percent.toFixed(1);

            ever_printed_percent = (ever_printed/total) * 100;
            ever_printed_percent = ever_printed_percent.toFixed(1);

            var ever_reported_percent = (100 - ever_registered_percent - ever_printed_percent).toFixed(1);
            // Make monochrome colors and set them as default for all pies
            Highcharts.getOptions().plotOptions.pie.colors = (function () {
                var colors = [],
                    base = Highcharts.getOptions().colors[0],
                    i;

                for (i = 0; i < 10; i += 1) {
                    // Start out with a darkened base color (negative brighten), and end
                    // up with a much brighter color
                    colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
                }
                return colors;
            }());

            // Build the chart
            $('#piechart').highcharts({
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: '<font style="color:#004586;font-size:0.75em;font-weight:bold">National Total Reported, Total Registered, Printed</font>',
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>:<br> {point.percentage:.1f} %',
                            style: {
                                color:[ (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black']
                            }
                        }
                    }
                },
                series: [{
                    name: "People",

                    data: [

                        {
                            name: "Registered",
                            color:'#729fcf',
                            y: parseFloat(ever_registered_percent)
                        },
                        {
                            name: "Reported",
                            color: '#cfe7f5',
                            y: parseFloat(ever_reported_percent)
                        },
                        {
                            name: "Printed",
                            y:parseFloat(ever_printed_percent)
                        }

                    ]
                }]
            });

}



function drawRightChart(monthly,yearly){
            aggregates("#monthly_reported", monthly.reported_aggregate, monthly.reported_aggregate);
            aggregates("#annual_reported", yearly.reported_aggregate, yearly.reported_aggregate);



            aggregates("#monthly_printed",monthly.printed_aggregate,monthly.reported_aggregate);
             aggregates("#annual_printed",yearly.printed_aggregate,yearly.reported_aggregate);


            aggregates("#monthly_verified",monthly.verified_aggregate,monthly.reported_aggregate);
            aggregates("#annual_verified",yearly.verified_aggregate,yearly.reported_aggregate);


            aggregates("#monthly_re_printed",monthly.re_printed_aggregate,monthly.reported_aggregate);
            aggregates("#annual_re_printed",yearly.re_printed_aggregate,yearly.reported_aggregate);



             aggregates("#monthly_incomplete",monthly.incomplete_aggregate,monthly.reported_aggregate);
             aggregates("#annual_incomplete",yearly.incomplete_aggregate,yearly.reported_aggregate);


             aggregates("#monthly_supected_duplicates",monthly.supected_duplicates_aggregate,monthly.reported_aggregate);
              aggregates("#annual_supected_duplicates",yearly.supected_duplicates_aggregate,yearly.reported_aggregate);



             aggregates("#monthly_amendement",monthly.amendement_request_aggregate,monthly.reported_aggregate);
             aggregates("#annual_amendement",yearly.amendement_request_aggregate,yearly.reported_aggregate);
}
 function aggregates(id, value, reported){
        var percent = (value/reported) *100;
        var perId = id+"_percent";
        html = value + " ("+ parseInt(percent)+"%)";
        $(perId).html(html);
        drawbarchart(id,percent);
    }

//Draw Bar charts
 function drawbarchart(container,percent){
    //var container = '#container';
                $(function () {
                $(container).highcharts({
                    chart: {
                        type: 'bar',
                        spacingBottom: 0,
                        spacingTop: 0,
                        spacingLeft: 0,
                        spacingRight: 0,
                        margin:[0,0,0,0],
                        width: null,
                        height: 20
                    },
                    title: {
                        text: ''
                    },
                    xAxis: {
                        //categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania']
                        labels: {
                            enabled: false
                        }

                    },
                    yAxis: {
                        min: 0,
                        labels: {
                            enabled: false
                        },
                        title:{
                            enabled:false
                        },
                        axis:{
                            enabled:false
                        },
                        min: 0,
                        max: 100

                    },
                    legend: {
                                enabled: false
                     }
                    ,
                    tooltip: {
                        enabled: false
                    },
                    series: [{
                        name: 'reported',
                        colors: '#729fcf',
                        data: [percent],
                        pointPadding: -3,

                    }]
                });
            });
    }

/*Functions for calculations*/
/* Calculating avegerate time to register*/
function average_interval (duration){
        var total_interval =0;

        for (var i in duration) {
            var report = new Date(duration[i].report_time).getTime();
            var register = new Date(duration[i].register_time).getTime();
            total_interval = total_interval + (register - report);
        };

        return total_interval/(duration.length * 1000 * 60);
}

function array_sum(array){
    var sum = 0 ;
    for(var key in array){
        sum = sum + array[key];
    }
    return sum;
}
function getData(control, url,call) {

    if (!control && !url) {

        return;

    }

    var xmlhttp;

    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            if (xmlhttp.status == 200) {

                var result = xmlhttp.responseText;
                
                if(call ==1){
                    loadData(control, result);
                }
                else if(call==2){
                    loadRightChart(control,result);
                }
                else{
                    loadPieChart(control,result);
                }

            }
            else if (xmlhttp.status == 400) {
                alert('There was an error 400')
            }
            else {
                alert('something else other than 200 was returned')
            }
        }
    }

    xmlhttp.open("GET", url, true);
    xmlhttp.send();

}
//Average Time interval function

function loadData(control, data) {

    if (!control && !data) {

        return;

    }
   
    control.innerHTML = "";
   

    var tablecontent = JSON.parse(data);

    __$("registered").innerHTML = tablecontent['total_approved'];
    __$("reported").innerHTML = tablecontent['total_registered'];
    __$("avg_time").innerHTML = tablecontent['total_duration'];
    __$("reg_date").innerHTML = tablecontent['reg_date'];
    tablecontent = tablecontent['results'];

     for (var i in tablecontent){
          var tr = document.createElement("tr");
          

          var row = "<td width='18.18%' style='padding-left:2%;font-weight:bold' >"+tablecontent[i].district+"</td><td width='27.27%' id =graph"+i+" >Graph</td><td width='9.091%' id=reported"+i+" align='center'></td><td width='9.099%' id=registered"+i+" align='center'></td><td width='9.091%' id=time"+i+" align='right'>15min</td><td width='27.27' id="+i+" align = 'center'>Bar</td>";
          tr.innerHTML = row;
          control.appendChild(tr);

          __$("right").style.height= (36*window.innerHeight/100) + "px";
          __$("piechart").style.height= (45*window.innerHeight/100) + "px";

          i++;

     }



     //Initializing Aggregates
        

        var ever_registered = 0;
        var ever_reported = 0;

        var average_sum = 0;
        var num_of_districts = 0;



        for(var i in tablecontent){
            

            //Total Reported
           var district_total_reported = array_sum(tablecontent[i].reported);
                __$("reported"+i).innerHTML=district_total_reported;

            //Total Registered
            
            var district_total_registered = array_sum(tablecontent[i].registered);
             __$("registered"+i).innerHTML=district_total_registered;

            //Average time to register and Average Sum
            var average = tablecontent[i].duration;
            __$("time"+i).innerHTML=average;
            average_sum = average_sum + average;
            num_of_districts = parseInt(i) + 1;
            
           
            
        }

        //__$("avg_time").innerHTML = (average_sum/num_of_districts).toFixed(2);
        for (var i in tablecontent){
            drawMiniGraph("#graph"+i, null, tablecontent[i].reported);
          
            drawReportToRegisterChart("#"+i,array_sum(tablecontent[i].registered),array_sum(tablecontent[i].reported));
        }
        

}

var step = 2;
var cycle = 1;
setInterval(function() {

    if(__$("scroll")) {

        if(direction == 1) {
            if(cycle==2){
                     location.reload(true);
                    //$(location).attr("href", "/dashboard/map_dashboard");

            }
            position += step;

            if((position * 1.7) > __$("scroll").scrollHeight) {

                direction = 0;
                cycle = 1;

            }

        } else if(direction == 0) {

            

            position -= step;

            if(position < 0) {

                direction = 1;
                cycle = 2

            }

        }

        __$("scroll").scrollTop = position;

    }

}, 100);

if (__$("left_body")) {

    getData(__$("left_body"), "/dashboard/get_records",1);

}

function loadRightChart(control,data){
    if (!control && !data) {

        return;

    }
   

    var tablecontent = JSON.parse(data);

        var agg = new Aggregate (tablecontent);
        agg.setAggregates();
        //__$("reported").innerHTML = agg.reported_aggregate;
       // __$("registered").innerHTML = agg.registered_aggregate;
        drawRightChart(agg,agg);

        drawPieChart(agg.registered_aggregate,agg.reported_aggregate,agg.printed_aggregate);
}



function loadPieChart(control,data){

    var tablecontent = JSON.parse(data);

        var agg = new Aggregate (tablecontent);
        agg.setAggregates();
        drawPieChart(agg.registered_aggregate,agg.reported_aggregate,agg.printed_aggregate);

}

function average_interval (duration){
        var total_interval =0;

        for (var i in duration) {
            var report = new Date(duration[i].report_time).getTime();
            var register = new Date(duration[i].register_time).getTime();
            total_interval = total_interval + (register - report);
        };

        return total_interval/(duration.length * 1000 * 60);
}
/* Highchart Functions*/
$(document).ready(
    function(){
        getData(__$("left_body"), "/assets/data.json",2);
        getData(__$("left_body"), "/assets/data.json",3);
        

    }
);
