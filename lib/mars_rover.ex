defmodule MarsRover do
  import MarsRover.Controls

  def process_commands(current_position, []), do: current_position

  def process_commands(current_position, [current_command | remaining_commands]) do
    current_position
    |> process_command(current_command)
    |> process_commands(remaining_commands)
  end

  defp process_command(current_position, :move), do: move(current_position)
  defp process_command(current_position, :left), do: rotate_left(current_position)
  defp process_command(current_position, :right), do: rotate_right(current_position)
end
