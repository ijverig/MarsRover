defmodule MarsRover do
  def process(current_position, command)
  def process({x,y,:north}, :move), do: {x, y+1, :north}
  def process({x,y,:south}, :move), do: {x, y-1, :south}
  def process({x,y,:west}, :move), do: {x-1, y, :west}
  def process({x,y,:east}, :move), do: {x+1, y, :east}
end
