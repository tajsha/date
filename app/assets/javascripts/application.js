// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require jquery.magnific-popup.js
//= require jquery.purr
//= require best_in_place
//= require cufon-yui
//= require Helvetica_Neue_LT_Std_400.font
//= require Helvetica_Neue_LT_Std_italic_300.font
//= require Helvetica_Neue_LT_Std_500.font
//= require Helvetica_Neue_LT_Std_750.font
//= require Dosis_400.font
//= require cufon
//= require jquery.jqtransform
//= require_tree .

$(function(){
  $('select').jqTransSelect();
  $('input[type=checkbox]').jqTransCheckBox();
  $('.box_detail').masonry({
  	columnWidth: 80,
  	itemSelector: '.common_box'
	});
});