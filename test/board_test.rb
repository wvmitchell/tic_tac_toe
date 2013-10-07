require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'

class BoardTest < MiniTest::Test

  def test_it_has_nine_possible_moves
    board = Board.new
    assert_equal 9, board.spaces.count
  end

  def test_move_updates_spaces_hash
    board = Board.new
    board.move(:a, 1)
    assert_equal 1, board.spaces[:a]
  end

  def test_move_on_already_placed_space_doesnt_update
    board = Board.new
    board.move(:a, 1)
    board.move(:a, 2)
    assert_equal 1, board.spaces[:a]
  end

  def test_board_is_not_expired_by_default
    board = Board.new
    refute board.expired?
  end

  def test_board_is_expired_once_a_winning_horizontal_combo_played
    board = Board.new
    board.move(:a, 1)
    refute board.expired?
    board.move(:b, 3)
    refute board.expired?
    board.move(:c, 5)
    assert board.expired?
  end

  def test_board_is_expired_once_a_winning_vertical_combo_played
    board = Board.new
    board.move(:a, 1)
    refute board.expired?
    board.move(:d, 3)
    refute board.expired?
    board.move(:g, 5)
    assert board.expired?
  end

  def test_board_is_expired_once_a_winning_diagonal_combo_played
    board = Board.new
    board.move(:a, 1)
    refute board.expired?
    board.move(:e, 3)
    refute board.expired?
    board.move(:i, 5)
    assert board.expired?
  end

  def test_winner_returns_winning_set_or_nil
    board = Board.new
    board.move(:a, 1)
    refute board.winning_set
    board.move(:b, 3)
    refute board.winning_set
    board.move(:c, 5)
    assert_equal [:a,:b,:c], board.winning_set
  end

  def test_winner_returns_correct_string
    board = Board.new
    board.move(:a, 1)
    board.move(:b, 3)
    board.move(:c, 5)
    assert "Player 1", board.winner
  end

  def test_winner_returns_nil_if_no_winner_present
    board = Board.new
    assert_nil board.winner
  end

  def test_board_is_expired_when_no_winner_but_board_full
    board = Board.new
    board.spaces = {a:1,b:3,c:4,d:2,e:5,f:6,g:7,h:8,i:10}
    assert board.full?
    assert board.expired?
  end

  def test_board_is_not_full_by_default
    board = Board.new
    refute board.full?
  end

  def test_find_full_sets_returns_subset_of_array_with_filled_values
    board = Board.new
    board.move(:a, 1)
    board.move(:b, 2)
    board.move(:c, 3)
    assert_equal [[:a, :b, :c]], board.find_full_sets([[:a,:b,:c],[:d,:e,:f]])
  end

end
