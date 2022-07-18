# frozen_string_literal: true
require 'byebug'
require_relative './board'

class GameOfLife
  def initialize(rows, columns, initial_state: nil)
    @rows = rows
    @columns = columns

    if initial_state
      @board = Board.new(rows, columns, initial_state: initial_state)
    else
      @board = Board.new(rows, columns)
      init_with_random(@board)
    end
  end

  attr_reader :board, :rows, :columns

  def init_with_random(board)
    # iterate cells and randomly set to alive or dead
  end

  def start(num_iterations: nil)
    if num_iterations
      num_iterations.times { update_board }
      return
    end

    loop { update_board }
  end

  def update_board
    board.each_cell! { |x, y, state| update_cell(x, y, state) }
  end

  def update_cell(x, y, state)
    # handle general case where cell is surrounded by 8 cells
    if (x > 0 && x < (rows - 1)) && (y > 0 && y < (columns - 1))
      return update_middle_cell(x, y, state)
    end

    # handle case of corners
    if x == 0 && y == 0
      return update_upper_left_cell(state)
    elsif x == 0 && y == columns - 1
      return update_upper_right_cell(state)
    elsif x == (rows - 1) && y == 0
      return update_lower_left_cell(state)
    elsif x == (rows - 1) && y == columns - 1
      return update_lower_right_cell(state)
    end

    # handle case of edge
    return update_top_edge_cell(x, y, state) if x == 0
    return update_left_edge_cell(x, y, state) if y == 0
    return update_right_edge_cell(x, y, state) if y == columns - 1
    return update_bottom_edge_cell(x, y, state) if x == rows - 1
  end

  def update_logic(state, live_neighbors)
    # set to dead due to overpopulation
    return 0 if live_neighbors > 3

    # continue to live if 2 or 3 live neighbors
    return 1 if state == 1 && live_neighbors == 3 || live_neighbors == 2

    # set to dead if live cell has less than 2 live neighbors
    return 0 if state == 1 && live_neighbors < 2

    # set dead to live if exactly 3 live neighbors
    return 1 if state == 0 && live_neighbors == 3
  end

  def update_upper_left_cell(state)
    live_neighbors = [board[0, 1], board[1, 0], board[1, 1]].reduce(:+)
    update_logic(state, live_neighbors)
  end

  def update_lower_left_cell(state)
    live_neighbors = [board[(rows - 2), 0], board[(rows - 2), 1], board[(rows - 1), 1]].reduce(:+)
    update_logic(state, live_neighbors)
  end

  def update_upper_right_cell(state)
    live_neighbors = [board[0, (columns - 2)], board[1, (columns - 2)], board[1, (columns - 1)]].reduce(:+)
    update_logic(state, live_neighbors)
  end

  def update_lower_right_cell(state)
    live_neighbors = [board[(rows - 1), (columns - 2)], board[(rows - 2), (columns - 2)], board[(rows - 2), (columns - 1)]].reduce(:+)
    update_logic(state, live_neighbors)
  end

  def update_top_edge_cell(x, y, state)
    live_neighbors = [board[0, (y - 1)], board[1, (y - 1)], board[1, y],
                      board[1, (y + 1)], board[0, (y + 1)]].reduce(:+)
    update_logic(state, live_neighbors)
  end

  def update_left_edge_cell(x, y, state)
    live_neighbors = [board[(x - 1), 0], board[(x - 1), 1],
                      board[x, 1], board[(x + 1), 1],
                      board[(x + 1), 0]].reduce(:+)
    update_logic(state, live_neighbors)
  end

  def update_right_edge_cell(x, y, state)
    live_neighbors = [board[(x - 1), y], board[(x - 1), (y - 1)],
                      board[x, (y - 1)], board[(x + 1), (y - 1)],
                      board[(x + 1), y]].reduce(:+)
    update_logic(state, live_neighbors)
  end

  def update_bottom_edge_cell
  end

  def update_middle_cell
  end
end
