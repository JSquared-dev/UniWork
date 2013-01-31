

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trafficlights is
port (major_sensor, minor_sensor : in std_logic;
		major_lights, minor_lights : out std_logic_vector(2 downto 0);
		clk : in std_logic
);
end trafficlights;

architecture Behavioural of trafficlights is
component trafficlightscontroller is
port (major_car, minor_car : in std_logic;
		TT_fire, T3_fire, T5_fire : in std_logic;
		TT_Reset, T3_Reset, T5_Reset : out std_logic;
		TT_Enable, T3_Enable, T5_Enable : out std_logic;
		major_lights, minor_lights : out std_logic_vector(1 downto 0); -- 00 red, 01 amber, 10 green, 11 flashing green
		clk : in std_logic
);
end component;
component timer is 
port (seconds_timeout : in integer;
		enable, reset : in std_logic;
		fire : out std_logic;
		clk : in std_logic);
end component;
signal TT_fire, T3_fire, T5_fire : std_logic;
signal TT_Reset, T3_Reset, T5_Reset : std_logic;
signal TT_Enable, T3_Enable, T5_Enable : std_logic;
begin
TLC : trafficlightscontroller port map (major_sensor, minor_sensor, TT_fire, T3_fire, T5_fire, 
														TT_Reset, T3_Reset, T5_Reset, TT_Enable, T3_Enable, T5_Enable, 
														major_lights(1 downto 0), minor_lights(1 downto 0), clk);
TT : timer port map (1, TT_Enable, TT_Reset, TT_fire, clk);
T3 : timer port map (3, T3_Enable, T3_Reset, T3_fire, clk);
T5 : timer port map (5, T5_Enable, T5_Reset, T5_fire, clk);



	major_lights(2) <= '0';
	minor_lights(2) <= '0';
end Behavioural;
