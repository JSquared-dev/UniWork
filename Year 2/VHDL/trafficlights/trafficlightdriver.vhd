

library ieee;
use ieee.std_logic_1164.all;

entity trafficlightdriver is
port (encoded_light : in std_logic_vector(1 downto 0);
		red_light, amber_light, green_light : out std_logic;
		clk : in std_logic
		);
end trafficlightdriver;


architecture Behavioural of trafficlightdriver is
component timer is
port (seconds_timeout : in integer;
		enable, reset : in std_logic;
		fire : out std_logic;
		clk : in std_logic);
end component;
signal tt1_fire, tt1_reset, tt1_enable : std_logic;
signal tt2_fire, tt2_reset, tt2_enable : std_logic;
begin

TT1 : timer port map(1, tt1_enable, tt1_reset, tt1_fire, clk);
TT2 : timer port map(1, tt2_enable, tt2_reset, tt2_fire, clk);


process (encoded_light)
begin
	if (encoded_light = "00") then
		red_light <= '1';
		amber_light <= '0';
		green_light <= '0';
	elsif (encoded_light = "01") then
		red_light <= '0';
		amber_light <= '1';
		green_light <= '0';
	elsif (encoded_light = "10") then
		red_light <= '0';
		amber_light <= '0';
		green_light <= '1';
	elsif (encoded_light = "11") then
		red_light <= '0';
		amber_light <= '0';
		if (tt1_fire = '1') then
			tt1_reset <= '1';
			tt1_enable <= '0';
			tt2_reset <= '0';
			tt2_enable <= '1';
			green_light <= '0';
		elsif (tt2_fire = '1') then
			tt2_reset <= '1';
			tt2_enable <= '0';
			tt1_reset <= '0';
			tt1_enable <= '1';
			green_light <= '1';
		end if;
	end if;
end process;


end Behavioural;
		