defmodule MarsRover.CLI.Draw do
  alias MarsRover.CLI.Formatter

  @off_plateau_message "Error: can't move rover outside the plateau"
  @collision_message "Error: another rover is on the way"

  def draw_results(results, plateau),
    do: Enum.map_join(results, "\n", &draw_result(&1, plateau))

  defp draw_result({:ok, position} = result, plateau),
    do: format_result(result, :normal) <> draw_plateau(position, plateau)

  defp draw_result({:error, reason}, _plateau), do: format_result(reason, :red)

  defp format_result(:off_plateau, color), do: do_format(@off_plateau_message, color)
  defp format_result(:collision, color), do: do_format(@collision_message, color)
  defp format_result(result, color), do: Formatter.format_result(result) |> do_format(color)

  defp do_format(message, color), do: "#{IO.ANSI.format([:inverse, color, do_format(message)])}\n"
  defp do_format(message), do: " #{String.pad_trailing(message, 55)}"

  defp draw_plateau(position, {max_x, max_y}) do
    for row <- max_y..0,
        col <- 0..max_x,
        into: "",
        do: edge_if_first(col) <> tile({col, row}, position) <> new_line_or_space(col, max_x)
  end

  defp edge_if_first(0), do: "┃ "
  defp edge_if_first(_), do: ""

  defp tile({x, y}, {x, y, heading}), do: arrow(heading)
  defp tile(_, _), do: "."

  defp arrow(:north), do: "⇧"
  defp arrow(:south), do: "⇩"
  defp arrow(:west), do: "⇦"
  defp arrow(:east), do: "⇨"

  defp new_line_or_space(x, x), do: "\n"
  defp new_line_or_space(_, _), do: " "
end
