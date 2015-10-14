defmodule Mix.Tasks.Nerd.Deploy do
  use Mix.Task

  @shortdoc "Sends a greeting to us from Nerd"

  @moduledoc """
    This is where we would put any long form documentation or doctests.
  """

  def run(_args) do
    Mix.shell.cmd("git push")
  end

  # We can define other functions as needed here.
end
