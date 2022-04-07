require_relative '../UI/MethodesTexte'

class Solveur

  def initialize(grille, gui)
    @grille = grille
    @gui = gui
  end

  def analyser_grille
    tester_methode1
  end

  def tester_methode1
    @grille.liste_iles.each do |ile|
      if ile.numero == 4 && ile.get_liste_voisins.length == 2 && !ile.est_complete?
        @gui.aide_label.set_text(MethodesTexte::METHODE1)
        return
      end
    end

    @gui.aide_label.set_text(MethodesTexte::AUCUNE_AIDE)
  end
end
