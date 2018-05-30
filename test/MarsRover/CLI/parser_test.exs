defmodule MarsRover.ParserTest do
  use ExUnit.Case, async: true

  alias MarsRover.CLI.Parser

  test "good input" do
    good_input = """
    25 543
    10 42 N
    LMLMLMLMM
    3 3 E
    MMRMMRMRRM
    """

    {plateau, deployments} = Parser.parse_input(good_input)
    [{rover1, commands1}, {rover2, commands2}] = deployments

    assert plateau == {25, 543}
    assert rover1 == {10, 42, :north}
    assert commands1 == ~W/left move left move left move left move move/a
    assert rover2 == {3, 3, :east}
    assert commands2 == ~W/move move right move move right move right right move/a
  end

  test "negative numbers plateau" do
    input = """
    -5 -3
    1 2 N
    LMLM
    """

    {plateau, deployments} = Parser.parse_input(input)
    [{rover, commands}] = deployments

    assert plateau == {5, 3}
    assert rover == {1, 2, :north}
    assert commands == ~W/left move left move/a
  end

  test "empty input" do
    assert_raise BadInputError, fn -> Parser.parse_input("") end
  end

  test "empty input command" do
    input = """
    5 3
    1 2 N
    
    """

    assert_raise BadInputError, fn -> Parser.parse_input(input) end
  end

  test "bad input command" do
    input = """
    5 3
    1 2 N
    ++--
    """

    assert_raise BadInputError, fn -> Parser.parse_input(input) end
  end
end
