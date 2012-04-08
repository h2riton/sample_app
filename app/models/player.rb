class Player < ActiveRecord::Base
  attr_accessible :nickname
  
  belongs_to :user
end
