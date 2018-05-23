defmodule MarsRoverTest do
  use ExUnit.Case, async: true

  import MarsRover

  test "rotate 180 degress" do
    position_facing_north = {0, 0, :north}
    assert process_commands(position_facing_north, [:left, :left]) == {0, 0, :south}
    assert process_commands(position_facing_north, [:right, :right]) == {0, 0, :south}
  end

  test "rotate 270 degress" do
    position_facing_south = {0, 0, :south}
    assert process_commands(position_facing_south, [:left, :left, :left]) == {0, 0, :west}
    assert process_commands(position_facing_south, [:right, :right, :right]) == {0, 0, :east}
  end

  test "move from 0,0,N to 3,2,S" do
    commands = ~W/right move move left move move move right move right move/a
    assert process_commands({0, 0, :north}, commands) == {3, 2, :south}
  end

  test "move from 3,2,S to 0,0,N" do
    commands = ~W/left left move left move left move move move right move move right/a
    assert process_commands({3, 2, :south}, commands) == {0, 0, :north}
  end
end
