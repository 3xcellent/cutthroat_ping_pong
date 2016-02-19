require_relative '../ping_pong.rb'

describe PingPong do
  subject do
    described_class.new
  end

  describe '#side_output' do
    context 'when point is odd' do
      context 'when the point side' do
        let(:side) { described_class::SIDE_A }
        let(:expected_output) { " 1    " }

        it 'returns the correct output' do
          expect(subject.send(:side_output,side)).to eq(expected_output)
        end
      end

      context 'when NOT the point side' do
        let(:side) { described_class::SIDE_B }
        let(:expected_output) { " 2  3 " }
        it 'returns the correct output' do
          expect(subject.send(:side_output,side)).to eq(expected_output)
        end
      end
    end
  end

  describe '#play_point`' do
    before do
      allow(subject).to receive(:puts)
    end

    context 'before the point is played' do
      let(:point_player_per_point) {
        [ [ 1, 'A' ],
          [ 1, 'A' ],
          [ 2, 'B' ],
          [ 2, 'B' ],
          [ 3, 'A' ],
          [ 3, 'A' ],
          [ 1, 'B' ],
          [ 1, 'B' ],
          [ 2, 'A' ],
          [ 2, 'A' ],
          [ 3, 'B' ],
          [ 3, 'B' ],
          [ 1, 'A' ] ]
      }

      it 'has the correct player playing for points on the correct side' do
        point_player_per_point.each do |p|
          expect(subject.point_player).to eq(p[0])
          expect(subject.point_side).to eq(p[1])

          subject.play_point
        end
      end
    end

    context 'after point is played' do
      let(:expected_point_opportunities_per_point) {
        [ [ [1,0,0], [1,0,0], [0,0,0] ],
          [ [2,0,0], [2,0,0], [0,0,0] ],
          [ [2,1,0], [2,0,0], [0,1,0] ],
          [ [2,2,0], [2,0,0], [0,2,0] ],
          [ [2,2,1], [2,0,1], [0,2,0] ],
          [ [2,2,2], [2,0,2], [0,2,0] ],
          [ [3,2,2], [2,0,2], [1,2,0] ],
          [ [4,2,2], [2,0,2], [2,2,0] ],
          [ [4,3,2], [2,1,2], [2,2,0] ],
          [ [4,4,2], [2,2,2], [2,2,0] ],
          [ [4,4,3], [2,2,2], [2,2,1] ],
          [ [4,4,4], [2,2,2], [2,2,2] ],
          [ [5,4,4], [3,2,2], [2,2,2] ] ] }

      it 'allows each player the correct number of opportunites per side to play for points' do
        expected_point_opportunities_per_point.each do |p|
          subject.play_point

          expect(subject.player_point_opportunities).to eq(p[0])
          expect(subject.player_point_serves).to eq(p[1])
          expect(subject.player_point_receives).to eq(p[2])
        end
      end
    end
  end
end
