class Permission < Struct.new(:user)
  def allow?(controller, action)
    if user.nil?
      controller == "galleries" && action.in?(%w[index show])
    elsif user.admin?
      true
    else
      controller == "galleries" && action != "destroy"
    end
  end
end