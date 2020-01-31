with LEDs;          use LEDs;
with Button;        use Button;
with Ada.Real_Time; use Ada.Real_Time;

package body Driver is

   type Index is mod 4;

   Pattern : constant array (Index) of User_LED := (Orange, Red, Blue, Green);
   --  The LEDs are not physically laid out "consecutively" in such a way that
   --  we can simply go in enumeral order to get circular rotation. Thus we
   --  define this mapping, using a consecutive index to get the physical LED
   --  blinking order desired.

   task body Controller is
      Period     : constant Time_Span := Milliseconds (100);  -- arbitrary
      Next_Start : Time := Clock;
      Next_LED   : Index := 0;
   begin
      loop
         Off (Pattern (Next_LED));

         if Button.Current_Direction = Pushed then
            Next_LED := Next_LED - 1;
         else
            Next_LED := Next_LED + 1;
         end if;

         On (Pattern (Next_LED));

         Next_Start := Next_Start + Period;
         delay until Next_Start;
      end loop;
   end Controller;

end Driver;
