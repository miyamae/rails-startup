/*
 *  <button type="submit" class="btn btn-primary"
 *    data-confirm="Do you really want to delete the file?">Delete</button>
 *
 *  // OR
 *  $.confirmDialog('Are you sure?', function() {
 *    alert('done');
 *  });
 *
 *  Author: https://github.com/miyamae
 */

$.rails.allowAction = function(link) {
  if (!link.attr('data-confirm')) {
    return true;
  }
  var message = link.attr('data-confirm');
  $.rails.showConfirmDialog(message, link);
  return false;
};

$.rails.confirmed = function(link) {
  link.removeAttr('data-confirm');
  return link.trigger('click.rails');
};

$.rails.showConfirmDialog = function(message, link) {
  var html =
    '<div class="modal fade" id="confirm-dialog">' +
      '<div class="modal-dialog">' +
        '<div class="modal-content">' +
          '<div class="modal-header">' +
            '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>' +
            '<h4 class="modal-title">' + I18n.t('js.confirm.title') + '</h4>' +
          '</div>' +
          '<div class="modal-body">' +
            '<p>' + message + '</p>' +
          '</div>' +
          '<div class="modal-footer">' +
          '<button type="button" class="btn btn-default" data-dismiss="modal">' + I18n.t('js.confirm.cancel') + '</button>' +
          '<button type="button" class="btn btn-primary loading confirm" ' +
            'data-loading-text="' + I18n.t('js.confirm.wait') + '">' + I18n.t('js.confirm.ok') + '</button>' +
        '</div>' +
      '</div>' +
    '</div>';
  $('body').append($(html));
  $('#confirm-dialog .confirm').click(function() {
    var btn = $(this);
    if ($.fn.bsbutton) {
      btn.bsbutton('loading');
    } else {
      btn.button('loading');
    }
    setTimeout(function () {
      if ($.fn.bsbutton) {
        btn.bsbutton('reset');
      } else {
        btn.button('reset');
      }
    }, 10000);
    if (typeof(link) == 'function') {
      link.call();
      $('#confirm-dialog').modal('hide');
      return true;
    } else {
      return $.rails.confirmed(link);
    }
  });
  $('#confirm-dialog').on('hidden.bs.modal', function() {
    $('#confirm-dialog').remove();
  });
  $('#confirm-dialog').modal();
  $('.modal-backdrop').css('z-index', 0);
};

$.confirmDialog = function(message, link) {
  $.rails.showConfirmDialog(message, link);
};
