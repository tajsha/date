class Search < ActiveRecord::Base
  attr_accessible :age, :children, :ethnicity, :gender, :religion, :zip_code, :birthday, :max_age, :min_age
  
  def users
    @users ||= find_users
  end
    
    private
    
  def find_users
    users = User.order(:id)
    users = users.where(gender: gender) if gender.present?
       users = users.where(zip_code: zip_code) if zip_code.present?
       users = users.where(children: children) if children.present?
       users = users.where(religion: religion) if religion.present?
       users = users.where(ethnicity: ethnicity) if ethnicity.present?
       User.where("birthday >= ? AND birthday <= ?", Date.today - min_age, Date.today - max_age)
       users
  end
end
