# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('.best_in_place').best_in_place()
	$('.converation').click (e) ->
		href = $(this).data('href')
		if(e.target != $('.conversation_avatar'))
			window.location = href
	$('.adv_search').click (e) ->
		e.preventDefault
		$('.advanced_search_div').removeClass('hide')
	$('.simple_search').click (e) ->
		e.preventDefault
		$('.advanced_search_div').addClass('hide')