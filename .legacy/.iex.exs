# IEx.configure colors: [enabled: true]
# IEx.configure colors: [ eval_result: [ :cyan, :bright ] ]
# IO.puts IO.ANSI.red_background() <> IO.ANSI.white() <> " ❄❄❄ Good Luck with Elixir ❄❄❄ " <> IO.ANSI.reset
Application.put_env(:elixir, :ansi_enabled, true)
IEx.configure(
 colors: [
   eval_result: [:green, :bright] ,
   eval_error: [[:red,:bright,"Bug Bug ..!!"]],
   eval_info: [:yellow, :bright ],
 ],
 # default_prompt: [
 #   "\e[G",    # ANSI CHA, move cursor to column 1
 #    :white,
 #    "I",
 #    :red,
 #    "❤" ,       # plain string
 #    :green,
 #    "%prefix",:white,"|",
 #     :blue,
 #     "%counter",
 #     :white,
 #     "|",
 #    :red,
 #    "▶" ,         # plain string
 #    :white,
 #    "▶▶"  ,       # plain string
 #      # ❤ ❤-»" ,  # plain string
 #    :reset
 #  ] |> IO.ANSI.format |> IO.chardata_to_string

)
