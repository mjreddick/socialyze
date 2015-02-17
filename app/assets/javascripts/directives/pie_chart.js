angular.module('socialyze')
    .directive('pieChart', pieChart)

    function pieChart() {
        return {
            restrict: 'E',
            scope: {
                pieChartData: '='
            },
            link: function(scope, element, attrs) {
                // Use set of colors given by d3
                var color = d3.scale.category10();

pieChartData = [1,2,3,4];
                var pieChart = d3.select("pie-chart")
                var svg = pieChart.append("svg")

                // Based on the data given, generate starting and 
                // ending angles for each wedge/data piece
                var pie = d3.layout.pie();
                var pieAngles = pie(pieChartData)

                // Define and set dimensions of svg
                var w = 400;
                var h = 400;
                svg.attr("width",w).attr("height", h);

                // Define dimensions of pie chart (the circle)
                var outerRadius = w/2;
                var innerRadius = 0;  // it's zero because it's a pie, not a donut

                // Create wedges based on the data(starting and ending angles,etc)
                var arcs = svg.selectAll("g.arc")
                            .data(pieAngles)
                            .enter()
                            .append('g')
                            .attr("class", "arc")
                            .attr("transform", "translate(200,200)");

                // d3.svg.arc() constructs a new arc generator
                var arc = d3.svg.arc()
                                .innerRadius(innerRadius)
                                .outerRadius(outerRadius);

                // Fill in wedges. Dimensions to fill in are defined
                // by the variable arc
                arcs.append('path')
                    .attr('fill', function(d,i) { return color(i)})
                    .attr('d', arc);

                // Append text
                arcs.append("text")
                    .attr("transform", function(d) {
                        return "translate(" + arc.centroid(d) + ")";
                    })
                    .attr("text-anchor", "middle")
                    .text(function(d) {
                        return d.value
                    });
            } // end of link 
        }; // end of return
    }; // end of pieChart