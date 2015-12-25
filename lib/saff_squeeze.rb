class SaffSqueeze
  def doit(starting_gen)
    next_gen = InitializeBoard.new.call(starting_gen)

    row_num = 0
    row = starting_gen[row_num]
    row.each_with_index do |cell, col_num|
      num_live_neighbors = CountLiveNeighbors.new.call(col_num, row_num, starting_gen)
      next_gen[row_num][col_num] = CalculateNextState.new.call(cell, num_live_neighbors)
    end

    row_num = 1
    row = starting_gen[row_num]
    row.each_with_index do |cell, col_num|
      num_live_neighbors = CountLiveNeighbors.new.call(col_num, row_num, starting_gen)
      next_gen[row_num][col_num] = CalculateNextState.new.call(cell, num_live_neighbors)
    end

    row_num = 2
    row = starting_gen[row_num]
    row.each_with_index do |cell, col_num|
      num_live_neighbors = CountLiveNeighbors.new.call(col_num, row_num, starting_gen)
      next_gen[row_num][col_num] = CalculateNextState.new.call(cell, num_live_neighbors)
    end

    next_gen
  end
end

class InitializeBoard
  def call(starting_gen)
    Array.new(starting_gen.length) { Array.new(starting_gen.length, 0) }
  end
end

class CountLiveNeighbors
  def call(col_num, row_num, starting_gen)
    grid_size = starting_gen.length
    neighbors = []

    if row_num > 0 && col_num > 0
      neighbors << starting_gen[row_num-1][col_num-1]
    end
    if row_num > 0
      neighbors << starting_gen[row_num-1][col_num]
    end
    if row_num > 0 && col_num < grid_size - 1
      neighbors << starting_gen[row_num-1][col_num+1]
    end
    if col_num > 0
      neighbors << starting_gen[row_num][col_num-1]
    end
    if col_num < grid_size - 1
      neighbors << starting_gen[row_num][col_num+1]
    end
    if row_num < grid_size - 1 && col_num > 0
      neighbors << starting_gen[row_num+1][col_num-1]
    end
    if row_num < grid_size - 1
      neighbors << starting_gen[row_num+1][col_num]
    end
    if row_num < grid_size - 1 && col_num < grid_size - 1
      neighbors << starting_gen[row_num+1][col_num+1]
    end

    neighbors.count { |n| n == 1 }
  end
end

class CalculateNextState
  def call(cell, num_live_neighbors)
    # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    # Any live cell with two or three live neighbours lives on to the next generation.
    # Any live cell with more than three live neighbours dies, as if by over-population.
    # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

    next_state = nil

    if cell == 1 && num_live_neighbors == 2
      next_state = 1
    elsif cell == 1 && num_live_neighbors == 3
      next_state = 1
    elsif cell == 0 && num_live_neighbors == 3
      next_state = 1
    elsif cell == 1 && num_live_neighbors > 4
      next_state = 0
    elsif cell == 1 && num_live_neighbors < 2
      next_state = 0
    elsif cell == 0
      next_state = 0
    end

    next_state
  end
end
