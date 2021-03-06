class TicTacToe

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      end

      def input_to_index(number)
        number.to_i - 1
      end

      def move(array, token = "X")
        @board[array] = token
      end

      def position_taken?(position)
        if @board[position].include?("X") == false
            @board[position].include?("O")
        else
            @board[position].include?("X")
        end
      end

      def valid_move?(position)
        if position.between?(0,8) == true && self.position_taken?(position) == false
            return true
        end
      end

      def turn_count
        @board.count{|token| token == "X" || token == "O"}
      end

      def current_player
        turn_count % 2 == 0 ? "X" : "O"
      end

      def turn
        position = gets
        new_number = self.input_to_index(position)
        if self.valid_move?(new_number) == true
            self.move(new_number, self.current_player)
            self.display_board
        else
            gets
        end
    end

    def won?
        WIN_COMBINATIONS.find do |indices|
            values = @board.values_at(*indices)
            values.all?("X") || values.all?("O")
        end
    end

    def full?
        if @board.any?(" ")
            false
        else
            true
        end
    end

    def draw?
        if !self.won? && self.full?
            true
        elsif !self.full? && !self.won?
            false
        else won?
            false
        end
    end

    def over?
        self.full? || self.draw? || self.won?          
    end

    def winner
        if self.won?
            return @board[self.won?[1]]
        end
    end

    def play
        until self.over?
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}!"
        else self.draw?
            puts "Cat's Game!"
        end

    end
end
