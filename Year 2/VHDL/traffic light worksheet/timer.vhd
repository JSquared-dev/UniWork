

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity timer is
port (seconds_timeout : in integer;
		enable, reset : in std_logic;
		fire : out std_logic;
		clk : in std_logic);
end timer;

architecture Behavioural of timer is
signal current_count : integer;
begin
	process (clk, enable, reset)
	begin
		if (reset = '1') then
			current_count <= 0;
		elsif (enable = '1' AND rising_edge(clk)) then
			current_count <= current_count +1;
		else
			current_count <= current_count;
		end if;
	end process;
	
	process (current_count)
	begin
	-- if count is >50,000,000 then fire. else don't fire
		if (current_count > (50000000 * seconds_timeout)) then 
			fire <= '1';
		else 
			fire <= '0';
		end if;
	end process;
end Behavioural;