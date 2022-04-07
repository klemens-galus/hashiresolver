require_relative '../UI/MethodesTexte'

class Solveur
  def initialize(grille, gui)
    @grille = grille
    @gui = gui
  end

  def analyser_grille
    return if tester_methode1 == true

    pas_aides if tester_methode2 == false
  end

  #
  # Si une ile de 4 à deux voisins, tout relier par des ponts doubles
  #
  def tester_methode1
    # Verification des iles
    @grille.liste_iles.each do |ile|
      if ile.numero == 4 && ile.get_liste_voisins.length == 2 && !ile.est_complete?
        # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
        if @gui.aide_label.text == MethodesTexte::METHODE1_NORMALE
          @gui.aide_label.set_text(MethodesTexte::METHODE1_FACILE)
          ile.afficher_aide
        # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
        elsif @gui.aide_label.text != MethodesTexte::METHODE1_FACILE
          @gui.aide_label.set_text(MethodesTexte::METHODE1_NORMALE)
        else
          # Réaffichage de la cellule
          ile.afficher_aide
        end
        return true
      end
    end

    false
  end

  #
  # Si une ile de 6 à trois voisins, tout relier par des ponts doubles
  #
  def tester_methode2
    # Verification des iles
    @grille.liste_iles.each do |ile|
      if ile.numero == 6 && ile.get_liste_voisins.length == 3 && !ile.est_complete?
        # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
        if @gui.aide_label.text == MethodesTexte::METHODE2_NORMALE
          @gui.aide_label.set_text(MethodesTexte::METHODE2_FACILE)
          ile.afficher_aide
        # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
        elsif @gui.aide_label.text != MethodesTexte::METHODE2_FACILE
          @gui.aide_label.set_text(MethodesTexte::METHODE2_NORMALE)
        else
          # Réaffichage de la cellule
          ile.afficher_aide
        end

        return true
      end
    end

    false
  end

  def pas_aides
    # Aucune ile ne correspond à la méthode
    @gui.aide_label.set_text(MethodesTexte::AUCUNE_AIDE)
  end
end
