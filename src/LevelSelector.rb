require 'gtk3'
require 'gdk3'
require "./ArcadeMenu.rb"


class LevelSelector

    #@ListeNiveaux Liste des niveaux

    def initialize(fenetre, diff, pseudo)
        @pseudo = pseudo;

        mainColor = Gdk::RGBA::parse("#003049")
        secondColor = Gdk::RGBA::parse("#00507a")

        @builder = Gtk::Builder.new()
        @builder.add_from_file("../asset/glade/LevelSelector2.glade")
        @builder.get_object('mainWindow').remove(@builder.get_object("levels"))
        @main = fenetre
        @main.add(@builder.get_object("levels"))
        @main.override_background_color(:'normal', mainColor)

        listbox = @builder.get_object('listbox')
        listbox.override_background_color(:'normal', secondColor)
        @main.set_title(diff.capitalize())


        @listeNiveaux = Array.new()
        @listeButton = Array.new()
        @listeLabels = Array.new()

        @files = Dir.glob("../levels/"+diff+"/*")

        @files.each{ |n| @listeNiveaux.push(File.basename(n,"*"))}
        puts(@listeNiveaux)
        @listeNiveaux.each{ |n|
          label = Gtk::Label.new(n)
          @listeLabels.push(label)

          button = Gtk::Button.new()
          button.add(label)
          button.override_background_color(:'normal', secondColor)
          button.relief = Gtk::ReliefStyle::NONE
          @listeButton.push(button)
        
        }
        @listeLabels.each{ |n| n.name = "BTNLVL"}
        
        @listeButton.each{ |n|
          n.signal_connect "clicked" do |_widget| puts "Hello ";
          end
        }
   
        provider = Gtk::CssProvider.new()
        provider.load(data: <<-CSS)
        #BTNLVL{
            font-family: "Pixellari";
            font-size: 65px;
        }
        CSS
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
        
        @listeButton.each{ |n| listbox.add(n)}


        button = Gtk::Button.new(:label => "Say hello")
        button.signal_connect "clicked" do |_widget|
          puts "Hello World!!"
        end

        retourBtn = @builder.get_object("retourBtn")
        retourBtn.signal_connect('clicked') do
            clearWindow()
            mainMenu = ArcadeMenu.new(@main, @pseudo)
        end

        retourBtn.signal_connect('enter-notify-event') do
            @builder.get_object("retourImage").set_from_file("../asset/images/return_hover.png");
        end
        retourBtn.signal_connect('leave-notify-event') do
            @builder.get_object("retourImage").set_from_file("../asset/images/return.png");
        end



        #main.add(button)
        @main.signal_connect("delete-event") { |_widget| Gtk.main_quit }
        @main.show_all
    end

    def clearWindow()
        @main.remove(@builder.get_object("levels"))
    end

end

