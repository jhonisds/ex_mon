defmodule ExMon do
  @moduledoc """
  Documentation for `ExMon`.
  """
  alias ExMon.{Game, Player}
  alias ExMon.Game.Status

  @computer_name "Robotinick"

  @doc """
  Hello world.

  ## Examples

      iex> ExMon.hello()
      :world

  """
  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:puch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message()
  end
end
