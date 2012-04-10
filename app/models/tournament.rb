class Tournament < ActiveRecord::Base
  attr_accessible :title
  
  belongs_to :player

  validates :title,     :presence => true, :length => { :maximum => 20 }
  validates :player_id, :presence => true
  
  default_scope :order => 'tournaments.created_at DESC'
end
