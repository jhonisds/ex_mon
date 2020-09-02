defmodule ExMonTest do
  use ExUnit.Case
  # doctest ExMon
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      player = ExMon.create_player("Player1", :chute, :soco, :cura)

      expected = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Player1"
      }

      assert expected == player
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = ExMon.create_player("Player1", :chute, :soco, :cura)
      message = capture_io(fn -> assert ExMon.start_game(player) == :ok end)

      assert message =~ "The game is started!"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("Player1", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      message =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert message =~ "The Player attacked the computer dealing"
      assert message =~ "It's computer turn"
      assert message =~ "It's player turn"
      assert message =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      message =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert message =~ "Invalid move: wrong"
    end
  end
end
