
with Ada.Command_Line;

with Ada.Text_IO;
use  Ada.Text_IO;


package body Options is

  package CLI renames Ada.Command_Line;


function Parse return Positive
 is
  Idx : Positive := 1;
  ArgFound : Boolean;
 begin

  Command := tUS(CLI.Argument(1));

  while Idx <= CLI.Argument_Count loop

   declare
    Arg : String :=  CLI.Argument(Idx);
   begin

    if Arg(1) /= '-'
    then
      exit;
    end if;

    Put_Line( Arg );

    ArgFound := False;

    for opt in Known_Options'Range
    loop

     if Arg = Known_Options(opt).Token
     then

      ArgFound := True;

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

    if ArgFound = False then
     null;
     -- raise exception: "Unknown Argument"
     Put_Line("Uknown Argument: " & Arg);
    end if;

   end;

   Idx := Idx + 1;
  end loop;

  return Idx;
 end Parse;


end Options;
