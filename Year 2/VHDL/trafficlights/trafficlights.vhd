

library ieee;
use ieee.std_logic_1164.all;

entity trafficlights is
port (placeholder : in bit;
		clk : in std_logic
		);
end trafficlights;


architecture Behavioural of trafficlights is
	type STATE_TYPE is (s0, s1, s2);
	signal current_state, next_state : STATE_TYPE;
begin
-- input logic
	process (placeholder)
	begin
	end process;

-- state register
	process (clk)
	begin
		if (rising_edge(clk)) then
		current_state <= next_state;
		end if;
	end process;

-- output logic
	process (placeholder)
	begin
	end process;

end Behavioural;
