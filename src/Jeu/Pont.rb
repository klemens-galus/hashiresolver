require_relative 'Orientation'

# Classe représentant un pont
#
class Pont
  # @double Si le pont est simple ou double
  # @ile_debut 1ere ile du pont
  # @ile_fin 2eme ile du pont
  # @double Boolean indiquant si le pont est simple ou double

  attr_reader :ile_debut, :ile_fin, :orientation
  attr :double, true

  def initialize(ile_debut, ile_fin, orientation)
    @double = false
    @ile_debut = ile_debut
    @ile_fin = ile_fin
    @orientation = orientation
    @tableau_case_pont = []
  end

  #
  # Ajoute une case en tant que "corps" du pont
  #
  # @param [CaseVide] case_pont Case à ajouter
  #
  def ajouter_case_pont(case_pont)
    @tableau_case_pont << case_pont
  end

  def to_s
    "Pont entre #{@ile_debut} et #{@ile_fin} |#{@orientation}|"
  end

  #
  # Methode de suppression du pont. Retire le pont des iles puis libères les cases qui le composait
  #
  def supprimer
    ile_debut.retirer_pont(self)
    ile_fin.retirer_pont(self)

    # Libération des cases
    effacer
  end

  #
  # Mise à jour de l'affichage des cases qui compose le pont
  #
  def afficher
    @tableau_case_pont.each do |case_pont|
      # Debug
      puts 'modif affichage case'

      case_pont.afficher_corp_pont_simple(@orientation) unless @double
      case_pont.afficher_corp_pont_double(@orientation) if @double
    end
  end

  #
  # Liberation de toutes les cases qui compose le pont
  #
  def effacer
    @tableau_case_pont.each do |case_pont|
      case_pont.effacer_corp_pont()
    end
  end
end
