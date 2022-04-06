require_relative "./Pont"
require 'gtk3'

class Ile < Gtk::Button

  # @tailleIle      => Taille de notre ile (le nombre de ponts possibles)
  # @ileVoisine     => Tableau comprenant les iles voisines de notre ile actuel
  # @nbPont         => compte le nombre actuel de ponts // Peut être simplifié par @pont.length
  # @pont           => Tableau comprenant les différents ponts

  # @param [Integer]
  def Ile.creer(jeu, taille, x, y)
    new(jeu ,taille, x, y)
  end

  def initialize(jeu, taille, x, y)

    @jeu = jeu # Pour connaitre les iles et les ponts
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

    @pont = [Array.new, Array.new, Array.new, Array.new]

    @x = x
    @y = y
  end

  attr_reader :pont
  attr_reader :tailleIle
  attr_accessor :nbPont
  attr_reader :x, :y


  def trouvePont(pont, x, y)
    # Retourne vrai si un pont est déjà contruit sur la ligne du pont que l'on veut poser
    cases = @jeu.getTab(x, y)
    if cases.size > 1
      # Il y a plusieurs ponts dessus
      puts "Plusieurs ponts"
      if cases.at(0) != pont
        # C'est pas notre pont en paramètre donc besoin de le tester
        puts "Pas notre pont 0"
        if cases.at(0).taille != 0
          # C'est un pont contruit donc on vrai
          puts "Il y a un pont 0"
          return true
        end
      else
        if cases.at(1) != pont
          # C'est pas notre pont non plus
          puts "Pas notre pont 1"
          if cases.at(1).taille != 0
            # C'est un pont contruit donc on vrai
            puts "Il y a un pont 1"
            return true
          end
        end
      end
      # Si tout cela n'est pas vérifier, alors il n'y a pas de pont de construit
      puts "Il n'y a pas de pont"
      false
    end
  end

  ##
  # Retourne vrai si le nombre de pont == la taille de l'ile
  # Sinon faux
  def capaMaxAtteinte
    @nbPont == @tailleIle ? true : false
  end

  def ajouteLiaision(pont, ileB, cardinal)

    case cardinal
    when "N"
      setIleVoisine(ileB, nil, nil, nil)
      @pont.at(0).push(pont)
    when "S"
      setIleVoisine(nil, ileB, nil, nil)
      @pont.at(1).push(pont)
    when "E"
      setIleVoisine(nil, nil, ileB, nil)
      @pont.at(2).push(pont)
    when "O"
      setIleVoisine(nil, nil, nil, ileB)
      @pont.at(3).push(pont)
    else
      "Erreur cardinal"
    end

  end

  ##
  # Modifie la taille du pont entre lui-même et son voisin, l'ile en paramètre en donnée en String et avec son Cardinal
  # @param cardinal : "N", "S", "E", "O"
  def initModif(cardinal, x, y)

    case cardinal
    when "N"          # Pont entre self et la voisine NORD
      ileB = @ileVoisine.at(0)
      unless @pont.at(0).at(0) == nil
        if @pont.at(0).at(0).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte || ileB.capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(0, x, y)
          else
            case @pont.at(0).at(0).taille
            when 1
              pontModife(0, x, y)
              pontModife(0, x, y)
            else
              pontModife(0, x, y)
              pontModife(0, x, y)
              pontModife(0, x, y)
            end
          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(0, x, y)
        end
      end

    when "S"          # Pont entre self et la voisine SUD
      ileB = @ileVoisine.at(1)
      unless @pont.at(1).at(0) == nil
        if @pont.at(1).at(0).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte || ileB.capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(1, x, y)
          else
            case @pont.at(1).at(0).taille
            when 1
              pontModife(1, x, y)
              pontModife(1, x, y)
            else
              pontModife(1, x, y)
              pontModife(1, x, y)
              pontModife(1, x, y)
            end
          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(1, x, y)
        end
      end

    when "E"          # Pont entre self et la voisine EST
      puts "E"
      ileB = @ileVoisine.at(2)
      unless @pont.at(2).at(0) == nil
        if @pont.at(2).at(0).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte || ileB.capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(2, x, y)
          else
            case @pont.at(2).at(0).taille
            when 1
              pontModife(2, x, y)
              pontModife(2, x, y)
            else
              pontModife(2, x, y)
              pontModife(2, x, y)
              pontModife(2, x, y)
            end
          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(2, x, y)
        end
      end

    when "O"          # Pont entre self et la voisine OUEST
      ileB = @ileVoisine.at(3)
      unless @pont.at(3).at(0) == nil
        if @pont.at(3).at(0).taille != 2
          # Si le pont ajoute des ponts

          unless capaMaxAtteinte || ileB.capaMaxAtteinte
            # Si la capaMax est pas atteinte

            pontModife(3, x, y)

          else
            case @pont.at(3).at(0).taille
            when 1
              pontModife(3, x, y)
              pontModife(3, x, y)
            else
              pontModife(3, x, y)
              pontModife(3, x, y)
              pontModife(3, x, y)
            end
          end
        else
          # Le pont est supprimer donc on peut ne pas tester la capaMax

          pontModife(3, x, y)
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

  def pontModife(index, x, y)


    # On enlève la taille du pont à notre nbPont mais aussi à sa voisine
    @nbPont -= @pont.at(index).at(0).taille

    ileB = @ileVoisine.at(index)
    ileB.nbPont=(ileB.nbPont - @pont.at(index).at(0).taille)

    aPont = false
      # On modifie tout les ponts du tableau
      for i in 0..@pont.at(index).size - 1
        if trouvePont(@pont.at(index).at(i), @pont.at(index).at(i).x, @pont.at(index).at(i).y)
          aPont = true
        end
      end

    if aPont == false
      for i in 0..@pont.at(index).size - 1
        @pont.at(index).at(i).modifiePont
      end
    end



    # On ajoute la nouvelle taille du pont
    @nbPont += @pont.at(index).at(0).taille
    ileB.nbPont=(ileB.nbPont + @pont.at(index).at(0).taille)

  end

  def to_s
    "#{@tailleIle}"
  end

end
