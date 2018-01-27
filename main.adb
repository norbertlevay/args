with
    Build_Date,
    Options,
    -- Commands,
    Ada.Exceptions,
    Ada.Text_IO,
    Ada.Direct_IO,
    Ada.Text_IO.Bounded_IO,
    Ada.Command_Line,
    Ada.Strings.Unbounded,
    Ada.Strings.Bounded,
    GNAT.Traceback.Symbolic;


use
    Ada.Exceptions,
    Ada.Text_IO,
    Ada.Strings.Unbounded,
    Ada.Command_Line;


procedure main is

 Version : String := "main 0.0.0 Build: " & Build_Date.BuildDate ;

 procedure Print_Usage is
 begin
   Put_Line("Version: " & Version);
   New_Line;
   Put_Line("Usage:");
   Put_Line(" main listopts  - list parsed options");
   New_Line;
   Put_Line("Options:");
    for opt in Options.Known_Options'Range
    loop
      Put_Line(  "  "
               & To_String(Options.Known_Options(opt).Token)
               & "    "
               & To_String(Options.Known_Options(opt).Description));
    end loop;
   New_Line;
   New_Line;
 end Print_Usage;

 Idx_Params : Positive;

 begin

 Idx_Params := Options.Parse;

 Put_Line("IdxParams: " & Positive'Image(Idx_params));

 --
 -- run the command
 --

 if Options.Command = "help"
 then

   Print_Usage;

 elsif Options.Command = "list"
 then

   while Idx_Params <= Argument_Count loop
    Put_Line("EXEC: list " & Argument(Idx_params));
    Idx_Params := Idx_Params + 1;
   end loop;

  else

   Put_Line("Unknwon command");

 end if;


-- Exception handling:
--
 -- declare exception:
 -- Queue_Error : exception; <- behaves like "type" (not "variable")
 --
 -- to rasie exception:
 -- raise Queue_Error with "Buffer Full"; <-- "with msg-string" is optional
 -- msg-string can be retrieved by Exception_Meassage( e_id )
 --
 -- When cathing exception instance identifier does not need
 -- to be declared expicitely:
 -- Except_ID : Ada.Exceptions.EXCEPTION_OCCURRENCE;
 -- It is clear from syntax "when <e_instance> : <e_type> => [code]"
 -- Except_ID will be filled in when a particular exception actually happens
 -- and is an index which can be used to retrieve more info about
 -- that particular exception

 exception
 when Except_ID : Name_Error =>
--     Put_Line( "Name> " & Exception_Name( Except_ID ) );
--     Put_Line( "Mesg> " & Exception_Message( Except_ID ) );
     -- Ada RefMan: Mesg should be short (one line)
     Put_Line( "Info: ");
     Put_Line( Exception_Information( Except_ID ) );
     -- Ada RefMan: Info can be long
  when Except_ID : others =>
     declare
      Error : File_Type := Standard_Error;
     begin
      New_Line(Error);
      Put_Line(Error, "Program error, send a bug-report:");
      Put_Line(Error, "provide program's arguments and copy the following information: ");
--      New_Line(Error);
--      Put_Line(Error, "Exception_Name: " & Exception_Name( Except_ID ) );
--      Put_Line(Error, "Exception_Message: " & Exception_Message( Except_ID ) );
      Put_Line(Error, "Exception_Information: ");
      Put_Line(Error, Exception_Information( Except_ID ) );
 --     New_Line(Error);
      --Put_Line(" > Trace-back of call stack: " );
      -- Put_Line( GNAT.Traceback.Symbolic.Symbolic_Traceback(Except_ID) );
      -- See more at: http://compgroups.net/comp.lang.ada/gnat-symbolic-traceback-on-exceptions/1409155#sthash.lNdkTjq6.dpuf
      -- Do teh same manually, use:
      -- addr2line -e ./fits addr1 addr2 ...
     end;
end main;

