class Recipe < ApplicationRecord
    has_many :items
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 1 }
end
