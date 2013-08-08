class Question < ActiveRecord::Base
  attr_accessible :answer, :asked_by, :asked_to, :question
end
