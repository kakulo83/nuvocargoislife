# frozen_string_literal: true

require_relative '../src/board'

RSpec.describe Board do
  describe '#initialize' do
    context 'without initial_state' do
      subject { described_class.new }

      it 'defaults rows to NUM_ROWS' do
        expect(subject.rows).to eq(NUM_ROWS)
      end

      it 'defaults columns to NUM_COLUMNS' do
        expect(subject.columns).to eq(NUM_COLUMNS)
      end
    end

    context 'with initial_state' do
      let(:initial_state) do
        [
          [0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
          [1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1],
          [1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1]
        ]
      end

      subject { described_class.new(initial_state: initial_state) }

      it 'sets rows to intial_state rows' do
        expect(subject.rows).to eq(initial_state.count)
      end

      it 'defaults columns to initial_state columns' do
        expect(subject.columns).to eq(initial_state.first.count)
      end

      it 'initializes to initial_state' do
        aggregate_failures do
          expect(subject[0, 0]).to eq(0)
          expect(subject[0, 1]).to eq(1)
          expect(subject[2, 0]).to eq(1)
          expect(subject[9, 9]).to eq(1)
          expect(subject[9, 10]).to eq(1)
        end
      end
    end
  end

  describe '#[]' do
    let(:initial_state) do
      [
        [1, 2],
        [4, 5]
      ]
    end

    subject { described_class.new(initial_state: initial_state) }

    it 'access the cell given the x,y coordinate' do
      aggregate_failures do
        expect(subject[0, 0]).to eq(1)
        expect(subject[0, 1]).to eq(2)
        expect(subject[1, 0]).to eq(4)
        expect(subject[1, 1]).to eq(5)
      end
    end
  end

  describe '#[]=' do
    subject { described_class.new }

    it 'sets the cell given the x,y coordinate' do
      subject[0, 0] = 99
      subject[9, 9] = -1

      aggregate_failures do
        expect(subject[0, 0]).to eq(99)
        expect(subject[9, 9]).to eq(-1)
      end
    end
  end

  describe '#each_cell!' do
    let(:initial_state) do
      [
        [0, 1],
        [6, 7]
      ]
    end

    subject { described_class.new(initial_state: initial_state) }

    it 'invokes the block for each cell' do
      subject.each_cell! { |_, _, state| state * 2 }

      aggregate_failures do
        expect(subject[0, 0]).to eq(0)
        expect(subject[0, 1]).to eq(2)
        expect(subject[1, 0]).to eq(12)
        expect(subject[1, 1]).to eq(14)
      end
    end
  end
end
