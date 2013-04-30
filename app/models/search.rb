class Search < ActiveRecord::Base
  attr_accessible :age, :children, :ethnicity, :gender, :religion, :zip_code
  
  def users
    @users ||= find_users
  end

private

def find_users
  users = User.order(:username)
  users = users.where("religion", "%#{keywords}%" if keywords.present?)
end

end
