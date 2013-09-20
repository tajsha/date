ThinkingSphinx::Index.define :user, :with => :active_record do
  # fields
  indexes name, :as => :user, :sortable => true
  indexes religion, about_me, career, sexuality, children, user_smoke, user_drink, age, gender, ethnicity, education, username
# attributes
  has created_at, updated_at
end