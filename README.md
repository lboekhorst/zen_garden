# Zen Garden

Transform your test suite into a beautiful zen garden and enjoy some peace and
tranquility.

## Installation

The package can be installed by adding `zen_garden` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:zen_garden, "~> 0.1.0"}
  ]
end
```

# Configuration

The formatter can be configured by adding `ZenGarden` to your list of
formatters in `test_helper.exs`:

```elixir
ExUnit.configure(formatters: [ZenGarden])
```
