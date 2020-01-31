with Button; use Button;
with Morse_Code; use Morse_Code;

package Lexer is
	function Get_Next_Input (Current_Status : in Directions) return Input_Char;
end Lexer;
