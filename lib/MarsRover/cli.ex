defmodule MarsRover.CLI do
  alias MarsRover.{Parser, Formatter, Draw}

  def main(args) do
    args |> parse_args() |> run() |> output()
  end

  @switches [help: :boolean, version: :boolean, draw: :boolean]
  @aliases [h: :help, v: :version]

  defp parse_args(args) do
    case OptionParser.parse(args, aliases: @aliases, strict: @switches) do
      {[help: true], [], _} -> :help
      {[version: true], [], _} -> :version
      {options, [file], _} -> {File.read!(file), options[:draw]}
      {options, [], _} -> {IO.read(:all), options[:draw]}
      _ -> :help
    end
  end

  defp run(:help) do
    """
    Process rovers in a given grid.

    Usage:

        mars_rover --help              # Displays this usage information
        mars_rover --version           # Displays the version of this app
        mars_rover [options]           # Process the standard input
        mars_rover [options] <file>    # Process the input file

        Options:
            -d, --draw                 # Draw deployment results \
    """
  end

  defp run(:version) do
    "MarsRover v" <> MarsRover.version()
  end

  defp run({input, draw?}) do
    {plateau, deployments} = Parser.parse_input(input)

    MarsRover.deploy(plateau, deployments)
    |> display_results(plateau, draw?)
  end

  defp display_results(results, plateau, true),
    do: results |> Draw.draw_results(plateau)

  defp display_results(results, _plateau, _draw?),
    do: results |> Formatter.format_results()

  defp output(text), do: IO.puts(text)
end
