require 'gtk3'

class MainMenu

  def initialize()
    builder = Gtk::Builder.new()
    builder.add_from_file("./ressources/glade/Jeu.glade")

    mainWindow = builder.get_object('window')
    mainWindow.set_title("Jeu")

    mainWindow.signal_connect "destroy" do
      Gtk.main_quit()
    end

    mainWindow.set_window_position(Gtk::WindowPosition::CENTER)

    mainWindow.show_all()
  end

end