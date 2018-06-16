document.addEventListener("turbolinks:load", function() {
  skillbarListener();
});

function loadSkillbars() {
  var $skillbars = $(".skillbar-filler");

  $skillbars.map(function(skillbar, index) {
    if ( isScrolledIntoView( $(this) ) ) {
      var width = ( $(this).data("percent") - 5 ) + "%";
      $(this).animate({ width: width }, 2500);
    }
  });
};

function isScrolledIntoView(elem) {
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();
    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    return ( (elemBottom <= docViewBottom) && (elemTop >= docViewTop) );
};

function skillbarListener() {
  loadSkillbars();

  $('body').scroll(function() {
    loadSkillbars();
  })
};
