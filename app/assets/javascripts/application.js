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

 hoverer = function(){
	$("img").each(function(i, obj){
    
    var position;
    var action = true;
    position = $(obj).position();
    console.log(position.top, position.left);

    $(obj).bind("click", function(e){
    if (action)
    {
 		$(obj).css("top", position.top).css("left", position.left).css("z-index", "1000").css("position", "absolute").animate({
            height: "500px",
            width: "600px"
        });
        action = false;
    }
    else
    {
        $(obj).animate({
            width: "150px",
            height: "100px"
        });
        action = true;
    }
    });
  });
};
