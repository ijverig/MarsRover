defmodule MarsRover.FormatterTest do
  use ExUnit.Case, async: true

  alias MarsRover.Formatter

  test "returns right format" do
    results = [
      {:ok, {1, 5, :south}},
      {:error, :off_plateau}
    ]

    assert Formatter.format_results(results) == """
           1 5 S
           #{IO.ANSI.format([:red, "Error: can't move rover outside the plateau"], true)}\
           """
  end
end
