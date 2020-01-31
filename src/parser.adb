package body Parser is
   Buffer : Morse(1 .. 8) := (Gap, Gap, Gap, Gap, Gap, Gap, Gap, Gap);
   Buffer_Index : Positive := Buffer'First;
   procedure Reset_Parser is
   begin
      Buffer_Index := Buffer'First;
      Buffer := (Gap, Gap, Gap, Gap, Gap, Gap, Gap, Gap);
   end Reset_Parser;

   function Eat_Input_Char (Input : in Input_Char) return Character is
      Letter : Character;
   begin
      if Input = Error then
         return '*'; -- Error character
      elsif Buffer_Index > Buffer'Last and (Input = Dot or else Input = Dash) then
         return '*'; -- Error character
      end if;

      case Input is
         when Dot =>
            Buffer (Buffer_Index) := Dot;
            Buffer_Index := Buffer_Index + 1;
            return '#';
         when Dash =>
            Buffer (Buffer_Index) := Dash;
            Buffer_Index := Buffer_Index + 1;
            return '#';
         when Gap =>
            if Buffer_Index = Buffer'First then
               -- The buffer is empty, so the previous char was a Gap too.
               return ' ';
            else
               Buffer_Index := Buffer'First;
               Letter := Parse_Letter (Buffer);
               for I in Buffer'Range loop
                  Buffer (I) := Gap;
               end loop;
               return Letter;
            end if;
         when others =>
            return '#';
      end case;
   end Eat_Input_Char;
end Parser;
