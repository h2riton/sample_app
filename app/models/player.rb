class Player < ActiveRecord::Base
  attr_accessible :nickname
  
  belongs_to :user
  
  has_many :tournaments, :dependent => :destroy
  
  validates :nickname,  :presence => true, :length => { :maximum => 20}
  validates :user_id,   :presence => true
  
  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
    Tournament.where("player_id = ?", id)
  end
  
end
