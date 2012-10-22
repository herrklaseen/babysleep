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
     .attr("class", function(d, i) {
        if (i % 2 != 0) {
          return "awake bar";
        }
        else {
          return "asleep bar";
        }
     })
     .text(function(d) { return d + "%"; });
  };
  var thereIsAChartHere = $("#sleeptime_chart");
  if (thereIsAChartHere) {
    createChart();
  };
});
