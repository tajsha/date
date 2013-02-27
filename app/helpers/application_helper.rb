module ApplicationHelper

  def flash_messages
    return nil if flash.empty?
    flash_messages = ''
    flash.each { |key, msg| flash_messages += content_tag(:div, msg) }
    content_tag(:div, flash_messages.html_safe, :class => 'notices')
  end

<<<<<<< HEAD
end
=======
end
>>>>>>> 90831cb1170b72a27e74714ec85f81fd4add0648
