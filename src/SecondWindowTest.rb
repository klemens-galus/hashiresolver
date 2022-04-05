require "gtk3"

class SecondWindowTest
  def initialize(fenetre)
    buildInterface(fenetre)
  end

  def buildInterface(fenetre)
    @builder = Gtk::Builder.new()
    @builder.add_from_file("../asset/glade/secondMenu.glade")

    @mainWindow = fenetre
    @builder.get_object("mainWindow").remove(@builder.get_object("box1"))
    @mainWindow.add(@builder.get_object("box1"))
    @mainWindow.set_title("Second Menu")

    mainColor = Gdk::RGBA::parse("#003049")

    @mainWindow.override_background_color(:'normal', mainColor)

    @mainWindow.signal_connect "destroy" do
      Gtk.main_quit()
    end

    @mainWindow.set_window_position(Gtk::WindowPosition::CENTER)
  end

  def show()
    @mainWindow.show_all()
    Gtk.main()
  end
end
