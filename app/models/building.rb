#This is the building eg: Meevaart
class Building < ActiveRecord::Base
  attr_accessible :address, :name
  belongs_to :organization
  has_many :rooms
end