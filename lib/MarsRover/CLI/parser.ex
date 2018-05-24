defmodule MarsRover.Parser do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> do_parse_input
  end

  defp do_parse_input([plateau_input | deployments_input]),
    do: {parse_plateau(plateau_input), parse_deployments(deployments_input)}

  defp parse_plateau(plateau_input) do
    plateau_input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp parse_deployments([]), do: []

  defp parse_deployments([position_input | [commands_input | remaining_deployments]]) do
    rover_position = parse_position(position_input)
    rover_commands = parse_commands(commands_input)

    [{rover_position, rover_commands}] ++ parse_deployments(remaining_deployments)
  end

  defp parse_position(position_input) do
    position_input
    |> String.split()
    |> Enum.map(&do_parse_position/1)
    |> List.to_tuple()
  end

  defp do_parse_position("N"), do: :north
  defp do_parse_position("S"), do: :south
  defp do_parse_position("W"), do: :west
  defp do_parse_position("E"), do: :east
  defp do_parse_position(number_string), do: String.to_integer(number_string)

  defp parse_commands(commands_input) do
    commands_input
    |> String.graphemes()
    |> Enum.map(&do_parse_command/1)
  end

  defp do_parse_command("M"), do: :move
  defp do_parse_command("L"), do: :left
  defp do_parse_command("R"), do: :right
end
