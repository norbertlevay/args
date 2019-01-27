with Ada.Text_io; use Ada.Text_io;

procedure enum2 is
   type Color is (Red, Blue, Green);

   type Day is (Sunday, Monday, Tuesday, 
                Wednesday, Thursday, Friday, Saturday);

   package Color_IO is new Enumeration_IO(Color);
   package Day_IO is new Enumeration_IO(Day);

   use Color_IO;
   use Day_IO;

   c: Color;
   d: Day;
   x: character;
   s: String(1..2);

begin

    while not end_of_file loop
        get(c);  
        put(c); put(" ");

        get(x); 
        get(s); 
        put(s); put(" ");

        get(d); put(d);

        new_line;
    end loop;

end enum2;
