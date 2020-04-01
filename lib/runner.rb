require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer'
require './lib/gameplay'
require './lib/player'
require './lib/multiboats'

cruiser1 = Ship.new("Cruiser", 3)
submarine1 = Ship.new("Submarine", 2)
cruiser2 = Ship.new("Cruiser", 3)
submarine2 = Ship.new("Submarine", 2)
board_user = Board.new
board_computer = Board.new
computer = Computer.new(board_user, board_computer)
player = Player.new(board_user, board_computer)
multiboats = Multiboats.new(2)
game = Gameplay.new(board_user, board_computer, computer, player, cruiser1, cruiser2, submarine1, submarine2, multiboats)


game.start
