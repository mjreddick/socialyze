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


                /***************************
                * Data manipulation
                ***************************/
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

                /**************************
                * Pie Chart via D3
                ***************************/
                var pieChart = d3.select("pie-chart")
                var svg = pieChart.append("svg")

                // Based on the data given, generate starting and 
                // ending angles for each wedge/data piece
                var pie = d3.layout.pie();
                var pieAngles = pie(values);


                // Define and set dimensions of svg
                var w = 900;
                var h = 600;
                svg.attr("width",w).attr("height", h);

                // Define dimensions of pie chart (the circle)
                var outerRadius = w/5;
                var innerRadius = 0;  // it's zero because it's a pie, not a donut

                // Create wedges based on the data(starting and ending angles,etc)
                var arcs = svg.selectAll("g.arc")
                            .data(pieAngles)
                            .enter()
                            .append('g')
                            .attr("class", "arc")
                            .attr("id", function(d,i) { return 'arc' + i })
                            .attr("transform", "translate(" + w/2.5 + "," + h/2 +")");

                // d3.svg.arc() constructs a new arc generator
                var arc = d3.svg.arc()
                                .innerRadius(innerRadius)
                                .outerRadius(outerRadius);

                // Fill in wedges. Dimensions to fill in are defined
                // by the variable arc
                arcs.append('path')
                    .attr('fill', function(d,i) { return color(i)})
                    .attr('d', arc)
                    .attr('id', function(d,i) { return "path" + i })
                    .on('mouseenter', function(d,i) {
                        toggleText(this,d,i)
                    })
                    .on('mouseleave', function(d,i) {
                        var parent  = d3.select(this.parentNode)
                        var path = d3.select(this)

                        // Revert to original color
                        path.attr('fill', color(i))

                        // Remove text and line
                        parent.selectAll("text").remove()
                        parent.selectAll("line").remove()
                    });

                /****************
                * Legend
                ******************/
                var colorBoxWH  = 35    // Dimensions of colored squares
                var margin      = 7
                var legend = svg.append("g")
                                .attr("class", "legend")

                // Append colored squares
                legend.selectAll("rect")
                  .data(keys)
                  .enter()
                  .append("rect")
                  .attr("id", function(d,i) { return 'box' + i})
                  .attr("x", w * .75)
                  .attr("y", function(d,i) { return (h * .20) + i * (colorBoxWH + margin) })
                  .attr("height", colorBoxWH)
                  .attr("width", colorBoxWH)
                  .attr("fill", function(d,i) { return color(i) })

                // Append text
                legend.selectAll("text")
                    .data(keys)
                    .enter()
                    .append("text")
                    .attr("text-anchor", "start")
                    .text(function(d,i) { return d.replace("char_", "").replace("_", " - ")})
                    .attr("transform", function(d,i) {
                        var textHeight  = 27
                        var x           = w * .75 + colorBoxWH + margin
                        var y           = (h * .20) + i * (colorBoxWH + margin) + textHeight

                        return "translate(" + x +"," + y + ")"
                    });


                var toggleText = function(elem,d,i) {
                    var path    = d3.select(elem)
                    var parent  = d3.select(elem.parentNode)
                    var c       = arc.centroid(d)

                    // Label position
                    var label   = "translate(" + c[0]*3 +"," + c[1]*3 + ")"

                    // Percent Text variables
                    var fontSize    = parseInt(path.style("font-size"));
                    var marginTop   = 3
                    var positionRel = fontSize + marginTop
                    var percentPos  = "translate(" + c[0]*3 +"," + (c[1]*3 + positionRel) + ")";

                    // Line variables
                    var x1      = c[0] * 1.85;
                    var y1      = c[1] * 1.85;
                    var x2      = c[0] * 2.5;
                    var y2      = c[1] * 2.5;

                    // Toggle brighter color of original
                    path
                        .attr('fill', d3.rgb(path.style("fill")).brighter(0.38));

                    // Append text
                    parent
                        .append("text")
                        .attr("transform", label)
                        .attr("text-anchor", "middle")
                        .text(keys[i].replace("char_", "").replace("_", " - "));

                    // Append percentage
                    parent 
                        .append("text")
                        .attr("text-anchor", "middle")
                        .attr("class", "pie-percentage")
                        .attr("transform", percentPos)
                        .text(percentArr[i] + '%');

                    // Append line
                    parent
                        .append("line")
                        .attr("x1", x1)
                        .attr("y1", y1)
                        .attr("x2", x2)
                        .attr("y2", y2)
                        .attr("stroke-width", 1.5)
                        .attr("stroke", "black");
                }// end of toggleText()
                        
            } // end of link 
        }; // end of return
    }; // end of pieChart