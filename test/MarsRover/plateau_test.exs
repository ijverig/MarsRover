defmodule MarsRover.PlateauTest do
  use ExUnit.Case, async: true

  alias MarsRover.Plateau

  describe "a 1by1 plateau - valid positions: x = 0, y = 0" do
    @plateau1x1 {0, 0}

    test "0,1,W is off the plateau" do
      assert Plateau.off_plateau?({0, 1, :east}, @plateau1x1)
    end

    test "1,0,S is off the plateau" do
      assert Plateau.off_plateau?({1, 0, :east}, @plateau1x1)
    end

    test "0,0,N is on the plateau" do
      refute Plateau.off_plateau?({0, 0, :east}, @plateau1x1)
    end
  end

  describe "a 5by4 plateau - valid positions: x ∈ 0..4, y ∈ 0..3" do
    @plateau5x4 {4, 3}

    test "5,4,S is off the plateau" do
      assert Plateau.off_plateau?({5, 4, :east}, @plateau5x4)
    end

    test "-1,0,E is off the plateau" do
      assert Plateau.off_plateau?({-1, 0, :east}, @plateau5x4)
    end

    test "0,-1,E is off the plateau" do
      assert Plateau.off_plateau?({0, -1, :east}, @plateau5x4)
    end

    test "99,87,W is off the plateau" do
      assert Plateau.off_plateau?({99, 87, :east}, @plateau5x4)
    end

    test "0,0,N is on the plateau" do
      refute Plateau.off_plateau?({0, 0, :east}, @plateau5x4)
    end

    test "3,3,W is on the plateau" do
      refute Plateau.off_plateau?({3, 3, :east}, @plateau5x4)
    end

    test "4,3,W is on the plateau" do
      refute Plateau.off_plateau?({4, 3, :east}, @plateau5x4)
    end
  end

  describe "collision validation" do
    @already_deployed [{:ok, {1, 2, :east}}, {:error, :collision}, {:ok, {4, 1, :south}}]

    test "in collision" do
      assert Plateau.in_collision?({1, 2, :north}, [{:ok, {1, 2, :east}}])
      assert Plateau.in_collision?({4, 1, :west}, @already_deployed)
    end

    test "not in collision" do
      refute Plateau.in_collision?({1, 2, :north}, [])
      refute Plateau.in_collision?({1, 4, :west}, @already_deployed)
    end
  end
end
