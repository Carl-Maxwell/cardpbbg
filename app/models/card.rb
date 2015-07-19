class Card < ActiveRecord::Base
  belongs_to :user

  validates :card_which, :user, presence: true

  def cardify
    GameCard.new(self)
  end
end
