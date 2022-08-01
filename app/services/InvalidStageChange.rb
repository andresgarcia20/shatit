class InvalidStageChange < StandardError
  def initialize(msg = "The stage you are trying to change is invalid")
    super
  end
end
