# Classe qui va stocker la map

class Jeu

  # @jeu => tableau qui va stocker les iles et les ponts

  def Jeu.creer(taille)
    new(taille)
  end

  def initialize(taille)
    @jeu = Array.new(taille)
    @taille = taille
    for x in 0..Math.sqrt(@taille)-1 do
      for y in 0..Math.sqrt(@taille)-1 do
        @jeu.delete_at(x + Math.sqrt(@taille) * y)
        @jeu.insert(x + Math.sqrt(@taille) * y, Array.new.insert(0," "))
      end
    end
  end

  attr_reader :taille

  def getCase(x, y)
    @jeu.at(x + Math.sqrt(@taille) * y).at(0)
  end

  def getTab(x, y)
    @jeu.at(x + Math.sqrt(@taille) * y)
  end

  def estIle(x, y)
    if @jeu.at(x + Math.sqrt(@taille) * y).at(0).class == Ile
      true
    else
      false
    end
  end

  # @jeu.at(0) -> Retourne le tableau dans la case 0
  # @jeu.at(0).at(0) -> Retourne l'objet de la case 0 de la case 0



  def ajouterObj(x, y, obj)
    if(x >= 0 && x < Math.sqrt(@taille)) && (y >=0 && y < Math.sqrt(@taille))
      # Si l'objet est présent dans le tableau dans la case x et y
      tableau = @jeu.at(x + Math.sqrt(@taille) * y)
      unless tableau.include?(obj)
        # On verifie si l'objet que l'on veut ajouter est un pont

        case obj
        when Pont
            # On verifie si le premier est un pont
            if tableau.empty?
              # Si c'est vide, alors on ajoute dans la liste le pont
              tableau.push(obj)
            else
              # Sinon on verifie si c'est un pont
              if tableau.at(0).class == Pont
                # Si c'est un pont, alors on ajoute le pont à la liste des ponts
                tableau.insert(1, obj)
              else
                # Sinon on supprime la case et on réécrit
                tableau.delete_at(0)
                tableau.insert(0, obj)
              end
            end
        else
          # Sinon on supprime la case et on réécrit
          tableau.delete_at(0)
          tableau.insert(0, obj)
        end
      end
    end
  end

  def to_s
    string = ""
    for x in 0..Math.sqrt(@taille)-1 do
      for y in 0..Math.sqrt(@taille)-1 do

        # On test la classe de notre objet
        # Si c'est un Pont, alors on va afficher le pont avec la plus grande valeur entre les deux
        # Si c'est une ile, alors aucun problème
        # Si c'est un @ alors aucun soucis

        case(@jeu.at(x + Math.sqrt(@taille) * y).at(0))
          when Pont
            if @jeu.at(x + Math.sqrt(@taille) * y).size != 1
              # On regarde la taille des deux ponts, et on affiche le plus grand
              if @jeu.at(x + Math.sqrt(@taille) * y).at(0).taille > @jeu.at(x + Math.sqrt(@taille) * y).at(1).taille
                string += (@jeu.at(x + Math.sqrt(@taille) * y).at(0).to_s + " ")
              else
                string += (@jeu.at(x + Math.sqrt(@taille) * y).at(1).to_s + " ")
              end
            else
              string += (@jeu.at(x + Math.sqrt(@taille) * y).at(0).to_s + " ")
            end

          else
            # On affiche normalement
            string += (@jeu.at(x + Math.sqrt(@taille) * y).at(0).to_s + " ")
        end
      end
      string += "\n"
    end
    string
  end

  def testFini
    for x in 0..Math.sqrt(@taille)-1 do
      for y in 0..Math.sqrt(@taille)-1 do

        # Pour chaque case, on va verifier si les iles ont toutes la capaMax
        if getCase(x, y).class == Ile
          if getCase(x, y).capaMaxAtteinte == false
            # Si la case actuel n'a pas atteint sa capaMax, alors on continue le jeu
            return false
          end
        end
      end
    end
    # Si toute les cases ont atteint leur capamax, alors on retourne vrai
    true
  end

end
