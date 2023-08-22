class Device
  include ActiveModel::Model

  attr_accessor :id, :readings

  validates :id, presence: true

  def initialize(attributes = {})
    self.readings = []
    super(attributes)
  end
end