class Player < ActiveRecord::Base
  attr_accessible :nickname
  
  belongs_to :user
  
  validates :nickname,  :presence => true, :length => { :maximum => 20}
  validates :user_id,   :presence => true
  
end
