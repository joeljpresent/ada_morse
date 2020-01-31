with Parser; use Parser;
with Test_Utils; use Test_Utils;
with Morse_Code; use Morse_Code;

package body Parser_Test is

   procedure Test_Eat_Input_Char is
      Result : Character;
   begin
      Reset_Parser;
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Gap);
      Test_Case ((Result = 'E'), "Test_Eat_Input_Char_E");

      Reset_Parser;
      Result := Eat_Input_Char (Gap);
      Test_Case ((Result = ' '), "Test_Eat_Input_Char_Gap");

      Reset_Parser;
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dash);
      Result := Eat_Input_Char (Dash);
      Test_Case ((Result = '#'), "Test_Eat_Input_Char_Middle");
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Gap);
      Test_Case ((Result = 'P'), "Test_Eat_Input_Char_P");

      Reset_Parser;
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Result := Eat_Input_Char (Dot);
      Test_Case ((Result = '*'), "Test_Eat_Input_Char_Too_Much");
      Result := Eat_Input_Char (Gap);
      Test_Case ((Result = '#'), "Test_Eat_Input_Char_Too_Much_Gap");
   end Test_Eat_Input_Char;


end Parser_Test;
