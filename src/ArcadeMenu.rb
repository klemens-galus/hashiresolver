require 'gtk3'

class ArcadeMenu

    def initialize(fenetre)
        buildInterface(fenetre)
    end

    def buildInterface(fenetre)
        @builder = Gtk::Builder.new()
        @builder.add_from_file("../asset/glade/arcadeMenu.glade")

        @mainWindow = fenetre
        @builder.get_object("mainWindow").remove(@builder.get_object("arcadeBox"))
        @mainWindow.add(@builder.get_object("arcadeBox"))
        @mainWindow.set_title("Arcade")

        @mainWindow.signal_connect ('destroy') do
            Gtk.main_quit()
        end

        facileBtn = @builder.get_object("facileBtn")
        facileBtn.signal_connect('clicked') do
            puts "Facile";
        end

        normalBtn = @builder.get_object("normalBtn")
        normalBtn.signal_connect('clicked') do
            puts "Normal";
        end

        difficileBtn = @builder.get_object("difficileBtn")
        difficileBtn.signal_connect('clicked') do
            puts "Difficile"
        end

        retourBtn = @builder.get_object("retourBtn")
        retourBtn.signal_connect('clicked') do
            clearWindow()
            mainMenu = MainMenu.new(@mainWindow)
        end 
        
    end

    def clearWindow()
        @mainWindow.remove(@builder.get_object("arcadeBox"))
    end

end