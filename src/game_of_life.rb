# frozen_string_literal: true

require_relative './board'

class GameOfLife
  def initialize(rows, columns, initial_state)
    if initial_state
      @board = Board.new(rows, columns, initial_state)
    else
      @board = Board.new(rows, columns)
      init_with_random(@board)
    end
  end

  attr_reader :board

  def init_with_random(board)
    # iterate cells and randomly set to alive or dead
  end

  def start(num_iterations)
    if num_iterations
      num_iterations.times { update_board }
      return
    end

    # iterate over each cell, apply game rules
    loop { update_board }
  end

  def update_board
    # N^2 O complexity
    # iterate over all cells and call update_cell for each one
    board.each_cell { |x, y, state| update_cell(x, y, state) }
  end

  # Apply rules of Game of Life
  # NOTE: Encapsulate the rules in another object if we want to make it general, different games etc
  # TODO: Definitely write test cases for corners, borders, etc
  def update_cell(x, y, state)

    # handle case of corners

    # handle case of edge

    # handle general case where cell is surrounded by 8 cells

    # board[x,y]
  end
end


game = GameOfLife.new(20, 20)
game.start
