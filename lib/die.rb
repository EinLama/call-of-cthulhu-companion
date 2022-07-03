
class Die
  attr_reader :eyes

  def initialize(eyes=100)
    @eyes = eyes
  end

  def roll!
    random_generator(1..@eyes)
  end

  def random_generator(range)
    rand(range)
  end
end