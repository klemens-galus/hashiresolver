require "gtk3"
require "./SecondWindowTest.rb"
require "./ArcadeMenu.rb"
require "./Astuces.rb"

class MainMenu
  def initialize(fenetre, pseudo)
    @pseudo = pseudo
    buildInterface(fenetre)
  end

  def buildInterface(fenetre)
    @builder = Gtk::Builder.new()
    @builder.add_from_file("../asset/glade/mainMenu.glade")

    @mainWindow = fenetre
    @builder.get_object("mainWindow").remove(@builder.get_object("mainMenuBox"))
    @mainWindow.add(@builder.get_object("mainMenuBox"))
    @mainWindow.set_title("Main Menu")

    @mainWindow.signal_connect "destroy" do
      Gtk.main_quit()
    end

    @bienvenueLabel = @builder.get_object("bienvenueLabel")
    @bienvenueLabel.set_text("Bienvenue " + @pseudo)

    continuerBtn = @builder.get_object("continuerBtn")
    continuerBtn.signal_connect('clicked') do
      play()
    end

    arcadeBtn = @builder.get_object("arcadeBtn")
    arcadeBtn.signal_connect('clicked') do
      arcade()
    end

    tutoBtn = @builder.get_object("tutoBtn")
    tutoBtn.signal_connect('clicked') do
      tuto()
    end
  end

  def show()
    @mainWindow.show_all()
    Gtk.main()
  end

  def play()
    puts "Je lance play"
    clearWindow()
    secondWindow = SecondWindowTest.new(@mainWindow)
  end

  def arcade()
    puts("je lance l'arcade")
    clearWindow()
    arcadeWindow = ArcadeMenu.new(@mainWindow, @pseudo)
  end

  def tuto()
    puts("je lance le tuto")
    clearWindow()
    tutoWindow = Astuces.new(@mainWindow, @pseudo)
  end

  def clearWindow()
    @mainWindow.remove(@builder.get_object("mainMenuBox"))
  end
end
