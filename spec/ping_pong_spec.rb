require_relative '../ping_pong.rb'

describe CutthroatPingPong do
  subject do
    described_class.new
  end

  describe '#side_output' do
    context 'when point is odd' do
      context 'when the point side' do
        let(:side) { described_class::SIDE_A }
        let(:expected_output) { " 0    " }

        it 'returns the correct output' do
          expect(subject.send(:side_output,side)).to eq(expected_output)
        end
      end

      context 'when NOT the point side' do
        let(:side) { described_class::SIDE_B }
        let(:expected_output) { " 1  2 " }
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
        [ [ 0, 'A' ],
          [ 0, 'A' ],
          [ 1, 'B' ],
          [ 1, 'B' ],
          [ 2, 'A' ],
          [ 2, 'A' ],
          [ 0, 'B' ],
          [ 0, 'B' ],
          [ 1, 'A' ],
          [ 1, 'A' ],
          [ 2, 'B' ],
          [ 2, 'B' ],
          [ 0, 'A' ] ]
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
      let(:expected_point_opportunities) { [ [1,0,0],
                                                       [2,0,0],
                                                       [2,1,0],
                                                       [2,2,0],
                                                       [2,2,1],
                                                       [2,2,2],
                                                       [3,2,2],
                                                       [4,2,2],
                                                       [4,3,2],
                                                       [4,4,2],
                                                       [4,4,3],
                                                       [4,4,4],
                                                       [5,4,4] ] }

      let(:expected_serve_opportunities) { [ [1,0,0],
                                             [2,0,0],
                                             [2,0,0],
                                             [2,0,0],
                                             [2,0,1],
                                             [2,0,2],
                                             [2,0,2],
                                             [2,0,2],
                                             [2,1,2],
                                             [2,2,2],
                                             [2,2,2],
                                             [2,2,2],
                                             [3,2,2] ] }

      let(:expected_receive_opportunities) { [ [0,0,0],
                                               [0,0,0],
                                               [0,1,0],
                                               [0,2,0],
                                               [0,2,0],
                                               [0,2,0],
                                               [1,2,0],
                                               [2,2,0],
                                               [2,2,0],
                                               [2,2,0],
                                               [2,2,1],
                                               [2,2,2],
                                               [2,2,2] ] }

      it 'allows each player the correct number of opportunites to servce and receive for points' do
        expected_point_opportunities.each_with_index do |p,i|
          subject.play_point

          expect(subject.player_point_opportunities).to eq(expected_point_opportunities[i])
          expect(subject.player_point_serves).to eq(expected_serve_opportunities[i])
          expect(subject.player_point_receives).to eq(expected_receive_opportunities[i])
        end
      end
    end
  end
end
