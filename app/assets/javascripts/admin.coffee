//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-confirm

$ ->

    $('.sysmsg').show();
    setTimeout (-> $('.sysmsg').fadeOut('slow')), 5000

    $('.btn.loading').click ->
        $(@).button('loading')
        setTimeout (=> $(@).button('reset')), 10000
