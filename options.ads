
--Implement:

-- prog [options] cmd [options] [params]

--Rules/requirements:
-- RU Options are parsed by name and always start with dash.
-- RU Option may have at most one value or none.
-- RU Parameters start after last option or its value if it has one.
-- RU Parameters are parsed by position.
-- TODO:
-- RQ Support -- (dash-dash) convention to separate options from parameters.
-- RU Option may be given at most once, regardless whether before or after cmd.
-- RQ Detect invalid option for a given command.
-- RQ Detect unknown options to the whole program.

-- From iNet, note on dash-dash convention to separate options from params/args:
--  '--' as a special argument is a GNU extension, but it is mentioned
--  in the POSIX guidelines. see section 12.2, guideline 10:
--  opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html ...
--  this means you can expect most POSIX and GNU utilities to respect
--  the convention, but others may not.

with Ada.Strings.Unbounded;
use  Ada.Strings.Unbounded;


package Options is

type Option_Record (HasValue : Boolean := False) is
  record
    Token       : Unbounded_String;
    Description : Unbounded_String;
    case HasValue is
     when False => State : Boolean;
     when True  => Value : Unbounded_String;
    end case;
   end record;

function tUS ( s : String ) return Unbounded_String renames To_Unbounded_String;

type All_Options is ( v, h, l );

Known_Options : array (All_Options) of Option_Record := (
  v => (False, tUS("-v"), tUS("print version"),     False ),
  h => (False, tUS("-h"), tUS("print help"),        False ),
  l => (True,  tUS("--verbose"), tUS("level of details (1..5)"),tUS("1") )
  );

Commands: array (Positive range <>) of Option_Record := (
  (False, tUS("help"), tUS("print help"),         False ),
  (False, tUS("list"), tUS("list options table"), False )
);
-- FIXME misused Option_Record; needs only Token & Description

Command : Unbounded_String := Null_Unbounded_String;
-- set by Parse <-- FIXME

function Parse return Positive;
-- parse CLI Argument list into Options table and Command variable
-- return index of the 1st param (to be stored in Params_Start_Index)

end Options;
