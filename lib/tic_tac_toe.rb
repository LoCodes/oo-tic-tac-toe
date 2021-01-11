require 'pry'


class TicTacToe

    attr_accessor :board

    # WIN_COMBINATIONS
    # defines a constant WIN_COMBINATIONS with arrays for each win combination 

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]
  


#  #initialize
#    assigns an instance variable @board to an array with 9 blank spaces " "
    def initialize
        @board = board || Array.new(9, " ")
    end 

# #display_board
# prints arbitrary arrangements of the board

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end 


# #input_to_index
#  accepts the user's input (a string) as an argument 
#  converts the user's input (a string) into an integer
#  converts the user's input from the user-friendly format (on a 1-9 scale) 
#    to the array-friendly format (where the first index starts at 0)

    def input_to_index(input)
        input.to_i - 1
 #       binding.pry
    end 


#  #move
#  allows "X" player in the top left and "O" in the middle   

    def move(index, token)
        @board[index] = token
    end 

#     #position_taken?
#     returns true/false based on whether the position on the board is already occupied

    def position_taken?(index)
        @board[index] != " "
    end 

# #valid_move?
# returns true/false based on whether the position is already occupied
# checks that the attempted move is within the bounds of the game board

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end 

#   #turn_count
#   counts occupied positions    

    def turn_count
        @board.count{|square| square != " " }
    end 
 
# #current_player
# returns the correct player, X, for the third move
# returns the correct player, O, for the fourth move
  
    def current_player 
        turn_count.even? ? "X" : "O"
    end 
 
# #turn
# receives user input via the gets method
# calls #input_to_index, #valid_move?, and #current_player
# makes valid moves and displays the board
# asks for input again after a failed validation
  
 
    def turn
        puts "Please enter a number (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
          token = current_player
          move(index, token)
        else
          turn
        end
        display_board
      end

# #won?
# returns false for a draw
# returns the winning combo for a win

      def won?
        WIN_COMBINATIONS.any? do |combo|
          if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
            return combo
          end
        end
      end

# #full?
# returns true for a draw
# returns false for an in-progress game

      def full?
        @board.all?{|square| square != " " }
      end 

# #draw?
# returns true for a draw
# returns false for a won game
# returns false for an in-progress game    

      def draw?
        full? && !won?
      end

#  #over?
#  returns true for a draw
#  returns true for a won game
#  returns false for an in-progress game     

      def over?
        won? || draw?
      end

# #winner
# return X when X won
# returns O when O won
# returns nil when no winner
      
      def winner
        if combo = won?
          @board[combo[0]]
        end
      end
    
      def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
      end
end 


# #play
#   asks for players input on a turn of the game
#   checks if the game is over after every turn
#   plays the first turn of the game
#   plays the first few turns of the game
#   checks if the game is won after every turn
#   checks if the game is draw after every turn
#   stops playing if someone has won
#   congratulates the winner X
#   congratulates the winner O
#   stops playing in a draw
#   prints "Cat's Game!" on a draw
#   plays through an entire game