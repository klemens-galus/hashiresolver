require_relative './Command'
require_relative '../Jeu/Grille'

class AddCommand < Command
  def initialize(a, b,grille)
    super(a,b,grille)
  end

  def execute
    @grille.creer_pont(@a,@b)
  end
end
