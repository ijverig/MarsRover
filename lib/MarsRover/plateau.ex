defmodule MarsRover.Plateau do
  defguard is_off_plateau(x, y, max_x, max_y)
           when x not in 0..max_x or y not in 0..max_y
end
