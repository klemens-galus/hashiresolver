require 'gtk3'

class InterfacePartie

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

        backBtn = @builder.get_object("backBtn")
        backBtn.signal_connect('clicked') do
          back()
        end

        panneauGaucheBox = @builder.get_object("panneauGaucheBox")
        panneauGaucheBox.override_background_color(:"normal", Gdk::RGBA::parse("#004366"))

        panneauHautBox = @builder.get_object("panneauHautBox")
        panneauHautBox.override_background_color(:"normal", Gdk::RGBA::parse("#00507a"))

        panneauBasBox = @builder.get_object("panneauBasBox")
        panneauBasBox.override_background_color(:"normal", Gdk::RGBA::parse("#00507a"))

        aideBox = @builder.get_object("aideBox")
        aideBox.override_background_color(:"normal", Gdk::RGBA::parse("#004366"))

        aideBtn = @builder.get_object("aideBtn")
        aideBtn.override_background_color(:"normal", Gdk::RGBA::parse("#e9e1b7"))

        verifierBtn = @builder.get_object("verifierBtn")
        verifierBtn.override_background_color(:"normal", Gdk::RGBA::parse("#e9e1b7"))

        hypoBtn = @builder.get_object("hypoBtn")
        hypoBtn.override_background_color(:"normal", Gdk::RGBA::parse("#e9e1b7"))

        finHypoBtn = @builder.get_object("finHypoBtn")
        finHypoBtn.override_background_color(:"normal", Gdk::RGBA::parse("#e9e1b7"))

        undoBtn = @builder.get_object("undoBtn")
        undoBtn.override_background_color(:"normal", Gdk::RGBA::parse("#e9e1b7"))

        redoBtn = @builder.get_object("redoBtn")
        redoBtn.override_background_color(:"normal", Gdk::RGBA::parse("#e9e1b7"))

        panneauGaucheBox.name = "panneauGaucheBox"
        panneauHautBox.name = "panneauHautBox"
        panneauBasBox.name = "panneauBasBox"

        aideBox.name = "aideBox"
        aideBtn.name = "aideBtn"
        verifierBtn.name = "verifierBtn"
        hypoBtn.name = "hypoBtn"
        finHypoBtn.name = "finHypoBtn"
        undoBtn.name = "undoBtn"
        redoBtn.name = "redoBtn"

        provider = Gtk::CssProvider.new()
        provider.load(data: <<-CSS)
        #panneauGaucheBox, #panneauHautBox, #panneauBasBox, #aideBox{
            border: 1px solid black;
        }

        #aideBtn, #verifierBtn, #hypoBtn, #finHypoBtn, #undoBtn, #redoBtn{
            font-family: Arial;
            font-size: 15px;
            border-radius: 0;
            color: black;
        }
        CSS

        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)

    end

    def back()

    end

end