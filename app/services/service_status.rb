class ServiceStatus
  attr_reader :status, :notice

  def initialize(status, notice)
    @status = status
    @notice = notice
  end

  def success?
    @status
  end
end
