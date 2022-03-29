require_relative "./Pont"

class Ile

  # @tailleIle      => Taille de notre ile (le nombre de ponts possibles)
  # @ileVoisine     => Tableau comprenant les iles voisines de notre ile actuel
  # @nbPont         => compte le nombre actuel de ponts // Peut être simplifié par @pont.length
  # @pont           => Tableau comprenant les différents ponts

  # @param [Integer]
  def Ile.creer(taille)
    new(taille)
  end

  def initialize(taille)

    # On définit une taille pour le tableau contenant les iles voisines, comme une ile peut avoir 4 voisines, alors on définit une taille de 4
    @ileVoisine = Array.new(4)

    # On définit un tableau pour le tableau de ponts, qui peut contenir un maximum de "tailleIle" ponts
    @pont = Array.new(4)

    # On définit la taille de l'ile
    @tailleIle = taille

    # On ajoute la liste des iles voisines
    @ileVoisine = [nil, nil, nil, nil]

    # On initialise les ponts à 0
    @nbPont = 0

    @pont = [nil, nil, nil, nil]
  end

  attr_reader :tailleIle
  attr_accessor :nbPont


  ##
  # Retourne vrai si le nombre de pont == la taille de l'ile
  # Sinon faux
  def capaMaxAtteinte
    @nbPont == @tailleIle ? true : false
  end

  def ajouteLiasion(pont, ileB, cardinal)

    case cardinal
    when "N"
      setIleVoisine(ileB, nil, nil, nil)
      @pont.delete_at(0)
      @pont.insert(0, pont)
    when "S"
      setIleVoisine(nil, ileB, nil, nil)
      @pont.delete_at(1)
      @pont.insert(1, pont)
    when "E"
      setIleVoisine(nil, nil, ileB, nil)
      @pont.delete_at(2)
      @pont.insert(2, pont)
    when "O"
      setIleVoisine(nil, nil, nil, ileB)
      @pont.delete_at(3)
      @pont.insert(3, pont)
    else
      "Erreur cardinal"
    end

  end

  ##
  # Modifie la taille du pont entre lui-même et son voisin, l'ile en paramètre en donnée en String et avec son Cardinal
  # @param cardinal : "N", "S", "E", "O"
  def modifiePont(cardinal)

    case cardinal
    when "N"          # Pont entre self et la voisine NORD
      unless @pont.at(0) == nil
        if @pont.at(0).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(0)

          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(0)
        end
      end

    when "S"          # Pont entre self et la voisine SUD

      unless @pont.at(1) == nil
        if @pont.at(1).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(1)

          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(1)
        end
      end

    when "E"          # Pont entre self et la voisine EST

      unless @pont.at(2) == nil
        if @pont.at(2).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(2)

          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(2)
        end
      end

    when "O"          # Pont entre self et la voisine OUEST

      unless @pont.at(3) == nil
        if @pont.at(3).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(3)

          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(3)
        end
      end

    else
      "Erreur, cardinal non trouvé"
    end

  end

  def setIleVoisine(ileN, ileS, ileE, ileO)

    unless ileN == nil
      @ileVoisine.delete_at(0)
      @ileVoisine.insert(0, ileN)
    end
    unless ileS == nil
      @ileVoisine.delete_at(1)
      @ileVoisine.insert(1, ileS)
    end
    unless ileE == nil
      @ileVoisine.delete_at(2)
      @ileVoisine.insert(2, ileE)
    end
    unless ileO == nil
      @ileVoisine.delete_at(3)
      @ileVoisine.insert(3, ileO)
    end

  end

  def pontModife(index)

    # On enlève la taille du pont à notre nbPont mais aussi à sa voisine
    @nbPont -= @pont.at(index).taille

    ileB = @ileVoisine.at(index)
    ileB.nbPont=(ileB.nbPont - @pont.at(index).taille)


    # On modifie le pont 0 du tableau
    @pont.at(index).modifiePont

    # On ajoute la nouvelle taille du pont
    @nbPont += @pont.at(index).taille
    ileB.nbPont=(ileB.nbPont + @pont.at(index).taille)

  end

  def to_s
    "#{@tailleIle}"
  end

end