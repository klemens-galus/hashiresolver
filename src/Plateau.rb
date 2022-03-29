# Classe qui va être utilisé pour lire les fichiers de jeu et les stocker dans un tableau

require_relative './Jeu'


class Plateau

  # @plateauFacile => stocke les plateaux de jeux facile
  # @plateauMoyen => stocke les plateaux de jeux moyen
  # @plateauDifficile => stocke les plateaux de jeux difficile


  def Plateau.init
    new
  end

  def initialize
    @plateauFacile = Array.new
    @plateauMoyen = Array.new
    @plateauDifficile = Array.new
  end

  def lireFichier(fichier)
    # Nouveau tableau
    tab = Array.new
    tab_temp = Array.new
    tab_final = Array.new

    #On crée un nouveau jeu
    @plateauFacile.push(Jeu.creer(25))

    # On stocke dans le tableau toutes les lignes du fichier
    IO.foreach(fichier){|block| tab.push(block) }

    # Format lecture : Ile nb {taille, x, y}, Pont nb {ileA, ileB, x, y}
    for block in tab
      tab_final.push(block.split(" "))
    end

    i = 1
    puts nb_ile = tab_final.at(0).at(1).to_i
    while i <= nb_ile

      taille_ile = tab_final.at(i).at(0).to_i
      x = tab_final.at(i).at(1).to_i
      y = tab_final.at(i).at(2).to_i
      @plateauFacile.at(0).ajouterObj(x, y, Ile.creer(taille_ile))
      i+=1
    end

    #j = 0
    #nb_pont = tab_final.at(nb_ile).at(1).to_i
    #while j < nb_pont
    #  ileA = nil
    #  ileB = nil
    #  @plateauFacile.at(1).ajouterObj(0, 2, Pont.creer())
    #  j+=1
    #end


  end

  def afficher
    print @plateauFacile.at(0).to_s
  end

end