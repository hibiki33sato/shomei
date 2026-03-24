class Signature < ApplicationRecord
  validates :name_kanji, presence: true
end
