defmodule MarsRover do
  def process_command(current_position, :move), do: move(current_position)
  def process_command(current_position, :left), do: rotate_left(current_position)
  def process_command(current_position, :right), do: rotate_right(current_position)

  defp move({x, y, :north}), do: {x, y + 1, :north}
  defp move({x, y, :south}), do: {x, y - 1, :south}
  defp move({x, y, :west}), do: {x - 1, y, :west}
  defp move({x, y, :east}), do: {x + 1, y, :east}

  defp rotate_left({x, y, :north}), do: {x, y, :west}
  defp rotate_left({x, y, :west}), do: {x, y, :south}
  defp rotate_left({x, y, :south}), do: {x, y, :east}
  defp rotate_left({x, y, :east}), do: {x, y, :north}

  defp rotate_right({x, y, :north}), do: {x, y, :east}
  defp rotate_right({x, y, :east}), do: {x, y, :south}
  defp rotate_right({x, y, :south}), do: {x, y, :west}
  defp rotate_right({x, y, :west}), do: {x, y, :north}
end
