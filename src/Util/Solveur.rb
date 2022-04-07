require_relative '../UI/MethodesTexte'

class Solveur
  def initialize(grille, gui)
    @grille = grille
    @gui = gui
  end

  def analyser_grille
    return if tester_methode1 == true
    return if tester_methode2 == true
    return if tester_methode3 == true
    return if tester_methode4 == true
    return if tester_methode5 == true
    return if tester_methode6 == true
    return if tester_methode7 == true
    return if tester_methode8 == true
    return if tester_methode9 == true
    return if tester_methode10 == true
    return if tester_methode11 == true
    return if tester_methode12 == true
    return if tester_methode13 == true
    return if tester_methode14 == true

    pas_aides if tester_methode15 == false
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

  #
  # Si une ile de 8 à quatre voisins, tout relier par des ponts doubles
  #
  def tester_methode3
    # Verification des iles
    @grille.liste_iles.each do |ile|
      if ile.numero == 8 && ile.get_liste_voisins.length == 4 && !ile.est_complete?
        # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
        if @gui.aide_label.text == MethodesTexte::METHODE3_NORMALE
          @gui.aide_label.set_text(MethodesTexte::METHODE3_FACILE)
          ile.afficher_aide
        # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
        elsif @gui.aide_label.text != MethodesTexte::METHODE3_FACILE
          @gui.aide_label.set_text(MethodesTexte::METHODE3_NORMALE)
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
  # Si une ile à un voisins, relier l'ile
  #
  def tester_methode4
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.get_liste_voisins.length == 1 && !ile.est_complete?
        # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
        if @gui.aide_label.text == MethodesTexte::METHODE4_NORMALE
          @gui.aide_label.set_text(MethodesTexte::METHODE4_FACILE)
          ile.afficher_aide
        # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
        elsif @gui.aide_label.text != MethodesTexte::METHODE4_FACILE
          @gui.aide_label.set_text(MethodesTexte::METHODE4_NORMALE)
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
  # Si une ile de 3 à deux voisins, relier 1 pont de chaque
  #
  def tester_methode5
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 3 && ile.get_liste_voisins.length == 2 && !ile.est_complete?

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          #ce n'est pas un pont simple
          unless @grille.get_pont(ile, ile_voisine) != nil && !@grille.get_pont(ile, ile_voisine).double
            puts "pont pas simple avec #{ile_voisine}"
            valid = true
          end
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE5_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE5_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE5_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE5_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Si une ile de 5 à trois voisins, relier 1 pont de chaque
  #
  def tester_methode6
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 5 && ile.get_liste_voisins.length == 3 && !ile.est_complete?

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          # pas de pont sur un voisin
          valid = true if @grille.get_pont(ile, ile_voisine).nil?
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE6_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE6_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE6_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE6_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Si une ile de 7 à 4 voisins, relier 1 pont de chaque
  #
  def tester_methode7
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 7 && ile.get_liste_voisins.length == 4 && !ile.est_complete?

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          # pas de pont sur un voisin
          valid = true if @grille.get_pont(ile, ile_voisine).nil?
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE7_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE7_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE7_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE7_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Si une ile de 3 à 2 voisins dont une ile de 1, relier tous les ponts
  #
  def tester_methode8
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 3 && ile.get_liste_voisins.length == 2 && !ile.est_complete?

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          #Il y a un 1 dans les voisins
          if ile_voisine.numero == 1
            valid = true
          end
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE8_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE8_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE8_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE8_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Si une ile de 5 à 3 voisins dont une ile de 1, relier tous les ponts
  #
  def tester_methode9
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 5 && ile.get_liste_voisins.length == 3 && !ile.est_complete?

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          #Il y a un 1 dans les voisins
          if ile_voisine.numero == 1
            valid = true
          end
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE9_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE9_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE9_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE9_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Si une ile de 7 à 4 voisins dont une ile de 1, relier tous les ponts
  #
  def tester_methode10
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 7 && ile.get_liste_voisins.length == 4 && !ile.est_complete?

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          #Il y a un 1 dans les voisins
          if ile_voisine.numero == 1
            valid = true
          end
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE10_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE10_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE10_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE10_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Si une ile de 4 à 3 voisins dont 2 ile de 1, relier tous les ponts
  #
  def tester_methode11
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 4 && ile.get_liste_voisins.length == 3 && !ile.est_complete?

        nb_ile1 = 0
        ile.get_liste_voisins.each do |ile_voisine|
          #Il y a un 1 dans les voisins
          if ile_voisine.numero == 1
            nb_ile1 += 1
          end
        end

        if nb_ile1 == 2
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE11_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE11_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE11_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE11_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Si une ile de 6 à 4 voisins dont 1 ile de 1, relier un pont sur tous sauf le 1
  #
  def tester_methode12
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 6 && ile.get_liste_voisins.length == 4 && !ile.est_complete?

        nb_ile1 = 0
        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          #Il y a un 1 dans les voisins
          if ile_voisine.numero == 1
            nb_ile1 += 1
          end

          #ce n'est pas un pont simple
          unless @grille.get_pont(ile, ile_voisine) != nil && !@grille.get_pont(ile, ile_voisine).double
            puts "pont pas simple avec #{ile_voisine}"
            valid = true
          end
        end

        if nb_ile1 == 1 && valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE12_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE12_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE12_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE12_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Une ile de 1 ne peux pas être relié à une autre ile de 1
  #
  def tester_methode13
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 1

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          #Il y a un 1 dans les voisins et un pont qui relit les deux iles
          valid = true if ile_voisine.numero == 1 && !@grille.get_pont(ile, ile_voisine).nil?
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE13_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE13_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE13_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE13_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Une ile de 2 ne peux pas être relié à une autre ile de 2
  #
  def tester_methode14
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 2

        valid = false
        ile.get_liste_voisins.each do |ile_voisine|
          #Il y a un 1 dans les voisins et un pont qui relit les deux iles
          valid = true if ile_voisine.numero == 2 && !@grille.get_pont(ile, ile_voisine).nil? && @grille.get_pont(ile, ile_voisine).double
        end

        if valid
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE14_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE14_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE14_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE14_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  #
  # Une ile de 2 ne peux pas être relié à deux iles de 1 (isolement)
  #
  def tester_methode15
    # Verification des iles
    @grille.liste_iles.each do |ile|
      puts "ile #{ile}, nb voisins : #{ile.get_liste_voisins.length}"
      if ile.numero == 2

        nb_ponts_avec1 = 0
        ile.get_liste_voisins.each do |ile_voisine|
          nb_ponts_avec1 += 1 if ile_voisine.numero == 1 && !@grille.get_pont(ile, ile_voisine).nil?
        end

        if nb_ponts_avec1 > 1
          # une aide à déja été demandé pour ce cas => affichage de l'ile concernée
          if @gui.aide_label.text == MethodesTexte::METHODE15_NORMALE
            @gui.aide_label.set_text(MethodesTexte::METHODE15_FACILE)
            ile.afficher_aide
          # Blocage dans l'état aide facile (pour ne pas réafficher l'aide difficile)
          elsif @gui.aide_label.text != MethodesTexte::METHODE15_FACILE
            @gui.aide_label.set_text(MethodesTexte::METHODE15_NORMALE)
          else
            # Réaffichage de la cellule
            ile.afficher_aide
          end

          return true
        end
      end
    end

    false
  end

  def pas_aides
    # Aucune ile ne correspond à la méthode
    @gui.aide_label.set_text(MethodesTexte::AUCUNE_AIDE)
  end
end
