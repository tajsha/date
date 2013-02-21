module ApplicationHelper

  def flash_messages
    return nil if flash.empty?
    flash_messages = ''
    flash.each { |key, msg| flash_messages += content_tag(:div, msg) }
    content_tag(:div, flash_messages.html_safe, :class => 'notices')
  end

end
