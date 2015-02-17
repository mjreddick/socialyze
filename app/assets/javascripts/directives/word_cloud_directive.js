angular.module('socialyze')
  .directive('wordCloud', wordCloud)

  function wordCloud() {
  return {
    restrict: 'E',
    scope: {
      wordCloudData: "="
    },      
    link: function(scope, element, attrs) {
        // Word Cloud functions
        // var fill = d3.scale.category20();
        //   d3.layout.cloud().size([300, 300])
        //       .words([
        //         "Hello", "world", "normally", "you", "want", "more", "words",
        //         "than", "this"].map(function(d) {
        //         return {text: d, size: 10 + Math.random() * 90};
        //       }))
        //       .padding(5)
        //       .rotate(function() { return ~~(Math.random() * 2) * 90; })
        //       .font("Impact")
        //       .fontSize(function(d) { return d.size; })
        //       .on("end", draw)
        //       .start();

        words = ["word"]

          function draw(words) {
            d3.select("word-cloud").append("svg")
                .attr("width", 800)
                .attr("height", 800)
              .selectAll("text")
                .data(words)
              .enter().append("text")
                .style("font-size", function(d) { return 200 + "px"; })
                .attr("dy", 300)
                .attr("text-anchor", "bottom")
                .text(function(d) {return d;})
                // .style("fill", function(d, i) { return fill(i); })
                
                // .attr("transform", function(d) {
                //   return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                // })
                // .text(function(d) { return d; });
          }

          draw(words);

      } // End Link function

    } // End Return Function

  } // End wordCloud function