class Reading
  include ActiveModel::Model

  attr_accessor :timestamp, :count

  validates :timestamp, presence: true
  validates :count, presence: true, numericality: { only_integer: true }

  def duplicate?
    device.readings.any? { |r| r.timestamp === self.timestamp}
  end

  def save
    device.readings << self unless duplicate?
  end
end