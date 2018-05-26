defmodule MarsRover.PlateauTest do
  use ExUnit.Case

  alias MarsRover.Plateau

  describe "the Plateau agent" do
    setup do
      Plateau.start({6, 4})

      on_exit(fn ->
        Plateau.stop()
      end)
    end

    test "already initialized" do
      assert {:error, {:already_started, _pid}} = Plateau.start({6, 4})
    end

    test "initial values" do
      assert Plateau.max_x() == 6
      assert Plateau.max_y() == 4
      assert Plateau.already_deployed() == []
    end

    test "updates" do
      Plateau.add_deploy_result({:ok, {3, 5, :east}})
      assert Plateau.already_deployed() == [{:ok, {3, 5, :east}}]
    end
  end

  describe "a 1by1 plateau - valid positions: x = 0, y = 0" do
    setup do
      Plateau.start({0, 0})

      on_exit(fn ->
        Plateau.stop()
      end)
    end

    test "0,1,W is off the plateau" do
      assert Plateau.off_plateau?({0, 1, :east})
    end

    test "1,0,S is off the plateau" do
      assert Plateau.off_plateau?({1, 0, :east})
    end

    test "0,0,N is on the plateau" do
      refute Plateau.off_plateau?({0, 0, :east})
    end
  end

  describe "a 5by4 plateau - valid positions: x ∈ 0..4, y ∈ 0..3" do
    setup do
      Plateau.start({4, 3})

      on_exit(fn ->
        Plateau.stop()
      end)
    end

    test "5,4,S is off the plateau" do
      assert Plateau.off_plateau?({5, 4, :east})
    end

    test "-1,0,E is off the plateau" do
      assert Plateau.off_plateau?({-1, 0, :east})
    end

    test "0,-1,E is off the plateau" do
      assert Plateau.off_plateau?({0, -1, :east})
    end

    test "99,87,W is off the plateau" do
      assert Plateau.off_plateau?({99, 87, :east})
    end

    test "0,0,N is on the plateau" do
      refute Plateau.off_plateau?({0, 0, :east})
    end

    test "3,3,W is on the plateau" do
      refute Plateau.off_plateau?({3, 3, :east})
    end

    test "4,3,W is on the plateau" do
      refute Plateau.off_plateau?({4, 3, :east})
    end
  end

  describe "collision validation" do
    setup do
      Plateau.start({4, 3})

      on_exit(fn ->
        Plateau.stop()
      end)
    end

    test "in collision" do
      Plateau.add_deploy_result({:ok, {1, 2, :east}})
      assert Plateau.in_collision?({1, 2, :north})

      Plateau.add_deploy_result({:error, :collision})
      Plateau.add_deploy_result({:ok, {4, 1, :south}})
      assert Plateau.in_collision?({4, 1, :west})
    end

    test "not in collision" do
      refute Plateau.in_collision?({1, 2, :north})

      Plateau.add_deploy_result({:ok, {1, 2, :east}})
      Plateau.add_deploy_result({:error, :collision})
      Plateau.add_deploy_result({:ok, {4, 1, :south}})
      refute Plateau.in_collision?({1, 4, :west})
    end
  end
end
