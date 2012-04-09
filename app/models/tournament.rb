class Tournament < ActiveRecord::Base
  attr_accessible :title
  
  belongs_to :player
  
  default_scope :order => 'tournaments.created_at DESC'
end
