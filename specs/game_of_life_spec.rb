# frozen_string_literal: true

require_relative '../src/game_of_life'

RSpec.describe GameOfLife do
  describe '#init_with_random' do
    xit 'populates the board randomly' do
    end
  end

  describe '#start' do
    subject { described_class.new(10, 10) }

    context 'when num_iterations is defined' do
      it 'invokes update_board num_iterations times' do
        num_iterations = 3
        allow(subject).to receive(:update_board)
        expect(subject).to receive(:update_board).exactly(num_iterations).times

        subject.start(num_iterations: num_iterations)
      end
    end
  end

  describe '#update_board' do
    xit 'it invokes each_ceil! on board' do
    end
  end

  describe '#update_cell' do
    let(:board) { double('board') }
    let(:initial_state) do
      [
        [1, 1, 0, 1],
        [0, 0, 1, 1],
        [1, 1, 1, 0],
        [0, 0, 0, 0]
      ]
    end

    subject { described_class.new(4, 4, initial_state: initial_state) }

    before do
      allow(subject).to receive(:update_upper_left_cell)
      allow(subject).to receive(:update_lower_left_cell)
      allow(subject).to receive(:update_upper_right_cell)
      allow(subject).to receive(:update_lower_right_cell)
      allow(subject).to receive(:update_top_edge_cell)
      allow(subject).to receive(:update_left_edge_cell)
      allow(subject).to receive(:update_right_edge_cell)
      allow(subject).to receive(:update_bottom_edge_cell)
      allow(subject).to receive(:update_middle_cell)
    end

    context 'when the cell is at the upper-left corner' do
      it 'calls #update_upper_left_cell' do
        expect(subject).to receive(:update_upper_left_cell)
        subject.update_cell(0, 0, 1)
      end
    end

    context 'when the cell is at the upper-right corner' do
      it 'calls #update_upper_right_cell' do
        expect(subject).to receive(:update_upper_right_cell)
        subject.update_cell(0, 3, 1)
      end
    end

    context 'when the cell is at the lower-left corner' do
      it 'calls #update_lower_right_cell' do
        expect(subject).to receive(:update_lower_left_cell)
        subject.update_cell(3, 0, 0)
      end
    end

    context 'when the cell is at the lower-right corner' do
      it 'calls #update_lower_right_cell' do
        expect(subject).to receive(:update_lower_right_cell)
        subject.update_cell(3, 3, 0)
      end
    end

    context 'when the cell is on the top edge' do
      it 'calls #update_top_edge_cell' do
        expect(subject).to receive(:update_top_edge_cell)
        subject.update_cell(0, 2, 0)
      end
    end

    context 'when the cell is on the left edge' do
      it 'calls #update_left_edge_cell' do
        expect(subject).to receive(:update_left_edge_cell)
        subject.update_cell(1, 0, 0)
      end
    end

    context 'when the cell is on the right edge' do
      it 'calls #update_right_edge_cell' do
        expect(subject).to receive(:update_right_edge_cell)
        subject.update_cell(2, 3, 1)
      end
    end

    context 'when the cell is on the bottom edge' do
      it 'calls #update_bottom_edge_cell' do
        expect(subject).to receive(:update_bottom_edge_cell)
        subject.update_cell(3, 1, 0)
      end
    end

    context 'when the cell is not on a corner or edge' do
      it 'calls #update_middle_cell' do
        expect(subject).to receive(:update_middle_cell)
        subject.update_cell(1, 1, 0)
      end
    end
  end

  context 'when updating cells' do
    let(:initial_state) do
      [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ]
    end

    subject { described_class.new(4, 4, initial_state: initial_state) }

    describe '#update_upper_left_cell' do
      it 'sets cell to dead if less than 2 live neighbours' do
        subject.board[0, 0] = 1
        expect(subject.update_upper_left_cell(1)).to eq(0)
      end

      it 'sets cell to live if 2 or 3 live neighbours' do
        subject.board[1, 0] = 1
        subject.board[1, 1] = 1
        expect(subject.update_upper_left_cell(0)).to eq(1)
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
        subject.board[1, 0] = 1
        subject.board[1, 1] = 1
        subject.board[0, 1] = 1
        expect(subject.update_upper_left_cell(1)).to eq(1)
      end
    end

    describe '#update_lower_left_cell' do
      it 'sets cell to dead if less than 2 live neighbours' do
        subject.board[3, 0] = 1
        expect(subject.update_lower_left_cell(1)).to eq(0)
      end

      it 'sets cell to live if 2 or 3 live neighbours' do
        subject.board[2, 0] = 1
        subject.board[2, 1] = 1
        expect(subject.update_lower_left_cell(0)).to eq(1)
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
        subject.board[2, 0] = 1
        subject.board[2, 1] = 1
        subject.board[3, 1] = 1
        expect(subject.update_lower_left_cell(0)).to eq(1)
      end
    end

    describe '#update_upper_right_cell' do
      it 'sets cell to dead if less than 2 live neighbours' do
        subject.board[0, 3] = 1
        expect(subject.update_upper_right_cell(1)).to eq(0)
      end

      it 'sets cell to live if 2 or 3 live neighbours' do
        subject.board[0, 2] = 1
        subject.board[1, 2] = 1
        expect(subject.update_upper_right_cell(0)).to eq(1)
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
        subject.board[0, 2] = 1
        subject.board[1, 2] = 1
        subject.board[1, 3] = 1
        expect(subject.update_upper_right_cell(0)).to eq(1)
      end
    end

    describe '#update_lower_right_cell' do
      it 'sets cell to dead if less than 2 live neighbours' do
        subject.board[3, 3] = 1
        expect(subject.update_lower_right_cell(1)).to eq(0)
      end

      it 'sets cell to live if 2 or 3 live neighbours' do
        subject.board[3, 2] = 1
        subject.board[2, 2] = 1
        subject.board[2, 3] = 1
        expect(subject.update_lower_right_cell(1)).to eq(1)
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
        subject.board[3, 2] = 1
        subject.board[2, 2] = 1
        subject.board[2, 3] = 1
        expect(subject.update_lower_right_cell(0)).to eq(1)
      end
    end

    describe '#update_top_edge_cell' do
      it 'sets cell to dead if less than 2 live neighbors' do
        subject.board[0, 1] = 1
        expect(subject.update_top_edge_cell(0, 1, 1)).to eq(0)
      end

      it 'sets cell to live if 2 or 3 live neighbors' do
        subject.board[0, 1] = 1
        subject.board[0, 0] = 1
        subject.board[0, 2] = 1
        expect(subject.update_top_edge_cell(0, 1, 0)).to eq(1)
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
        subject.board[0, 0] = 1
        subject.board[0, 2] = 1
        expect(subject.update_top_edge_cell(0, 1, 0)).to eq(1)
      end

      it 'sets live cell to dead if 4 or more live neighbors' do
        subject.board[0, 1] = 1
        subject.board[0, 0] = 1
        subject.board[1, 0] = 1
        subject.board[1, 1] = 1
        subject.board[0, 2] = 1
        expect(subject.update_top_edge_cell(0, 1, 1)).to eq(0)
      end
    end

    describe '#update_left_edge_cell' do
      it 'sets cell to dead if less than 2 live neighbors' do
        subject.board[1, 0] = 1
        expect(subject.update_left_edge_cell(1, 0, 1)).to eq(0)
      end

      it 'sets cell to live if 2 or 3 live neighbors' do
        subject.board[1, 0] = 1
        subject.board[0, 0] = 1
        subject.board[0, 1] = 1
        expect(subject.update_left_edge_cell(1, 0, 1)).to eq(1)
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
        subject.board[0, 0] = 1
        subject.board[0, 1] = 1
        subject.board[1, 1] = 1
        expect(subject.update_left_edge_cell(1, 0, 0)).to eq(1)
      end

      it 'sets live cell to dead if 4 or more live neighbors' do
        subject.board[0, 0] = 1
        subject.board[0, 1] = 1
        subject.board[1, 1] = 1
        subject.board[2, 0] = 1
        expect(subject.update_left_edge_cell(1, 0, 0)).to eq(0)
      end
    end

    describe '#update_right_edge_cell' do
      it 'sets cell to dead if less than 2 live neighbors' do
        subject.board[1, 3] = 1
        expect(subject.update_right_edge_cell(1, 3, 1)).to eq(0)
      end

      it 'sets cell to live if 2 or 3 live neighbors' do
        subject.board[1, 3] = 1
        subject.board[0, 3] = 1
        subject.board[2, 3] = 1
        expect(subject.update_right_edge_cell(1, 3, 1)).to eq(1)
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
        subject.board[0, 3] = 1
        subject.board[2, 3] = 1
        subject.board[1, 2] = 1
        expect(subject.update_right_edge_cell(1, 3, 0)).to eq(1)
      end

      it 'sets live cell to dead if 4 or more live neighbors' do
        subject.board[1, 3] = 1
        subject.board[0, 2] = 1
        subject.board[2, 3] = 1
        subject.board[2, 2] = 1
        subject.board[1, 2] = 1
        expect(subject.update_right_edge_cell(1, 3, 1)).to eq(0)
      end
    end

    describe '#update_bottom_edge_cell' do
      it 'sets cell to dead if less than 2 live neighbors' do
      end

      it 'sets cell to live if 2 or 3 live neighbors' do
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
      end

      it 'sets live cell to dead if 4 or more live neighbors' do
      end
      it 'sets cell to dead if less than 2 live neighbors' do
      end

      it 'sets cell to live if 2 or 3 live neighbors' do
      end

      it 'sets dead cell to live if exactly 3 live neighbors' do
      end

      it 'sets live cell to dead if 4 or more live neighbors' do
      end
    end
  end
end
