ThinkingSphinx::Index.define :user, :with => :active_record do
  # fields
  indexes name, :as => :user, :sortable => true
  indexes religion, about_me, sexuality, children, user_smoke, user_drink, age, gender
  indexes ethnicity.name, :as => :ethnicity
  indexes gender.name, :as => :gender
# attributes
  has created_at, updated_at
end