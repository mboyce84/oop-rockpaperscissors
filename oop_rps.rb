# Object-oriented "Paper, Rock, Scissors"

# 1. PRS is a game between 2 players. Both players pick a hand of either paper, rock or scissors
# 2. Next, the two hands are compared for a winner and it's either a tie condition (if both hands are the same) or P>R, R>S and S>P

class Player

  attr_accessor :choice
  attr_reader :name

  def initialize(name)
    @name = name
  end

end

class Human < Player

  def picks_hand
    begin
      print "\nChoose your weapon: (R/P/S) > "
      self.choice = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(choice)
  end
end

class Computer < Player

  def picks_hand
    self.choice = Game::CHOICES.keys.sample   
  end

end

class Game

  CHOICES = {'p' => 'paper', 'r' => 'rock', 's' => 'scissors'}

  attr_reader :player, :computer

  def initialize
    @player = Human.new("You")
    @computer = Computer.new("Computer")
  end

  def setup
    system("clear")
    puts "--------- OOP Rock Paper Scissors Ruby Game---------"
    puts "\nRules: Rock defeats (breaks) Scissors, Scissors defeats (cuts) Paper and Paper defeats (covers) Rock. This game is played against the computer."
  end

  def play
    setup
    player.picks_hand
    computer.picks_hand
    compare_hands
    replay
  end

  def replay
    sleep(1)
    puts "\nWould you like to play another round of Rock, Paper, Scissors? (Y/N)"
    play_again_choice = gets.chomp.downcase
    if (play_again_choice == 'y') || (play_again_choice == 'yes')
      puts "\n---------Time for a rematch!---------\n"
      sleep(1)
      game = Game.new.play
    elsif (play_again_choice == 'n') || (play_again_choice == 'no')
      puts "\n---------Thanks for playing!---------\n"
      exit
    else
      puts "\nInvalid response entered. Would You Like to Play again? (Y/N)"
      play_again_choice = gets.chomp.downcase
      replay_game
    end
  end

  def compare_hands
    if player.choice == computer.choice
      puts "\nIt's a Tie! You both picked #{CHOICES[(computer.choice)]} :)"
    # User Wins
    elsif (player.choice == 'r' && computer.choice == 's') || (player.choice == 's' && computer.choice == 'p') || (player.choice == 'r' && computer.choice == 'p')
      puts "\nYou won! You picked #{CHOICES[(player.choice)]} and the computer picked #{CHOICES[(computer.choice)]}."
    else
      puts "\nThe computer won! You picked #{CHOICES[(player.choice)]} and the computer picked #{CHOICES[(computer.choice)]}."
    end
  end

end

game = Game.new.play