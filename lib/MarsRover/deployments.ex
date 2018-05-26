defmodule MarsRover.Deployments do
  import MarsRover.Controls
  alias MarsRover.Plateau

  def deploy_several(deployments, plateau, deployed \\ [])

  def deploy_several([], _plateau, deployed), do: Enum.reverse(deployed)

  def deploy_several([{position, commands} | remaining], plateau, deployed) do
    result = deploy(position, commands, plateau, deployed)
    deploy_several(remaining, plateau, [result | deployed])
  end

  def deploy(position, commands, plateau, deployed),
    do: position |> validate_position(plateau, deployed) |> do_deploy(commands, plateau, deployed)

  defp do_deploy({:ok, position}, [command | remaining], plateau, deployed),
    do: position |> next_position(command) |> deploy(remaining, plateau, deployed)

  defp do_deploy({:ok, position}, [], _plateau, _deployed), do: {:ok, position}
  defp do_deploy(error, _commands, _plateau, _deployed), do: error

  defp validate_position(position, plateau, deployed) do
    cond do
      Plateau.off_plateau?(position, plateau) -> {:error, :off_plateau}
      Plateau.in_collision?(position, deployed) -> {:error, :collision}
      true -> {:ok, position}
    end
  end

  defp next_position(position, :move), do: move(position)
  defp next_position(position, :left), do: rotate_left(position)
  defp next_position(position, :right), do: rotate_right(position)
end
