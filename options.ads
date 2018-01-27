
--Implement:

-- prog [options] cmd [options] [params]

--Rules/requirements:
-- RU Options are parsed by name and always start with dash.
-- RU Option may be given at most once.
-- RU Option may have at most one value or none.
-- RQ Support -- (dash-dash) convention to separate options from parameters.
-- RU Parameters start after last option or its value if it has one.
-- RU Parameters are parsed by position.
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

type All_Options is ( v, h, l, w );

Known_Options : array (All_Options) of Option_Record := (
  v => (False, tUS("-v"), tUS("print version")    ,False     ),
  h => (False, tUS("-h"), tUS("print usage info") ,False     ),
  l => (True,  tUS("-l"), tUS("list something")   ,tUS("1")  ),
  w => (True,  tUS("-w"), tUS("print verbosity")  ,tUS("23") )
  );


Command : Unbounded_String;
-- set by Prse <-- FIXME

function Parse return Positive;
-- parse CLI Argument list into Options table and detect errors
-- return index of the 1st param (to be stored in Params_Start_Index)

end Options;
