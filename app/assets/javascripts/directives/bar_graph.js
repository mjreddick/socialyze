angular.module('socialyze')
  .directive('barGraph', barGraph)
function barGraph() {
  return {
    restrict: 'E',
    scope: {
      barGraphData: "="
    },
    // Manipulate the dom / shitz
    // Scope refers to teh scope of the function barGraph
    // element refers to the actual bar graph element
    // attrs attributes of the element (contains the data we pass it)
    link: function(scope, element, attrs) {

      console.log("SCOPE", scope.barGraphData)

      var data = scope.barGraphData;
      var values = [];
      
      for(var i = 0; i < data.length; i++) {
        console.log(data[i]);
        values.push(data[i].value);
      }

      var margin = {top: 20, right: 20, bottom: 50, left: 60},
          width = 960 - margin.left - margin.right,
          height = 500 - margin.top - margin.bottom;

      var x = d3.scale.ordinal()
          .rangeRoundBands([0, width], .1);

      var y = d3.scale.linear()
          .range([height, 0]);

      var xAxis = d3.svg.axis()
          .scale(x)
          .orient("bottom");

      var yAxis = d3.svg.axis()
          .scale(y)
          .orient("left")
          .ticks(10);

      // var bar = d3.select("svg")
      var svg = d3.select("bar-graph").append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        x.domain(data.map(function(d) { return d.word; }));
        y.domain([0, d3.max(data, function(d) { return d.value; })]);

        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis)
          .append("text")
            .attr("x", 500)
            .attr("dy", "3em")
            .style("text-anchor", "end")
            .text("Words");

        svg.append("g")
            .attr("class", "y axis")
            .call(yAxis)
          .append("text")
            .attr("transform", "rotate(-90)")
            .attr("y", 6)
            .attr("dy", ".71em")
            .style("text-anchor", "end")
            .text("Frequency");

        svg.selectAll(".bar")
            .data(data)
          .enter().append("rect")  
            .attr("class", "bar")
            .attr("x", function(d) { return x(d.word); })
            .attr("width", x.rangeBand())
            .attr("y", function(d) { return y(d.value); })
            .attr("height", function(d) { return height - y(d.value); });

    }
  }
}