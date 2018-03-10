$(document).ready(function() {
  previewImageListener();
});

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('.preview_image').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
};

function previewImageListener() {
  $("input[type='file']").on('change', function() {
    readURL(this);
  });
};