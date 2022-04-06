require 'gtk3'
require_relative 'Orientation'

#
# Bouton représentant une case vide
#
class CaseVide < Gtk::Button

  attr :libre, true

  def initialize
    super
    @libre = true
    set_relief(Gtk::ReliefStyle::NONE)
    override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1))
  end

  def afficher_corp_pont_simple(orientation)
    @libre = false
    if orientation == Orientation::HORIZONTAL
      set_label('----')
    elsif orientation == Orientation::VERTICAL
      set_label('|')
    end
  end

  def afficher_corp_pont_double(orientation)
    @libre = false
    if orientation == Orientation::HORIZONTAL
      set_label('====')
    elsif orientation == Orientation::VERTICAL
      set_label('||')
    end
  end

  def effacer_corp_pont
    @libre = true
    set_label('')
  end
end
