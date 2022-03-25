require_relative "./Ile"

NORD = "N"
SUD = "S"
EST = "E"
OUEST = "O"
V = "vertical"
H = "horizontal"

ileA = Ile.creer(5)   #               B
ileB = Ile.creer(7)   #
ileC = Ile.creer(3)   #         C     A     D
ileD = Ile.creer(6)   #
ileE = Ile.creer(4)   #               E


pontA = Pont.creer(ileA, ileB, V) # A est au sud de B
pontB = Pont.creer(ileA, ileC, H) # A est à l'est de C
pontC = Pont.creer(ileD, ileA, H) # A est à l'ouest de D
pontD = Pont.creer(ileE, ileA, V) # A est au nord de E


ileA.modifiePont(NORD)
ileA.modifiePont(EST)
ileA.modifiePont(OUEST)
ileA.modifiePont(OUEST)
ileA.modifiePont(OUEST)
ileA.modifiePont(EST)
ileA.modifiePont(SUD)




print(ileA.to_s + "\n")
print(ileB.to_s + "\n")
print(ileC.to_s + "\n")
print(ileD.to_s + "\n")
print(ileE.to_s + "\n")


