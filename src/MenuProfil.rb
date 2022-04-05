require 'gtk3'
require 'gdk3'
require 'yaml'
require "./MainMenu.rb"

class MenuProfil

    @listeProfil
    #private_class_method :new

    def initialize(fenetre)

      @builder = Gtk::Builder.new()
      @builder.add_from_file("../asset/glade/menuProfil2.glade")
      @mainWindow = fenetre

      @builder.get_object("mainWindow").remove(@builder.get_object("profils"))

      @mainWindow.add(@builder.get_object('profils'))

      mainColor = Gdk::RGBA::parse("#003049")
      secondColor = Gdk::RGBA::parse("#00507a")
      @mainWindow.override_background_color(:'normal', mainColor)

      @listbox = @builder.get_object('listbox')
      @listbox.override_background_color(:'normal', secondColor)
      @mainWindow.set_title("Menu profil")


      @ListeProfil = Array.new()
      @ListeButton = Array.new()
      @ListeLabels = Array.new()
      @files = Dir.glob("../save/*")

      @files.each do |n|
        @ListeProfil.push(File.basename(n,"*"))
      end

      puts(@ListeProfil)
      @ListeProfil.each do |n|
        label = Gtk::Label.new(n)
        @ListeLabels.push(label)



        button = Gtk::Button.new()
        button.add(label);
        button.override_background_color(:'normal', secondColor)
        button.relief = :none
        @ListeButton.push(button)

      end


      #save

      newProfilButton = @builder.get_object("newProfilButton")
      newProfilLabel = @builder.get_object("newProfilLabel")
      newProfilButton.signal_connect "clicked" do
        puts "nouveau profil"
        showNewProfilPopup()
      end

      @ListeLabels.each do |n|
        n.name = "BTNLVL"
      end

      @ListeButton.each do |n|
        n.signal_connect "clicked" do |_widget|
          clearWindow()
          mainMenu = MainMenu.new(@mainWindow, "")
        end
      end

      provider = Gtk::CssProvider.new()
      provider.load(data: <<-CSS)
      #BTNLVL{
          font-family: "Pixellari";
          font-size: 65px;
      }
      CSS
      Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, provider, Gtk::StyleProvider::PRIORITY_APPLICATION)

      @ListeButton.each{ |n| @listbox.add(n)}


      button = Gtk::Button.new(:label => "Say hello")
      button.signal_connect "clicked" do |_widget|
        puts "Hello World!!"
      end

      #main.add(button)
      @mainWindow.signal_connect("delete-event") do |_widget|
        Gtk.main_quit
      end

      @mainWindow.show_all

    end

    def clearWindow()
      @mainWindow.remove(@builder.get_object("profils"))
    end

    def showNewProfilPopup()
      #popup
      popup = Gtk::Window.new("First example")
      popup.show
      popup.set_title "// Edit //"


      box = Gtk::Box.new(:vertical, 10)

      text = Gtk::Entry.new
      text.set_text "Entrez votre nom"

      box.add(text)

      button = Gtk::Button.new "Valider"
      button.signal_connect "clicked" do
        createProfil(text.text)
        popup.close()
      end
      box.add(button)

      popup.add box
      popup.show_all
    end

    def createProfil(name)
      secondColor = Gdk::RGBA::parse("#00507a")
      puts "creation profil de " + name
      File.new("../save/"+name+".yml","w+")
      label = Gtk::Label.new(name)
      button = Gtk::Button.new()
      button.add(label)
      button.relief = :none
      button.override_background_color(:'normal', secondColor)
      button.name="BTNLVL"
      @listbox.add(button)
      @mainWindow.show_all



    end

    def show()
      @mainWindow.show_all()
      Gtk.main()
    end

end
