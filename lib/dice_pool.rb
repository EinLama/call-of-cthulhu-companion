class DicePool
  attr_reader :dice

  def initialize
    @dice = []
  end

  def add(die)
    @dice << die
  end
end