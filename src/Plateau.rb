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
    @plateauFacile.push(Jeu.creer(100))

    # On stocke dans le tableau toutes les lignes du fichier
    IO.foreach(fichier){|block| tab.push(block) }

    # Format lecture : Ile nb {taille, x, y}, Pont nb {ileA, ileB, x, y}
    for block in tab
      tab_final.push(block.split(" "))
    end

    i = 0

    while i < tab_final.size()

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

    for x in 0..(Math.sqrt(jeu.taille)) - 1
      for y in 0..(Math.sqrt(jeu.taille)) - 1
        # Il faut regarder l'ile en X la plus proche au dessus et au dessous

        ileNord, ileSud, ileOuest, ileEst = nil, nil, nil, nil

        if x > 0 && x < (Math.sqrt(jeu.taille)) - 1
          xIle = x - 1
          trouve = false
          while xIle >= 0 && trouve == false
            # Je pars du haut de notre tableau, et on va chercher l'ile la plus proche au dessus si il y en a une
            if jeu.estIle(xIle, y)
              ileNord = jeu.getCase(xIle, y)
              trouve = true
            else
              xIle-=1
            end
          end

          xIle = x + 1
          trouve = false
          while xIle < 10 && trouve == false
            # Je pars du bas du tableau, et on va chercher l'ile la plus proche au dessous si il y en a une
            if jeu.estIle(xIle, y)
              ileSud = jeu.getCase(xIle, y)
              trouve = true
            else
              xIle+=1
            end
          end
        end

        if y > 0 && y < (Math.sqrt(jeu.taille)) - 1
          yIle = y - 1
          trouve = false
          while yIle >= 0 && trouve == false
            # Je pars du haut de notre tableau, et on va chercher l'ile la plus proche à gauche si il y en a une
            if jeu.estIle(x, yIle)
              ileOuest = jeu.getCase(x, yIle)
              trouve = true
            else
              yIle-=1
            end
          end

          yIle = y + 1
          trouve = false
          while yIle < 10 && trouve == false
            # Je pars du bas du tableau, et on va chercher l'ile la plus proche à droite si il y en a une
            if jeu.estIle(x, yIle)
              ileEst = jeu.getCase(x, yIle)
              trouve = true
            else
              yIle+=1
            end
          end
        end

        unless jeu.estIle(x, y)
          if ileNord != nil && ileSud != nil && ileSud != "@" && ileNord != "@"
            jeu.ajouterObj(x, y, Pont.creer(ileSud, ileNord, "vertical"))
          end
          if ileEst != nil && ileOuest != nil && ileOuest != "@" && ileEst != "@"
            jeu.ajouterObj(x, y, Pont.creer(ileEst, ileOuest, "horizontal"))
          end
        end
      end
    end
  end

  def afficher
    puts @plateauFacile.at(0).to_s
  end

end