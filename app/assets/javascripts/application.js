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
  
  $('.img_box').imagesLoaded(function(){
    $('.box_detail').masonry({
  	  columnWidth: 80,
  	  itemSelector: '.common_box'
	  });
  });
	
  $('a#inbox_link, a#sentbox_link').click(function(e){
		e.preventDefault();
		var href = $(this).attr('href');
		console.log('href'+href);
		$(this).parent().siblings().removeClass('active');
		$(this).parent().addClass('active');
		$('.tab_contr').css('display','none');;
		$(href).css('display','block');
	})
  $('#signin_link').click(function () {
      $('#signin-dropdown').toggle();
      return false;
  });
  $('#signin-dropdown').click(function(e) {
      e.stopPropagation();
  });
  $(document).click(function() {
      $('#signin-dropdown').hide();
  });
  $('.select_conversations').on('click',function(){
    console.log('checking')
    if($(this).is(':checked')){
      $('.tab_contr:visible .conversation_checkbox').each(function(){
        $(this).prop('checked', true)
        console.log('length', $(this).closest('a.jqTransformCheckbox').length)
        $(this).parent().find('a.jqTransformCheckbox').addClass('jqTransformChecked')
      })
      console.log('unchecked')
    }
    else {
      $('.tab_contr:visible .conversation_checkbox').each(function(){
        $(this).prop('checked', false)
        $(this).parent().find('a.jqTransformCheckbox').removeClass('jqTransformChecked')
      })
      console.log('checked')
    }
  })
  // $(".jqtransform").jqTransform();
});