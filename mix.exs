defmodule ExCernan.Mixfile do
  use Mix.Project

  def project do
    [
      app: :excernan,
      version: "0.0.1",
      dialyzer: [
        plt_add_apps: [:cerlnan_avro],
        flags: [:unmatched_returns,:error_handling,:race_conditions, :no_opaque],
      ],
      deps: deps()
    ]
  end

  defp deps do
    [{:dialyxir, "~> 0.5.1", only: [:dev, :test], runtime: false},
     {:cerlnan_avro, git: "https://github.com/postmates/cerlnan_avro", tag: "0.0.1"},
    ]
  end

end
