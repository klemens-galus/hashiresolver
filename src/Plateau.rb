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

  attr_reader :plateauFacile
  attr_reader :plateauMoyen
  attr_reader :plateauDifficile

  def lireFichier(fichier)
    # Nouveau tableau
    tab = Array.new
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
      @plateauFacile.at(0).ajouterObj(x, y, Ile.creer(taille_ile, x, y))
      i+=1
    end
    setLiaison
  end

  def setLiaison

    jeu = @plateauFacile.at(0)

    x = 0
    y = 0

    for x in 0..Math.sqrt(jeu.taille) - 1
      for y in 0..Math.sqrt(jeu.taille) - 1
        if jeu.estIle(x - 1, y) && jeu.estIle(x + 1, y)
          puts "ajout H"
          jeu.ajouterObj(x, y, Pont.creer(jeu.getCase(x + 1, y), jeu.getCase(x - 1, y), "vertical"))
        end
        if jeu.estIle(x, y - 1) && jeu.estIle(x, y + 1)
          puts "ajout V"
          jeu.ajouterObj(x, y, Pont.creer(jeu.getCase(x, y + 1), jeu.getCase(x, y - 1), "horizontal"))
        end
      end
    end
  end

  def afficher
    puts @plateauFacile.at(0).to_s
  end

end