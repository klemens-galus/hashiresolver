require 'yaml'
require 'gtk3'
require_relative '../Jeu/Grille'
require_relative '../Jeu/Ile'
require_relative '../Jeu/Pont'
require_relative '../Jeu/Chronometre'

class Sauvegardeur
  private_class_method :new

  def self.sauvegarder_niveau_arcade(difficulte, niveau, pseudo, grille, chrono)
    fichier_joueur = File.open("../saves/#{pseudo}.yml", 'r')
    puts "#{difficulte}, #{niveau}, #{pseudo}, #{grille}, #{chrono}"

    data_joueur = YAML.load(fichier_joueur.read)
    fichier_joueur.close
    puts data_joueur

    data_joueur[:arcade][difficulte.to_sym][niveau.to_sym] = {
      ponts: {
        ile_debut: [],
        ile_fin: [],
        double: []
      },
      temps: chrono.temps
    }

    grille.liste_ponts.each do |pont|
      data_joueur[:arcade][difficulte.to_sym][niveau.to_sym][:ponts][:ile_debut] << "#{pont.ile_debut.x},#{pont.ile_debut.y}"
      data_joueur[:arcade][difficulte.to_sym][niveau.to_sym][:ponts][:ile_fin] << "#{pont.ile_fin.x},#{pont.ile_fin.y}"
      data_joueur[:arcade][difficulte.to_sym][niveau.to_sym][:ponts][:double] << pont.double
    end

    fichier_joueur = File.open("../saves/#{pseudo}.yml", 'w')

    fichier_joueur << (data_joueur.to_yaml)
    fichier_joueur.close
  end
end
