defmodule MarsRoverTest do
  use ExUnit.Case, async: true

  describe "basic controls for rovers" do
    test "movements" do
      position_facing_north = {1, 1, :north}
      assert MarsRover.process_command(position_facing_north, :move) == {1, 2, :north}

      position_facing_south = {1, 1, :south}
      assert MarsRover.process_command(position_facing_south, :move) == {1, 0, :south}

      position_facing_west = {1, 1, :west}
      assert MarsRover.process_command(position_facing_west, :move) == {0, 1, :west}

      position_facing_east = {1, 1, :east}
      assert MarsRover.process_command(position_facing_east, :move) == {2, 1, :east}
    end

    test "rotations" do
      position_facing_north = {0, 0, :north}
      assert MarsRover.process_command(position_facing_north, :left) == {0, 0, :west}
      assert MarsRover.process_command(position_facing_north, :right) == {0, 0, :east}

      position_facing_south = {0, 0, :south}
      assert MarsRover.process_command(position_facing_south, :left) == {0, 0, :east}
      assert MarsRover.process_command(position_facing_south, :right) == {0, 0, :west}

      position_facing_west = {0, 0, :west}
      assert MarsRover.process_command(position_facing_west, :left) == {0, 0, :south}
      assert MarsRover.process_command(position_facing_west, :right) == {0, 0, :north}

      position_facing_east = {0, 0, :east}
      assert MarsRover.process_command(position_facing_east, :left) == {0, 0, :north}
      assert MarsRover.process_command(position_facing_east, :right) == {0, 0, :south}
    end
  end
end
