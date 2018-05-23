defmodule MarsRoverTest do
  use ExUnit.Case, async: true

  test "movements" do
    position_facing_north = {1,1,:north}
    assert MarsRover.process(position_facing_north, :move) == {1,2,:north}

    position_facing_south = {1,1,:south} 
    assert MarsRover.process(position_facing_south, :move) == {1,0,:south}
    
    position_facing_west = {1,1,:west}
    assert MarsRover.process(position_facing_west, :move) == {0,1,:west}

    position_facing_east = {1,1,:east}
    assert MarsRover.process(position_facing_east, :move) == {2,1,:east}
  end
end
