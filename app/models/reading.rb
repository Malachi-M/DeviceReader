class Reading
  include ActiveModel::Model

  # Public: The timestamp of the reading.
  attr_accessor :timestamp

  # Public: The count of the reading.
  attr_accessor :count

  # Public: Validates the presence of timestamp and count, and that count is an integer.
  validates :timestamp, presence: true
  validates :count, presence: true, numericality: { only_integer: true }
end
