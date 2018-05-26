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

  defp format_result(result) do
    "#{IO.ANSI.format([:inverse, Formatter.format_result(result)])}\n"
  end

  defp draw_plateau({x, y, heading}, {max_x, max_y}) do
    for row <- max_y..0,
        col <- 0..max_x,
        into: "",
        do: tile({col, row}, {x, y}, heading) <> new_line_or_space(col, max_x)
  end

  defp tile({x, y}, {x, y}, heading), do: arrow(heading)
  defp tile(_, _, _), do: "."

  defp arrow(:north), do: "⇧"
  defp arrow(:south), do: "⇩"
  defp arrow(:west), do: "⇦"
  defp arrow(:east), do: "⇨"

  defp new_line_or_space(col, max_x) when col == max_x, do: "\n"
  defp new_line_or_space(_, _), do: " "
end
