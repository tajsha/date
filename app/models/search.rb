class Search < ActiveRecord::Base
  attr_accessible :age, :children, :ethnicity, :gender, :religion, :zip_code
  
  def users
    users = User.order(:id)
    users = users.where(gender: gender) if gender
    users = users.where(zip_code: zip_code) if zip_code
    users = users.where(children: children) if children
    users = users.where(religion: religion) if religion
    users = users.where(ethnicity: ethnicity) if ethnicity
    users
  end

end
