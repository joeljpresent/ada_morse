with LCD_Std_Out; use LCD_Std_Out;

package body Screen is
   procedure Put_On_Screen (Input : in Character) is
   begin
      if Input = '*' then
         Put ("Error");
      elsif Input /= '#' then
         Put (Input);
      end if;
   end Put_On_Screen;
end Screen;
