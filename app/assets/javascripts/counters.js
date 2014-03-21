var isChecked = true
<<<<<<< HEAD
=======

>>>>>>> 71def3d50f21c90e3baaa96e3b22e6c4b797cd57
$(document).ready(function() {
    document.getElementById("checkbox_all").onclick = function(){
          checkedAll(isChecked);
          isChecked = !isChecked;
    };
        $("#user_address").autocomplete({
          source: $('#address').data('address')
        });
    });

function checkedAll(isChecked) {
    var c = document.getElementsByTagName('input');
    for (var i = 0; i < c.length; i++){
        if (c[i].type == 'checkbox'){
          c[i].checked = isChecked;
        }
    }
}