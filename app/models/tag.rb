class Tag < ApplicationRecord
  has_many :markings
  has_many :gossips, through: :markings
end
