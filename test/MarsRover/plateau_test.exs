defmodule MarsRover.PlateauTest do
  use ExUnit.Case, async: true

  alias MarsRover.Plateau

  require Plateau

  describe "a 1by1 plateau - valid positions: x = 0, y = 0" do
    @plateau1x1_x 0
    @plateau1x1_y 0

    test "0,1,W is off the plateau" do
      assert Plateau.is_off_plateau(0, 1, @plateau1x1_x, @plateau1x1_y)
    end

    test "1,0,S is off the plateau" do
      assert Plateau.is_off_plateau(1, 0, @plateau1x1_x, @plateau1x1_y)
    end

    test "0,0,N is on the plateau" do
      refute Plateau.is_off_plateau(0, 0, @plateau1x1_x, @plateau1x1_y)
    end
  end

  describe "a 5by4 plateau - valid positions: x ∈ 0..4, y ∈ 0..3" do
    @plateau5x4_x 4
    @plateau5x4_y 3

    test "5,4,S is off the plateau" do
      assert Plateau.is_off_plateau(5, 4, @plateau5x4_x, @plateau5x4_y)
    end

    test "-1,0,E is off the plateau" do
      assert Plateau.is_off_plateau(-1, 0, @plateau5x4_x, @plateau5x4_y)
    end

    test "0,-1,E is off the plateau" do
      assert Plateau.is_off_plateau(0, -1, @plateau5x4_x, @plateau5x4_y)
    end

    test "99,87,W is off the plateau" do
      assert Plateau.is_off_plateau(99, 87, @plateau5x4_x, @plateau5x4_y)
    end

    test "0,0,N is on the plateau" do
      refute Plateau.is_off_plateau(0, 0, @plateau5x4_x, @plateau5x4_y)
    end

    test "3,3,W is on the plateau" do
      refute Plateau.is_off_plateau(3, 3, @plateau5x4_x, @plateau5x4_y)
    end

    test "4,3,W is on the plateau" do
      refute Plateau.is_off_plateau(4, 3, @plateau5x4_x, @plateau5x4_y)
    end
  end
end
