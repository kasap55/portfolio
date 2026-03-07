class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :due_on, presence: true
end
