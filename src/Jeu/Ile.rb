require 'gtk3'
require_relative 'Grille'
require_relative '../UI/AppColors'

#
# Bouton représentant une île
#
class Ile < Gtk::Button
  # @x Position x de l'ile dans la grille
  # @y Position y de l'ile dans la grille
  # @numero Nombres de pont attendus par cette ile
  # @grille Grille qui contient cette ile

  attr_reader :x, :y, :numero, :grille

  def initialize(x, y, numero, grille)
    @x = x
    @y = y
    @numero = numero
    @grille = grille
    @liste_ponts = []

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
      # Selection de la case
      if grille.selected.nil?
        grille.selected = self
        # Debug
        puts "#{self} est selectionnée"
        # Retour visuel de selection
        add_border

      # Deselction de la case
      elsif grille.selected == self
        grille.selected = nil
        # Debug
        puts "#{self} est deselectionnée"
        # Retour visuel de la deselection
        remove_border

      # Selection apres une autre selection => essai de création d'un pont
      elsif grille.selected != self && !grille.selected.nil?
        grille.creer_pont(grille.selected, self)
      end
    end
  end

  #
  # Methode d'ajout d'un pont sur l'ile
  #
  # @param [Pont] pont Le pont à ajouter
  #
  def ajouter_pont(pont)
    @liste_ponts << pont
    update_etat_ile
  end

  #
  # Methode de suppression d'un pont de l'ile
  #
  # @param [Pont] pont Le pont à supprimer
  #
  def retirer_pont(pont)
    @liste_ponts.delete(pont)
    update_etat_ile
  end

  #
  # Compte de nombre de ponts en tenant compte des doubles ponts
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
  # Change le style de l'ile en fonction des ses variables
  #
  def update_etat_ile
    # l'ile est complete
    if nombre_ponts == @numero
      override_color(:normal, AppColors::ILE_TEXTE_COMPLETE)
    else
      override_color(:normal, AppColors::ILE_TEXTE_NORMAL)
    end
  end

  #
  # Indicatieur visuel de selection de l'ile
  #
  def add_border
    override_color(:normal, AppColors::ILE_TEXTE_SELECTION)
  end

  #
  # Retour à la normal de l'ile
  #
  def remove_border
    update_etat_ile
  end

  def to_s
    "Ile #{@x},#{@y} |#{@numero}|"
  end
end
