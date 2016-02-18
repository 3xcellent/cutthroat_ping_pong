class PingPong
  attr_reader :current_point, :point_player, :point_side, :player_point_opportunities, :player_point_serves, :player_point_receives

  SIDE_A = 'A'
  SIDE_B = 'B'

  def initialize
    @player_positions = [ 1, 2, 3 ]
    @point_player = 1
    @point_side = SIDE_A
    @current_point = 0

    @player_point_opportunities = [ 0, 0, 0 ]
    @player_point_serves = [ 0, 0, 0 ]
    @player_point_receives = [ 0, 0, 0 ]
  end

  def play_point
    show_output
    set_stats
    @current_point += 1
    change_positions
    show_stats
  end

  def show_output
    puts side_output(SIDE_A) +"\n"
    puts "------\n"
    puts side_output(SIDE_B) +"\n"
  end

  private

  def show_stats
    puts "points #{player_point_opportunities}"
    puts "serves #{player_point_serves}"
    puts "rec    #{player_point_receives}"
  end

  def set_stats
    puts "point player: #{@point_player}"
    @player_point_opportunities[@point_player-1] += 1
    if @point_side == SIDE_A
      @player_point_serves[@point_player-1] += 1
    else
      @player_point_receives[@point_player-1] += 1
    end

  end

  def change_positions
    if @current_point.even?
      @point_player = @point_player % 3 + 1
      @point_side = @point_side == SIDE_A ? SIDE_B : SIDE_A
      @player_positions.rotate!(-1)
    end
  end

  def side_output(side)
    if side == @point_side
      " #{@point_player}    "
    else
      p = @player_positions
      p.delete(@point_player)
      " #{p[0]}  #{p[1]} "
    end
  end
end
