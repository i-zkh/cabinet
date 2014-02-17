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
    $(document).ready(function() {
        $('.fancybox').fancybox();
    });
};

    $(document).ready(function() {
        $('.fancybox').fancybox();
			   Init();
    });

// initialize
function Init() {
 var dropZone = document.getElementById('filedrag');
     dropZone.addEventListener('dragover', handleDragOver, false);
     dropZone.addEventListener('drop', handleFileSelect, false);
}

// file drag hover
function handleDragOver(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    evt.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
}

// file selection
function handleFileSelect(evt) {
  evt.stopPropagation();
  evt.preventDefault();

	var files = evt.target.files || evt.dataTransfer.files; // FileList object.

  // files is a FileList of File objects. List some properties.
  var output = [];
  for (var i = 0, f; f = files[i]; i++) {
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", 'report_drag', false);
    xhr.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
    xhr.setRequestHeader("X_FILENAME", "file." + f.name.split('.').pop());
	  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	  xhr.send(f);
    // output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
    //                 f.size, ' bytes, last modified: ',
    //                 f.lastModifiedDate.toLocaleDateString(), '</li>');
  }
    // document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
}