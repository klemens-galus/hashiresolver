require 'gtk3'
require 'yaml'
require_relative 'Ile'
require_relative 'Pont'
require_relative 'CaseVide'
require_relative 'Orientation'

#
# Grille de jeu contenant les îles et les ponts
#
class Grille < Gtk::Grid
  # @data_niveau Données du niveau actuel
  # @taille Taille de la grille (selon les données du niveau)
  # @selected Ile séléctionnée
  # @liste_ponts Liste des ponts crées

  attr :selected, true

  def initialize(difficulty, niveau)
    @selected = nil
    @liste_ponts = []

    super()
    charger_niveau(difficulty, niveau)
    placer_iles
  end

  #
  # Charge les données du niveau en mémoire
  #
  # @param [String] difficulty La difficulté du niveau choisi
  # @param [String] niveau Le niveau choisi
  #
  def charger_niveau(difficulty, niveau)
    fichier_niveau = File.open("../levels/#{difficulty}/#{niveau}.yml")

    # Récuperation des  données en YAML (format hash)
    @data_niveau = YAML.load(fichier_niveau.read)

    # Taille de la zone de jeu (carré pour l'instant)
    @taille = @data_niveau[:taille]

    # Debug
    puts @data_niveau
  end

  #
  # Initialise la grille avec des cellules 
  #
  # @return [<Type>] <description>
  #
  def placer_iles
    (0..@taille - 1).each do |i|
      (0..@taille - 1).each do |j|
        attach(CaseVide.new, i, j, 1, 1)
      end
    end

    puts @data_niveau[:iles].split('%')

    @data_niveau[:iles].split('%').each do |data_ile|
      pos = data_ile.split('/')[0]
      nombre_ponts = data_ile.split('/')[1]
      x = pos.split(',')[0]
      y = pos.split(',')[1]

      case_vide = get_child_at(x.to_i, y.to_i)
      remove(case_vide)
      puts "creation ile #{x},#{y} |#{nombre_ponts}|"
      attach(Ile.new(x.to_i, y.to_i, nombre_ponts.to_i, self), x.to_i, y.to_i, 1, 1)
    end
  end

  def get_pont(ile1, ile2)
    @liste_ponts.each do |pont|
      if (pont.ile_debut == ile1 && pont.ile_fin == ile2) || (pont.ile_debut == ile2 && pont.ile_fin == ile1)
        return pont
      end
    end
    nil
  end

  #
  # Ajoute les cases qui separent deux iles pour former un pont
  #
  # @param [Pont] pont Le pont a former
  #
  def ajouter_corp_pont(pont)
    if pont.orientation == Orientation::VERTICAL
      (pont.ile_debut.y..pont.ile_fin.y).each do |y|
        pont.ajouter_case_pont(get_child_at(pont.ile_debut.x, y)) unless get_child_at(pont.ile_debut.x,
                                                                                      y).instance_of?(Ile)
      end
    elsif pont.orientation == Orientation::HORIZONTAL
      (pont.ile_debut.x..pont.ile_fin.x).each do |x|
        pont.ajouter_case_pont(get_child_at(x, pont.ile_debut.y)) unless get_child_at(x,
                                                                                      pont.ile_debut.y).instance_of?(Ile)
      end
    end
  end

  def verification_croisement(pont)
    if pont.orientation == Orientation::VERTICAL
      (pont.ile_debut.y..pont.ile_fin.y).each do |y|
        case_pont = get_child_at(pont.ile_debut.x, y)
        return false if !case_pont.instance_of?(Ile) && !case_pont.libre
      end
    elsif pont.orientation == Orientation::HORIZONTAL
      (pont.ile_debut.x..pont.ile_fin.x).each do |x|
        case_pont = get_child_at(x, pont.ile_debut.y)
        return false if !case_pont.instance_of?(Ile) && !case_pont.libre
      end
    end
    true
  end

  def creer_pont(ile1, ile2)
    puts "essai création d'un pont"

    if get_pont(ile1, ile2).nil?
      if ile1.x == ile2.x
        pont = Pont.new(ile1, ile2, Orientation::VERTICAL) if ile1.y < ile2.y
        pont = Pont.new(ile2, ile1, Orientation::VERTICAL) if ile2.y < ile1.y

      elsif ile1.y == ile2.y
        pont = Pont.new(ile1, ile2, Orientation::HORIZONTAL) if ile1.x < ile2.x
        pont = Pont.new(ile2, ile1, Orientation::HORIZONTAL) if ile2.x < ile1.x
      end

      if verification_croisement(pont)
        @liste_ponts << pont

        ile1.ajouter_pont(pont)
        ile2.ajouter_pont(pont)

        ajouter_corp_pont(pont)
        pont.afficher
        puts "pont ajouté : #{pont}"
      end
    else
      pont = get_pont(ile1, ile2)

      if pont.double
        pont.supprimer
        @liste_ponts.delete(pont)
      else
        pont.double = true
        pont.afficher
      end
    end

    ile1.remove_border
    ile2.remove_border
    @selected = nil
  end
end
