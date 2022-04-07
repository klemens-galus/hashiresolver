require_relative './Command'
require_relative '../Jeu/Grille'

class RemCommand < Command
  def initialize(a, b, grille)
    super(a,b,grille)
  end

  def execute
    puts @grille,@a,@b
    @grille.creer_pont(@a,@b)
    @grille.creer_pont(@a,@b)
  end
end
