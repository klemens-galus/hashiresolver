require 'gtk3'
require 'gdk3'
require "./ArcadeMenu.rb"


class Astuces

  def remplir(file)
    fich = File.open(file)
    rep = fich.read()
    fich.close()
    return rep

  end
  def initialize(fenetre, pseudo)
    @pseudo = pseudo;
    @text = nil
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
    num_page = 0
    text_page[0] = remplir("../asset/textes/Apage1.txt")
    text_page[1] = remplir("../asset/textes/Apage2.txt")
    text_page[2] = remplir("../asset/textes/Apage3.txt")
    text_page[3] = remplir("../asset/textes/Apage4.txt")
    text_page[4] = remplir("../asset/textes/Apage5.txt")

    tview = @builder.get_object("viewtext")
    tbuf = Gtk::TextBuffer.new
    tview.set_buffer tbuf

    tbuf.set_text(text_page[0])
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
      if(num_page>0)
        num_page = num_page-1
        tbuf.set_text(text_page[num_page])
      end
    end

    backBtn.signal_connect('enter-notify-event') do
      @builder.get_object("backImg").set_from_file("../asset/images/boutons/gauche/gauche_hover.png");
    end
    backBtn.signal_connect('leave-notify-event') do
      @builder.get_object("backImg").set_from_file("../asset/images/boutons/gauche/gauche.png");
    end

    forwBtn = @builder.get_object("forwBtn")
    forwBtn.signal_connect('clicked') do
      if(num_page<4)
        num_page = num_page+1
        tbuf.set_text(text_page[num_page])
      end
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

