require 'gtk3'

#
# Génère une aide en fonction des solutions possibles durant une partie
#
class Aide

  #
  # Regarde les aides possibles pour une île
  #
  def verif_aide
    aide = Random.new

    case aide.rand(17)
    when 0
      ile4_coins
    when 1
      ile6_cote
    when 2
      ile8_centre
    when 3
      ile12_voisine
    when 4
      ile3_coin_non_liee
    when 5
      ile5_cote_non_liee
    when 6
      ile7_centre_non_liee
    when 7
      ile3_coin_voisine1
    when 8
      ile5_cote_voisine1
    when 9 
      ile7_cote_voisine1
    when 10
      ile4_3voisines_dont_2voisines1
    when 11
      ile6_4voisines_dont_voisine1
    when 12
      ile1_reliee_ile1
    when 13
      ile2_reliee2_ile2
    when 14
      ile2_reliee_2voisines1
    when 15
      ile3_reliee_voisine1_et_reliee2_voisine2
    when 16
      segment_complete_reliee_voisine1
    end
  end

  # Techniques permettant de bien commencer une partie

  # SI île(4) dans un coin ET île(4) pas complètement liée
  #	Afficher(Une île située dans un coin ne peut pas avoir plus de deux îles voisines, et peut donc avoir un maximum de 4 ponts obligatoires)
  #	OU
  #	Afficher(Une île de 4 avec deux voisines est encore présente)
  def ile4_coins
    'Une île située dans un coin ne peut pas avoir plus de deux îles voisines, et peut donc avoir un maximum de 4 ponts obligatoire'
  end

  # SINON SI île(6) sur un côté ET île(6) pas complètement liée
  #	Afficher(Une île située sur un côté ne peut pas avoir plus de trois îles voisines, et peut donc avoir un maximum de 6 ponts obligatoires)
  #	OU
  #	Afficher(Une île de 6 avec trois voisines est encore présente)
  def ile6_cote
    'Une île située sur un côté ne peut pas avoir plus de trois îles voisines, et peut donc avoir un maximum de 6 ponts obligatoires'
  end

  # SINON SI île(8) vers le centre ET île(8) pas complètement liée
  #	Afficher(Une île située vers le centre ne peut pas avoir plus de quatre îles voisines, et peut donc avoir un maximum de 8 ponts obligatoires)
  #	OU
  #	Afficher(Une île de 8 avec quatre voisines est encore présente)
  def ile8_centre
    'Une île située vers le centre ne peut pas avoir plus de quatre îles voisines, et peut donc avoir un maximum de 8 ponts obligatoires'
  end

  # Techniques basiques

  # SI île(1) OU île(2) n'a qu'une seule voisine
  #	Afficher(Une île avec une seule voisine peut être directement reliée à cette dernière)
  #	OU
  #	Afficher(Une île avec une seule voisine est encore présente)
  def ile12_voisine
    'Une île avec une seule voisine peut être directement reliée à cette dernière'
  end

  # SI île(3) dans un coin ET un côté pas lié
  #	Afficher(Une île de 3 située dans un coin peut-être reliée au moins une fois à chacune de ses voisines)
  #	OU
  #	Afficher(Une île de 3 dans un coin peut encore être reliée)
  def ile3_coin_non_liee
    'Une île de 3 située dans un coin peut-être reliée au moins une fois à chacune de ses voisines'
  end

  # SINON SI île(5) sur un côté ET un côté pas lié
  #	Afficher(Une île de 5 située sur un côté peut-être reliée au moins une fois à chacune de ses voisines)
  #	OU
  #	Afficher(Une île de 5 sur un côté peut encore être reliée)
  def ile5_cote_non_liee
    'Une île de 5 située sur un côté peut-être reliée au moins une fois à chacune de ses voisines'
  end

  # SINON SI île(7) vers le centre ET un côté pas lié
  #	Affichier(Une île de 7 située vers le centre peut-être reliée au moins une fois à chacune de ses voisines)
  #	OU
  #	Afficher(Une île de 7 vers le centre peut encore être reliée)
  def ile7_centre_non_liee
    'Une île de 7 située vers le centre peut-être reliée au moins une fois à chacune de ses voisines'
  end

  # SI île(3) dans un coin ET voisine de île(3) est île(1)
  #	Afficher(Une île de 3 située dans un coin possédant une île de 1 comme voisine peut reliée son autre voisine avec tout ses ponts restants)
  #	OU
  #	Afficher(Une île de 3 avec deux îles voisine dont une île de 1 est encore présente)
  def ile3_coin_voisine1
    'Une île de 3 située dans un coin possédant une île de 1 comme voisine peut reliée son autre voisine avec tout ses ponts restants'
  end

  # SINON SI île(5) sur un côté ET voisine de île(5) est île(1)
  #	Afficher(Une île de 5 située sur un côté possédant une île de 1 comme voisine peut reliée toutes ses autres voisines avec tout ses ponts restants)
  #	OU
  #	Afficher(Une île de 5 avec trois îles voisine dont une île de 1 est encore présente)
  def ile5_cote_voisine1
    'Une île de 5 située sur un côté possédant une île de 1 comme voisine peut reliée toutes ses autres voisines avec tout ses ponts restants'
  end

  # SINON SI île(7) sur un côté ET voisine de île(7) est île(1)
  #	Afficher(Une île de 7 située vers le centre possédant une île de 1 comme voisine peut reliée toutes ses autres voisines avec tout ses ponts restants)
  #	OU
  #	Afficher(Une île de 7 avec quatre îles voisine dont une île de 1 est encore présente)
  def ile7_cote_voisine1
    'Une île de 7 située vers le centre possédant une île de 1 comme voisine peut reliée toutes ses autres voisines avec tout ses ponts restants'
  end

  # SI île(4) avec 3 voisines ET deux voisines de île(4) sont île(1)
  #	Afficher(Une île de 4 avec trois îles voisines dont deux d'entre elle sont de 1 doit obligatoirement avoir un pont avec ces dernières)
  #	OU
  #	Afficher(Une île de 4 avec trois îles voisines dont deux îles de 1 est encore présente)
  def ile4_3voisines_dont_2voisines1
    'Une île de 4 avec trois îles voisines dont deux d\'entre elle sont de 1 doit obligatoirement avoir un pont avec ces dernières'
  end

  # SI île(6) avec 4 voisines ET une voisine de île(6) est île(1)
  #	Afficher(Une île de 6 avec quatre voisines dont une île de 1 est obligatoirement reliée une fois aux autres voisines)
  def ile6_4voisines_dont_voisine1
    'Une île de 6 avec quatre voisines dont une île de 1 est obligatoirement reliée une fois aux autres voisines'
  end

  # Techniques d'isolements

  # SI île(1) est reliée à une voisine île(1)
  #	Afficher(Une île de 1 ne peut pas être reliée à une autre île de 1 pour éviter d'être isolée)
  def ile1_reliee_ile1
    'Une île de 1 ne peut pas être reliée à une autre île de 1 pour éviter d\'être isolée'
  end

  # SINON SI île(2) est doublement reliée à une voisine île(2)
  #	Afficher(Une île de 2 ne peut pas être reliée avec deux ponts à une autre île de 2 pour éviter d'être isolée)
  def ile2_reliee2_ile2
    'Une île de 2 ne peut pas être reliée avec deux ponts à une autre île de 2 pour éviter d\'être isolée'
  end

  # SI île(2) est reliée à deux voisines île(1)
  # Afficher(Une île de 2 ne peut pas être reliée à deux autres îles de 1 pour éviter d'être isolée)
  def ile2_reliee_2voisines1
    'Une île de 2 ne peut pas être reliée à deux autres îles de 1 pour éviter d\'être isolée'
  end

  # SINON SI île(3) est reliée à une voisine île(1) et une voisine île(2)
  #	Afficher(Une île de 3 ne peut pas avoir tous ses ponts reliée à une autre île de 1 ainsi qu'à une autre île de 2 pour éviter d'être isolée)
  def ile3_reliee_voisine1_et_reliee2_voisine2
    'Une île de 3 ne peut pas avoir tous ses ponts reliée à une autre île de 1 ainsi qu\'à une autre île de 2 pour éviter d\'être isolée'
  end

  # SI segment d'îles complétées reliée à une voisine île(1)
  #	Afficher(Un segment d'îles complétées ne peut pas finir sur une île de 1 pour éviter d'être isolé)
  def segment_complete_reliee_voisine1
    'Un segment d\'îles complétées ne peut pas finir sur une île de 1 pour éviter d\'être isolé'
  end
end
