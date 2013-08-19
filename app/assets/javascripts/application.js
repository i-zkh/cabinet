// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var hoverer = function(){
	$("img").each(function(i, obj){
    
    var position;
    var action = true;
    position = $(obj).position();
    $(obj).bind("click", function(e){
    if (action)
    {
 		$(obj).css("position", "absolute").css("z-index", "1000").animate({
            height: "500px",
            width: "600px",
            position: position.top,
            position: position.left
        });
        action = false;
    }
    else
    {
        $(obj).animate({
            width: "150px",
            height: "100px"
        });
        $(obj).css("position", "relative");
        action = true;
    }
    });

//    position = $(obj).position();
//    $(obj).bind("mouseover", function(e){
// 		$(obj).css("position", "absolute").css("z-index", "1000").animate({
//            height: "400px",
//            width: "350px"
//        });
//
//    $(obj).bind("mouseleave", function(e){
//      $(obj).css("position", "relative").animate({
// 		width: "150px",
//		height: "100px"
//        });
//        });
        

//	$(clone).appendTo("#pic").css("position", "absolute").animate({
//            height: "60px",
//            width: "60px"
//        }, 200, function(){
//            
//    $(clone).bind("mouseout", function(e){
//            $(clone).animate({
//            height: "30px",
//            width: "30px"
//       }, 200, function(){$(clone).remove();});
//            }); // end mouseout

 //       }); // end animate callback
        
 // end mouseover
    
  }); // end each
};
