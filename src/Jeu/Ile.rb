require 'gtk3'
require_relative 'Grille'

#
# Bouton représentant une île
#
class Ile < Gtk::Button
  attr_reader :x, :y, :numero, :grille

  def initialize(x, y, numero, grille)
    @x = x
    @y = y
    @numero = numero
    @grille = grille
    @liste_ponts = []

    super(label: numero.to_s)

    set_relief(Gtk::ReliefStyle::NONE)
    override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1))

    signal_connect 'clicked' do
      if grille.selected.nil?
        grille.selected = self
        puts "#{self} est selectionnée"
        add_border

      elsif grille.selected == self
        grille.selected = nil
        puts "#{self} est deselectionnée"
        remove_border

      elsif grille.selected != self && !grille.selected.nil?
        grille.creer_pont(grille.selected, self)

      end
    end
  end

  def ajouter_pont(pont)
    @liste_ponts << pont
    update_etat_ile
  end

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

    return count
  end

  #
  # Change le style de l'ile en fonction des ses variables
  #
  def update_etat_ile
    if nombre_ponts == @numero
      override_color(:normal, Gdk::RGBA.new(0, 1, 0, 1))
    else
      override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1))
    end
  end

  def add_border
    override_color(:normal, Gdk::RGBA.new(1, 0, 0, 1))
  end

  def remove_border
    if nombre_ponts == @numero
      override_color(:normal, Gdk::RGBA.new(0, 1, 0, 1))
    else
      override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1))
    end
  end

  def to_s
    "Ile #{@x},#{@y} |#{@numero}|"
  end
end
