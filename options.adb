
with Ada.Command_Line;

with Ada.Text_IO;
use  Ada.Text_IO;


package body Options is

  package CLI renames Ada.Command_Line;

-- fill in Known_Options table
-- return index to first non-option arg
--function Parse_Options(From : Positive) return Positive
 procedure Parse_Options
           ( Next : in out Integer;
             Opts : in out Option_Array)
 is
  Idx : Positive := Next;
 begin

  while Idx <= CLI.Argument_Count
  loop

   declare
    Arg : String :=  CLI.Argument(Idx);
   begin

    Put_Line( "DBG: " & Arg );

    exit when Arg(1) /= '-';

    -- for opt in Known_Options'Range
    for opt in Opts'Range
    loop

     if Arg = Opts(opt).Token
     then

      if Opts(opt).HasValue = False
      then
        Opts(opt).State := True;
        Put_Line(All_Options'Image(opt)
                 & " WithValue: " & Boolean'Image(Opts(opt).HasValue)
                 & " State: " & Boolean'Image(Opts(opt).State)
                 & " > " & To_String(Opts(opt).Description)
                 );
      else
        Idx := Idx + 1;
        Opts(opt).Value := tUS(CLI.Argument(Idx));
        Put_Line(All_Options'Image(opt)
                 & " WithValue: " & Boolean'Image(Opts(opt).HasValue)
                 & " Value: " & To_String(Opts(opt).Value)
                 & " > " & To_String(Opts(opt).Description)
                 );
      end if;
     end if;

    end loop;
   end;-- declare

   Idx := Idx + 1;
  end loop;

  Next := Idx;
  return;
 end Parse_Options;

 -- if no params returned index is bigger then count of arguments
 procedure Parse
           ( Next : in out Integer;
             Opts : in out Option_Array)
 is
  Idx : Positive;
 begin

  Parse_Options(Next,Opts);
  Idx := Next;

  if Idx > CLI.Argument_Count then
    Next := Idx;
    return;
  end if;

  Command := tUS(CLI.Argument(Idx));

  Idx := Idx + 1;

  Parse_Options(Idx,Opts);

  Next := Idx;
  return;

 end Parse;


end Options;
