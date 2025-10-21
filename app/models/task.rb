class Task < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true, length: {maximum:30}
    validates :completed, inclusion: { in: [true, false] }
    validates :due_date, presence: true

end
