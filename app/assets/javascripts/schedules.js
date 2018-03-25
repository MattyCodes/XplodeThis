document.addEventListener("turbolinks:load", function() {
  $(".panel-header").on('click', function(e) {
    $(this).siblings('.panel-content').toggle(400);
    $(this).children('.arrow_span').toggleClass('glyphicon-menu-down');
    $(this).children('.arrow_span').toggleClass('glyphicon-menu-up');
  });
});
