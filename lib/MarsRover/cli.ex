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

  defp run({input, true}) do
    {plateau, deployments} = Parser.parse_input(input)

    MarsRover.deploy(plateau, deployments)
    |> Draw.draw_results(plateau)
  end

  defp run({input, _draw?}) do
    {plateau, deployments} = Parser.parse_input(input)

    MarsRover.deploy(plateau, deployments)
    |> Formatter.format_results()
  end

  defp output(text), do: IO.puts(text)
end
