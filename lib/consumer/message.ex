defmodule Consumer.Message do

  @derive [Poison.Encoder]

  defstruct [:url]
end
