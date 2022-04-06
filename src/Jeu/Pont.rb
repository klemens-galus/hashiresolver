require_relative 'Orientation'

# Classe représentant un pont
#
class Pont
  # @double Si le pont est simple ou double
  # @ile_debut 1ere ile du pont
  # @ile_fin 2eme ile du pont

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

  def supprimer
    ile_debut.retirer_pont(self)
    ile_fin.retirer_pont(self)
    effacer
  end

  def afficher
    @tableau_case_pont.each do |case_pont|
      puts 'modif affichage case'

      case_pont.afficher_corp_pont_simple(@orientation) unless @double
      case_pont.afficher_corp_pont_double(@orientation) if @double
    end
  end

  def effacer
    @tableau_case_pont.each do |case_pont|
      case_pont.effacer_corp_pont()
    end
  end
end
