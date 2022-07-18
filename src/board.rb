# frozen_string_literal: true

NUM_ROWS = 10
NUM_COLUMNS = 10

class Board
  def initialize(rows = NUM_ROWS, columns = NUM_COLUMNS, initial_state: nil)
    if initial_state
      @rows = initial_state.count
      @columns = initial_state.first.count
      @board = initial_state
      @buffer_board = Array.new(@rows, Array.new(@columns, 0))
    else
      @rows = rows
      @columns = columns
      @board = Array.new(rows, Array.new(columns, 0))
      @buffer_board = Array.new(rows, Array.new(columns, 0))
    end
  end

  attr_reader :rows, :columns

  def each_cell!
    @buffer_board = @board.each_with_index.map do |row, x|
      row.each_with_index.map do |state, y|
        yield x, y, state
      end
    end
    @board = @buffer_board
  end

  def [](x, y)
    @board[x][y]
  end

  def []=(x, y, state)
    @board[x][y] = state
  end

  def render
    # iterate over board and display state of each cell
    # output string representation of board

    # if 0 print .
    # if 1 print X

    # possibly convert each row to string, then join each row with a newline char
  end
end
