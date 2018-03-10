document.addEventListener("turbolinks:load", function() {
  adminPanelListener();
});

function adminPanelListener() {
  $("#admin-actions-panel").on('click', function(e) {
    if ( $("#admin-panel-close")[0] != e.target ) {
      $(this).addClass('active');
      $(this).children('.panel-links-container').removeClass('hide');
    }
  });

  $("#admin-panel-close").on('click', function() {
    $("#admin-actions-panel").removeClass("active");
    $(".panel-links-container").addClass('hide');
  });
};
