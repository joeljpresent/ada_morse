with Ada.Interrupts.Names;
with Ada.Real_Time; use Ada.Real_Time;
with Registers;     use Registers;
with STM32F4;       use STM32F4;
with STM32F4.GPIO;  use STM32F4.GPIO;

package body Button is
	protected Button is
		pragma Interrupt_Priority;

		function Current_Direction return Directions;
		entry Wait_For_Signal;

	private
		procedure Interrupt_Handler;
		pragma Attach_Handler
		  (Interrupt_Handler,
		   Ada.Interrupts.Names.EXTI0_Interrupt);

		Direction : Directions := Released;  -- arbitrary
		Last_Time : Time := Clock;
		We_Have_A_Signal : Boolean := False;
	end Button;

	Debounce_Time : constant Time_Span := Milliseconds (250);

	protected body Button is
		function Current_Direction return Directions is
		begin
			return Direction;
		end Current_Direction;

		entry Wait_For_Signal when We_Have_A_Signal is
		begin
			We_Have_A_Signal := False;
		end Wait_For_Signal;

		procedure Interrupt_Handler is
			Now : constant Time := Clock;
		begin
			--  Clear interrupt
			EXTI.PR (0) := 1;

			--  Debouncing
			if Now - Last_Time >= Debounce_Time then
				if Direction = Released then
					Direction := Pushed;
				else
					Direction := Released;
				end if;

				Last_Time := Now;
				We_Have_A_Signal := True;
			end if;
		end Interrupt_Handler;
	end Button;

	function Current_Direction return Directions is
	begin
		return Button.Current_Direction;
	end Current_Direction;

	function Wait_For_Direction return Directions is
	begin
		Button.Wait_For_Signal;
		return Button.Current_Direction;
	end Wait_For_Direction;

	procedure Initialize is
		RCC_AHB1ENR_GPIOA  : constant Word := 16#01#;
		RCC_APB2ENR_SYSCFG : constant Word := 2**14;
	begin
		--  Enable clock for GPIO-A
		RCC.AHB1ENR := RCC.AHB1ENR or RCC_AHB1ENR_GPIOA;

		--  Configure PA0
		GPIOA.MODER (0) := Mode_IN;
		GPIOA.PUPDR (0) := No_Pull;

		--  Enable clock for SYSCFG
		RCC.APB2ENR := RCC.APB2ENR or RCC_APB2ENR_SYSCFG;

		--  Select PA for EXTI0
		SYSCFG.EXTICR1 (0) := 0;

		--  Interrupt on rising edge
		EXTI.FTSR (0) := 1;
		EXTI.RTSR (0) := 1;
		EXTI.IMR (0) := 1;
	end Initialize;
begin
	Initialize;
end Button;
