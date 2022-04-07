require 'gtk3'
require_relative 'Grille'
require_relative '../UI/AppColors'
require_relative '../Util/UndoRedo'

#
# Bouton représentant une île
#
class Ile < Gtk::Button
  # @x Position x de l'île dans la grille
  # @y Position y de l'île dans la grille
  # @numero Nombres de ponts attendus par cette île
  # @grille Grille qui contient cette île

  attr_reader :x, :y, :numero, :grille

  def initialize(x, y, numero, grille, undoredo)
    @x = x
    @y = y
    @numero = numero
    @grille = grille
    @liste_ponts = []
    @undoRedo = undoredo
    super(label: numero.to_s)
    set_style
    connect_signals
  end

  #
  # Style général de la case vide
  #
  def set_style
    set_relief(Gtk::ReliefStyle::NONE)
    override_color(:normal, AppColors::ILE_TEXTE_NORMAL)
  end

  #
  # Gestion des signaux
  #
  def connect_signals
    signal_connect 'clicked' do
      # Sélection de la case
      if grille.selected.nil?
        grille.selected = self
        # Debug
        puts "#{self} est selectionnée"
        # Retour visuel de sélection
        add_border

      # Désélection de la case
      elsif grille.selected == self
        grille.selected = nil
        # Debug
        puts "#{self} est deselectionnée"
        # Retour visuel de la désélection
        remove_border

      # Sélection après une autre sélection => essai de création d'un pont
      elsif grille.selected != self && !grille.selected.nil?
        @undoRedo.undoEmpile(grille.selected, self)
        grille.creer_pont(grille.selected, self)



      end
    end
  end

  #
  # Méthode d'ajout d'un pont sur l'île
  #
  # @param [Pont] pont Le pont à ajouter
  #
  def ajouter_pont(pont)
    @liste_ponts << pont
    update_etat_ile
  end

  #
  # Méthode de suppression d'un pont de l'île
  #
  # @param [Pont] pont Le pont à supprimer
  #
  def retirer_pont(pont)
    @liste_ponts.delete(pont)
    update_etat_ile
  end

  #
  # Compte le nombre de ponts en tenant compte des doubles ponts
  #
  # @return [int] Le nombre de ponts
  #
  def nombre_ponts
    count = 0
    @liste_ponts.each do |pont|
      count += 1 if pont.double
      count += 1
    end

    count
  end

  #
  # Change le style de l'île en fonction des ses variables
  #
  def update_etat_ile
    # l'île est complète
    if est_complete?
      override_color(:normal, AppColors::ILE_TEXTE_COMPLETE)
    else
      override_color(:normal, AppColors::ILE_TEXTE_NORMAL)
    end

    override_background_color(:normal, AppColors::ILE_BACKGROUND_TRANSPARENT)
  end

  #
  # Indicatieur visuel de sélection de l'île
  #
  def add_border
    override_color(:normal, AppColors::ILE_TEXTE_SELECTION)
  end

  #
  # Retour à la normal de l'île
  #
  def remove_border
    update_etat_ile
  end

  #
  # Indicateur visuel si l'île est concernée par une aide
  #
  def afficher_aide
    override_background_color(:normal, AppColors::ILE_BACKGROUND_AIDE)
  end

  #
  # Renvoi la liste des iles voisines de l'île
  #
  # @return [Array] Liste d'îles voisines
  #
  def get_liste_voisins
    liste_voisins = []

    # Gauche
    (0..@x - 1).reverse_each do |x|
      child = @grille.get_child_at(x, @y)

      if child.instance_of?(Ile)
        liste_voisins << child
        break
      end
    end

    # Droite
    (@x + 1..@grille.taille - 1).each do |x|
      child = @grille.get_child_at(x, @y)

      if child.instance_of?(Ile)
        liste_voisins << child
        break
      end
    end

    # Haut
    (0..@y - 1).reverse_each do |y|
      child = @grille.get_child_at(@x, y)

      if child.instance_of?(Ile)
        liste_voisins << child
        break
      end
    end

    # Bas
    (@y + 1..@grille.taille - 1).each do |y|
      child = @grille.get_child_at(@x, y)

      if child.instance_of?(Ile)
        liste_voisins << child
        break
      end
    end

    liste_voisins
  end

  def est_complete?
    return true if @numero == nombre_ponts

    false
  end

  def to_s
    "Ile #{@x},#{@y} |#{@numero}|"
  end
end
