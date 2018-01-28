
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

    exit when Arg(1) /= '-';

    Put_Line( "DBG: " & Arg );

    for opt in Opts'Range
    loop

     if Arg = Opts(opt).Token
     then

      if Opts(opt).HasValue = False
      then
        Opts(opt).State := True;
        Put_Line("DBG: "
                 & All_Options'Image(opt)
                 & " WithValue: " & Boolean'Image(Opts(opt).HasValue)
                 & " State: " & Boolean'Image(Opts(opt).State)
                 & " > " & To_String(Opts(opt).Description)
                 );
      else
        Idx := Idx + 1;
        Opts(opt).Value := tUS(CLI.Argument(Idx));
        Put_Line("DBG: "
                 & All_Options'Image(opt)
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



end Options;
