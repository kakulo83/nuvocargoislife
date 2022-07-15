# frozen_string_literal: true

NUM_ROWS = 10
NUM_COLUMNS = 10

class Board
  def initialize(rows = NUM_ROWS, columns = NUM_COLUMNS, initial_state)
    # We use a 'buffer' grid to write the new state, calculating it from the old grid state
    @old_grid = Array.new(rows, Array.new(columns, 0))
    @current_grid = Array.new(rows, Array.new(columns, 0))
    @rows = rows
    @columns = columns

    if initial_state
      # consume inital_state and populate grid accordingly
    end
  end

  attr_reader :rows, :columns

  def each_cell
    @old_grid.each_with_index do |row, x|
      row.each_with_index do |state, y|
        yield x, y, state
      end
    end
    @old_grid = @current_grid
  end

  def [](x, y)
    @old_grid[x][y]
  end

  def []=(x, y, state)
    @current_grid[x][y] = state
  end

  def render
    # iterate over board and display state of each cell
    # output string representation of board

    # if 0 print .
    # if 1 print X

    # possibly convert each row to string, then join each row with a newline char
  end
end
