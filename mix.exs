defmodule ZenGarden.MixProject do
  use Mix.Project

  def project do
    [
      app: :zen_garden,
      version: "0.1.0",
      build_path: "_build",
      config_path: "config/config.exs",
      deps_path: "deps",
      lockfile: "mix.lock",
      elixir: "~> 1.7",
      elixirc_options: [warnings_as_errors: true],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Transform your test suite into a beautiful zen garden",
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Laurens Boekhorst"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/lboekhorst/zen_garden"}
    ]
  end
end
