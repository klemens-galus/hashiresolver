class Command
  attr_reader :a, :b

  def initialize(a ,b, grille)
    @a = a
    @b = b
    @grille = grille
  end

  def getA
    return @a
  end
  def getB
    return @b
  end
end
