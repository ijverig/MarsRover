defmodule MarsRover.CLITest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureIO
  alias MarsRover.CLI

  @off_plateau_message IO.ANSI.format([:red, "Error: can't move rover outside the plateau"])
  @collision_message IO.ANSI.format([:red, "Error: another rover is on the way"])

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

  test "bad arguments" do
    assert capture_io(fn ->
             CLI.main(["--bad-argument"])
           end) =~ "Usage:\n\n    mars_rover --help"
  end

  test "input given as file argument" do
    assert capture_io(fn ->
             CLI.main(["test/fixtures/file.input"])
           end) == "0 5 N\n#{@off_plateau_message}\n5 4 W\n#{@collision_message}\n"
  end

  test "input given as stdin" do
    assert capture_io("2 2\n1 0 N\nLMMMM\n", fn ->
             CLI.main([])
           end) == "#{@off_plateau_message}\n"
  end

  test "resets tty formatting correctly" do
    assert capture_io("2 2\n1 0 N\nLMMMM\n1 0 N\nM\n", fn ->
             CLI.main([])
           end) == "#{@off_plateau_message}\n1 1 N\n"
  end
end
