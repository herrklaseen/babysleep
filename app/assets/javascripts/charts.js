$(document).ready(function() {
  function createChart() {
    var data = [];
    var containerWidth = $(".container").innerWidth();
    $("#sleeptime_chart p").each(function() {
      data.push($(this).text());
      $(this).remove();
    });
    var chart = d3.select("#sleeptime_chart").append("div")
    .attr("class", "chart clearfix");

    chart.selectAll("div")
     .data(data)
   .enter().append("div")
     .style("width", function(d) { return (d * 1) + "%"; })
     .style("min-height", function(d) { return "20px" })
     .style("display", function(d) {
        if(d == 0) {
          return "none"
        } else {
          return "block"
        };
     })
     .attr("class", function(d, i) {
        if (i % 2 != 0) {
          return "awake bar";
        }
        else {
          return "asleep bar";
        }
     });
  };
  var thereIsAChartHere = $("#sleeptime_chart");
  if (thereIsAChartHere) {
    createChart();
  };
});
