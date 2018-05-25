defmodule MarsRover.Formatter do
  def format_results(results), do: Enum.map_join(results, "\n", &format_result/1)

  def format_result({:ok, final_position}), do: final_position |> format_position()
  def format_result({:error, reason}), do: reason |> format_error()

  defp format_position({x, y, :north}), do: format_position({x, y, "N"})
  defp format_position({x, y, :south}), do: format_position({x, y, "S"})
  defp format_position({x, y, :west}), do: format_position({x, y, "W"})
  defp format_position({x, y, :east}), do: format_position({x, y, "E"})
  defp format_position({x, y, heading}), do: "#{x} #{y} #{heading}"

  defp format_error(:off_plateau), do: format_error("can't move rover outside the plateau")
  defp format_error(:collision), do: format_error("another rover is on the way")
  defp format_error(message), do: "#{IO.ANSI.format([:red, "Error: ", message])}"
end
