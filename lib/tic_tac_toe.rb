class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # TL to BR diagonal
  [2,4,6], # TR to BL diagonal
]

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move (index, token)
  @board[index] = token
end

def position_taken?(index)
  @board[index] == 'X' || @board[index] == 'O'
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(@board, index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(@board, index)
    move(@board, index, token(@board))
    display_board(@board)
  else
    turn(@board)
  end
end

def turn_count
  turns = 0
  @board.each do |space|
    if (space == "X" || space == "O")
      turns += 1
    end
  end
  turns
end

def token
  turn_count(@board).even? ? "X" : "O"
end

def play
turn(@board) until over?(@board)
  if won?(@board)
    puts "Congratulations #{winner(@board)}!"
  elsif draw?(@board)
    puts "Cat's Game!"
  end
end

def won?
  WIN_COMBINATIONS.detect do |combo|
    @board[combo[0]] == @board[combo[1]] &&
    @board[combo[1]] == @board[combo[2]] &&
    position_taken?(@board, combo[0])
  end
end

def full?
  @board.all?{|token| token == "X" || token == "O"}
end

def draw?
  !won?(@board) && full?(@board)
end

def over?
  won?(@board) || draw?(@board)
end

def winner
  if winning_combo = won?(@board)
    @board[winning_combo.first]
  end
end
end
