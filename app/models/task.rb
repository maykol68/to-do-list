class Task < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :completed, default: false 

end
