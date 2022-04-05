require 'gtk3'

class InterfaceArcade

    def initialize()
        builder = Gtk::Builder.new()
        builder.add_from_file("../asset/glade/arcadeMenu")

        mainWindow = builder.get_object('mainWindow')
        mainWindow.set_title("Main Menu")

        mainWindow.signal_connect "destroy" do
            Gtk.main_quit()
        end

        mainWindow.set_window_position(Gtk::WindowPosition::CENTER)

        mainWindow.override_background_color(:"normal", Gdk::RGBA::parse("#003049"))

        facileBtn = builder.get_object("facileBtn")
        facileBtn.signal_connect("clicked"){
            puts "Facile";
        }

        normalBtn = builder.get_object("normalBtn")
        normalBtn.signal_connect("clicked"){

            puts "Normal";
        }

        difficileBtn = builder.get_object("difficileBtn")
        difficileBtn.signal_connect("clicked"){

            puts "Difficile"
        }
    
        mainWindow.show_all()
    end

end


InterfaceArcade.new()

Gtk.main()