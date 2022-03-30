require 'gtk3'
require 'gdk3'
require "./MainMenu.rb"


class ClassementMenu

    #@ListeNiveaux Liste des niveaux

    def initialize(fenetre, pseudo)
        @pseudo = pseudo;

        @builder = Gtk::Builder.new()
        @builder.add_from_file("../asset/glade/ClassementMenu.glade")
        @builder.get_object('mainWindow').remove(@builder.get_object("classementBox"))

        @main = fenetre
        @main.add(@builder.get_object("classementBox"))
        mainColor = Gdk::RGBA::parse("#003049")
        secondColor = Gdk::RGBA::parse("#00507a")
        @main.override_background_color(:'normal', mainColor)

        listbox = @builder.get_object('listbox')
        listbox.override_background_color(:'normal', secondColor)
        @main.set_title("Selection du niveau")


        listeScores = Hash.new()

        @ListeNiveaux = Array.new()
        @ListeButton = Array.new()
        @ListeLabels = Array.new()
        @files = Dir.glob("../saves/*")

        @files.each do |n|
            f = File.open(n)
            score = f.read()
            f.close()

            listeScores[File.basename(n, "*")] = score
        end
        

        listeScores.sort_by{|name, score| score.to_i()}.reverse().each do |k,v| 
          label = Gtk::Label.new(k + " : " + v)
          label.name = "score"

          listbox.add(label)
        end
        
   
        provider = Gtk::CssProvider.new()
        provider.load(data: <<-CSS)
        #score{
            font-family: "Pixellari";
            font-size: 65px;
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

        @main.show_all
    end

    def clearWindow()
        @main.remove(@builder.get_object("classementBox"))
    end
end

