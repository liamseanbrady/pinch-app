// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  });

  $(document).on('click', '#goal-buttons-open', function() {
    $(this).hide();
    $(this).siblings('#goal-buttons').show();
    $(this).siblings('#goal-buttons-close').show();
  });

  $(document).on('click', '#goal-buttons-close', function() {
    $(this).hide();
    $(this).siblings('#goal-buttons').hide();
    $(this).siblings('#goal-buttons-open').show();
  });
});