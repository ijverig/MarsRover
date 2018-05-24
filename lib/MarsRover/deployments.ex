defmodule MarsRover.Deployments do
  import MarsRover.{Controls, Plateau}

  def deploy_several(plateau, deployments) do
    Enum.map(deployments, fn {initial_position, commands} ->
      deploy(initial_position, plateau, commands)
    end)
  end

  def deploy({x, y, _heading}, {max_x, max_y}, _commands)
      when is_off_plateau(x, y, max_x, max_y),
      do: {:error, :off_plateau}

  def deploy(current_position, _plateau, []), do: {:ok, current_position}

  def deploy(current_position, plateau, [current_command | remaining_commands]) do
    current_position
    |> run_command(current_command)
    |> deploy(plateau, remaining_commands)
  end

  defp run_command(current_position, :move), do: move(current_position)
  defp run_command(current_position, :left), do: rotate_left(current_position)
  defp run_command(current_position, :right), do: rotate_right(current_position)
end
