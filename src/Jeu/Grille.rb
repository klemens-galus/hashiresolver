require 'gtk3'
require 'yaml'
require_relative 'Ile'
require_relative 'Pont'
require_relative 'CaseVide'
require_relative 'Orientation'
require_relative 'VictoirePopup'
#
# Grille de jeu contenant les îles et les ponts
#
class Grille < Gtk::Grid
  # @data_niveau Données du niveau actuel
  # @taille Taille de la grille (selon les données du niveau)
  # @selected Ile séléctionnée
  # @liste_ponts Liste des ponts crées
  # @liste_iles Liste des iles du niveau (utilisée pour la verification de victoire)
  # @gui Le menu qui contient la grille

  attr :selected, true
  attr_reader :liste_ponts, :taille, :liste_iles

  def initialize(difficulty, niveau, gui)
    @selected = nil
    @liste_ponts = []
    @liste_iles = []
    @gui = gui

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
  # Initialise la grille avec des cellules vides puit place les iles par rapport aux données
  #
  def placer_iles
    # Placement case vides
    (0..@taille - 1).each do |i|
      (0..@taille - 1).each do |j|
        attach(CaseVide.new, i, j, 1, 1)
      end
    end

    # Debug
    puts @data_niveau[:iles].split('%')

    # Lecture des données pour placer les iles
    @data_niveau[:iles].split('%').each do |data_ile|
      pos = data_ile.split('/')[0]
      nombre_ponts = data_ile.split('/')[1]
      x = pos.split(',')[0]
      y = pos.split(',')[1]

      # Récuperation de la case vide à l'endroit voulu pour echanger avec l'ile
      case_vide = get_child_at(x.to_i, y.to_i)
      remove(case_vide)

      # Debug
      puts "creation ile #{x},#{y} |#{nombre_ponts}|"

      # Ajout de l'ile dans la grille
      ile = Ile.new(x.to_i, y.to_i, nombre_ponts.to_i, self)
      attach(ile, x.to_i, y.to_i, 1, 1)

      # Ajout de l'ile dans la liste pour la verification de victoire
      @liste_iles << ile
    end
  end

  #
  # Recherche d'un pont entre deux iles
  #
  # @param [Ile] ile1 Premiere ile du pont
  # @param [Ile] ile2 Seconde ile du pont
  #
  # @return [Pont] Pont trouvé ou nil si aucun pont entre les deux iles
  #
  def get_pont(ile1, ile2)
    @liste_ponts.each do |pont|
      # Verification dans les deux sens (ile1 => ile2 et ile2 => ile1)
      if (pont.ile_debut == ile1 && pont.ile_fin == ile2) || (pont.ile_debut == ile2 && pont.ile_fin == ile1)
        return pont
      end
    end

    # Aucun pont trouvé
    nil
  end

  #
  # Ajoute les cases qui separent deux iles pour former un pont
  #
  # @param [Pont] pont Le pont a former
  #
  def ajouter_corp_pont(pont)
    if pont.orientation == Orientation::VERTICAL
      # Parcours de cases qui séparent deux iles verticales
      (pont.ile_debut.y..pont.ile_fin.y).each do |y|
        # Ajout de la case seulement si ce n'est pas une ile (permet de passer les iles des bouts)
        pont.ajouter_case_pont(get_child_at(pont.ile_debut.x, y)) unless get_child_at(pont.ile_debut.x,
                                                                                      y).instance_of?(Ile)
      end
    elsif pont.orientation == Orientation::HORIZONTAL
      # Meme principe pour des iles horizontales
      (pont.ile_debut.x..pont.ile_fin.x).each do |x|
        pont.ajouter_case_pont(get_child_at(x, pont.ile_debut.y)) unless get_child_at(x,
                                                                                      pont.ile_debut.y).instance_of?(Ile)
      end
    end
  end

  #
  # Verifie si le pont que l'on veut créer croise un autre pont ou rencontre une ile
  #
  # @param [Pont] pont Le pont à verifier
  #
  # @return [Boolean] true si le pont peut être créer, false sinon
  #
  def verification_croisement(pont)
    if pont.orientation == Orientation::VERTICAL
      # Verification de toutes les cases pour un pont à la vertical
      (pont.ile_debut.y + 1..pont.ile_fin.y - 1).each do |y|
        case_pont = get_child_at(pont.ile_debut.x, y)
        # detection si une case n'est pas libre ou si une ile est sur le chemin du pont
        return false if case_pont.instance_of?(Ile) || !case_pont.libre
      end
    elsif pont.orientation == Orientation::HORIZONTAL
      # Meme principe pour l'horizontal
      (pont.ile_debut.x + 1..pont.ile_fin.x - 1).each do |x|
        case_pont = get_child_at(x, pont.ile_debut.y)
        return false if case_pont.instance_of?(Ile) || !case_pont.libre
      end
    end
    # Toutes les cases sont valides, le pont peut être crée
    true
  end

  #
  # Création d'un pont entre deux iles
  #
  # @param [Ile] ile1 Premiere ile du pont
  # @param [Ile] ile2 Seconde ile du pont
  #
  def creer_pont(ile1, ile2)
    # Debug
    puts "essai création d'un pont"

    # Cas où le pont souhaité n'existe pas
    if get_pont(ile1, ile2).nil?
      # Memes x => pont vertical
      if ile1.x == ile2.x
        # Création des ponts avec ile_depart.x < ile_fin.x pour avoir tous les ponts dans le même sens
        pont = Pont.new(ile1, ile2, Orientation::VERTICAL) if ile1.y < ile2.y
        pont = Pont.new(ile2, ile1, Orientation::VERTICAL) if ile2.y < ile1.y

      # Même y => pont horizontal
      elsif ile1.y == ile2.y
        # Création des ponts avec ile_depart.y < ile_fin.y pour avoir tous les ponts dans le même sens
        pont = Pont.new(ile1, ile2, Orientation::HORIZONTAL) if ile1.x < ile2.x
        pont = Pont.new(ile2, ile1, Orientation::HORIZONTAL) if ile2.x < ile1.x
      end

      if !pont.nil? && verification_croisement(pont)
        # Ajout du pont dans la liste, les iles et affichage du pont
        @liste_ponts << pont

        ile1.ajouter_pont(pont)
        ile2.ajouter_pont(pont)

        ajouter_corp_pont(pont)

        # Met à jour l'affichage de toutes les parties du pont
        pont.afficher

        # Debug
        puts "pont ajouté : #{pont}"
      end
    else # Cas où le pont existe déjà

      pont = get_pont(ile1, ile2)

      if pont.double
        pont.supprimer
        @liste_ponts.delete(pont)
      else
        pont.double = true
        # Mise a jour de l'affichage de toutes les parties du pont pour afficher un pont double
        pont.afficher
      end
    end

    # Deselection des iles à la fin de la création du pont
    ile1.remove_border
    ile2.remove_border
    @selected = nil

    # Verification de victoire
    gagner if check_victoire
  end

  #
  # Verification de toutes les iles pour la victoire
  #
  def check_victoire
    # Verification de la completion de chaques iles
    @liste_iles.each do |ile|
      return false if ile.numero != ile.nombre_ponts
    end

    true
  end


  # Retourne un score en fonction du temps et de la difficulté
def calcul_score
  case @diff
  when 'facile'
    return 10000 / @chrono.temps                    # Donc 120 secondes donne => 10000 / 120 un score de 83.33
  when 'normal'
    return 10000 / @chrono.temps * 2                # Donc 120 secondes donne => 10000 / 120 * 2 un score de 166.66
  when 'difficile'
    return 10000 / @chrono.temps * 5                # Donc 120 secondes donne => 10000 / 120 * 5 un score de 416.66
  else
    return nil
  end
end

#
# Fonction de gestion de la victoire
#
def gagner
  @gui.stop_chrono
  @gui.sauvegarder_grille

  score = calcul_score

  VictoirePopup.popup(score)
end

end
