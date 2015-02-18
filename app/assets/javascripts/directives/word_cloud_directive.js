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

words = ["word", "word2", "word3", "word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2","word", "word2"]

      var fill = d3.scale.category20();
  function draw(words) {
    d3.select("body").append("svg")
        .attr("width", 500)
        .attr("height", 500)
      // .append("g")
      //   .attr("width", 500)
      //   .attr("height", 500)
      //   // .attr("transform", "translate(300,300)")
      .selectAll("text")
        .data(words)
      .enter().append("text")
        .style("font-size", function(d) { return 50 + "px"; })
        .style("font-family", "Impact")
        .style("fill", function(d, i) { return fill(i); })
        // .attr("text-anchor", "middle")
        .attr("transform", function(d) {
          return "translate(" + [Math.random() * 600, Math.random() * 600] + ")rotate(" + 0 + ")";
        })
        .text(function(d) { return d; });
  }




draw(words)




        

        //   function draw(words) {
        //     d3.select("word-cloud").append("svg")
        //         .attr("width", 800)
        //         .attr("height", 800)
        //       .selectAll("text")
        //         .data(words)
        //       .enter().append("text")
        //         .style("font-size", function(d) { return 100 + "px"; })
        //         .attr("dy", 300)
        //         .attr("text-anchor", "bottom")
        //         .text(function(d) {return d;})
        //         // .style("fill", function(d, i) { return fill(i); })
                
        //         // .attr("transform", function(d) {
        //         //   return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
        //         // })
        //         // .text(function(d) { return d; });
        //   }

        //   draw(words);

      } // End Link function

    } // End Return Function

  } // End wordCloud function