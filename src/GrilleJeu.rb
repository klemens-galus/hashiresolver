require 'gtk3'

class GrilleJeu

    def initialize(fenetre)
        buildInterface(fenetre)
    end

    def buildInterface(fenetre)
        @builder = Gtk::Builder.new()
        @builder.add_from_file("../asset/glade/grilleJeu.glade")

        @mainWindow = fenetre
        @builder.get_object("mainWindow").remove(@builder.get_object("grilleJeuBox"))
        @mainWindow.add(@builder.get_object("grilleJeuBox"))
        @mainWindow.set_title("Jeu")

        @mainWindow.signal_connect ('destroy') do
            Gtk.main_quit()
        end

        @mainWindow.override_background_color(:"normal", Gdk::RGBA::parse("#003049"))

       # spacingBox = @builder.get_object("spacingBox")
        #spacingBox.override_background_color(:"normal", Gdk::RGBA::parse("#004366"))

        panneauGaucheBox = @builder.get_object("panneauGaucheBox")
        panneauGaucheBox.override_background_color(:"normal", Gdk::RGBA::parse("#004366"))

        panneauHautBox = @builder.get_object("panneauHautBox")
        panneauHautBox.override_background_color(:"normal", Gdk::RGBA::parse("#00507a"))

        panneauBasBox = @builder.get_object("panneauBasBox")
        panneauBasBox.override_background_color(:"normal", Gdk::RGBA::parse("#00507a"))

        aideBox = @builder.get_object("aideBox")
        aideBox.override_background_color(:"normal", Gdk::RGBA::parse("#004366"))


    end

end