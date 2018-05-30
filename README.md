# Mars Rover Problem

This is a library to process rovers deployments.

It receives rovers initial positions, commands for each rover, a plateau specification and deploys each rover, simulating the plateau exploration and final positions.

## Instalation

```shellscript
mix deps.get
mix test
mix escript.build
```

## Usage

It can both be used as a library:

```elixir
import MarsRover

plateau = {2, 2}

deployments = [
    {{0, 0, :north}, [:move, :move]},
    {{0, 0, :west}, [:left, :move]}
]

MarsRover.deploy(plateau, deployments)
# [
#    {:ok, {0, 2, :north}},
#    {:error, :off_plateau}
# ]
```

or as a command line app:

```shellscript
▸ ./mars_rover --help
Process rovers in a given grid.

Usage:

    mars_rover --help              # Displays this usage information
    mars_rover --version           # Displays the version of this app
    mars_rover [options]           # Process the standard input
    mars_rover [options] <file>    # Process the input file

    Options:
        -d, --draw                 # Draw deployment results
```

## Examples

!["mars_rover" output](https://raw.githubusercontent.com/ijverig/MarsRover/master/screenshots/CLI-example.png)

!["mars_rover --draw" output](https://raw.githubusercontent.com/ijverig/MarsRover/master/screenshots/CLI-draw-example.png)

!["mars_rover file" output](https://raw.githubusercontent.com/ijverig/MarsRover/master/screenshots/CLI-file-example.png)

## Details

Why elixir? Well, pattern matching makes it ridiculously easy to solve the problem… <br>
Both parsing and processing commands are done in a very readable and straight way.

Development was done making input test cases. All input limits are handled as tests. <br>
Tests have dozens of inputs. You can find several examples of how it all works in the tests.

`++` concatenation is used when parsing for readability sake. If the input were to be really large then it would be better to use Tail Call Optimization instead.

Another approach to the problem would be to have it all as concurrent processes (rovers, CLI, plateau and parsing) interacting with each other.

## Bonus

A [WIP branch] with the option to animate output results.

[WIP branch]: https://github.com/ijverig/MarsRover/tree/animation