with Ada.Text_IO; use Ada.Text_IO;

package body Test_Utils is
    procedure Test_Case (Condition : Boolean; Test_Name : String) is
    begin
    Put ("Test ");
    Put (Test_Name);
    Put (": ");

    if Condition = True then
        Put ("ok");
    else
        Put ("KO");
    end if;

    New_Line (1);
    end Test_Case;
end Test_Utils;
