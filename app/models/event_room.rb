class EventRoom < ActiveRecord::Base
  include ::Dated

  attr_accessible :end_at, :event_id, :room_id, :start_at, :building
  attr_accessor :building
  belongs_to :event
  belongs_to :room
end
