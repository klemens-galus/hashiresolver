require_relative "./Ile"

class Pont

  @@nbPont = 0
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

      @ileA.ajouteLiaision(self, ileB, "N")
      @ileB.ajouteLiaision(self, ileA, "S")

    else orientation == "horizontal"

      @ileA.ajouteLiaision(self, ileB, "O")
      @ileB.ajouteLiaision(self, ileA, "E")

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

  def to_s
    if @taille == 0
      " "
    elsif @taille == 1
      "-"
    else
      "="
    end
  end

end