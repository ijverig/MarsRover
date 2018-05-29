defmodule MarsRover.Draw do
  alias MarsRover.Formatter

  def draw_results(results, plateau) do
    Enum.map_join(results, "\n", &draw_result(&1, plateau))
  end

  defp draw_result({:ok, position} = result, plateau) do
    format_result(result) <> draw_plateau(position, plateau)
  end

  defp draw_result(error, _plateau) do
    format_result(error)
  end

  defp format_result(result),
    do: "#{IO.ANSI.format([:inverse, Formatter.format_result(result)])}\n"

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
