//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-confirm

function closeMessage() {
    $('.sysmsg').fadeOut('slow');
}

$.fn.bsbutton = $.fn.button;

$(function() {

    $('.sysmsg').show();
    setTimeout('closeMessage()', 5000);

   $('.btn.loading').click(function() {
        var btn = $(this);
        btn.bsbutton('loading');
        setTimeout(function () {
            btn.bsbutton('reset');
        }, 5000);
    });

});
