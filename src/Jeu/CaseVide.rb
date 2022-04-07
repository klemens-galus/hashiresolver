require 'gtk3'
require_relative '../UI/AppColors'
require_relative 'Orientation'

#
# Bouton représentant une case vide
#
class CaseVide < Gtk::Button

  # @libre Boolean pour savoir si la case est déjà uttilisée par un pont

  attr :libre, true

  def initialize
    super
    @libre = true

    set_style
  end

  #
  # Style général de la case vide
  #
  def set_style
    # Pas de fond
    set_relief(Gtk::ReliefStyle::NONE)

    # Non clickable
    set_sensitive(false)

    # Couleure du texte
    override_color(:normal, AppColors::ILE_TEXTE_NORMAL)
  end

  #
  # Affichage de cette case pour un pont simple en fonction de l'orientation
  #
  # @param [Orientation] orientation Orientation du pont au quel appartient cette case
  #
  def afficher_corp_pont_simple(orientation)
    @libre = false

    if orientation == Orientation::HORIZONTAL
      set_label('--')
    elsif orientation == Orientation::VERTICAL
      set_label('|')
    end
  end

  #
  # Affichage de cette case pour un pont double en fonction de l'orientation
  #
  # @param [Orientation] orientation Orientation du pont au quel appartient cette case
  #
  def afficher_corp_pont_double(orientation)
    @libre = false

    if orientation == Orientation::HORIZONTAL
      set_label('==')
    elsif orientation == Orientation::VERTICAL
      set_label('||')
    end
  end

  #
  # Liberation de la case
  #
  def effacer_corp_pont
    @libre = true

    set_label('')
  end
end
