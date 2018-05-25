defmodule MarsRover.DeploymentsTest do
  use ExUnit.Case, async: true

  alias MarsRover.Deployments

  @plateau {4, 6}

  test "move north from 0,0,N" do
    position_heading_north = {0, 0, :north}
    {:ok, final_position} = Deployments.deploy(position_heading_north, [:move], @plateau)
    assert final_position == {0, 1, :north}
  end

  test "rotate 180 degress" do
    position_heading_north = {0, 0, :north}

    commands = ~W/left left/a
    {:ok, final_position} = Deployments.deploy(position_heading_north, commands, @plateau)
    assert final_position == {0, 0, :south}

    commands = ~W/right right/a
    {:ok, final_position} = Deployments.deploy(position_heading_north, commands, @plateau)
    assert final_position == {0, 0, :south}
  end

  test "rotate 270 degress" do
    position_heading_south = {0, 0, :south}

    commands = ~W/left left left/a
    {:ok, final_position} = Deployments.deploy(position_heading_south, commands, @plateau)
    assert final_position == {0, 0, :west}

    commands = ~W/right right right/a
    {:ok, final_position} = Deployments.deploy(position_heading_south, commands, @plateau)
    assert final_position == {0, 0, :east}
  end

  test "move from 0,0,N to 3,2,S" do
    commands = ~W/right move move left move move move right move right move/a
    {:ok, final_position} = Deployments.deploy({0, 0, :north}, commands, @plateau)
    assert final_position == {3, 2, :south}
  end

  test "move from 3,2,S to 0,0,N" do
    commands = ~W/left left move left move left move move move right move move right/a
    {:ok, final_position} = Deployments.deploy({3, 2, :south}, commands, @plateau)
    assert final_position == {0, 0, :north}
  end

  test "move from upper-right 4,6,W in a square and come back" do
    upper_right = {4, 6, :west}
    commands = ~W/move left move left move left move left/a
    {:ok, final_position} = Deployments.deploy(upper_right, commands, @plateau)
    assert final_position == upper_right
  end

  test "start from outside the plateau -9,-9,N" do
    commands = []
    result = Deployments.deploy({-9, -9, :north}, commands, @plateau)
    assert result == {:error, :off_plateau}

    commands = ~W/move left move move move move move/a
    result = Deployments.deploy({-9, -9, :north}, commands, @plateau)
    assert result == {:error, :off_plateau}
  end

  test "move from 3,2,N to -2,3,W offgrid" do
    commands = ~W/move left move move move move move/a
    result = Deployments.deploy({3, 2, :north}, commands, @plateau)
    assert result == {:error, :off_plateau}
  end

  test "move from 3,5,W to 6,5,E offgrid and back" do
    commands = ~W/left left move move move left left move move move/a
    result = Deployments.deploy({3, 5, :west}, commands, @plateau)
    assert result == {:error, :off_plateau}
  end

  test "processing several deployments" do
    plateau = {4, 4}

    deployments = [
      {{0, 0, :north}, [:move, :move, :move, :right, :move, :move, :move, :left]}
    ]

    assert Deployments.deploy_several(deployments, plateau) == [{:ok, {3, 3, :north}}]
  end
end
