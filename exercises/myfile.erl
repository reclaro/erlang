-module(myfile).
-export([read_polite/1, read_dev/1]).

read(File) ->
    case file:read_file(File) of
      {ok, Bin} -> Bin;
      {error,Error} -> throw(Error)
    end.

read_polite(File) ->
    try read(File) of
        Bin -> Bin
    catch
        throw:Error -> {"Error reading file", File, Error}
    end.

read_dev(File) ->
    catch read(File). %if you want the stacktrace read/1 should use error(Error)

