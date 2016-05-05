class TicTacToe
  def initialize
    print "\n-=*=- Tic Tac Toe -=*=-\n"
    @player_1 = Player.new
    @player_2 = Player.new
  end
  
  # players - names and marks assigned to players
  
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
      symbol = gets.chomp.upcase!
      until symbol =~ /[OX]/
        puts "Invalid input, O or X only:"
        symbol = gets.chomp.upcase!
      end
      @@first_symbol = symbol
      return symbol
    end
    
    def assign_symbol
      symbol = @@first_symbol == "X" ? "O" : "X"
    end
  end
  
  # board class - contents and current state of the game board
  
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
    
    def mark_position (position, mark)
      # placeholder
    end
    
    def draw_board (cells)
      full_board = []
      cells.each_with_index do |row, index|
        full_board.push(draw_row_contents(row))
        full_board.push(draw_separator) unless index == 2
        full_board.flatten!
      end
      return full_board
    end
    
    def check
      [check_rows, check_columns, check_diagonals].include?(true)
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
    
    def check_rows
      # placeholder
    end
    
    def check_columns
      # placeholder
    end
    
    def check_diagonals
      # placeholder
    end
  end
  
  public
  
  def start
    board = Board.new
    current_player = @player_1
    turn = 1
    while turn < 10
      print_board(board.state) # print current board - OK!
      mark_position(current_player.symbol, board) # get coordinates and modify the cell - OK!
      print_board(board.state)
      if turn > 4
        if board.check # add method
          declare_winner # add method
          break
        end
      end
      declare_tie if turn == 9
      turn += 1
      switch_player # add method
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
    coords = gets.chomp.downcase
    until validate_position(coords, board)
      puts "You can't mark this position. Pick another one:"
      coords = gets.chomp.downcase
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
    return coords =~ /[a-i]/ ? true : false
  end
  
  def position_free? (coords, board)
    free = false
    board.cells.each do |row|
      free = true if row.include?(coords)
    end
    return free
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
  
  def declare_winner
    
  end
  
  def declare_tie
    
  end
  
end

test = TicTacToe.new
test.start