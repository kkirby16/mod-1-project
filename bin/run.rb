require_relative "../config/environment"
require_relative "../lib/cli"

cli = CommandLineInterface.new
cli.greet
cli.main_menu_options
