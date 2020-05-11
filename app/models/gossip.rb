class Gossip < ApplicationRecord
  validates :title, presence: true, length: { in: 3..24 }
  validates :content, presence: true
  belongs_to :user
  has_many :markings
  has_many :tags, through: :markings
  has_many :comments
end
