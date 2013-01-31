
library ieee;
use ieee.std_logic_1164.all;

entity trafficlightscontroller is
port (major_car, minor_car : in std_logic;
		TT_fire, T3_fire, T5_fire : in std_logic;
		TT_Reset, T3_Reset, T5_Reset : out std_logic;
		TT_Enable, T3_Enable, T5_Enable : out std_logic;
		major_lights, minor_lights : out std_logic_vector(1 downto 0); -- 00 red, 01 amber, 10 green, 11 flashing green
		clk : in std_logic
);
end trafficlightscontroller;

architecture fsm of trafficlightscontroller is
type STATE_TYPE is (Init, MG, MGW, MGF, MGFW, MA, MAW, MR, FG, FGW, FGF, FGFW, FA, FAW);
signal state : STATE_TYPE;
begin
	process (clk)
	begin
	if (rising_edge(clk)) then
		case state is
		when Init => 
			if (major_car = '1') then
				state <= MG;
			elsif(minor_car = '1') then
				state <= FG;
			else
				state <= MG;
			end if;
		when MG =>
			state <= MGW;
		when MGW =>
			if (T5_fire = '1' AND minor_car = '1') then
				state <= MGF;
			else
				state <= MGW;
			end if;
		when MGF =>
			state <= MGFW;
		when MGFW =>
			if (TT_fire = '1') then
				state <= MA;
			else
				state <= MGFW;
			end if;
		when MA =>
			state <= MAW;
		when MAW =>
			if (TT_fire = '1') then
				state <= MR;
			else
				state <= MAW;
			end if;
		when MR =>
			state <= FG;
		when FG =>
			state <= FGW;
		when FGW =>
			if (T3_fire = '1' AND major_car = '1') then
				state <= FGF;
			else
				state <= FGW;
			end if;
		when FGF =>
			state <= FGFW;
		when FGFW =>
			if (TT_fire = '1')  then
				state <= FA;
			else
				state <= FGFW;
			end if;
		when FA =>
			state <= FAW;
		when FAW =>
			if (TT_fire = '1') then
				state <= Init;
			else
				state <= FAW;
			end if;
		end case;
	end if;
	end process;

	process (state)
	begin
		case state is
		when Init =>
			major_lights <= "00";
			minor_lights <= "00";
			TT_Reset <= '0';
			T3_Reset <= '0';
			T5_Reset <= '0';
			TT_Enable <= '0';
			T3_Enable <= '0';
			T5_Enable <= '0';
		when MG =>
			major_lights <= "10";
			minor_lights <= "00";
			TT_Reset <= '0';
			T3_Reset <= '0';
			T5_Reset <= '1';
			TT_Enable <= '0';
			T3_Enable <= '0';
			T5_Enable <= '0';
		when MGW =>
			major_lights <= "10";
			minor_lights <= "00";
			TT_Reset <= '0';
			T3_Reset <= '0';
			T5_Reset <= '0';
			TT_Enable <= '0';
			T3_Enable <= '0';
			T5_Enable <= '1';
		when MGF =>
			major_lights <= "11";
			minor_lights <= "00";
			T3_Reset <= '0';
			T3_Enable <= '0';
			T5_Reset <= '0';
			T5_Enable <= '0';
			TT_Reset <= '1';
			TT_Enable <= '0';
		when MGFW =>
			major_lights <= "11";
			minor_lights <= "00";
			T3_Reset <= '0';
			T3_Enable <= '0';
			T5_Reset <= '0';
			T5_Enable <= '0';
			TT_Reset <= '0';
			TT_Enable <= '1';
		when MA =>
			major_lights <= "01";
			minor_lights <= "00";
			T3_Reset <= '0';
			T3_Enable <= '0';
			T5_Reset <= '0';
			T5_Enable <= '0';
			TT_Reset <= '1';
			TT_Enable <= '0';
		when MAW =>
			major_lights <= "01";
			minor_lights <= "00";
			T3_Reset <= '0';
			T3_Enable <= '0';
			T5_Reset <= '0';
			T5_Enable <= '0';
			TT_Reset <= '0';
			TT_Enable <= '1';
		when MR =>
			major_lights <= "00";
			minor_lights <= "00";
			T3_Reset <= '0';
			T3_Enable <= '0';
			T5_Reset <= '0';
			T5_Enable <= '0';
			TT_Reset <= '1';
			TT_Enable <= '0';
		when FG =>
			major_lights <= "00";
			minor_lights <= "10";
			T3_Reset <= '1';
			T3_Enable <= '0';
			T5_Reset <= '0';
			T5_Enable <= '0';
			TT_Reset <= '1';
			TT_Enable <= '0';
		when FGW =>
			major_lights <= "00";
			minor_lights <= "10";
			T5_Reset <= '0';
			T5_Enable <= '0';
			TT_Reset <= '1';
			TT_Enable <= '0';
			T3_Reset <= '0';
			T3_Enable <= '1';
		when FGF =>
			major_lights <= "00";
			minor_lights <= "11";
			T5_Reset <= '0';
			T5_Enable <= '0';
			T3_Reset <= '0';
			T3_Enable <= '1';
			TT_Enable <= '0';
			TT_Reset <= '1';
		when FGFW =>
			major_lights <= "00";
			minor_lights <= "11";
			T5_Reset <= '0';
			T5_Enable <= '0';
			T3_Reset <= '0';
			T3_Enable <= '1';
			TT_Reset <= '0';
			TT_Enable <= '1';
		when FA =>
			major_lights <= "00";
			minor_lights <= "01";
			T5_Reset <= '0';
			T5_Enable <= '0';
			T3_Reset <= '0';
			T3_Enable <= '1';
			TT_Enable <= '0';
			TT_Reset <= '1';
		when FAW =>
			major_lights <= "00";
			minor_lights <= "01";
			T5_Reset <= '0';
			T5_Enable <= '0';
			T3_Reset <= '0';
			T3_Enable <= '1';
			TT_Reset <= '0';
			TT_Enable <= '1';
		end case;
	end process;

end fsm;
