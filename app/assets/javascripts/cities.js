document.addEventListener("turbolinks:load", function() {
  buyPassesPanelListener();
});

function buyPassesPanelListener() {
  $(".buy-passes-toggle").on('click', function(e) {
    var $contentDiv = $( $(this).siblings(".buy-passes-content")[0] );
    $contentDiv.toggleClass("open");
  });
};
