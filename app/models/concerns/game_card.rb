# this is not a concern ... I just don't know where else Rails would accept it

class GameCard
  attr_accessor :which, :name, :attack

  def initialize(card)
    @card = card
    generate( card.card_which )

  end

  def generate(which)
    rng = RNG.new(which)

    self.which  = which
    self.name   = rng.name
    self.attack = rng.attack
  end

  class RNG
    def initialize(which)
      @rng = Random.new(which.to_i)
    end

    def name
      sample(%w[Sandman Soldier Fortune Disaster War Torment Death Squiggle])
    end

    def attack
      rng.rand(6) + rng.rand(6)
    end

    private

    attr_accessor :rng

    def rand(n)
      rng.rand(n)
    end

    def sample(arr)
      arr.sample(random: rng)
    end
  end
end
