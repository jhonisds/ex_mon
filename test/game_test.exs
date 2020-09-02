defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Player1", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Player1", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)

      Game.start(computer, player)

      expected = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Player1"
        },
        status: :started,
        turn: :player
      }

      assert expected == Game.info()
    end
  end

  describe "update/1" do
    test "returns the current game state" do
      player = Player.build("Player1", :chute, :soco, :cura)
      computer = Player.build("Computer", :chute, :soco, :cura)

      Game.start(computer, player)

      expected = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Player1"
        },
        status: :started,
        turn: :player
      }

      assert expected == Game.info()

      expected_state = %{
        computer: %Player{
          life: 80,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Computer"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Player1"
        },
        status: :started,
        turn: :player
      }

      Game.update(expected_state)
      expected = %{expected_state | turn: :computer, status: :continue}
      assert expected == Game.info()
    end
  end
end
