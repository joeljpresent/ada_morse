--  This file provides declarations for the blue user button on the STM32F4
--  Discovery board from ST Microelectronics.

package Button is
    pragma Elaborate_Body;

    type Directions is (Pushed, Released);

    function Current_Direction return Directions;

    function Wait_For_Direction return Directions;
end Button;
