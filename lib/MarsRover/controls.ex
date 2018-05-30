defmodule MarsRover.Controls do
  @moduledoc """
  Controls is the rover engine: handles movements and actions.
  """
  
  def move({x, y, :north}), do: {x, y + 1, :north}
  def move({x, y, :south}), do: {x, y - 1, :south}
  def move({x, y, :west}), do: {x - 1, y, :west}
  def move({x, y, :east}), do: {x + 1, y, :east}

  def rotate_left({x, y, :north}), do: {x, y, :west}
  def rotate_left({x, y, :west}), do: {x, y, :south}
  def rotate_left({x, y, :south}), do: {x, y, :east}
  def rotate_left({x, y, :east}), do: {x, y, :north}

  def rotate_right({x, y, :north}), do: {x, y, :east}
  def rotate_right({x, y, :east}), do: {x, y, :south}
  def rotate_right({x, y, :south}), do: {x, y, :west}
  def rotate_right({x, y, :west}), do: {x, y, :north}
end
