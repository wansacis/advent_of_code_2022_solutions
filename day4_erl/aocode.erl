-module(aocode).
-export([start/0]).

comp_stuff(E1, E2) ->
  [L1,H1] = lists:map(fun(X) -> {Int,_} = string:to_integer(X), Int end, string:tokens(E1,"-")),
  [L2,H2] = lists:map(fun(X) -> {Int,_} = string:to_integer(X), Int end, string:tokens(E2,"-")),
  if
    % Part 1
    L1 >= L2, H1 =< H2 -> 1;
    L2 >= L1, H2 =< H1 -> 1;
    % Part 2
    L1 >= L2, L1 =< H2 -> 1;
    L2 >= L1, L2 =< H1 -> 1;
    H1 >= L2, H1 =< H2 -> 1;
    H2 >= L1, H2 =< H1 -> 1;
    true -> 0
  end.

result(Num) -> 
  io:fwrite("~w~n", [Num]),
  ok.

go_through_lines(L, Score) ->
  case io:get_line(L,'') of
    eof -> result(Score);
    Data ->
      [E1, EA] =  string:split(Data, ","),
      E2 = string:trim(EA),
      go_through_lines(L, Score + comp_stuff(E1,E2))
  end.


start() ->
  {ok, L} = file:open("data", read),
  go_through_lines(L, 0).
