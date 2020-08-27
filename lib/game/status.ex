defmodule ExMon.Game.Status do
  @moduledoc """
  Module Status
  """
  alias ExMon.Game

  def print_round_message() do
    IO.puts("The game is started!")
    IO.inspect(Game.info())
  end
end
