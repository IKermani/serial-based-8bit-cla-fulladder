LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY adder8c IS
    PORT(
	 CLK, CLR  :  IN   STD_LOGIC;
         x_in      :  IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
         y_in      :  IN   STD_LOGIC_VECTOR(7 DOWNTO 0);
         carry_in  :  IN   STD_LOGIC;
         sum       :  OUT  STD_LOGIC;
         carry_out :  OUT  STD_LOGIC
        );
END adder8c;




ARCHITECTURE behavioral OF adder8c IS

SIGNAL    h_sum              :    STD_LOGIC;
SIGNAL    carry_generate     :    STD_LOGIC;
SIGNAL    carry_propagate    :    STD_LOGIC;
SIGNAL    carry_in_internal  :    STD_LOGIC;
SIGNAL	  counter	     	:	  INTEGER;

BEGIN
    counter <= '0';
    CLR <= '0';

    PROCESS (CLK, CLR)
    BEGIN
	
		IF (CLR = '1') THEN
			counter <= '0';
		ELSIF (rising_edge(CLK)) THEN	
			carry_generate = x_in(counter) AND y_in(counter);
			carry_propagate = x_in(counter) XOR y_in(counter);
			IF ( counter = '0' ) THEN
				carry_in_internal <= carry_generate OR (carry_propagate AND carry_in);
				h_sum <= x_in(0) XOR y_in(0);
				sum <= h_sum XOR carry_in;
			ELSIF ( counter = '7' ) THEN
					carry_out <= carry_generate OR (carry_propagate AND carry_in_internal);
				h_sum <= x_in(7) XOR y_in(7);
				sum <= h_sum XOR carry_in_internal;
			ELSE
				carry_in_internal <= carry_generate OR ( carry_propagate AND carry_in_internal);
				h_sum <= x_in(counter) XOR y_in(counter);
				sum <= h_sum XOR carry_in_internal;
					
			END IF;

			counter <= counter + '1';

			IF ( counter = '8' ) THEN
				CLR <= '1';
			END IF;

		END IF;

    END PROCESS;

END behavioral;
