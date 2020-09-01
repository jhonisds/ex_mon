defmodule ExMon do
  @moduledoc """
  Documentation for `ExMon`.
  """
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotinick"

  @doc """
  Create player.

  ## Examples

      iex> player = ExMon.create_player("Jhoni", :kick, :push, :heal)
      %ExMon.Player{
      life: 100,
      moves: %{move_avg: :push, move_heal: :heal, move_rnd: :kick},
      name: "Jhoni"
      }

  """
  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:puch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  @doc """
  Move player.

  ## Examples

      iex> ExMon.make_move :kick
      11

  """
  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal ->
        "realiza_cura"

      move ->
        Actions.attack(move)

        Status.print_round_message(Game.info())
    end
  end
end
