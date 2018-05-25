defmodule MarsRover.Deployments do
  import MarsRover.{Controls, Plateau}

  def deploy_several(deployments, plateau, deployed \\ [])

  def deploy_several([], _plateau, deployed), do: Enum.reverse(deployed)

  def deploy_several([{position, commands} | remaining], plateau, deployed) do
    result = deploy(position, commands, plateau)
    deploy_several(remaining, plateau, [result | deployed])
  end

  def deploy(position, commands, plateau),
    do: validate_position(position, plateau) |> do_deploy(commands, plateau)

  defp do_deploy({:ok, position}, [command | remaining], plateau),
    do: next_position(position, command) |> deploy(remaining, plateau)

  defp do_deploy({:ok, position}, [], _plateau), do: {:ok, position}
  defp do_deploy(error, _commands, _plateau), do: error

  defp validate_position({x, y, _heading}, {max_x, max_y})
       when is_off_plateau(x, y, max_x, max_y),
       do: {:error, :off_plateau}

  defp validate_position(position, _plateau), do: {:ok, position}

  defp next_position(position, :move), do: move(position)
  defp next_position(position, :left), do: rotate_left(position)
  defp next_position(position, :right), do: rotate_right(position)
end
