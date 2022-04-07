require_relative './AddCommand'
require_relative '../Jeu/Grille'
require_relative './AddCommand'
require_relative './RemCommand'
class UndoRedo

  def initialize(grille)
    @undo = []
    @redo = []
    @grille = grille
  end

  def undoEmpile(a,b)
    puts a,b
    @undo.push( RemCommand.new(a,b,@grille) )
  end

  def redoEmpile(a,b)
    @redo.push( AddCommand.new(a,b,@grille) )
  end

  def undoExecute
    if !@undo.empty?
      ret = @undo.pop
      self.redoEmpile(ret.getA(),ret.getB())
      ret.execute()
    end
  end

  def redoExecute
    if !@redo.empty?
      ret = @redo.pop
      self.undoEmpile(ret.getA(),ret.getB())
      ret.execute()
    end
  end
end

