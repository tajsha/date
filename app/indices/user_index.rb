ThinkingSphinx::Index.define :user, :with => :active_record do
  # fields
  indexes name, :as => :user, :sortable => true
  indexes [ethnicity, religion, about_me, sexuality, children, user_smoke, user_drink, age, gender]
  indexes ethnicity
  indexes religion
  indexes age
  indexes gender
# attributes
  has id, created_at, updated_at
end