require "gtk3"
require "./MenuProfil.rb"

mainColor = Gdk::RGBA::parse("#003049")

mainWindow = Gtk::Window.new()
mainWindow.override_background_color(:'normal', mainColor)

mainWindow.set_window_position(Gtk::WindowPosition::CENTER)

mainWindow.set_default_size(1280,720)

mainMenu = MenuProfil.new(mainWindow)
mainMenu.show()
