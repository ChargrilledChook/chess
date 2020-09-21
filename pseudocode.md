1. Initialize a new board with default pieces
2. Allow white to input a move
3. If the move is legal* update the board
4. Re-draw the board
5. If the other player is in checkmate OR the game is stalemated end the game
6. Otherwise repeat step 2 with the other colour

Legal move:
  * The piece can move that way (ie a rook can go cardinally)
  * Board state allows it (ie not blocked by another piece)
  * It is on the board
  * It does not put the player in check
