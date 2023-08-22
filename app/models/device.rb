class Device
  include ActiveModel::Model

  attr_accessor :id, :readings

  # Creates a new instance of Device.
  #
  # @param [Hash] attributes The attributes to initialize the device with.
  # @option attributes [String] :id The ID of the device.
  # @option attributes [Array] :readings The readings of the device.
  # @return [Device] A new instance of Device.
  def initialize(attributes = {})
    self.readings = []
    super(attributes)
  end

  validates :id, presence: true
end