--  The "last chance handler" (LCH) is the routine automatically called when
--  any exception is propagated. It is not intended to be called directly. The
--  system-defined LCH simply stops the entire application, ungracefully.
--  Users may redefine it, however, as we have done here. This one turns off
--  all but the red LED, which it turns on, and then goes into an infinite
--  loop.

with System;

package Last_Chance_Handler is

   procedure Last_Chance_Handler (Msg : System.Address; Line : Integer);
   pragma Export (C, Last_Chance_Handler, "__gnat_last_chance_handler");
   pragma No_Return (Last_Chance_Handler);

end Last_Chance_Handler;
