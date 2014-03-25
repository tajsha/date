# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
if $('.pagination').length
  $('#append_and_paginate').prepend('<a id="append_more_results" href="javascript:void(0);">Show more questions</a>');
  $('#append_more_results').click ->
    url = $('.pagination .next_page').attr('href')
    if url
      $('.pagination').text('Fetching more products...')
      $.getScript(url)