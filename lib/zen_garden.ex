defmodule ZenGarden do
  alias ExUnit.CLIFormatter

  use GenServer

  def init(opts), do: CLIFormatter.init(opts)

  def handle_cast({:test_finished, %ExUnit.Test{state: nil} = test}, config) do
    if config.trace() do
      IO.puts(success(trace_test_result(test), config))
    else
      case :rand.uniform() do
        rand when rand < 0.05 ->
          IO.write(success(Enum.random(["🌳", "🌴", "🌲", "🌵", "🍀", "🌻"]), config))

        _rand ->
          IO.write(success(".", config))
      end
    end

    test_counter = update_test_counter(config.test_counter, test)
    test_timings = update_test_timings(config.test_timings, test)
    config = %{config | test_counter: test_counter, test_timings: test_timings}

    {:noreply, config}
  end

  def handle_cast(event, config), do: CLIFormatter.handle_cast(event, config)

  defp trace_test_time(%ExUnit.Test{time: time}) do
    "#{format_us(time)}ms"
  end

  defp trace_test_result(test) do
    "\r  * #{test.name} (#{trace_test_time(test)})"
  end

  defp format_us(us) do
    us = div(us, 10)

    if us < 10 do
      "0.0#{us}"
    else
      us = div(us, 10)
      "#{div(us, 10)}.#{rem(us, 10)}"
    end
  end

  defp update_test_counter(test_counter, %{tags: %{test_type: test_type}}) do
    Map.update(test_counter, test_type, 1, &(&1 + 1))
  end

  defp update_test_timings(timings, %ExUnit.Test{} = test) do
    [test | timings]
  end

  defp colorize(escape, string, %{colors: colors}) do
    if colors[:enabled] do
      [escape, string, :reset]
      |> IO.ANSI.format_fragment(true)
      |> IO.iodata_to_binary()
    else
      string
    end
  end

  defp success(msg, config) do
    colorize(:green, msg, config)
  end
end
