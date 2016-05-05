class TicTacToe
  def initialize
    print "\n-=*=- Tic Tac Toe -=*=-\n"
    @player_1 = Player.new
    @player_2 = Player.new
  end

  class Player
    @@player_count = 0;
    @@first_symbol = nil
    attr_reader :name, :symbol
    
    def initialize
      @@player_count += 1
      @name = get_name
      @symbol = @@player_count == 1 ? get_symbol : assign_symbol
      puts "Player #{@@player_count}: #{@name}, mark: #{@symbol}"
    end
    
    private
    
    def get_name
      puts "Please enter your name:"
      name = gets.chomp
    end
    
    def get_symbol
      puts "Please choose your mark (O/X):"
      symbol = get_input
      puts symbol
      until symbol =~ /^[OX]$/
        puts "Invalid input, O or X only:"
        symbol = get_input
      end
      @@first_symbol = symbol
      return symbol
    end
    
    def assign_symbol
      symbol = @@first_symbol == "X" ? "O" : "X"
    end
  end
    
  class Board
    attr_accessor :cells, :state
    def initialize
      @cells = [
        ["a","b","c"],
        ["d","e","f"],
        ["g","h","i"]
      ]
	    @state = draw_board(@cells)
	  end
    
    public

    def draw_board (cells)
      full_board = []
      cells.each_with_index do |row, index|
        full_board.push(draw_row_contents(row))
        full_board.push(draw_separator) unless index == 2
        full_board.flatten!
      end
      return full_board
    end
    
    def check (cells)
      [check_rows(cells), check_columns(cells), check_diagonals(cells)].include?(true)
    end
    
    private
    
    def draw_row_contents (row)
      complete_row = []
      complete_row.push(draw_space, draw_contents(row), draw_space)
    end
    
    def draw_separator
      "===+---+==="
    end
    
    def draw_space
      "   |   |   "
    end
    
    def draw_contents (row)
      " #{row[0]} | #{row[1]} | #{row[2]} "
    end
    
    def check_rows (cells)
      counter = 0
      ["X", "O"].each do |symbol|
        cells.each do |row|
          counter = row.count(symbol)
          return true if counter == 3
        end
      end
      return false
    end
    
    def check_columns (cells)
      counter = 0
      ["X", "O"].each do |symbol|
        [*(0..2)].each do |row|
          [*(0..2)].each do |column|
            if cells[column][row] == symbol
              counter += 1
            end
          end
          return true if counter == 3
          counter = 0
        end
      end
      return false
    end
    
    def check_diagonals (cells)
      counter = 0
      ["X", "O"].each do |symbol|
        [*(0..2)].each do |coord_a|
          counter += 1 if cells[coord_a][coord_a] == symbol
        end
        return true if counter == 3
        counter = 0
        [*(0..2)].each do |coord_a|
          coord_b = 2 - coord_a
          counter += 1 if cells[coord_a][coord_b] == symbol
        end
        return true if counter == 3
        counter = 0
      end
      return false
    end
  end
  
  public
  
  def start
    board = Board.new
    current_player = @player_1
    turn = 1
    while turn < 10
      print_board(board.state) # print current board
      mark_position(current_player.symbol, board) # place a mark on the board
      print_board(board.state) # print updated board
      if turn > 4
        if board.check(board.cells) # check if last move ended the game
          puts "#{current_player.name} wins!"
          break
        end
      end
      if turn == 9
        puts "It's a tie."
        break
      end
      turn += 1
      current_player = current_player == @player_1 ? @player_2 : @player_1 # swap players
      puts "#{current_player.name}'s turn."
    end
  end
  
  def play_again
    loop do
      puts "Would you like to play again? (Y/N)"
      user_input = get_input
      until user_input =~ /^[YN]$/
        puts "Invalid input"
        user_input = get_input
      end
      if user_input == "Y"
        self.start
      else
        break
      end
    end
  end
  
  private
  
  def print_board (state)
    state.each do |row|
      puts row
    end
  end
  
  def mark_position (symbol, board)
    puts "Which position (a-i) do you want to mark?"
    coords = get_input.downcase
    until validate_position(coords, board)
      puts "You can't mark this position. Pick another one:"
      coords = get_input.downcase
      validate_position(coords, board)
    end
    puts "Marked position #{coords} with an #{symbol}."
    update_board(board, coords, symbol)
  end
  
  def validate_position (coords, board)
    position_valid = false
    position_valid = true if input_valid?(coords) && position_free?(coords, board)
  end
  
  def input_valid? (coords)
    return coords =~ /^[a-i]$/ ? true : false
  end
  
  def position_free? (coords, board)
    board.cells.each do |row|
      return true if row.include?(coords)
    end
    return false
  end
  
  def update_board (board, coords, symbol)
    board.cells.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        if cell == coords
          board.cells[row_index][cell_index] = symbol
        end
      end
    end
    board.state = board.draw_board(board.cells)
  end
end

def get_input
  return gets.chomp.upcase
end

new_game = TicTacToe.new
new_game.start
new_game.play_again
