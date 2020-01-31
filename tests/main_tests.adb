with Ada.Text_IO; use Ada.Text_IO;
with Morse_Test; use Morse_Test;
with Parser_Test; use Parser_Test;

procedure Main_Tests is
begin
   Test_Image_Morse_Char_Character;
   New_Line(1);
   Test_Parse_Letter;
   New_Line(1);
   Test_Eat_Input_Char;
end Main_Tests;
