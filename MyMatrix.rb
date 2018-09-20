require "matrix"

class MyMatrix < Matrix

  public

  def put_in i:, j:, element:
    @rows[i][j] = element
  end

  def fill_row n:, element:
    (0..@column_count-1).each do |j|
      put_in(i: n, j: j, element: element)
    end
  end

  def fill_col n:, element:
    (0..@rows.length-1).each do |i|
      put_in(i: i, j: n, element: element)
    end
  end

  def print_matrix
    @rows.each do |row|
      row.each do |element|
        print element
      end
      puts ''
    end
  end
end
