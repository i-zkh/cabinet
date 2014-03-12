$(document).ready(function() {
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
  for (var i = 0, f; f = files[i]; i++) {
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", 'report_drag', false);
    xhr.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
    xhr.setRequestHeader("X_FILENAME", "file." + f.name.split('.').pop());
	  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	  xhr.send(f);
  }
    document.getElementById('list').innerHTML = '<div class="notice">' + "Файл успешно добавлен" + '</div>';
}