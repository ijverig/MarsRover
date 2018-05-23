defmodule MarsRover do
  def process(current_position, command)

  def process({x,y,:north}, :move), do: {x, y+1, :north}
  def process({x,y,:south}, :move), do: {x, y-1, :south}
  def process({x,y,:west}, :move), do: {x-1, y, :west}
  def process({x,y,:east}, :move), do: {x+1, y, :east}

  def process({x,y,:north}, :left), do: {x, y, :west}
  def process({x,y,:north}, :right), do: {x, y, :east}

  def process({x,y,:south}, :left), do: {x, y, :east}
  def process({x,y,:south}, :right), do: {x, y, :west}

  def process({x,y,:west}, :left), do: {x, y, :south}
  def process({x,y,:west}, :right), do: {x, y, :north}

  def process({x,y,:east}, :left), do: {x, y, :north}
  def process({x,y,:east}, :right), do: {x, y, :south}
end
