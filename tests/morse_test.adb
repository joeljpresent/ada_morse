with Test_Utils; use Test_Utils;
with Morse_Code; use Morse_Code;

package body Morse_Test is
   procedure Test_Image_Morse_Char_Character is
      M_C : Morse_Char;
      C : Character;
   begin
      M_C := Dot;
      C := Image (M_C);
      Test_Case ((C = '.'), "Test_Image_Morse_Char_Character_Dot");

      M_C := Dash;
      C := Image (M_C);
      Test_Case ((C = '-'), "Test_Image_Morse_Char_Character_Dash");

      M_C := Gap;
      C := Image (M_C);
      Test_Case ((C = '/'), "Test_Image_Morse_Char_Character_Gap");
   end Test_Image_Morse_Char_Character;

   procedure Test_Parse_Letter is
      Morse_Case : Morse := (Gap, Gap, Gap, Gap, Gap, Gap, Gap, Gap);
      Result : Character;
   begin
      Morse_Case := (Gap, Gap, Gap, Gap, Gap, Gap, Gap, Gap);
      Result := Parse_Letter (Morse_Case);
      Test_Case ((Result = '#'), "Test_Parse_Letter_Full_Gap");

      Morse_Case := (Dot, Dot, Dot, Dot, Dot, Dot, Dot, Dot);
      Result := Parse_Letter (Morse_Case);
      Test_Case ((Result = '#'), "Test_Parse_Letter_Full_Dots");

      Morse_Case := (Gap, Dot, Gap, Gap, Gap, Gap, Gap, Gap);
      Result := Parse_Letter (Morse_Case);
      Test_Case ((Result = '#'), "Test_Parse_Letter_Begin_With_Gap");

      Morse_Case := (Dot, Gap, Gap, Gap, Gap, Gap, Gap, Gap);
      Result := Parse_Letter (Morse_Case);
      Test_Case ((Result = 'E'), "Test_Parse_Letter_E");

      Morse_Case := (Dash, Dot, Dot, Dash, Gap, Gap, Gap, Gap);
      Result := Parse_Letter (Morse_Case);
      Test_Case ((Result = 'X'), "Test_Parse_Letter_X");

      Morse_Case := (Dot, Dot, Dash, Dash, Dot, Dot, Gap, Gap);
      Result := Parse_Letter (Morse_Case);
      Test_Case ((Result = '?'), "Test_Parse_Letter_Question_Mark");
   end Test_Parse_Letter;
end Morse_Test;
