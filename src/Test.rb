require_relative "./Ile"
require_relative "./Jeu"
require_relative "./Plateau"

NORD = "N"
SUD = "S"
EST = "E"
OUEST = "O"
V = "vertical"
H = "horizontal"

stock = Plateau.init

stock.lireFichier("Plateau_1_eazy.txt")

=begin
ileA = Ile.creer(5)   #                B7
ileB = Ile.creer(7)   #
ileC = Ile.creer(3)   #         C3     A5     D6
ileD = Ile.creer(6)   #
ileE = Ile.creer(4)   #                E4


pontA = Pont.creer(ileA, ileB, V) # A est au sud de B
pontB = Pont.creer(ileA, ileC, H) # A est à l'est de C
pontC = Pont.creer(ileD, ileA, H) # A est à l'ouest de D
pontD = Pont.creer(ileE, ileA, V) # A est au nord de E

jeu = Jeu.creer


jeu.ajouterObj(0, 2, ileB)
jeu.ajouterObj(2, 0, ileC)
jeu.ajouterObj(2, 2, ileA)
jeu.ajouterObj(2, 4, ileD)
jeu.ajouterObj(4, 2, ileE)

jeu.ajouterObj(1, 2, pontA)
jeu.ajouterObj(2, 1, pontB)
jeu.ajouterObj(2, 3, pontC)
jeu.ajouterObj(3, 2, pontD)
=end


while true

  #system("cls")
  stock.afficher
  card = ""

  loop do

    print("Choississez le pont à ajouter ! (N, S, E, O) \n")
    card = gets.chomp

    if card == 'N' || card == 'S' || card == 'O' || card == 'E'
      break
    end
  end


  #case card
  #when 'N'
  #  ileA.modifiePont(card)
  #when 'S'
  #  ileA.modifiePont(card)
 # when 'O'
 #   ileA.modifiePont(card)
 # when 'E'
 #   ileA.modifiePont(card)
 # else "Erreur"
 # end


end





