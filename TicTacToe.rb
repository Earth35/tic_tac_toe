class TicTacToe
  def initialize
    print "\n-=*=- Tic Tac Toe -=*=-\n"
    @player_1 = Player.new
    @player_2 = Player.new
    @board = Board.new
    @current_player = @player_1
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
    
    private
    
    def draw_board (cells)
      full_board = []
      cells.each_with_index do |row, index|
        full_board.push(draw_row_contents(row))
        full_board.push(draw_separator) unless index == 2
        full_board.flatten!
      end
      return full_board
    end
    
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
  end
  
  # TicTacToe methods - define the flow and validations
  
  
end

test = TicTacToe.new