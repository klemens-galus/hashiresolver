# Classe qui va stocker la map

class Jeu
  
  # @jeu => tableau qui va stocker les iles et les ponts
  
  def Jeu.creer(taille)
    new(taille)
  end
  
  def initialize(taille)
    @jeu = Array.new(taille)
    @taille = taille
    @jeu.fill("@")
  end
  
  def ajouterObj(x, y, obj)
    if(x >= 0 && x < Math.sqrt(@taille)) && (y >=0 && y < Math.sqrt(@taille))
      unless @jeu.include?(obj)
          @jeu.delete_at(x + Math.sqrt(@taille) * y)
          @jeu.insert(x + Math.sqrt(@taille) * y, obj)
      end
    end
  end

  def to_s
    string = ""
    for x in 0..Math.sqrt(@taille)-1 do
      for y in 0..Math.sqrt(@taille)-1 do
        string += (@jeu.at(x + Math.sqrt(@taille) * y).to_s + " ")
      end
      string += "\n"
    end
    string
  end
  
end
