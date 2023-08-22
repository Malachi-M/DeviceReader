class Reading
  include ActiveModel::Model

  attr_accessor :timestamp, :count

  validates :timestamp, presence: true
  validates :count, presence: true, numericality: { only_integer: true }
end
