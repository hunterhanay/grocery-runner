class Recipe < ApplicationRecord
    has_many :items, dependent: :destroy
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 1 }
end
