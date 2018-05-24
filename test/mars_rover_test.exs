defmodule MarsRoverTest do
  use ExUnit.Case, async: true

  alias MarsRover

  test "processing several deployments" do
    plateau = {1, 1}

    deployments = [
      {{0, 0, :north}, [:move]},
      {{0, 0, :west}, [:move]},
      {{0, 0, :east}, [:move]}
    ]

    assert MarsRover.deploy(plateau, deployments) == [
             {:ok, {0, 1, :north}},
             {:error, :off_plateau},
             {:ok, {1, 0, :east}}
           ]
  end
end
