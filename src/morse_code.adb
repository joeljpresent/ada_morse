package body Morse_Code is

    function Matches_Morse_Char (C: Character) return Boolean is
    begin
        return C = '.' or else C = '-' or else C = '/';
    end Matches_Morse_Char;

    function Matches_Morse (S: String) return Boolean is
    begin
        for C of S loop
            if not Matches_Morse_Char (C) then
                return false;
            end if;
        end loop;
        return true;
    end Matches_Morse;

    function Image (C: Morse_Char) return Character is
    begin
        case C is
            when Dot => return '.';
            when Dash => return '-';
            when Gap => return '/';
        end case;
    end Image;

    function Image (M: Morse) return String
    is
        Str: String (M'Range);
    begin
        for I in M'Range loop
            Str (I) := Image (M (I));
        end loop;
        return Str;
    end Image;

    function To_Morse_Char (C: Character) return Morse_Char is
    begin
        case C is
            when '.' => return Dot;
            when '-' => return Dash;
            when '/' => return Gap;
            when others => raise Constraint_Error;
        end case;
    end To_Morse_Char;

    function Create_Morse (Image: String) return Morse is
        M: Morse (Image'Range);
    begin
        for I in Image'Range loop
            M (I) := To_Morse_Char (Image (I)); 
        end loop;
        return M;
    end Create_Morse;

    function Has_Image (M: Morse; Img: String) return Boolean is
    begin
        if M'Size > Img'Size and then M (Img'Last - Img'First + M'First + 1) /= Gap then
            return False;
        end if;
        for I in Img'Range loop
            if Image (M (I - Img'First + M'First)) /= Img (I) then
                return False;
            end if;
        end loop;
        return True;
    end Has_Image;

    function Parse_Letter (M: Morse) return Character is
    begin
        if Has_Image (M, ".-") then return 'A';
        elsif Has_Image (M, "-...") then return 'B';
        elsif Has_Image (M, "-.-.") then return 'C';
        elsif Has_Image (M, "-..") then return 'D';
        elsif Has_Image (M, ".") then return 'E';
        elsif Has_Image (M, "..-.") then return 'F';
        elsif Has_Image (M, "--.") then return 'G';
        elsif Has_Image (M, "....") then return 'H';
        elsif Has_Image (M, "..") then return 'I';
        elsif Has_Image (M, ".---") then return 'J';
        elsif Has_Image (M, "-.-") then return 'K';
        elsif Has_Image (M, ".-..") then return 'L';
        elsif Has_Image (M, "--") then return 'M';
        elsif Has_Image (M, "-.") then return 'N';
        elsif Has_Image (M, "---") then return 'O';
        elsif Has_Image (M, ".--.") then return 'P';
        elsif Has_Image (M, "--.-") then return 'Q';
        elsif Has_Image (M, ".-.") then return 'R';
        elsif Has_Image (M, "...") then return 'S';
        elsif Has_Image (M, "-") then return 'T';
        elsif Has_Image (M, "..-") then return 'U';
        elsif Has_Image (M, "...-") then return 'V';
        elsif Has_Image (M, ".--") then return 'W';
        elsif Has_Image (M, "-..-") then return 'X';
        elsif Has_Image (M, "-.--") then return 'Y';
        elsif Has_Image (M, "--..") then return 'Z';
        elsif Has_Image (M, "-----") then return '0';
        elsif Has_Image (M, ".----") then return '1';
        elsif Has_Image (M, "..---") then return '2';
        elsif Has_Image (M, "...--") then return '3';
        elsif Has_Image (M, "....-") then return '4';
        elsif Has_Image (M, ".....") then return '5';
        elsif Has_Image (M, "-....") then return '6';
        elsif Has_Image (M, "--...") then return '7';
        elsif Has_Image (M, "---..") then return '8';
        elsif Has_Image (M, "----.") then return '9';
        elsif Has_Image (M, ".-.-.-") then return '.';
        elsif Has_Image (M, "--..--") then return ',';
        elsif Has_Image (M, "..--..") then return '?';
        elsif Has_Image (M, ".----.") then return ''';
        elsif Has_Image (M, "-.-.--") then return '!';
        elsif Has_Image (M, "-..-.") then return '/';
        elsif Has_Image (M, "-.--.") then return '(';
        elsif Has_Image (M, "-.--.-") then return ')';
        elsif Has_Image (M, ".-...") then return '&';
        elsif Has_Image (M, "---...") then return ':';
        elsif Has_Image (M, "-.-.-.") then return ';';
        elsif Has_Image (M, "-...-") then return '=';
        elsif Has_Image (M, ".-.-.") then return '+';
        elsif Has_Image (M, "-....-") then return '-';
        elsif Has_Image (M, "..--.-") then return '_';
        elsif Has_Image (M, ".-..-.") then return '"';
        elsif Has_Image (M, "...-..-") then return '$';
        elsif Has_Image (M, ".--.-.") then return '@';
        end if;
        return '*';
    end Parse_Letter;

    function To_String (M: Morse) return String is
        Start_Of_Letter: Positive := M'First;
        End_Of_Letter: Positive;
        Str: String (M'Range);
        Str_Index: Positive := M'First;

        procedure Try_Parse_Letter is
        begin
            End_Of_Letter := Start_Of_Letter;
            while End_Of_Letter <= M'Last and then M (End_Of_Letter) /= Gap loop
                End_Of_Letter := End_Of_Letter + 1;
            end loop;
            Str (Str_Index) := Parse_Letter (M (Start_Of_Letter..End_Of_Letter - 1));
            Str_Index := Str_Index + 1;
            Start_Of_Letter := End_Of_Letter;
        end Try_Parse_Letter;

        procedure Add_Space is
        begin
            Str (Str_Index) := ' ';
            Str_Index := Str_Index + 1;
        end Add_Space;
        
    begin
        while Start_Of_Letter <= M'Last loop
            case M (Start_Of_Letter) is
                when Dot | Dash => Try_Parse_Letter;
                when Gap => Add_Space;
            end case;
            Start_Of_Letter := Start_Of_Letter + 1;
        end loop;
        return Str (M'First..Str_Index - 1);
    end To_String;
    
end Morse_Code;
