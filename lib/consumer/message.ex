defmodule Consumer.Message do

  @moduledoc false

  @derive [Poison.Encoder]

  defstruct [:url]
end
