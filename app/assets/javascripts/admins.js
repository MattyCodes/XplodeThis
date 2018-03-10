document.addEventListener("turbolinks:load", function() {
  adminPanelListener();
});

function adminPanelListener() {
  $("#admin-actions-panel").on('click', function(e) {
    if ( $("#admin-panel-close")[0] != e.target ) {
      openAdminPanel();
    }
  });

  $("#admin-panel-close").on('click', function() {
    closeAdminPanel();
  });
};

function openAdminPanel() {
  $("#admin-actions-panel").addClass('active');
  $(".panel-links-container").removeClass('hide');
};

function closeAdminPanel() {
  $("#admin-actions-panel").removeClass("active");
  $(".panel-links-container").addClass('hide');
};
