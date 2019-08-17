class Profile < ApplicationRecord
  has_paper_trail
  belongs_to :size
  belongs_to :gender
  belongs_to :agile, optional: true
  belongs_to :agileRelation, optional: true
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :expectancy, presence: true
  validates :bio, presence: true
  validates :phonenumber, presence: true
  validates :role, presence: true, inclusion: Role::ALL
end
