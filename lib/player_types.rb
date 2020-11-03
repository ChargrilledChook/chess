# PlayerTypes

# This is a helper module for the round class that centralises all the logic for creating players
# at the beginning of a new game. It's in a module purely for organisation / separation of responsibilites
module PlayerTypes
  def post_initialize(player_types)
    case player_types
    when "1" then @players = two_humans
    when "2" then @players = one_human_one_ai
    when "3" then @players = one_ai_one_human
    when "4" then @players = two_ai
    else
      puts player_selection_error_msg
      exit
    end
  end

  def two_humans
    [Player.new(colour: :white), Player.new(colour: :black)]
  end

  def two_ai
    [ComputerPlayer.new(colour: :white, board: board),
     ComputerPlayer.new(colour: :black, board: board)]
  end

  def one_human_one_ai
    [Player.new(colour: :white), ComputerPlayer.new(colour: :black, board: board)]
  end

  def one_ai_one_human
    [ComputerPlayer.new(colour: :white, board: board), Player.new(colour: :black)]
  end
end
