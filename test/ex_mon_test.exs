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

  describe "make_move/4" do
    test "returns the fetch player" do
    end
  end
end
