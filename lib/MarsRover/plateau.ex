defmodule MarsRover.Plateau do
  def off_plateau?({x, y, _heading}, {max_x, max_y}) do
    x not in 0..max_x or y not in 0..max_y
  end

  def in_collision?({x, y, _heading}, already_deployed) do
    Enum.any?(already_deployed, fn
      {:ok, {x2, y2, _heading}} -> {x, y} == {x2, y2}
      _error -> false
    end)
  end
end
