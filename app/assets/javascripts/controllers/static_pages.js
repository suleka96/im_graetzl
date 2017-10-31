APP.controllers.static_pages = (function() {

    function init() {
      if($("section.help").exists()) initHelp();
    }

// ---------------------------------------------------------------------- Public

// Dont scroll over the Footer Element
function checkOffset() {
    if($('#help_nav').offset().top + $('#help_nav').height() >= $('#footer').offset().top )
      $('#help_nav').addClass( "fix_nav" ).removeClass( "float_nav" );
}

function initHelp() {

  var elementPosition = $('#help_nav').offset();

  $(window).scroll(function(){
          if($(window).scrollTop() > elementPosition.top){
              $('#help_nav').addClass( "float_nav" ).removeClass( "fix_nav" );
              checkOffset();
          } else {
              $('#help_nav').css('position','static').removeClass( "fix_nav" ).removeClass( "float_nav" );
          }
  });

  var $sections = $('.container');

  // The user scrolls
  $(window).scroll(function(){

    // currentScroll is the number of pixels the window has been scrolled
    var currentScroll = $(this).scrollTop();

    // $currentSection is somewhere to place the section we must be looking at
    var $currentSection

    // We check the position of each of the divs compared to the windows scroll positon
    $sections.each(function(){
      // divPosition is the position down the page in px of the current section we are testing
      var divPosition = $(this).offset().top;
      // If the divPosition is less the the currentScroll position the div we are testing has moved above the window edge.
      // the -1 is so that it includes the div 1px before the div leave the top of the window.
      if( divPosition - 1 < currentScroll ){
        // We have either read the section or are currently reading the section so we'll call it our current section
        $currentSection = $(this);
        // If the next div has also been read or we are currently reading it we will overwrite this value again. This will leave us with the LAST div that passed.
      }

      // This is the bit of code that uses the currentSection as its source of ID
      var id = $currentSection.attr('id');
     $('a').addClass('-mint');
     $('#nav-'+id).removeClass('-mint');
     //alert(id);

    })

  });


  $('a[href*="#"]')
    // Remove links that don't actually link to anything
    .not('[href="#"]')
    .not('[href="#0"]')
    .click(function(event) {
      // On-page links
      if (
        location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
        &&
        location.hostname == this.hostname
      ) {
        // Figure out element to scroll to
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
        // Does a scroll target exist?
        if (target.length) {
          // Only prevent default if animation is actually gonna happen
          event.preventDefault();
          $('html, body').animate({
            scrollTop: target.offset().top
          }, 1000, function() {
            // Callback after animation
            // Must change focus!
            //var $target = $(target);
            //$target.focus();
            //if ($target.is(":focus")) { // Checking if the target was focused
              //return false;
            //} else {
              //$target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
              //$target.focus(); // Set focus again
            //};
          });
        }
      }
    });

}

    return {
        init: init
    }

})();
