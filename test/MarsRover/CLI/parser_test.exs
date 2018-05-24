defmodule MarsRover.ParserTest do
  use ExUnit.Case, async: true

  alias MarsRover.Parser

  test "good input" do
    good_input = """
    5 5
    1 2 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    """

    {plateau, deployments} = Parser.parse_input(good_input)
    [{rover1, commands1}, {rover2, commands2}] = deployments

    assert plateau == {5, 5}
    assert rover1 == {1, 2, :north}
    assert commands1 == ~W/left move left move left move left move move/a
    assert rover2 == {3, 3, :east}
    assert commands2 == ~W/move move right move move right move right right move/a
  end
end
