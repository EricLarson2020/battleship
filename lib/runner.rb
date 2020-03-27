require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer'
require './lib/gameplay'
require './lib/player'

cruiser1 = Ship.new("Cruiser", 3)
submarine1 = Ship.new("Submarine", 2)
cruiser2 = Ship.new("Cruiser", 3)
submarine2 = Ship.new("Submarine", 2)
board1 = Board.new
board2 = Board.new
computer = Computer.new(board2, board1)
player = Player.new
game = Gameplay.new(board1, board2, computer, player, cruiser1, cruiser2, submarine1, submarine2)


game.start
