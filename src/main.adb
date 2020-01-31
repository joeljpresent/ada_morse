--  The file declares the main procedure for the demonstration.

-- with Driver;               pragma Unreferenced (Driver);
--  The Driver package contains the task that actually controls the app so
--  although it is not referenced directly in the main procedure, we need it
--  in the closure of the context clauses so that it will be included in the
--  executable.

with Last_Chance_Handler;  pragma Unreferenced (Last_Chance_Handler);
--  The "last chance handler" is the user-defined routine that is called when
--  an exception is propagated. We need it in the executable, therefore it
--  must be somewhere in the closure of the context clauses.

with Button; use Button;
with LCD_Std_Out; use LCD_Std_Out;
with STM32.Board; use STM32.Board;
with Lexer; use Lexer;
with Parser; use Parser;
with Screen; use Screen;
with Morse_Code; use Morse_Code;

with System;

procedure Main is
    pragma Priority (System.Priority'First);
    Current_Status : Directions;
    Current_Char : Input_Char;
    Out_Char : Character;
begin
    Put ("> ");
    STM32.Board.Initialize_LEDs;

    loop
        Current_Status := Wait_For_Direction;
        Current_Char := Get_Next_Input (Current_Status);

        case Current_Char is
           when Dot => Turn_On (Green_LED); Turn_Off (Red_LED);
           when Dash => Turn_Off (Green_LED); Turn_On (Red_LED);
           when Gap => Turn_On (Green_LED); Turn_On (Red_LED);
           when Empty => Turn_Off (Green_LED); Turn_Off (Green_LED);
           when Error => Put ('#');
        end case;

        Out_Char := Eat_Input_Char (Current_Char);
        Put_On_Screen (Out_Char);
    end loop;
end Main;
