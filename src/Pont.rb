require_relative "./Ile"

class Pont

  # @ileA
  # @ileB
  # @taille

  ##
  # Constructeur de la classe Pont
  # @param ileA : Si vertical alors Sud du pont, si horizontale, alors Ouest du pont
  # @param ileB : Si vertical alors Nord du pont, si horizontale, alors Est du pont
  # @param orientation : Soit vertical, soit horizontale
  def Pont.creer(ileA, ileB, orientation)
    new(ileA, ileB, orientation)
  end

  ##
  # Initialisateur de la classe Pont, qui prend 2 iles en paramètres
  # @param [Ile, Ile], 2 iles
  #
  def initialize(ileA, ileB, orientation)

    @ileA = ileA
    @ileB = ileB
    @taille = 0
    if orientation == "vertical"

      @ileA.ajouteLiasion(self, ileB, "N")
      @ileB.ajouteLiasion(self, ileA, "S")

    else orientation == "horizontal"

      @ileA.ajouteLiasion(self, ileB, "E")
      @ileB.ajouteLiasion(self, ileA, "O")

    end


  end

  def taille
    @taille
  end

  ##
  # Permet de changer la taille du pont
  # Si le pont est égal à 0 ou 1, alors on incrémente
  # Si le pont est égal à 2, alors on passe à 0
  # @return [Integer, String] : la taille, ou une erreur
  def modifiePont

    case @taille
    when 0
      @taille = 1
    when 1
      @taille = 2
    when 2
      @taille = 0
    else
      "Error"
    end
  end

  ##
  # Retourne un String en fonction de la taille du pont
  # Taille = 0 : " "
  # Taille = 1 : "-"
  # Taille = 2 : "="
  def affichePont

    case @taille
    when 0
      " "
    when 1
      "-"
    when 2
      "="
    else
      "Error"
    end

  end

  def to_s
    "Taille : #{@taille}"
  end

end