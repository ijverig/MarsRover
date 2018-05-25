defmodule MarsRover.CLITest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureIO

  alias MarsRover.CLI

  @off_plateau_error_message IO.ANSI.format([:red, "can't move rover outside the plateau"], true)

  test "help information" do
    assert capture_io(fn ->
             CLI.main(["--help"])
           end) =~ "Usage:\n\n    mars_rover --help"
  end

  test "version information" do
    assert capture_io(fn ->
             CLI.main(["--version"])
           end) =~ "MarsRover v"
  end

  test "input given as file argument" do
    assert capture_io(fn ->
             CLI.main(["test/fixtures/good.input"])
           end) == "0 5 N\n#{@off_plateau_error_message}\n5 4 W\n"
  end

  test "input given as stdin" do
    assert capture_io("2 2\n1 0 N\nLMMMM\n", fn ->
             CLI.main([])
           end) == "#{@off_plateau_error_message}\n"
  end

  test "resets tty formatting correctly" do
    assert capture_io("2 2\n1 0 N\nLMMMM\n1 0 N\nM\n", fn ->
             CLI.main([])
           end) == "#{@off_plateau_error_message}\n1 1 N\n"
  end
end
