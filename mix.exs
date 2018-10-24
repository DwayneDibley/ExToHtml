defmodule Colourizer.MixProject do
  use Mix.Project

  def project do
    [
      app: :extohtml,
      version: "0.1.0",
      elixir: "~> 1.7",
      # start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps()
    ]
  end

  def escript do
    # [main_module: Countdown.CLI]
    [main_module: Colourizer]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # Run "mix help compile.app" to learn about applications.

      # mod: {Colourizer, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.18"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
