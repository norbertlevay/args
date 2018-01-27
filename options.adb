
with Ada.Command_Line;

with Ada.Text_IO;
use  Ada.Text_IO;


package body Options is

  package CLI renames Ada.Command_Line;

-- fill in Known_Options table
-- return index to first non-option arg
function Parse_Options(From : Positive) return Positive
 is
  Idx : Positive := From;
 begin

  while Idx <= CLI.Argument_Count
  loop

   declare
    Arg : String :=  CLI.Argument(Idx);
   begin

    Put_Line( "DBG: " & Arg );

    exit when Arg(1) /= '-';

    for opt in Known_Options'Range
    loop

     if Arg = Known_Options(opt).Token
     then

      if Known_Options(opt).HasValue = False
      then
        Known_Options(opt).State := True;
        Put_Line(All_Options'Image(opt)
                 & " WithValue: " & Boolean'Image(Known_Options(opt).HasValue)
                 & " State: " & Boolean'Image(Known_Options(opt).State)
                 & " > " & To_String(Known_Options(opt).Description)
                 );
      else
        Idx := Idx + 1;
        Known_Options(opt).Value := tUS(CLI.Argument(Idx));
        Put_Line(All_Options'Image(opt)
                 & " WithValue: " & Boolean'Image(Known_Options(opt).HasValue)
                 & " Value: " & To_String(Known_Options(opt).Value)
                 & " > " & To_String(Known_Options(opt).Description)
                 );
      end if;
     end if;

    end loop;
   end;-- declare

   Idx := Idx + 1;
  end loop;

  return Idx;
 end Parse_Options;

 -- returns index to params, if any
 -- if no params returned index is bigger then count of arguments
 function Parse return Positive
 is
  Idx : Positive := Parse_Options(1);
 begin

  if Idx > CLI.Argument_Count then
    return Idx;
  end if;

  Command := tUS(CLI.Argument(Idx));

  Idx := Idx + 1;

  Idx := Parse_Options(Idx);

  return Idx;

 end Parse;


end Options;
