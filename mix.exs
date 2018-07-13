defmodule ExCernanAvro.Mixfile do
  use Mix.Project

  def project do
    [
      app: :excernan_avro,
      version: "0.0.2",
      dialyzer: [
        plt_add_apps: [:cerlnan_avro],
        flags: [:unmatched_returns, :error_handling, :race_conditions, :no_opaque]
      ],
      deps: deps()
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5.1", only: [:dev, :test], runtime: false},
      {:cerlnan_avro, github: "postmates/cerlnan_avro", tag: "0.0.5"}
    ]
  end
end
