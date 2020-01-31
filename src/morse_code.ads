package Morse_Code is

    type Morse_Char is (Dot, Dash, Gap);
	type Input_Char is (Dot, Dash, Gap, Empty, Error);
    type Morse is array (Positive range <>) of Morse_Char;

    -- Return true iff C corresponds to a Morse char ('.', '-' or '/').
    function Matches_Morse_Char (C: Character) return Boolean;

    -- Return true iff S contains only Morse chars.
    function Matches_Morse (S: String) return Boolean;

    -- Display a single morse character as an ASCII character.
    function Image (C: Morse_Char) return Character
	    with Post => Matches_Morse_Char (Image'Result);

    -- Display the Morse code as a series of dots, dashes, and slashes.
    function Image (M: Morse) return String
	    with Post => (Image'Result'Size = M'Size
                      and then Matches_Morse (Image'Result));

    -- Transform a character into a Morse_Char.
    function To_Morse_Char (C: Character) return Morse_Char
	    with Pre => Matches_Morse_Char (C);

    -- Create Morse code from a series of dots, dashes, and slashes.
    function Create_Morse (Image: String) return Morse
        with Pre => Matches_Morse (Image),
             Post => Create_Morse'Result'Size = Image'Size;

    -- Transform the Morse code into an alphabetic string.
    function To_String (M: Morse) return String
        with Post => To_String'Result'Size <= M'Size;

    -- Check whether the Morse code has a certain image.
    function Has_Image (M: Morse; Img: String) return Boolean
        with Pre => Matches_Morse (Img);

    -- Convert the Morse code of a letter into the corresponding letter.
    function Parse_Letter (M: Morse) return Character;
end Morse_Code;
