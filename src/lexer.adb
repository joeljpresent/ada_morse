with Ada.Real_Time; use Ada.Real_Time;

package body Lexer is
 	Long_Time : constant Time_Span := Milliseconds (2000);
 	Short_Time : constant Time_Span := Milliseconds (1000);

	First_Push : Boolean := True;
	Last_Push : Time := Clock;
	Last_Release : Time := Clock;
	Type State is (Idle, Pushed);
	Current_State : State := Idle;

	function Get_Next_Input (Current_Status : in Directions) return Input_Char is
		Now : constant Time := Clock;
	begin
		if Current_Status = Pushed and then Current_State = Idle then
			Last_Push := Clock;

			Current_State := Pushed;

			if First_Push = False and then Now - Last_Release > Long_Time then
				return Gap;
			else
				First_Push := False;
				return Empty;
			end if;

		elsif Current_Status = Released and then Current_State = Pushed then
			Last_Release := Clock;
			Current_State := Idle;
			First_Push := False;

			if Now - Last_Push > Short_Time then
				return Dash;
			else
				return Dot;
			end if;
		else
			Last_Push := Clock;
			Last_Release := Clock;

			Current_State := Idle;
			return Error;
		end if;
	end Get_Next_Input;
end Lexer;
