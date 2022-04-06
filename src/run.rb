require 'gtk3'
require './MenuProfil'

main_window = Gtk::Window.new

main_window.set_window_position(Gtk::WindowPosition::CENTER)

main_window.set_default_size(1280, 720)

main_menu = MenuProfil.new(main_window)
main_menu.show
