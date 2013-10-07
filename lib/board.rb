class Board

  attr_accessor :spaces

  def initialize
    @spaces = {a:nil, b:nil, c: nil, d: nil, e: nil, f: nil, g: nil, h: nil, i: nil}
  end

  def move(space, move_num)
    @spaces[space] = move_num unless @spaces[space]
  end

  def expired?
    winning_combination_present? || full?
  end

  def winning_combination_present?
    winning_set
  end

  def winning_set
    horizontal_winner || vertical_winner || diagonal_winner
  end

  def winner
    if winning_combination_present?
      @spaces[winning_set.first]%2 == 1 ? "Player 1" : "Player 2"
    end
  end

  def full?
    @spaces.all? {|space| space.last}
  end

  def horizontal_winner
    h_rows = [[:a,:b,:c],[:d,:e,:f],[:g,:h,:i]]
    full_rows = find_full_sets(h_rows)
    full_rows.find do |row|
      row.all? {|space| @spaces[space] % 2 == 0} ||
      row.all? {|space| @spaces[space] % 2 == 1}
    end
  end

  def vertical_winner
    v_rows = [[:a,:d,:g],[:b,:e,:h],[:c,:f,:i]]
    full_rows = find_full_sets(v_rows)
    full_rows.find do |row|
      row.all? {|space| @spaces[space] % 2 == 0} ||
      row.all? {|space| @spaces[space] % 2 == 1}
    end
  end

  def diagonal_winner
    d_rows = [[:a,:e,:i],[:c,:e,:g]]
    full_rows = find_full_sets(d_rows)
    full_rows.find do |row|
      row.all? {|space| @spaces[space] % 2 == 0} ||
      row.all? {|space| @spaces[space] % 2 == 1}
    end
  end

  def find_full_sets(test_sets)
    test_sets.select do |set|
      set.all? {|space| @spaces[space]}
    end
  end
end
