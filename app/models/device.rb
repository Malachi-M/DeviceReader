class Device
  include ActiveModel::Model

  attr_accessor :id, :readings

  validates :id, presence: true

  def initialize(attributes = {})
    self.readings = []
    super(attributes)
  end

  def find_reading_by_timestamp(reading_timestamp)
    self.readings.detect { |r| r.timestamp === reading_timestamp }
  end
end