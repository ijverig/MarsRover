defmodule MarsRover do
  import MarsRover.{Controls, Plateau}

  def process_commands({x, y, _heading}, {max_x, max_y}, _commands)
      when is_off_plateau(x, y, max_x, max_y),
      do: {:error, :off_plateau}

  def process_commands(current_position, _plateau, []), do: {:ok, current_position}

  def process_commands(current_position, plateau, [current_command | remaining_commands]) do
    current_position
    |> process_command(current_command)
    |> process_commands(plateau, remaining_commands)
  end

  defp process_command(current_position, :move), do: move(current_position)
  defp process_command(current_position, :left), do: rotate_left(current_position)
  defp process_command(current_position, :right), do: rotate_right(current_position)
end
