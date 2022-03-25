require "gtk3"
require "./SecondWindowTest.rb"
require "./ArcadeMenu.rb"

class MainMenu
  def initialize()
    buildInterface()
  end

  def buildInterface()
    @builder = Gtk::Builder.new()
    @builder.add_from_file("../asset/glade/mainMenu.glade")
p
    @mainWindow = @builder.get_object("mainWindow")
    @mainWindow.set_title("Main Menu")

    mainColor = Gdk::RGBA::parse("#003049")

    @mainWindow.override_background_color(:'normal', mainColor)

    @mainWindow.signal_connect "destroy" do
      Gtk.main_quit()
    end

    @mainWindow.set_window_position(Gtk::WindowPosition::CENTER)

    continuerBtn = @builder.get_object("continuerBtn")
    continuerBtn.signal_connect('clicked') do
      play()
    end

    arcadeBtn = @builder.get_object("arcadeBtn")
    arcadeBtn.signal_connect('clicked') do
      arcade()
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
    arcadeWindow = ArcadeMenu.new(@mainWindow)
  end

  def clearWindow()
    @mainWindow.remove(@builder.get_object("mainMenuBox"))
  end
end
