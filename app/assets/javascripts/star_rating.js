$(function () {
    var checkedId = $('input:checked').attr('id');
    $('label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
});

$(document).ready(function() {
    // Makes stars glow on hover.
  $('label').hover(
    function() {    // mouseover
        $(this).prevAll().andSelf().addClass('glow');
    },
    function() {  // mouseout
        $(this).siblings().andSelf().removeClass('glow');
    });

  // Makes stars stay glowing after click.
  $('label').click(function() {
    $(this).siblings().removeClass("bright");
    $(this).prevAll().andSelf().addClass("bright");
  });

});