var isChecked = true

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