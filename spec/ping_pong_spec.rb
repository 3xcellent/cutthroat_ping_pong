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
    let(:expected_results) {
      [ [ 1, 1, 'A', [1,0,0], [1,0,0], [0,0,0] ],
        [ 2, 1, 'A', [2,0,0], [2,0,0], [0,0,0] ],
        [ 3, 2, 'B', [2,1,0], [2,0,0], [0,1,0] ],
        [ 4, 2, 'B', [2,2,0], [2,0,0], [0,2,0] ],
        [ 5, 3, 'A', [2,2,1], [2,0,1], [0,2,0] ],
        [ 6, 3, 'A', [2,2,2], [2,0,2], [0,2,0] ],
        [ 7, 1, 'B', [3,2,2], [2,0,2], [1,2,0] ],
        [ 8, 1, 'B', [4,2,2], [2,0,2], [2,2,0] ],
        [ 9, 2, 'A', [4,3,2], [2,1,2], [2,2,0] ],
        [ 10, 2, 'A', [4,4,2], [2,2,2], [2,2,0] ],
        [ 11, 3, 'B', [4,4,3], [2,2,2], [2,2,1] ],
        [ 12, 3, 'B', [4,4,4], [2,2,2], [2,2,2] ],
        [ 13, 1, 'A', [5,4,4], [3,2,2], [2,2,2] ] ] }

    before do
      allow(subject).to receive(:puts)
    end

    it 'rotates players correctly' do
      expected_results.each do |p|
        # check who is playing for points, and what side they are on
        expect(subject.point_player).to eq(p[1])
        expect(subject.point_side).to eq(p[2])

        subject.play_point

        # check that things were set properly after playing
        expect(subject.current_point).to eq(p[0])
        expect(subject.player_point_opportunities).to eq(p[3])
        expect(subject.player_point_serves).to eq(p[4])
        expect(subject.player_point_receives).to eq(p[5])
      end
    end
  end
end
