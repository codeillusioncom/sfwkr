// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require bakery/jquery.min
//= require bakery/bootstrap.min
//= require bakery/jquery-sortable
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require pages/jquery-ui
//= require sortablejs/Sortable
//= require pages/application
//= require cocoon
//= require trix
//= require bakery/jquery.amsify.suggestags
//= require_self

$(document).on("turbolinks:load", function() {
  $('.dropdown-toggle').dropdown();
});
