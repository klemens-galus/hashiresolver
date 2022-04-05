require 'gtk3'
require 'gdk3'
require "./MainMenu.rb"
require 'yaml'


class ClassementMenu


    def initialize(fenetre, pseudo)
        @pseudo = pseudo;

        buildInterface(fenetre)
        populateClassementList()
        applyCSS()
        connectSignals()

        @window.show_all
    end

    def buildInterface(fenetre)
        @builder = Gtk::Builder.new()
        @builder.add_from_file("../asset/glade/ClassementMenu.glade")
        @builder.get_object('mainWindow').remove(@builder.get_object("classementBox"))

        @window = fenetre
        @window.add(@builder.get_object("classementBox"))
        mainColor = Gdk::RGBA::parse("#003049")
        secondColor = Gdk::RGBA::parse("#00507a")
        @window.override_background_color(:'normal', mainColor)

        @listbox = @builder.get_object('listbox')
        @listbox.override_background_color(:'normal', secondColor)
        @window.set_title("Selection du niveau")
    end

    def populateClassementList()
        listeScores = Hash.new()

        files = Dir.glob("../saves/*")

        files.each do |n|
            data = YAML.load(File.read(n))
            listeScores[File.basename(n, ".*")] = data[:score]
        end
        

        listeScores.sort_by{|name, score| score}.reverse().each do |k,v| 
          label = Gtk::Label.new(k + " : " + v.to_s)
          label.name = "score"

          @listbox.add(label)
        end

    end

    def applyCSS()
        provider = Gtk::CssProvider.new()
        provider.load(data: <<-CSS)
        #score{
            font-family: "Pixellari";
            font-size: 65px;
        }
        CSS
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)
    end

    def connectSignals()
        retourBtn = @builder.get_object("retourBtn")
        retourBtn.signal_connect('clicked') do
            clearWindow()
            mainMenu = MainMenu.new(@window, @pseudo)
        end

        retourBtn.signal_connect('enter-notify-event') do
            @builder.get_object("retourImage").set_from_file("../asset/images/return_hover.png");
        end
        retourBtn.signal_connect('leave-notify-event') do
            @builder.get_object("retourImage").set_from_file("../asset/images/return.png");
        end
    end

    def clearWindow()
        @window.remove(@builder.get_object("classementBox"))
    end
end

