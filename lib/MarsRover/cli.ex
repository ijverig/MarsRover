defmodule MarsRover.CLI do
  alias MarsRover.{Parser, Formatter}

  def main(args) do
    args |> parse_args() |> run() |> output()
  end

  defp parse_args(["--help"]), do: :help
  defp parse_args(["--version"]), do: :version
  defp parse_args([file]), do: File.read!(file)
  defp parse_args([]), do: IO.read(:all)
  defp parse_args(_), do: :help

  defp run(:help) do
    """
    Usage:

        mars_rover --help      # Displays this usage information
        mars_rover --version   # Displays the version of this app
        mars_rover             # Process the standard input
        mars_rover file        # Process the input file
      
    Process rovers in a given grid. \
    """
  end

  defp run(:version) do
    "MarsRover v" <> MarsRover.version()
  end

  defp run(input) do
    {plateau, deployments} = Parser.parse_input(input)

    MarsRover.deploy(plateau, deployments)
    |> Formatter.format_results()
  end

  defp output(text), do: IO.puts(text)
end
