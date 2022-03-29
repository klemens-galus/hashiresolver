# Classe qui va stocker la map

class Jeu
  
  # @jeu => tableau qui va stocker les iles et les ponts
  
  def Jeu.creer
    new
  end
  
  def initialize
    @jeu = Array.new(25)
    @jeu.fill("@")
  end
  
  def ajouterObj(x, y, obj)
    if(x >= 0 && x < 5) && (y >=0 && y < 5)
      unless @jeu.include?(obj)
          @jeu.delete_at(x + 5 * y)
          @jeu.insert(x + 5 * y, obj)
      end
    end
  end

  def to_s
    string = ""
    for x in 0..4 do
      for y in 0..4 do
        string += (@jeu.at(x + 5 * y).to_s + " ")
      end
      string += "\n"
    end
    string
  end
  
end
