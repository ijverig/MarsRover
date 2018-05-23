defmodule MarsRover.ControlsTest do
  use ExUnit.Case, async: true

  alias MarsRover.Controls

  test "movements" do
    assert Controls.move({1, 1, :north}) == {1, 2, :north}
    assert Controls.move({1, 1, :south}) == {1, 0, :south}
    assert Controls.move({1, 1, :west}) == {0, 1, :west}
    assert Controls.move({1, 1, :east}) == {2, 1, :east}
  end

  test "rotations" do
    position_facing_north = {0, 0, :north}
    assert Controls.rotate_left(position_facing_north) == {0, 0, :west}
    assert Controls.rotate_right(position_facing_north) == {0, 0, :east}

    position_facing_south = {0, 0, :south}
    assert Controls.rotate_left(position_facing_south) == {0, 0, :east}
    assert Controls.rotate_right(position_facing_south) == {0, 0, :west}

    position_facing_west = {0, 0, :west}
    assert Controls.rotate_left(position_facing_west) == {0, 0, :south}
    assert Controls.rotate_right(position_facing_west) == {0, 0, :north}

    position_facing_east = {0, 0, :east}
    assert Controls.rotate_left(position_facing_east) == {0, 0, :north}
    assert Controls.rotate_right(position_facing_east) == {0, 0, :south}
  end
end
