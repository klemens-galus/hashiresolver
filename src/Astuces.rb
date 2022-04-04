require 'gtk3'
require 'gdk3'
require "./ArcadeMenu.rb"


class Astuces

  def remplir(file)
    fich = File.open(file)
    puts fich.read()
    fich.close()

  end
  def initialize(fenetre, pseudo)
    @pseudo = pseudo;
    mainColor = Gdk::RGBA::parse("#003049")
    secondColor = Gdk::RGBA::parse("#00507a")

    @builder = Gtk::Builder.new()
    @builder.add_from_file("../asset/glade/Astuces.glade")
    @builder.get_object('mainWindow').remove(@builder.get_object("astuces"))
    @main = fenetre
    @main.add(@builder.get_object("astuces"))
    @main.override_background_color(:'normal', mainColor)

    @main.set_title("Astuces")

    text_page = Array.new 5

    text_page[0] = "Tout pont débute et finit sur une île. \n
Deux îles ne peuvent pas être reliées par plus de deux ponts.\n
Aucun pont ne peut en croiser un autre.\n
Tous les ponts sont en ligne droite, à l'horizontale ou à la verticale.\n
Le nombre de ponts qui passent sur une île est le nombre indiqué sur l'île.\n
Toutes les îles doivent être reliées entre elles."
    remplir("test.txt")

    tview = @builder.get_object("viewtext")
    tbuf = Gtk::TextBuffer.new
    tview.set_buffer tbuf

    tbuf.set_text(text_page[0]);
    tview.name = "BUFF"

    tview.override_background_color(:'normal', secondColor)

    provider = Gtk::CssProvider.new()
    provider.load(data: <<-CSS)
        #BUFF{
            font-family: "Pixellari";
            font-size: 25px;
        }
        button:hover{
          background: transparent;
        }
    CSS
    Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
    retourBtn = @builder.get_object("retourBtn")
    retourBtn.signal_connect('clicked') do
      clearWindow()
      mainMenu = MainMenu.new(@main, @pseudo)
    end

    retourBtn.signal_connect('enter-notify-event') do
      @builder.get_object("retourImage").set_from_file("../asset/images/return_hover.png");
    end
    retourBtn.signal_connect('leave-notify-event') do
      @builder.get_object("retourImage").set_from_file("../asset/images/return.png");
    end


    backBtn = @builder.get_object("backBtn")
    backBtn.signal_connect('clicked') do
      clearWindow()
      mainMenu = ArcadeMenu.new(@main, @pseudo)
    end

    backBtn.signal_connect('enter-notify-event') do
      @builder.get_object("backImg").set_from_file("../asset/images/boutons/gauche/gauche_hover.png");
    end
    backBtn.signal_connect('leave-notify-event') do
      @builder.get_object("backImg").set_from_file("../asset/images/boutons/gauche/gauche.png");
    end

    forwBtn = @builder.get_object("forwBtn")
    forwBtn.signal_connect('clicked') do
      clearWindow()
      mainMenu = ArcadeMenu.new(@main, @pseudo)
    end

    forwBtn.signal_connect('enter-notify-event') do
      @builder.get_object("forwImg").set_from_file("../asset/images/boutons/droite/droite_hover.png");
    end
    forwBtn.signal_connect('leave-notify-event') do
      @builder.get_object("forwImg").set_from_file("../asset/images/boutons/droite/droite.png");
    end

    @main.signal_connect("delete-event") { |_widget| Gtk.main_quit }
    @main.show_all
  end

  def clearWindow()
    @main.remove(@builder.get_object("astuces"))
  end

end

