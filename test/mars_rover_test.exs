defmodule MarsRoverTest do
  use ExUnit.Case, async: false

  test "deployments on 0by0 plateau" do
    plateau = {0, 0}

    deployments = [
      {{0, 0, :north}, [:move]},
      {{0, 0, :east}, [:right]},
      {{4, 3, :west}, [:left]}
    ]

    assert MarsRover.deploy(plateau, deployments) == [
             {:error, :off_plateau},
             {:ok, {0, 0, :south}},
             {:error, :off_plateau}
           ]
  end

  test "processing several deployments" do
    plateau = {1, 1}

    deployments = [
      {{0, 0, :north}, [:move]},
      {{0, 0, :west}, [:move]},
      {{0, 0, :east}, [:move]},
      {{1, 1, :south}, [:move]}
    ]

    assert MarsRover.deploy(plateau, deployments) == [
             {:ok, {0, 1, :north}},
             {:error, :off_plateau},
             {:ok, {1, 0, :east}},
             {:error, :collision}
           ]
  end
end
