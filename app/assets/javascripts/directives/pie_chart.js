angular.module('socialyze')
    .directive('pieChart', pieChart)

    function pieChart() {
        return {
            restrict: 'E',
            scope: {
                pieChartData: '='
            },
            link: function(scope, element, attrs) {
                // Use color set given by d3
                var color = d3.scale.category20();

                // Delete keys in object if value is 0
                for(var key in scope.pieChartData) {
                    if(scope.pieChartData[key] === 0) {
                        delete scope.pieChartData[key]
                    }
                }

                // Separate object's keys and values into arrays
                var keys = Object.keys(scope.pieChartData)

                var values = [];
                for(var i = 0; i < keys.length; i++) {
                    // Push values
                    values.push(scope.pieChartData[keys[i]])
                }

                // Calculate the total value in the array
                var totalValue = 0;
                for(var i = 0; i < values.length; i++) {
                    totalValue += values[i]
                }

                // Calculate the percentage within values array
                var percentArr = [];
                for(var i = 0; i < values.length; i++) {
                    percentArr.push((values[i]/totalValue * 100).toFixed(2))
                }

                // Start to build pie chart
                var pieChart = d3.select("pie-chart")
                var svg = pieChart.append("svg")

                // Based on the data given, generate starting and 
                // ending angles for each wedge/data piece
                var pie = d3.layout.pie();
                var pieAngles = pie(values);


                // Define and set dimensions of svg
                var w = 600;
                var h = 600;
                svg.attr("width",w).attr("height", h);

                // Define dimensions of pie chart (the circle)
                var outerRadius = w/4;
                var innerRadius = 0;  // it's zero because it's a pie, not a donut

                // Create wedges based on the data(starting and ending angles,etc)
                var arcs = svg.selectAll("g.arc")
                            .data(pieAngles)
                            .enter()
                            .append('g')
                            .attr("class", "arc")
                            .attr("transform", "translate(" + w/2 + "," + h/2 +")");

                // d3.svg.arc() constructs a new arc generator
                var arc = d3.svg.arc()
                                .innerRadius(innerRadius)
                                .outerRadius(outerRadius);

                // Fill in wedges. Dimensions to fill in are defined
                // by the variable arc
                arcs.append('path')
                    .attr('fill', function(d,i) { return color(i)})
                    .attr('d', arc)
                    .on('mouseenter', function(d,i) {
                        var path = d3.select(this)
                        path
                            .attr('fill', d3.rgb(path.style("fill")).brighter(0.38))
                    })
                    .on('mouseleave', function(d,i) {
                        var path = d3.select(this)
                        path
                            .attr('fill', color(i))
                    });

                // Append text
                arcs.append("text")
                    .attr("transform", function(d) {
                        var c = arc.centroid(d)
                        return "translate(" + c[0]*3 +"," + c[1]*3 + ")";
                    })
                    .attr("text-anchor", "middle")
                    .text(function(d,i) {
                        return keys[i].replace("char_", "").replace("_", " - ")
                    });

                // Append percentage
                arcs.append("text")
                    .attr("text-anchor", "middle")
                    .attr("class", "pie-percentage")
                    .attr("transform", function(d) {
                        var t           = d3.select(this)
                        var c           = arc.centroid(d)
                        var fontSize    = parseInt(t.style('font-size'))
                        var marginTop   = 3
                        var positionRel = fontSize + marginTop
                        
                        return "translate(" + c[0]*3 +"," + (c[1]*3 + positionRel) + ")";
                    })
                    .text(function(d,i) {
                        return percentArr[i] + '%'
                    });

                // Append line
                arcs.append("line")
                    .attr("x1", function(d) {
                        var c = arc.centroid(d)
                        return c[0] * 1.85
                    })
                    .attr("y1", function(d){
                        var c = arc.centroid(d)
                        return c[1] * 1.85
                    })
                    .attr("x2", function(d) {
                        var c = arc.centroid(d)
                        return c[0]*2.5
                    })
                    .attr("y2", function(d) {
                        var c = arc.centroid(d)
                        return c[1] * 2.5
                    })
                    .attr("stroke-width", 1.5)
                    .attr("stroke", "black");

            } // end of link 
        }; // end of return
    }; // end of pieChart