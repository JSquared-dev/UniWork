-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II"
-- VERSION "Version 11.0 Build 208 07/03/2011 Service Pack 1 SJ Full Version"

-- DATE "11/01/2012 16:50:17"

-- 
-- Device: Altera EP3C16F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	trafficlights IS
    PORT (
	major_lights : OUT std_logic_vector(2 DOWNTO 0);
	minor_lights : OUT std_logic_vector(2 DOWNTO 0);
	major_sensor : IN std_logic;
	minor_sensor : IN std_logic;
	clk : IN std_logic
	);
END trafficlights;

-- Design Ports Information
-- major_lights[0]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- major_lights[1]	=>  Location: PIN_B2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- major_lights[2]	=>  Location: PIN_B1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- minor_lights[0]	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- minor_lights[1]	=>  Location: PIN_J2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- minor_lights[2]	=>  Location: PIN_J3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- minor_sensor	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_G21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- major_sensor	=>  Location: PIN_D2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF trafficlights IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_major_lights : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_minor_lights : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_major_sensor : std_logic;
SIGNAL ww_minor_sensor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL \TLDM|tt2_reset~0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \TLDF|tt2_reset~0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \TLDM|TT1|Add0~8_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~20_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~24_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~40_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~56_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~1\ : std_logic;
SIGNAL \TLDM|TT2|Add0~0_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~3\ : std_logic;
SIGNAL \TLDM|TT2|Add0~2_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~5\ : std_logic;
SIGNAL \TLDM|TT2|Add0~4_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~7\ : std_logic;
SIGNAL \TLDM|TT2|Add0~6_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~9\ : std_logic;
SIGNAL \TLDM|TT2|Add0~8_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~11\ : std_logic;
SIGNAL \TLDM|TT2|Add0~10_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~13\ : std_logic;
SIGNAL \TLDM|TT2|Add0~12_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~15\ : std_logic;
SIGNAL \TLDM|TT2|Add0~14_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~17\ : std_logic;
SIGNAL \TLDM|TT2|Add0~16_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~19\ : std_logic;
SIGNAL \TLDM|TT2|Add0~18_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~21\ : std_logic;
SIGNAL \TLDM|TT2|Add0~20_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~23\ : std_logic;
SIGNAL \TLDM|TT2|Add0~22_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~25\ : std_logic;
SIGNAL \TLDM|TT2|Add0~24_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~27\ : std_logic;
SIGNAL \TLDM|TT2|Add0~26_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~29\ : std_logic;
SIGNAL \TLDM|TT2|Add0~28_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~31\ : std_logic;
SIGNAL \TLDM|TT2|Add0~30_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~33\ : std_logic;
SIGNAL \TLDM|TT2|Add0~32_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~35\ : std_logic;
SIGNAL \TLDM|TT2|Add0~34_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~37\ : std_logic;
SIGNAL \TLDM|TT2|Add0~36_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~39\ : std_logic;
SIGNAL \TLDM|TT2|Add0~38_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~41\ : std_logic;
SIGNAL \TLDM|TT2|Add0~40_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~43\ : std_logic;
SIGNAL \TLDM|TT2|Add0~42_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~45\ : std_logic;
SIGNAL \TLDM|TT2|Add0~44_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~47\ : std_logic;
SIGNAL \TLDM|TT2|Add0~46_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~49\ : std_logic;
SIGNAL \TLDM|TT2|Add0~48_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~51\ : std_logic;
SIGNAL \TLDM|TT2|Add0~50_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~53\ : std_logic;
SIGNAL \TLDM|TT2|Add0~52_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~55\ : std_logic;
SIGNAL \TLDM|TT2|Add0~54_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~57\ : std_logic;
SIGNAL \TLDM|TT2|Add0~56_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~59\ : std_logic;
SIGNAL \TLDM|TT2|Add0~58_combout\ : std_logic;
SIGNAL \TLDM|TT2|Add0~60_combout\ : std_logic;
SIGNAL \T5|Add0~24_combout\ : std_logic;
SIGNAL \T5|Add0~56_combout\ : std_logic;
SIGNAL \TT|Add0~4_combout\ : std_logic;
SIGNAL \TT|Add0~10_combout\ : std_logic;
SIGNAL \TT|Add0~20_combout\ : std_logic;
SIGNAL \TT|Add0~56_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~4_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~10_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~20_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~28_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~42_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~59\ : std_logic;
SIGNAL \TLDF|TT1|Add0~60_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~24_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~36_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~45\ : std_logic;
SIGNAL \TLDF|TT2|Add0~47\ : std_logic;
SIGNAL \TLDF|TT2|Add0~46_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~49\ : std_logic;
SIGNAL \TLDF|TT2|Add0~48_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~51\ : std_logic;
SIGNAL \TLDF|TT2|Add0~50_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~53\ : std_logic;
SIGNAL \TLDF|TT2|Add0~52_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~55\ : std_logic;
SIGNAL \TLDF|TT2|Add0~54_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~57\ : std_logic;
SIGNAL \TLDF|TT2|Add0~56_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~59\ : std_logic;
SIGNAL \TLDF|TT2|Add0~58_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~60_combout\ : std_logic;
SIGNAL \T3|Add0~36_combout\ : std_logic;
SIGNAL \T3|Add0~40_combout\ : std_logic;
SIGNAL \T3|Add0~42_combout\ : std_logic;
SIGNAL \T3|Add0~59\ : std_logic;
SIGNAL \T3|Add0~60_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~9_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~10_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~11_combout\ : std_logic;
SIGNAL \TLDM|green_light~0_combout\ : std_logic;
SIGNAL \TLDM|green_light~1_combout\ : std_logic;
SIGNAL \TLDM|green_light~2_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~0_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~1_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~2_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~3_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~4_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~5_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~6_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~7_combout\ : std_logic;
SIGNAL \TLDM|TT2|LessThan0~8_combout\ : std_logic;
SIGNAL \TLDM|green_light~3_combout\ : std_logic;
SIGNAL \TLC|process_0~0_combout\ : std_logic;
SIGNAL \TLC|process_0~3_combout\ : std_logic;
SIGNAL \TLC|process_0~6_combout\ : std_logic;
SIGNAL \TLC|process_0~15_combout\ : std_logic;
SIGNAL \TT|LessThan0~9_combout\ : std_logic;
SIGNAL \TT|LessThan0~10_combout\ : std_logic;
SIGNAL \TT|LessThan0~11_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~9_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~10_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~11_combout\ : std_logic;
SIGNAL \TLDF|green_light~0_combout\ : std_logic;
SIGNAL \TLDF|green_light~1_combout\ : std_logic;
SIGNAL \TLDF|green_light~2_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~0_combout\ : std_logic;
SIGNAL \TLC|state.MR~q\ : std_logic;
SIGNAL \TLC|Selector4~0_combout\ : std_logic;
SIGNAL \T3|LessThan0~8_combout\ : std_logic;
SIGNAL \T3|LessThan0~10_combout\ : std_logic;
SIGNAL \TLC|state~24_combout\ : std_logic;
SIGNAL \TLDM|TT2|current_count[0]~0_combout\ : std_logic;
SIGNAL \T3|current_count[0]~0_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \TT|Add0~0_combout\ : std_logic;
SIGNAL \TLC|Selector1~0_combout\ : std_logic;
SIGNAL \TLC|state.MGFW~q\ : std_logic;
SIGNAL \major_sensor~input_o\ : std_logic;
SIGNAL \T3|Add0~0_combout\ : std_logic;
SIGNAL \minor_sensor~input_o\ : std_logic;
SIGNAL \TLC|state~23_combout\ : std_logic;
SIGNAL \TLC|state.Init~q\ : std_logic;
SIGNAL \TLC|Selector3~0_combout\ : std_logic;
SIGNAL \TLC|state.FG~q\ : std_logic;
SIGNAL \TLC|state~22_combout\ : std_logic;
SIGNAL \TLC|state.FA~q\ : std_logic;
SIGNAL \TLC|Selector6~0_combout\ : std_logic;
SIGNAL \TLC|state.FAW~q\ : std_logic;
SIGNAL \TLC|WideOr10~0_combout\ : std_logic;
SIGNAL \TLC|WideOr13~0_combout\ : std_logic;
SIGNAL \T3|Add0~1\ : std_logic;
SIGNAL \T3|Add0~2_combout\ : std_logic;
SIGNAL \T3|Add0~3\ : std_logic;
SIGNAL \T3|Add0~5\ : std_logic;
SIGNAL \T3|Add0~6_combout\ : std_logic;
SIGNAL \T3|Add0~7\ : std_logic;
SIGNAL \T3|Add0~9\ : std_logic;
SIGNAL \T3|Add0~11\ : std_logic;
SIGNAL \T3|Add0~12_combout\ : std_logic;
SIGNAL \T3|Add0~13\ : std_logic;
SIGNAL \T3|Add0~14_combout\ : std_logic;
SIGNAL \T3|Add0~15\ : std_logic;
SIGNAL \T3|Add0~16_combout\ : std_logic;
SIGNAL \T3|Add0~17\ : std_logic;
SIGNAL \T3|Add0~18_combout\ : std_logic;
SIGNAL \T3|Add0~19\ : std_logic;
SIGNAL \T3|Add0~21\ : std_logic;
SIGNAL \T3|Add0~22_combout\ : std_logic;
SIGNAL \T3|Add0~23\ : std_logic;
SIGNAL \T3|Add0~25\ : std_logic;
SIGNAL \T3|Add0~26_combout\ : std_logic;
SIGNAL \T3|Add0~27\ : std_logic;
SIGNAL \T3|Add0~29\ : std_logic;
SIGNAL \T3|Add0~30_combout\ : std_logic;
SIGNAL \T3|Add0~31\ : std_logic;
SIGNAL \T3|Add0~32_combout\ : std_logic;
SIGNAL \T3|Add0~33\ : std_logic;
SIGNAL \T3|Add0~34_combout\ : std_logic;
SIGNAL \T3|Add0~35\ : std_logic;
SIGNAL \T3|Add0~37\ : std_logic;
SIGNAL \T3|Add0~38_combout\ : std_logic;
SIGNAL \T3|Add0~39\ : std_logic;
SIGNAL \T3|Add0~41\ : std_logic;
SIGNAL \T3|Add0~43\ : std_logic;
SIGNAL \T3|Add0~44_combout\ : std_logic;
SIGNAL \T3|Add0~45\ : std_logic;
SIGNAL \T3|Add0~46_combout\ : std_logic;
SIGNAL \T3|Add0~47\ : std_logic;
SIGNAL \T3|Add0~48_combout\ : std_logic;
SIGNAL \T3|Add0~49\ : std_logic;
SIGNAL \T3|Add0~50_combout\ : std_logic;
SIGNAL \T3|Add0~51\ : std_logic;
SIGNAL \T3|Add0~52_combout\ : std_logic;
SIGNAL \T3|Add0~24_combout\ : std_logic;
SIGNAL \T3|Add0~28_combout\ : std_logic;
SIGNAL \T3|LessThan0~7_combout\ : std_logic;
SIGNAL \T3|Add0~20_combout\ : std_logic;
SIGNAL \T3|LessThan0~4_combout\ : std_logic;
SIGNAL \T3|LessThan0~6_combout\ : std_logic;
SIGNAL \T3|Add0~10_combout\ : std_logic;
SIGNAL \T3|Add0~8_combout\ : std_logic;
SIGNAL \T3|Add0~4_combout\ : std_logic;
SIGNAL \T3|LessThan0~2_combout\ : std_logic;
SIGNAL \T3|LessThan0~3_combout\ : std_logic;
SIGNAL \T3|LessThan0~5_combout\ : std_logic;
SIGNAL \T3|LessThan0~9_combout\ : std_logic;
SIGNAL \T3|Add0~53\ : std_logic;
SIGNAL \T3|Add0~54_combout\ : std_logic;
SIGNAL \T3|Add0~55\ : std_logic;
SIGNAL \T3|Add0~57\ : std_logic;
SIGNAL \T3|Add0~58_combout\ : std_logic;
SIGNAL \T3|Add0~56_combout\ : std_logic;
SIGNAL \T3|LessThan0~0_combout\ : std_logic;
SIGNAL \T3|LessThan0~1_combout\ : std_logic;
SIGNAL \T3|LessThan0~11_combout\ : std_logic;
SIGNAL \TLC|Selector4~1_combout\ : std_logic;
SIGNAL \TLC|state.FGW~q\ : std_logic;
SIGNAL \TLC|state~21_combout\ : std_logic;
SIGNAL \TLC|state.FGF~q\ : std_logic;
SIGNAL \TLC|Selector5~0_combout\ : std_logic;
SIGNAL \TLC|state.FGFW~q\ : std_logic;
SIGNAL \TLC|WideOr11~1_combout\ : std_logic;
SIGNAL \TLC|state~19_combout\ : std_logic;
SIGNAL \TLC|state.MG~q\ : std_logic;
SIGNAL \T5|Add0~0_combout\ : std_logic;
SIGNAL \T5|Add0~1\ : std_logic;
SIGNAL \T5|Add0~2_combout\ : std_logic;
SIGNAL \T5|Add0~3\ : std_logic;
SIGNAL \T5|Add0~5\ : std_logic;
SIGNAL \T5|Add0~6_combout\ : std_logic;
SIGNAL \T5|Add0~7\ : std_logic;
SIGNAL \T5|Add0~9\ : std_logic;
SIGNAL \T5|Add0~11\ : std_logic;
SIGNAL \T5|Add0~12_combout\ : std_logic;
SIGNAL \T5|Add0~13\ : std_logic;
SIGNAL \T5|Add0~14_combout\ : std_logic;
SIGNAL \T5|Add0~15\ : std_logic;
SIGNAL \T5|Add0~16_combout\ : std_logic;
SIGNAL \T5|Add0~17\ : std_logic;
SIGNAL \T5|Add0~18_combout\ : std_logic;
SIGNAL \T5|Add0~19\ : std_logic;
SIGNAL \T5|Add0~21\ : std_logic;
SIGNAL \T5|Add0~22_combout\ : std_logic;
SIGNAL \T5|Add0~23\ : std_logic;
SIGNAL \T5|Add0~25\ : std_logic;
SIGNAL \T5|Add0~26_combout\ : std_logic;
SIGNAL \T5|Add0~27\ : std_logic;
SIGNAL \T5|Add0~29\ : std_logic;
SIGNAL \T5|Add0~30_combout\ : std_logic;
SIGNAL \T5|Add0~31\ : std_logic;
SIGNAL \T5|Add0~32_combout\ : std_logic;
SIGNAL \T5|Add0~33\ : std_logic;
SIGNAL \T5|Add0~34_combout\ : std_logic;
SIGNAL \T5|Add0~35\ : std_logic;
SIGNAL \T5|Add0~37\ : std_logic;
SIGNAL \T5|Add0~38_combout\ : std_logic;
SIGNAL \T5|Add0~39\ : std_logic;
SIGNAL \T5|Add0~41\ : std_logic;
SIGNAL \T5|Add0~43\ : std_logic;
SIGNAL \T5|Add0~44_combout\ : std_logic;
SIGNAL \T5|Add0~45\ : std_logic;
SIGNAL \T5|Add0~46_combout\ : std_logic;
SIGNAL \T5|Add0~47\ : std_logic;
SIGNAL \T5|Add0~48_combout\ : std_logic;
SIGNAL \T5|Add0~49\ : std_logic;
SIGNAL \T5|Add0~50_combout\ : std_logic;
SIGNAL \TLC|process_0~12_combout\ : std_logic;
SIGNAL \T5|Add0~36_combout\ : std_logic;
SIGNAL \T5|Add0~51\ : std_logic;
SIGNAL \T5|Add0~52_combout\ : std_logic;
SIGNAL \TLC|process_0~1_combout\ : std_logic;
SIGNAL \T5|Add0~42_combout\ : std_logic;
SIGNAL \T5|Add0~40_combout\ : std_logic;
SIGNAL \TLC|process_0~2_combout\ : std_logic;
SIGNAL \TLC|process_0~13_combout\ : std_logic;
SIGNAL \T5|Add0~8_combout\ : std_logic;
SIGNAL \T5|Add0~10_combout\ : std_logic;
SIGNAL \T5|current_count[0]~0_combout\ : std_logic;
SIGNAL \T5|Add0~4_combout\ : std_logic;
SIGNAL \TLC|process_0~4_combout\ : std_logic;
SIGNAL \TLC|process_0~5_combout\ : std_logic;
SIGNAL \TLC|process_0~7_combout\ : std_logic;
SIGNAL \T5|Add0~28_combout\ : std_logic;
SIGNAL \TLC|process_0~8_combout\ : std_logic;
SIGNAL \T5|Add0~20_combout\ : std_logic;
SIGNAL \TLC|process_0~9_combout\ : std_logic;
SIGNAL \TLC|process_0~10_combout\ : std_logic;
SIGNAL \TLC|process_0~11_combout\ : std_logic;
SIGNAL \TLC|process_0~14_combout\ : std_logic;
SIGNAL \TLC|Selector0~0_combout\ : std_logic;
SIGNAL \TLC|state.MGW~q\ : std_logic;
SIGNAL \TLC|WideOr11~combout\ : std_logic;
SIGNAL \TLC|WideOr12~combout\ : std_logic;
SIGNAL \TT|Add0~1\ : std_logic;
SIGNAL \TT|Add0~2_combout\ : std_logic;
SIGNAL \TT|Add0~3\ : std_logic;
SIGNAL \TT|Add0~5\ : std_logic;
SIGNAL \TT|Add0~6_combout\ : std_logic;
SIGNAL \TT|Add0~7\ : std_logic;
SIGNAL \TT|Add0~9\ : std_logic;
SIGNAL \TT|Add0~11\ : std_logic;
SIGNAL \TT|Add0~12_combout\ : std_logic;
SIGNAL \TT|Add0~13\ : std_logic;
SIGNAL \TT|Add0~14_combout\ : std_logic;
SIGNAL \TT|Add0~15\ : std_logic;
SIGNAL \TT|Add0~16_combout\ : std_logic;
SIGNAL \TT|Add0~17\ : std_logic;
SIGNAL \TT|Add0~18_combout\ : std_logic;
SIGNAL \TT|Add0~19\ : std_logic;
SIGNAL \TT|Add0~21\ : std_logic;
SIGNAL \TT|Add0~22_combout\ : std_logic;
SIGNAL \TT|Add0~23\ : std_logic;
SIGNAL \TT|Add0~25\ : std_logic;
SIGNAL \TT|Add0~26_combout\ : std_logic;
SIGNAL \TT|Add0~27\ : std_logic;
SIGNAL \TT|Add0~29\ : std_logic;
SIGNAL \TT|Add0~30_combout\ : std_logic;
SIGNAL \TT|Add0~31\ : std_logic;
SIGNAL \TT|Add0~32_combout\ : std_logic;
SIGNAL \TT|Add0~33\ : std_logic;
SIGNAL \TT|Add0~34_combout\ : std_logic;
SIGNAL \TT|Add0~35\ : std_logic;
SIGNAL \TT|Add0~37\ : std_logic;
SIGNAL \TT|Add0~38_combout\ : std_logic;
SIGNAL \TT|Add0~39\ : std_logic;
SIGNAL \TT|Add0~40_combout\ : std_logic;
SIGNAL \TT|Add0~41\ : std_logic;
SIGNAL \TT|Add0~43\ : std_logic;
SIGNAL \TT|Add0~44_combout\ : std_logic;
SIGNAL \TT|Add0~45\ : std_logic;
SIGNAL \TT|Add0~46_combout\ : std_logic;
SIGNAL \TT|Add0~47\ : std_logic;
SIGNAL \TT|Add0~48_combout\ : std_logic;
SIGNAL \TT|Add0~49\ : std_logic;
SIGNAL \TT|Add0~50_combout\ : std_logic;
SIGNAL \TT|Add0~51\ : std_logic;
SIGNAL \TT|Add0~53\ : std_logic;
SIGNAL \TT|Add0~54_combout\ : std_logic;
SIGNAL \TT|Add0~55\ : std_logic;
SIGNAL \TT|Add0~57\ : std_logic;
SIGNAL \TT|Add0~58_combout\ : std_logic;
SIGNAL \TT|Add0~59\ : std_logic;
SIGNAL \TT|Add0~60_combout\ : std_logic;
SIGNAL \TT|Add0~36_combout\ : std_logic;
SIGNAL \TT|LessThan0~3_combout\ : std_logic;
SIGNAL \TT|Add0~42_combout\ : std_logic;
SIGNAL \TT|LessThan0~4_combout\ : std_logic;
SIGNAL \TT|LessThan0~0_combout\ : std_logic;
SIGNAL \TT|Add0~52_combout\ : std_logic;
SIGNAL \TT|LessThan0~1_combout\ : std_logic;
SIGNAL \TT|LessThan0~2_combout\ : std_logic;
SIGNAL \TT|Add0~28_combout\ : std_logic;
SIGNAL \TT|Add0~24_combout\ : std_logic;
SIGNAL \TT|LessThan0~7_combout\ : std_logic;
SIGNAL \TT|current_count[0]~0_combout\ : std_logic;
SIGNAL \TT|LessThan0~5_combout\ : std_logic;
SIGNAL \TT|Add0~8_combout\ : std_logic;
SIGNAL \TT|LessThan0~6_combout\ : std_logic;
SIGNAL \TT|LessThan0~8_combout\ : std_logic;
SIGNAL \TT|LessThan0~12_combout\ : std_logic;
SIGNAL \TLC|state~20_combout\ : std_logic;
SIGNAL \TLC|state.MA~q\ : std_logic;
SIGNAL \TLC|Selector2~0_combout\ : std_logic;
SIGNAL \TLC|state.MAW~q\ : std_logic;
SIGNAL \TLC|WideOr8~0_combout\ : std_logic;
SIGNAL \TLC|WideOr7~combout\ : std_logic;
SIGNAL \TLDM|Equal1~1_combout\ : std_logic;
SIGNAL \T5|Add0~53\ : std_logic;
SIGNAL \T5|Add0~54_combout\ : std_logic;
SIGNAL \T5|Add0~55\ : std_logic;
SIGNAL \T5|Add0~57\ : std_logic;
SIGNAL \T5|Add0~58_combout\ : std_logic;
SIGNAL \T5|Add0~59\ : std_logic;
SIGNAL \T5|Add0~60_combout\ : std_logic;
SIGNAL \TLC|state~18_combout\ : std_logic;
SIGNAL \TLC|state.MGF~q\ : std_logic;
SIGNAL \TLDM|comb~8_combout\ : std_logic;
SIGNAL \TLDM|TT1|current_count[0]~0_combout\ : std_logic;
SIGNAL \TLC|WideOr11~0_combout\ : std_logic;
SIGNAL \TLDM|red_light~0_combout\ : std_logic;
SIGNAL \TLDM|green_light~4_combout\ : std_logic;
SIGNAL \TLDM|tt2_reset~0_combout\ : std_logic;
SIGNAL \TLDM|tt2_reset~0clkctrl_outclk\ : std_logic;
SIGNAL \TLDM|tt1_reset~combout\ : std_logic;
SIGNAL \TLDM|tt1_enable~combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~1\ : std_logic;
SIGNAL \TLDM|TT1|Add0~2_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~3\ : std_logic;
SIGNAL \TLDM|TT1|Add0~5\ : std_logic;
SIGNAL \TLDM|TT1|Add0~6_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~7\ : std_logic;
SIGNAL \TLDM|TT1|Add0~9\ : std_logic;
SIGNAL \TLDM|TT1|Add0~11\ : std_logic;
SIGNAL \TLDM|TT1|Add0~12_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~13\ : std_logic;
SIGNAL \TLDM|TT1|Add0~14_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~15\ : std_logic;
SIGNAL \TLDM|TT1|Add0~16_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~17\ : std_logic;
SIGNAL \TLDM|TT1|Add0~18_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~19\ : std_logic;
SIGNAL \TLDM|TT1|Add0~21\ : std_logic;
SIGNAL \TLDM|TT1|Add0~22_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~23\ : std_logic;
SIGNAL \TLDM|TT1|Add0~25\ : std_logic;
SIGNAL \TLDM|TT1|Add0~26_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~27\ : std_logic;
SIGNAL \TLDM|TT1|Add0~28_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~29\ : std_logic;
SIGNAL \TLDM|TT1|Add0~30_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~31\ : std_logic;
SIGNAL \TLDM|TT1|Add0~32_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~33\ : std_logic;
SIGNAL \TLDM|TT1|Add0~34_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~35\ : std_logic;
SIGNAL \TLDM|TT1|Add0~36_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~37\ : std_logic;
SIGNAL \TLDM|TT1|Add0~38_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~39\ : std_logic;
SIGNAL \TLDM|TT1|Add0~41\ : std_logic;
SIGNAL \TLDM|TT1|Add0~43\ : std_logic;
SIGNAL \TLDM|TT1|Add0~44_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~45\ : std_logic;
SIGNAL \TLDM|TT1|Add0~46_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~47\ : std_logic;
SIGNAL \TLDM|TT1|Add0~48_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~49\ : std_logic;
SIGNAL \TLDM|TT1|Add0~50_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~51\ : std_logic;
SIGNAL \TLDM|TT1|Add0~53\ : std_logic;
SIGNAL \TLDM|TT1|Add0~54_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~55\ : std_logic;
SIGNAL \TLDM|TT1|Add0~57\ : std_logic;
SIGNAL \TLDM|TT1|Add0~58_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~59\ : std_logic;
SIGNAL \TLDM|TT1|Add0~60_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~3_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~42_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~4_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~0_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~52_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~1_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~2_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~7_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~10_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~0_combout\ : std_logic;
SIGNAL \TLDM|TT1|Add0~4_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~5_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~6_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~8_combout\ : std_logic;
SIGNAL \TLDM|TT1|LessThan0~12_combout\ : std_logic;
SIGNAL \TLDM|green_light~5_combout\ : std_logic;
SIGNAL \TLDM|green_light~combout\ : std_logic;
SIGNAL \TLDM|Equal1~0_combout\ : std_logic;
SIGNAL \TLDF|Equal1~1_combout\ : std_logic;
SIGNAL \TLDF|Equal1~2_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~0_combout\ : std_logic;
SIGNAL \TLDF|TT2|current_count[0]~0_combout\ : std_logic;
SIGNAL \TLDF|tt1_enable~combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~1\ : std_logic;
SIGNAL \TLDF|TT2|Add0~2_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~3\ : std_logic;
SIGNAL \TLDF|TT2|Add0~5\ : std_logic;
SIGNAL \TLDF|TT2|Add0~6_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~7\ : std_logic;
SIGNAL \TLDF|TT2|Add0~9\ : std_logic;
SIGNAL \TLDF|TT2|Add0~11\ : std_logic;
SIGNAL \TLDF|TT2|Add0~12_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~13\ : std_logic;
SIGNAL \TLDF|TT2|Add0~14_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~15\ : std_logic;
SIGNAL \TLDF|TT2|Add0~16_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~17\ : std_logic;
SIGNAL \TLDF|TT2|Add0~18_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~19\ : std_logic;
SIGNAL \TLDF|TT2|Add0~20_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~7_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~21\ : std_logic;
SIGNAL \TLDF|TT2|Add0~22_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~23\ : std_logic;
SIGNAL \TLDF|TT2|Add0~25\ : std_logic;
SIGNAL \TLDF|TT2|Add0~26_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~27\ : std_logic;
SIGNAL \TLDF|TT2|Add0~28_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~4_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~29\ : std_logic;
SIGNAL \TLDF|TT2|Add0~30_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~31\ : std_logic;
SIGNAL \TLDF|TT2|Add0~32_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~6_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~8_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~33\ : std_logic;
SIGNAL \TLDF|TT2|Add0~34_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~35\ : std_logic;
SIGNAL \TLDF|TT2|Add0~37\ : std_logic;
SIGNAL \TLDF|TT2|Add0~38_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~39\ : std_logic;
SIGNAL \TLDF|TT2|Add0~41\ : std_logic;
SIGNAL \TLDF|TT2|Add0~43\ : std_logic;
SIGNAL \TLDF|TT2|Add0~44_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~42_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~40_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~1_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~4_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~0_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~2_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~8_combout\ : std_logic;
SIGNAL \TLDF|TT2|Add0~10_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~3_combout\ : std_logic;
SIGNAL \TLDF|TT2|LessThan0~5_combout\ : std_logic;
SIGNAL \TLDF|green_light~3_combout\ : std_logic;
SIGNAL \TLC|WideOr9~0_combout\ : std_logic;
SIGNAL \TLDF|green_light~4_combout\ : std_logic;
SIGNAL \TLDF|tt2_reset~0_combout\ : std_logic;
SIGNAL \TLDF|tt2_reset~0clkctrl_outclk\ : std_logic;
SIGNAL \TLDF|tt1_reset~combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~1\ : std_logic;
SIGNAL \TLDF|TT1|Add0~2_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~3\ : std_logic;
SIGNAL \TLDF|TT1|Add0~5\ : std_logic;
SIGNAL \TLDF|TT1|Add0~6_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~7\ : std_logic;
SIGNAL \TLDF|TT1|Add0~9\ : std_logic;
SIGNAL \TLDF|TT1|Add0~11\ : std_logic;
SIGNAL \TLDF|TT1|Add0~12_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~13\ : std_logic;
SIGNAL \TLDF|TT1|Add0~14_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~15\ : std_logic;
SIGNAL \TLDF|TT1|Add0~16_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~17\ : std_logic;
SIGNAL \TLDF|TT1|Add0~18_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~19\ : std_logic;
SIGNAL \TLDF|TT1|Add0~21\ : std_logic;
SIGNAL \TLDF|TT1|Add0~22_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~23\ : std_logic;
SIGNAL \TLDF|TT1|Add0~25\ : std_logic;
SIGNAL \TLDF|TT1|Add0~26_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~27\ : std_logic;
SIGNAL \TLDF|TT1|Add0~29\ : std_logic;
SIGNAL \TLDF|TT1|Add0~30_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~31\ : std_logic;
SIGNAL \TLDF|TT1|Add0~32_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~33\ : std_logic;
SIGNAL \TLDF|TT1|Add0~34_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~35\ : std_logic;
SIGNAL \TLDF|TT1|Add0~37\ : std_logic;
SIGNAL \TLDF|TT1|Add0~38_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~39\ : std_logic;
SIGNAL \TLDF|TT1|Add0~41\ : std_logic;
SIGNAL \TLDF|TT1|Add0~43\ : std_logic;
SIGNAL \TLDF|TT1|Add0~44_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~40_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~36_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~45\ : std_logic;
SIGNAL \TLDF|TT1|Add0~46_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~47\ : std_logic;
SIGNAL \TLDF|TT1|Add0~48_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~3_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~4_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~49\ : std_logic;
SIGNAL \TLDF|TT1|Add0~50_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~51\ : std_logic;
SIGNAL \TLDF|TT1|Add0~53\ : std_logic;
SIGNAL \TLDF|TT1|Add0~54_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~55\ : std_logic;
SIGNAL \TLDF|TT1|Add0~57\ : std_logic;
SIGNAL \TLDF|TT1|Add0~58_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~52_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~56_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~1_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~0_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~2_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~24_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~7_combout\ : std_logic;
SIGNAL \TLDF|TT1|current_count[0]~0_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~5_combout\ : std_logic;
SIGNAL \TLDF|TT1|Add0~8_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~6_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~8_combout\ : std_logic;
SIGNAL \TLDF|TT1|LessThan0~12_combout\ : std_logic;
SIGNAL \TLDF|green_light~5_combout\ : std_logic;
SIGNAL \TLDF|comb~0_combout\ : std_logic;
SIGNAL \TLDF|green_light~combout\ : std_logic;
SIGNAL \TLDF|Equal1~0_combout\ : std_logic;
SIGNAL \TLDF|red_light~0_combout\ : std_logic;
SIGNAL \TT|current_count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \TLDF|TT2|current_count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \TLDF|TT1|current_count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \TLDM|TT2|current_count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \TLDM|TT1|current_count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \T5|current_count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \T3|current_count\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \TLC|ALT_INV_state.MG~q\ : std_logic;
SIGNAL \TLDM|ALT_INV_red_light~0_combout\ : std_logic;
SIGNAL \TLC|ALT_INV_state.FG~q\ : std_logic;
SIGNAL \TLDF|ALT_INV_red_light~0_combout\ : std_logic;
SIGNAL \TLC|ALT_INV_WideOr11~combout\ : std_logic;
SIGNAL \TLDM|ALT_INV_tt1_reset~combout\ : std_logic;
SIGNAL \TLDM|ALT_INV_tt1_enable~combout\ : std_logic;
SIGNAL \TLDF|ALT_INV_tt1_reset~combout\ : std_logic;
SIGNAL \TLDF|ALT_INV_tt1_enable~combout\ : std_logic;

BEGIN

major_lights <= ww_major_lights;
minor_lights <= ww_minor_lights;
ww_major_sensor <= major_sensor;
ww_minor_sensor <= minor_sensor;
ww_clk <= clk;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\TLDM|tt2_reset~0clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \TLDM|tt2_reset~0_combout\);

\TLDF|tt2_reset~0clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \TLDF|tt2_reset~0_combout\);

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
\TLC|ALT_INV_state.MG~q\ <= NOT \TLC|state.MG~q\;
\TLDM|ALT_INV_red_light~0_combout\ <= NOT \TLDM|red_light~0_combout\;
\TLC|ALT_INV_state.FG~q\ <= NOT \TLC|state.FG~q\;
\TLDF|ALT_INV_red_light~0_combout\ <= NOT \TLDF|red_light~0_combout\;
\TLC|ALT_INV_WideOr11~combout\ <= NOT \TLC|WideOr11~combout\;
\TLDM|ALT_INV_tt1_reset~combout\ <= NOT \TLDM|tt1_reset~combout\;
\TLDM|ALT_INV_tt1_enable~combout\ <= NOT \TLDM|tt1_enable~combout\;
\TLDF|ALT_INV_tt1_reset~combout\ <= NOT \TLDF|tt1_reset~combout\;
\TLDF|ALT_INV_tt1_enable~combout\ <= NOT \TLDF|tt1_enable~combout\;

-- Location: LCCOMB_X23_Y14_N10
\TLDM|TT1|Add0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~8_combout\ = (\TLDM|TT1|current_count\(5) & (\TLDM|TT1|Add0~7\ $ (GND))) # (!\TLDM|TT1|current_count\(5) & (!\TLDM|TT1|Add0~7\ & VCC))
-- \TLDM|TT1|Add0~9\ = CARRY((\TLDM|TT1|current_count\(5) & !\TLDM|TT1|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(5),
	datad => VCC,
	cin => \TLDM|TT1|Add0~7\,
	combout => \TLDM|TT1|Add0~8_combout\,
	cout => \TLDM|TT1|Add0~9\);

-- Location: LCCOMB_X23_Y14_N22
\TLDM|TT1|Add0~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~20_combout\ = (\TLDM|TT1|current_count\(11) & (\TLDM|TT1|Add0~19\ $ (GND))) # (!\TLDM|TT1|current_count\(11) & (!\TLDM|TT1|Add0~19\ & VCC))
-- \TLDM|TT1|Add0~21\ = CARRY((\TLDM|TT1|current_count\(11) & !\TLDM|TT1|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(11),
	datad => VCC,
	cin => \TLDM|TT1|Add0~19\,
	combout => \TLDM|TT1|Add0~20_combout\,
	cout => \TLDM|TT1|Add0~21\);

-- Location: LCCOMB_X23_Y14_N26
\TLDM|TT1|Add0~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~24_combout\ = (\TLDM|TT1|current_count\(13) & (\TLDM|TT1|Add0~23\ $ (GND))) # (!\TLDM|TT1|current_count\(13) & (!\TLDM|TT1|Add0~23\ & VCC))
-- \TLDM|TT1|Add0~25\ = CARRY((\TLDM|TT1|current_count\(13) & !\TLDM|TT1|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(13),
	datad => VCC,
	cin => \TLDM|TT1|Add0~23\,
	combout => \TLDM|TT1|Add0~24_combout\,
	cout => \TLDM|TT1|Add0~25\);

-- Location: LCCOMB_X23_Y13_N10
\TLDM|TT1|Add0~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~40_combout\ = (\TLDM|TT1|current_count\(21) & (\TLDM|TT1|Add0~39\ $ (GND))) # (!\TLDM|TT1|current_count\(21) & (!\TLDM|TT1|Add0~39\ & VCC))
-- \TLDM|TT1|Add0~41\ = CARRY((\TLDM|TT1|current_count\(21) & !\TLDM|TT1|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(21),
	datad => VCC,
	cin => \TLDM|TT1|Add0~39\,
	combout => \TLDM|TT1|Add0~40_combout\,
	cout => \TLDM|TT1|Add0~41\);

-- Location: LCCOMB_X23_Y13_N26
\TLDM|TT1|Add0~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~56_combout\ = (\TLDM|TT1|current_count\(29) & (\TLDM|TT1|Add0~55\ $ (GND))) # (!\TLDM|TT1|current_count\(29) & (!\TLDM|TT1|Add0~55\ & VCC))
-- \TLDM|TT1|Add0~57\ = CARRY((\TLDM|TT1|current_count\(29) & !\TLDM|TT1|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(29),
	datad => VCC,
	cin => \TLDM|TT1|Add0~55\,
	combout => \TLDM|TT1|Add0~56_combout\,
	cout => \TLDM|TT1|Add0~57\);

-- Location: LCCOMB_X37_Y13_N2
\TLDM|TT2|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~0_combout\ = (\TLDM|TT2|current_count\(0) & (\TLDM|TT2|current_count\(1) $ (VCC))) # (!\TLDM|TT2|current_count\(0) & (\TLDM|TT2|current_count\(1) & VCC))
-- \TLDM|TT2|Add0~1\ = CARRY((\TLDM|TT2|current_count\(0) & \TLDM|TT2|current_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(0),
	datab => \TLDM|TT2|current_count\(1),
	datad => VCC,
	combout => \TLDM|TT2|Add0~0_combout\,
	cout => \TLDM|TT2|Add0~1\);

-- Location: LCCOMB_X37_Y13_N4
\TLDM|TT2|Add0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~2_combout\ = (\TLDM|TT2|current_count\(2) & (!\TLDM|TT2|Add0~1\)) # (!\TLDM|TT2|current_count\(2) & ((\TLDM|TT2|Add0~1\) # (GND)))
-- \TLDM|TT2|Add0~3\ = CARRY((!\TLDM|TT2|Add0~1\) # (!\TLDM|TT2|current_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(2),
	datad => VCC,
	cin => \TLDM|TT2|Add0~1\,
	combout => \TLDM|TT2|Add0~2_combout\,
	cout => \TLDM|TT2|Add0~3\);

-- Location: LCCOMB_X37_Y13_N6
\TLDM|TT2|Add0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~4_combout\ = (\TLDM|TT2|current_count\(3) & (\TLDM|TT2|Add0~3\ $ (GND))) # (!\TLDM|TT2|current_count\(3) & (!\TLDM|TT2|Add0~3\ & VCC))
-- \TLDM|TT2|Add0~5\ = CARRY((\TLDM|TT2|current_count\(3) & !\TLDM|TT2|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(3),
	datad => VCC,
	cin => \TLDM|TT2|Add0~3\,
	combout => \TLDM|TT2|Add0~4_combout\,
	cout => \TLDM|TT2|Add0~5\);

-- Location: LCCOMB_X37_Y13_N8
\TLDM|TT2|Add0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~6_combout\ = (\TLDM|TT2|current_count\(4) & (!\TLDM|TT2|Add0~5\)) # (!\TLDM|TT2|current_count\(4) & ((\TLDM|TT2|Add0~5\) # (GND)))
-- \TLDM|TT2|Add0~7\ = CARRY((!\TLDM|TT2|Add0~5\) # (!\TLDM|TT2|current_count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(4),
	datad => VCC,
	cin => \TLDM|TT2|Add0~5\,
	combout => \TLDM|TT2|Add0~6_combout\,
	cout => \TLDM|TT2|Add0~7\);

-- Location: LCCOMB_X37_Y13_N10
\TLDM|TT2|Add0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~8_combout\ = (\TLDM|TT2|current_count\(5) & (\TLDM|TT2|Add0~7\ $ (GND))) # (!\TLDM|TT2|current_count\(5) & (!\TLDM|TT2|Add0~7\ & VCC))
-- \TLDM|TT2|Add0~9\ = CARRY((\TLDM|TT2|current_count\(5) & !\TLDM|TT2|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(5),
	datad => VCC,
	cin => \TLDM|TT2|Add0~7\,
	combout => \TLDM|TT2|Add0~8_combout\,
	cout => \TLDM|TT2|Add0~9\);

-- Location: LCCOMB_X37_Y13_N12
\TLDM|TT2|Add0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~10_combout\ = (\TLDM|TT2|current_count\(6) & (!\TLDM|TT2|Add0~9\)) # (!\TLDM|TT2|current_count\(6) & ((\TLDM|TT2|Add0~9\) # (GND)))
-- \TLDM|TT2|Add0~11\ = CARRY((!\TLDM|TT2|Add0~9\) # (!\TLDM|TT2|current_count\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(6),
	datad => VCC,
	cin => \TLDM|TT2|Add0~9\,
	combout => \TLDM|TT2|Add0~10_combout\,
	cout => \TLDM|TT2|Add0~11\);

-- Location: LCCOMB_X37_Y13_N14
\TLDM|TT2|Add0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~12_combout\ = (\TLDM|TT2|current_count\(7) & (\TLDM|TT2|Add0~11\ $ (GND))) # (!\TLDM|TT2|current_count\(7) & (!\TLDM|TT2|Add0~11\ & VCC))
-- \TLDM|TT2|Add0~13\ = CARRY((\TLDM|TT2|current_count\(7) & !\TLDM|TT2|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(7),
	datad => VCC,
	cin => \TLDM|TT2|Add0~11\,
	combout => \TLDM|TT2|Add0~12_combout\,
	cout => \TLDM|TT2|Add0~13\);

-- Location: LCCOMB_X37_Y13_N16
\TLDM|TT2|Add0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~14_combout\ = (\TLDM|TT2|current_count\(8) & (!\TLDM|TT2|Add0~13\)) # (!\TLDM|TT2|current_count\(8) & ((\TLDM|TT2|Add0~13\) # (GND)))
-- \TLDM|TT2|Add0~15\ = CARRY((!\TLDM|TT2|Add0~13\) # (!\TLDM|TT2|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(8),
	datad => VCC,
	cin => \TLDM|TT2|Add0~13\,
	combout => \TLDM|TT2|Add0~14_combout\,
	cout => \TLDM|TT2|Add0~15\);

-- Location: LCCOMB_X37_Y13_N18
\TLDM|TT2|Add0~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~16_combout\ = (\TLDM|TT2|current_count\(9) & (\TLDM|TT2|Add0~15\ $ (GND))) # (!\TLDM|TT2|current_count\(9) & (!\TLDM|TT2|Add0~15\ & VCC))
-- \TLDM|TT2|Add0~17\ = CARRY((\TLDM|TT2|current_count\(9) & !\TLDM|TT2|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(9),
	datad => VCC,
	cin => \TLDM|TT2|Add0~15\,
	combout => \TLDM|TT2|Add0~16_combout\,
	cout => \TLDM|TT2|Add0~17\);

-- Location: LCCOMB_X37_Y13_N20
\TLDM|TT2|Add0~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~18_combout\ = (\TLDM|TT2|current_count\(10) & (!\TLDM|TT2|Add0~17\)) # (!\TLDM|TT2|current_count\(10) & ((\TLDM|TT2|Add0~17\) # (GND)))
-- \TLDM|TT2|Add0~19\ = CARRY((!\TLDM|TT2|Add0~17\) # (!\TLDM|TT2|current_count\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(10),
	datad => VCC,
	cin => \TLDM|TT2|Add0~17\,
	combout => \TLDM|TT2|Add0~18_combout\,
	cout => \TLDM|TT2|Add0~19\);

-- Location: LCCOMB_X37_Y13_N22
\TLDM|TT2|Add0~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~20_combout\ = (\TLDM|TT2|current_count\(11) & (\TLDM|TT2|Add0~19\ $ (GND))) # (!\TLDM|TT2|current_count\(11) & (!\TLDM|TT2|Add0~19\ & VCC))
-- \TLDM|TT2|Add0~21\ = CARRY((\TLDM|TT2|current_count\(11) & !\TLDM|TT2|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(11),
	datad => VCC,
	cin => \TLDM|TT2|Add0~19\,
	combout => \TLDM|TT2|Add0~20_combout\,
	cout => \TLDM|TT2|Add0~21\);

-- Location: LCCOMB_X37_Y13_N24
\TLDM|TT2|Add0~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~22_combout\ = (\TLDM|TT2|current_count\(12) & (!\TLDM|TT2|Add0~21\)) # (!\TLDM|TT2|current_count\(12) & ((\TLDM|TT2|Add0~21\) # (GND)))
-- \TLDM|TT2|Add0~23\ = CARRY((!\TLDM|TT2|Add0~21\) # (!\TLDM|TT2|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(12),
	datad => VCC,
	cin => \TLDM|TT2|Add0~21\,
	combout => \TLDM|TT2|Add0~22_combout\,
	cout => \TLDM|TT2|Add0~23\);

-- Location: LCCOMB_X37_Y13_N26
\TLDM|TT2|Add0~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~24_combout\ = (\TLDM|TT2|current_count\(13) & (\TLDM|TT2|Add0~23\ $ (GND))) # (!\TLDM|TT2|current_count\(13) & (!\TLDM|TT2|Add0~23\ & VCC))
-- \TLDM|TT2|Add0~25\ = CARRY((\TLDM|TT2|current_count\(13) & !\TLDM|TT2|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(13),
	datad => VCC,
	cin => \TLDM|TT2|Add0~23\,
	combout => \TLDM|TT2|Add0~24_combout\,
	cout => \TLDM|TT2|Add0~25\);

-- Location: LCCOMB_X37_Y13_N28
\TLDM|TT2|Add0~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~26_combout\ = (\TLDM|TT2|current_count\(14) & (!\TLDM|TT2|Add0~25\)) # (!\TLDM|TT2|current_count\(14) & ((\TLDM|TT2|Add0~25\) # (GND)))
-- \TLDM|TT2|Add0~27\ = CARRY((!\TLDM|TT2|Add0~25\) # (!\TLDM|TT2|current_count\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(14),
	datad => VCC,
	cin => \TLDM|TT2|Add0~25\,
	combout => \TLDM|TT2|Add0~26_combout\,
	cout => \TLDM|TT2|Add0~27\);

-- Location: LCCOMB_X37_Y13_N30
\TLDM|TT2|Add0~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~28_combout\ = (\TLDM|TT2|current_count\(15) & (\TLDM|TT2|Add0~27\ $ (GND))) # (!\TLDM|TT2|current_count\(15) & (!\TLDM|TT2|Add0~27\ & VCC))
-- \TLDM|TT2|Add0~29\ = CARRY((\TLDM|TT2|current_count\(15) & !\TLDM|TT2|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(15),
	datad => VCC,
	cin => \TLDM|TT2|Add0~27\,
	combout => \TLDM|TT2|Add0~28_combout\,
	cout => \TLDM|TT2|Add0~29\);

-- Location: LCCOMB_X37_Y12_N0
\TLDM|TT2|Add0~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~30_combout\ = (\TLDM|TT2|current_count\(16) & (!\TLDM|TT2|Add0~29\)) # (!\TLDM|TT2|current_count\(16) & ((\TLDM|TT2|Add0~29\) # (GND)))
-- \TLDM|TT2|Add0~31\ = CARRY((!\TLDM|TT2|Add0~29\) # (!\TLDM|TT2|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(16),
	datad => VCC,
	cin => \TLDM|TT2|Add0~29\,
	combout => \TLDM|TT2|Add0~30_combout\,
	cout => \TLDM|TT2|Add0~31\);

-- Location: LCCOMB_X37_Y12_N2
\TLDM|TT2|Add0~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~32_combout\ = (\TLDM|TT2|current_count\(17) & (\TLDM|TT2|Add0~31\ $ (GND))) # (!\TLDM|TT2|current_count\(17) & (!\TLDM|TT2|Add0~31\ & VCC))
-- \TLDM|TT2|Add0~33\ = CARRY((\TLDM|TT2|current_count\(17) & !\TLDM|TT2|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(17),
	datad => VCC,
	cin => \TLDM|TT2|Add0~31\,
	combout => \TLDM|TT2|Add0~32_combout\,
	cout => \TLDM|TT2|Add0~33\);

-- Location: LCCOMB_X37_Y12_N4
\TLDM|TT2|Add0~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~34_combout\ = (\TLDM|TT2|current_count\(18) & (!\TLDM|TT2|Add0~33\)) # (!\TLDM|TT2|current_count\(18) & ((\TLDM|TT2|Add0~33\) # (GND)))
-- \TLDM|TT2|Add0~35\ = CARRY((!\TLDM|TT2|Add0~33\) # (!\TLDM|TT2|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(18),
	datad => VCC,
	cin => \TLDM|TT2|Add0~33\,
	combout => \TLDM|TT2|Add0~34_combout\,
	cout => \TLDM|TT2|Add0~35\);

-- Location: LCCOMB_X37_Y12_N6
\TLDM|TT2|Add0~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~36_combout\ = (\TLDM|TT2|current_count\(19) & (\TLDM|TT2|Add0~35\ $ (GND))) # (!\TLDM|TT2|current_count\(19) & (!\TLDM|TT2|Add0~35\ & VCC))
-- \TLDM|TT2|Add0~37\ = CARRY((\TLDM|TT2|current_count\(19) & !\TLDM|TT2|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(19),
	datad => VCC,
	cin => \TLDM|TT2|Add0~35\,
	combout => \TLDM|TT2|Add0~36_combout\,
	cout => \TLDM|TT2|Add0~37\);

-- Location: LCCOMB_X37_Y12_N8
\TLDM|TT2|Add0~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~38_combout\ = (\TLDM|TT2|current_count\(20) & (!\TLDM|TT2|Add0~37\)) # (!\TLDM|TT2|current_count\(20) & ((\TLDM|TT2|Add0~37\) # (GND)))
-- \TLDM|TT2|Add0~39\ = CARRY((!\TLDM|TT2|Add0~37\) # (!\TLDM|TT2|current_count\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(20),
	datad => VCC,
	cin => \TLDM|TT2|Add0~37\,
	combout => \TLDM|TT2|Add0~38_combout\,
	cout => \TLDM|TT2|Add0~39\);

-- Location: LCCOMB_X37_Y12_N10
\TLDM|TT2|Add0~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~40_combout\ = (\TLDM|TT2|current_count\(21) & (\TLDM|TT2|Add0~39\ $ (GND))) # (!\TLDM|TT2|current_count\(21) & (!\TLDM|TT2|Add0~39\ & VCC))
-- \TLDM|TT2|Add0~41\ = CARRY((\TLDM|TT2|current_count\(21) & !\TLDM|TT2|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(21),
	datad => VCC,
	cin => \TLDM|TT2|Add0~39\,
	combout => \TLDM|TT2|Add0~40_combout\,
	cout => \TLDM|TT2|Add0~41\);

-- Location: LCCOMB_X37_Y12_N12
\TLDM|TT2|Add0~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~42_combout\ = (\TLDM|TT2|current_count\(22) & (!\TLDM|TT2|Add0~41\)) # (!\TLDM|TT2|current_count\(22) & ((\TLDM|TT2|Add0~41\) # (GND)))
-- \TLDM|TT2|Add0~43\ = CARRY((!\TLDM|TT2|Add0~41\) # (!\TLDM|TT2|current_count\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(22),
	datad => VCC,
	cin => \TLDM|TT2|Add0~41\,
	combout => \TLDM|TT2|Add0~42_combout\,
	cout => \TLDM|TT2|Add0~43\);

-- Location: LCCOMB_X37_Y12_N14
\TLDM|TT2|Add0~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~44_combout\ = (\TLDM|TT2|current_count\(23) & (\TLDM|TT2|Add0~43\ $ (GND))) # (!\TLDM|TT2|current_count\(23) & (!\TLDM|TT2|Add0~43\ & VCC))
-- \TLDM|TT2|Add0~45\ = CARRY((\TLDM|TT2|current_count\(23) & !\TLDM|TT2|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(23),
	datad => VCC,
	cin => \TLDM|TT2|Add0~43\,
	combout => \TLDM|TT2|Add0~44_combout\,
	cout => \TLDM|TT2|Add0~45\);

-- Location: LCCOMB_X37_Y12_N16
\TLDM|TT2|Add0~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~46_combout\ = (\TLDM|TT2|current_count\(24) & (!\TLDM|TT2|Add0~45\)) # (!\TLDM|TT2|current_count\(24) & ((\TLDM|TT2|Add0~45\) # (GND)))
-- \TLDM|TT2|Add0~47\ = CARRY((!\TLDM|TT2|Add0~45\) # (!\TLDM|TT2|current_count\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(24),
	datad => VCC,
	cin => \TLDM|TT2|Add0~45\,
	combout => \TLDM|TT2|Add0~46_combout\,
	cout => \TLDM|TT2|Add0~47\);

-- Location: LCCOMB_X37_Y12_N18
\TLDM|TT2|Add0~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~48_combout\ = (\TLDM|TT2|current_count\(25) & (\TLDM|TT2|Add0~47\ $ (GND))) # (!\TLDM|TT2|current_count\(25) & (!\TLDM|TT2|Add0~47\ & VCC))
-- \TLDM|TT2|Add0~49\ = CARRY((\TLDM|TT2|current_count\(25) & !\TLDM|TT2|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(25),
	datad => VCC,
	cin => \TLDM|TT2|Add0~47\,
	combout => \TLDM|TT2|Add0~48_combout\,
	cout => \TLDM|TT2|Add0~49\);

-- Location: LCCOMB_X37_Y12_N20
\TLDM|TT2|Add0~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~50_combout\ = (\TLDM|TT2|current_count\(26) & (!\TLDM|TT2|Add0~49\)) # (!\TLDM|TT2|current_count\(26) & ((\TLDM|TT2|Add0~49\) # (GND)))
-- \TLDM|TT2|Add0~51\ = CARRY((!\TLDM|TT2|Add0~49\) # (!\TLDM|TT2|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(26),
	datad => VCC,
	cin => \TLDM|TT2|Add0~49\,
	combout => \TLDM|TT2|Add0~50_combout\,
	cout => \TLDM|TT2|Add0~51\);

-- Location: LCCOMB_X37_Y12_N22
\TLDM|TT2|Add0~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~52_combout\ = (\TLDM|TT2|current_count\(27) & (\TLDM|TT2|Add0~51\ $ (GND))) # (!\TLDM|TT2|current_count\(27) & (!\TLDM|TT2|Add0~51\ & VCC))
-- \TLDM|TT2|Add0~53\ = CARRY((\TLDM|TT2|current_count\(27) & !\TLDM|TT2|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(27),
	datad => VCC,
	cin => \TLDM|TT2|Add0~51\,
	combout => \TLDM|TT2|Add0~52_combout\,
	cout => \TLDM|TT2|Add0~53\);

-- Location: LCCOMB_X37_Y12_N24
\TLDM|TT2|Add0~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~54_combout\ = (\TLDM|TT2|current_count\(28) & (!\TLDM|TT2|Add0~53\)) # (!\TLDM|TT2|current_count\(28) & ((\TLDM|TT2|Add0~53\) # (GND)))
-- \TLDM|TT2|Add0~55\ = CARRY((!\TLDM|TT2|Add0~53\) # (!\TLDM|TT2|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(28),
	datad => VCC,
	cin => \TLDM|TT2|Add0~53\,
	combout => \TLDM|TT2|Add0~54_combout\,
	cout => \TLDM|TT2|Add0~55\);

-- Location: LCCOMB_X37_Y12_N26
\TLDM|TT2|Add0~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~56_combout\ = (\TLDM|TT2|current_count\(29) & (\TLDM|TT2|Add0~55\ $ (GND))) # (!\TLDM|TT2|current_count\(29) & (!\TLDM|TT2|Add0~55\ & VCC))
-- \TLDM|TT2|Add0~57\ = CARRY((\TLDM|TT2|current_count\(29) & !\TLDM|TT2|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(29),
	datad => VCC,
	cin => \TLDM|TT2|Add0~55\,
	combout => \TLDM|TT2|Add0~56_combout\,
	cout => \TLDM|TT2|Add0~57\);

-- Location: LCCOMB_X37_Y12_N28
\TLDM|TT2|Add0~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~58_combout\ = (\TLDM|TT2|current_count\(30) & (!\TLDM|TT2|Add0~57\)) # (!\TLDM|TT2|current_count\(30) & ((\TLDM|TT2|Add0~57\) # (GND)))
-- \TLDM|TT2|Add0~59\ = CARRY((!\TLDM|TT2|Add0~57\) # (!\TLDM|TT2|current_count\(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT2|current_count\(30),
	datad => VCC,
	cin => \TLDM|TT2|Add0~57\,
	combout => \TLDM|TT2|Add0~58_combout\,
	cout => \TLDM|TT2|Add0~59\);

-- Location: LCCOMB_X37_Y12_N30
\TLDM|TT2|Add0~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|Add0~60_combout\ = \TLDM|TT2|Add0~59\ $ (!\TLDM|TT2|current_count\(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \TLDM|TT2|current_count\(31),
	cin => \TLDM|TT2|Add0~59\,
	combout => \TLDM|TT2|Add0~60_combout\);

-- Location: LCCOMB_X23_Y21_N26
\T5|Add0~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~24_combout\ = (\T5|current_count\(13) & (\T5|Add0~23\ $ (GND))) # (!\T5|current_count\(13) & (!\T5|Add0~23\ & VCC))
-- \T5|Add0~25\ = CARRY((\T5|current_count\(13) & !\T5|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(13),
	datad => VCC,
	cin => \T5|Add0~23\,
	combout => \T5|Add0~24_combout\,
	cout => \T5|Add0~25\);

-- Location: LCCOMB_X23_Y20_N26
\T5|Add0~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~56_combout\ = (\T5|current_count\(29) & (\T5|Add0~55\ $ (GND))) # (!\T5|current_count\(29) & (!\T5|Add0~55\ & VCC))
-- \T5|Add0~57\ = CARRY((\T5|current_count\(29) & !\T5|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(29),
	datad => VCC,
	cin => \T5|Add0~55\,
	combout => \T5|Add0~56_combout\,
	cout => \T5|Add0~57\);

-- Location: LCCOMB_X21_Y18_N6
\TT|Add0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~4_combout\ = (\TT|current_count\(3) & (\TT|Add0~3\ $ (GND))) # (!\TT|current_count\(3) & (!\TT|Add0~3\ & VCC))
-- \TT|Add0~5\ = CARRY((\TT|current_count\(3) & !\TT|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(3),
	datad => VCC,
	cin => \TT|Add0~3\,
	combout => \TT|Add0~4_combout\,
	cout => \TT|Add0~5\);

-- Location: LCCOMB_X21_Y18_N12
\TT|Add0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~10_combout\ = (\TT|current_count\(6) & (!\TT|Add0~9\)) # (!\TT|current_count\(6) & ((\TT|Add0~9\) # (GND)))
-- \TT|Add0~11\ = CARRY((!\TT|Add0~9\) # (!\TT|current_count\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(6),
	datad => VCC,
	cin => \TT|Add0~9\,
	combout => \TT|Add0~10_combout\,
	cout => \TT|Add0~11\);

-- Location: LCCOMB_X21_Y18_N22
\TT|Add0~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~20_combout\ = (\TT|current_count\(11) & (\TT|Add0~19\ $ (GND))) # (!\TT|current_count\(11) & (!\TT|Add0~19\ & VCC))
-- \TT|Add0~21\ = CARRY((\TT|current_count\(11) & !\TT|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(11),
	datad => VCC,
	cin => \TT|Add0~19\,
	combout => \TT|Add0~20_combout\,
	cout => \TT|Add0~21\);

-- Location: LCCOMB_X21_Y17_N26
\TT|Add0~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~56_combout\ = (\TT|current_count\(29) & (\TT|Add0~55\ $ (GND))) # (!\TT|current_count\(29) & (!\TT|Add0~55\ & VCC))
-- \TT|Add0~57\ = CARRY((\TT|current_count\(29) & !\TT|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(29),
	datad => VCC,
	cin => \TT|Add0~55\,
	combout => \TT|Add0~56_combout\,
	cout => \TT|Add0~57\);

-- Location: LCCOMB_X32_Y16_N6
\TLDF|TT1|Add0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~4_combout\ = (\TLDF|TT1|current_count\(3) & (\TLDF|TT1|Add0~3\ $ (GND))) # (!\TLDF|TT1|current_count\(3) & (!\TLDF|TT1|Add0~3\ & VCC))
-- \TLDF|TT1|Add0~5\ = CARRY((\TLDF|TT1|current_count\(3) & !\TLDF|TT1|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(3),
	datad => VCC,
	cin => \TLDF|TT1|Add0~3\,
	combout => \TLDF|TT1|Add0~4_combout\,
	cout => \TLDF|TT1|Add0~5\);

-- Location: LCCOMB_X32_Y16_N12
\TLDF|TT1|Add0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~10_combout\ = (\TLDF|TT1|current_count\(6) & (!\TLDF|TT1|Add0~9\)) # (!\TLDF|TT1|current_count\(6) & ((\TLDF|TT1|Add0~9\) # (GND)))
-- \TLDF|TT1|Add0~11\ = CARRY((!\TLDF|TT1|Add0~9\) # (!\TLDF|TT1|current_count\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(6),
	datad => VCC,
	cin => \TLDF|TT1|Add0~9\,
	combout => \TLDF|TT1|Add0~10_combout\,
	cout => \TLDF|TT1|Add0~11\);

-- Location: LCCOMB_X32_Y16_N22
\TLDF|TT1|Add0~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~20_combout\ = (\TLDF|TT1|current_count\(11) & (\TLDF|TT1|Add0~19\ $ (GND))) # (!\TLDF|TT1|current_count\(11) & (!\TLDF|TT1|Add0~19\ & VCC))
-- \TLDF|TT1|Add0~21\ = CARRY((\TLDF|TT1|current_count\(11) & !\TLDF|TT1|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(11),
	datad => VCC,
	cin => \TLDF|TT1|Add0~19\,
	combout => \TLDF|TT1|Add0~20_combout\,
	cout => \TLDF|TT1|Add0~21\);

-- Location: LCCOMB_X32_Y16_N30
\TLDF|TT1|Add0~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~28_combout\ = (\TLDF|TT1|current_count\(15) & (\TLDF|TT1|Add0~27\ $ (GND))) # (!\TLDF|TT1|current_count\(15) & (!\TLDF|TT1|Add0~27\ & VCC))
-- \TLDF|TT1|Add0~29\ = CARRY((\TLDF|TT1|current_count\(15) & !\TLDF|TT1|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(15),
	datad => VCC,
	cin => \TLDF|TT1|Add0~27\,
	combout => \TLDF|TT1|Add0~28_combout\,
	cout => \TLDF|TT1|Add0~29\);

-- Location: LCCOMB_X32_Y15_N12
\TLDF|TT1|Add0~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~42_combout\ = (\TLDF|TT1|current_count\(22) & (!\TLDF|TT1|Add0~41\)) # (!\TLDF|TT1|current_count\(22) & ((\TLDF|TT1|Add0~41\) # (GND)))
-- \TLDF|TT1|Add0~43\ = CARRY((!\TLDF|TT1|Add0~41\) # (!\TLDF|TT1|current_count\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(22),
	datad => VCC,
	cin => \TLDF|TT1|Add0~41\,
	combout => \TLDF|TT1|Add0~42_combout\,
	cout => \TLDF|TT1|Add0~43\);

-- Location: LCCOMB_X32_Y15_N28
\TLDF|TT1|Add0~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~58_combout\ = (\TLDF|TT1|current_count\(30) & (!\TLDF|TT1|Add0~57\)) # (!\TLDF|TT1|current_count\(30) & ((\TLDF|TT1|Add0~57\) # (GND)))
-- \TLDF|TT1|Add0~59\ = CARRY((!\TLDF|TT1|Add0~57\) # (!\TLDF|TT1|current_count\(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(30),
	datad => VCC,
	cin => \TLDF|TT1|Add0~57\,
	combout => \TLDF|TT1|Add0~58_combout\,
	cout => \TLDF|TT1|Add0~59\);

-- Location: LCCOMB_X32_Y15_N30
\TLDF|TT1|Add0~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~60_combout\ = \TLDF|TT1|current_count\(31) $ (!\TLDF|TT1|Add0~59\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(31),
	cin => \TLDF|TT1|Add0~59\,
	combout => \TLDF|TT1|Add0~60_combout\);

-- Location: LCCOMB_X35_Y16_N26
\TLDF|TT2|Add0~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~24_combout\ = (\TLDF|TT2|current_count\(13) & (\TLDF|TT2|Add0~23\ $ (GND))) # (!\TLDF|TT2|current_count\(13) & (!\TLDF|TT2|Add0~23\ & VCC))
-- \TLDF|TT2|Add0~25\ = CARRY((\TLDF|TT2|current_count\(13) & !\TLDF|TT2|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(13),
	datad => VCC,
	cin => \TLDF|TT2|Add0~23\,
	combout => \TLDF|TT2|Add0~24_combout\,
	cout => \TLDF|TT2|Add0~25\);

-- Location: LCCOMB_X35_Y15_N6
\TLDF|TT2|Add0~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~36_combout\ = (\TLDF|TT2|current_count\(19) & (\TLDF|TT2|Add0~35\ $ (GND))) # (!\TLDF|TT2|current_count\(19) & (!\TLDF|TT2|Add0~35\ & VCC))
-- \TLDF|TT2|Add0~37\ = CARRY((\TLDF|TT2|current_count\(19) & !\TLDF|TT2|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(19),
	datad => VCC,
	cin => \TLDF|TT2|Add0~35\,
	combout => \TLDF|TT2|Add0~36_combout\,
	cout => \TLDF|TT2|Add0~37\);

-- Location: LCCOMB_X35_Y15_N14
\TLDF|TT2|Add0~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~44_combout\ = (\TLDF|TT2|current_count\(23) & (\TLDF|TT2|Add0~43\ $ (GND))) # (!\TLDF|TT2|current_count\(23) & (!\TLDF|TT2|Add0~43\ & VCC))
-- \TLDF|TT2|Add0~45\ = CARRY((\TLDF|TT2|current_count\(23) & !\TLDF|TT2|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(23),
	datad => VCC,
	cin => \TLDF|TT2|Add0~43\,
	combout => \TLDF|TT2|Add0~44_combout\,
	cout => \TLDF|TT2|Add0~45\);

-- Location: LCCOMB_X35_Y15_N16
\TLDF|TT2|Add0~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~46_combout\ = (\TLDF|TT2|current_count\(24) & (!\TLDF|TT2|Add0~45\)) # (!\TLDF|TT2|current_count\(24) & ((\TLDF|TT2|Add0~45\) # (GND)))
-- \TLDF|TT2|Add0~47\ = CARRY((!\TLDF|TT2|Add0~45\) # (!\TLDF|TT2|current_count\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(24),
	datad => VCC,
	cin => \TLDF|TT2|Add0~45\,
	combout => \TLDF|TT2|Add0~46_combout\,
	cout => \TLDF|TT2|Add0~47\);

-- Location: LCCOMB_X35_Y15_N18
\TLDF|TT2|Add0~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~48_combout\ = (\TLDF|TT2|current_count\(25) & (\TLDF|TT2|Add0~47\ $ (GND))) # (!\TLDF|TT2|current_count\(25) & (!\TLDF|TT2|Add0~47\ & VCC))
-- \TLDF|TT2|Add0~49\ = CARRY((\TLDF|TT2|current_count\(25) & !\TLDF|TT2|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(25),
	datad => VCC,
	cin => \TLDF|TT2|Add0~47\,
	combout => \TLDF|TT2|Add0~48_combout\,
	cout => \TLDF|TT2|Add0~49\);

-- Location: LCCOMB_X35_Y15_N20
\TLDF|TT2|Add0~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~50_combout\ = (\TLDF|TT2|current_count\(26) & (!\TLDF|TT2|Add0~49\)) # (!\TLDF|TT2|current_count\(26) & ((\TLDF|TT2|Add0~49\) # (GND)))
-- \TLDF|TT2|Add0~51\ = CARRY((!\TLDF|TT2|Add0~49\) # (!\TLDF|TT2|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(26),
	datad => VCC,
	cin => \TLDF|TT2|Add0~49\,
	combout => \TLDF|TT2|Add0~50_combout\,
	cout => \TLDF|TT2|Add0~51\);

-- Location: LCCOMB_X35_Y15_N22
\TLDF|TT2|Add0~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~52_combout\ = (\TLDF|TT2|current_count\(27) & (\TLDF|TT2|Add0~51\ $ (GND))) # (!\TLDF|TT2|current_count\(27) & (!\TLDF|TT2|Add0~51\ & VCC))
-- \TLDF|TT2|Add0~53\ = CARRY((\TLDF|TT2|current_count\(27) & !\TLDF|TT2|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(27),
	datad => VCC,
	cin => \TLDF|TT2|Add0~51\,
	combout => \TLDF|TT2|Add0~52_combout\,
	cout => \TLDF|TT2|Add0~53\);

-- Location: LCCOMB_X35_Y15_N24
\TLDF|TT2|Add0~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~54_combout\ = (\TLDF|TT2|current_count\(28) & (!\TLDF|TT2|Add0~53\)) # (!\TLDF|TT2|current_count\(28) & ((\TLDF|TT2|Add0~53\) # (GND)))
-- \TLDF|TT2|Add0~55\ = CARRY((!\TLDF|TT2|Add0~53\) # (!\TLDF|TT2|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(28),
	datad => VCC,
	cin => \TLDF|TT2|Add0~53\,
	combout => \TLDF|TT2|Add0~54_combout\,
	cout => \TLDF|TT2|Add0~55\);

-- Location: LCCOMB_X35_Y15_N26
\TLDF|TT2|Add0~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~56_combout\ = (\TLDF|TT2|current_count\(29) & (\TLDF|TT2|Add0~55\ $ (GND))) # (!\TLDF|TT2|current_count\(29) & (!\TLDF|TT2|Add0~55\ & VCC))
-- \TLDF|TT2|Add0~57\ = CARRY((\TLDF|TT2|current_count\(29) & !\TLDF|TT2|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(29),
	datad => VCC,
	cin => \TLDF|TT2|Add0~55\,
	combout => \TLDF|TT2|Add0~56_combout\,
	cout => \TLDF|TT2|Add0~57\);

-- Location: LCCOMB_X35_Y15_N28
\TLDF|TT2|Add0~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~58_combout\ = (\TLDF|TT2|current_count\(30) & (!\TLDF|TT2|Add0~57\)) # (!\TLDF|TT2|current_count\(30) & ((\TLDF|TT2|Add0~57\) # (GND)))
-- \TLDF|TT2|Add0~59\ = CARRY((!\TLDF|TT2|Add0~57\) # (!\TLDF|TT2|current_count\(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(30),
	datad => VCC,
	cin => \TLDF|TT2|Add0~57\,
	combout => \TLDF|TT2|Add0~58_combout\,
	cout => \TLDF|TT2|Add0~59\);

-- Location: LCCOMB_X35_Y15_N30
\TLDF|TT2|Add0~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~60_combout\ = \TLDF|TT2|current_count\(31) $ (!\TLDF|TT2|Add0~59\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(31),
	cin => \TLDF|TT2|Add0~59\,
	combout => \TLDF|TT2|Add0~60_combout\);

-- Location: LCCOMB_X24_Y17_N6
\T3|Add0~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~36_combout\ = (\T3|current_count\(19) & (\T3|Add0~35\ $ (GND))) # (!\T3|current_count\(19) & (!\T3|Add0~35\ & VCC))
-- \T3|Add0~37\ = CARRY((\T3|current_count\(19) & !\T3|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(19),
	datad => VCC,
	cin => \T3|Add0~35\,
	combout => \T3|Add0~36_combout\,
	cout => \T3|Add0~37\);

-- Location: LCCOMB_X24_Y17_N10
\T3|Add0~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~40_combout\ = (\T3|current_count\(21) & (\T3|Add0~39\ $ (GND))) # (!\T3|current_count\(21) & (!\T3|Add0~39\ & VCC))
-- \T3|Add0~41\ = CARRY((\T3|current_count\(21) & !\T3|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(21),
	datad => VCC,
	cin => \T3|Add0~39\,
	combout => \T3|Add0~40_combout\,
	cout => \T3|Add0~41\);

-- Location: LCCOMB_X24_Y17_N12
\T3|Add0~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~42_combout\ = (\T3|current_count\(22) & (!\T3|Add0~41\)) # (!\T3|current_count\(22) & ((\T3|Add0~41\) # (GND)))
-- \T3|Add0~43\ = CARRY((!\T3|Add0~41\) # (!\T3|current_count\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(22),
	datad => VCC,
	cin => \T3|Add0~41\,
	combout => \T3|Add0~42_combout\,
	cout => \T3|Add0~43\);

-- Location: LCCOMB_X24_Y17_N28
\T3|Add0~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~58_combout\ = (\T3|current_count\(30) & (!\T3|Add0~57\)) # (!\T3|current_count\(30) & ((\T3|Add0~57\) # (GND)))
-- \T3|Add0~59\ = CARRY((!\T3|Add0~57\) # (!\T3|current_count\(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(30),
	datad => VCC,
	cin => \T3|Add0~57\,
	combout => \T3|Add0~58_combout\,
	cout => \T3|Add0~59\);

-- Location: LCCOMB_X24_Y17_N30
\T3|Add0~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~60_combout\ = \T3|current_count\(31) $ (!\T3|Add0~59\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(31),
	cin => \T3|Add0~59\,
	combout => \T3|Add0~60_combout\);

-- Location: FF_X23_Y13_N27
\TLDM|TT1|current_count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~56_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(29));

-- Location: FF_X23_Y13_N11
\TLDM|TT1|current_count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~40_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(21));

-- Location: FF_X23_Y14_N11
\TLDM|TT1|current_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~8_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(5));

-- Location: FF_X23_Y14_N27
\TLDM|TT1|current_count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~24_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(13));

-- Location: LCCOMB_X24_Y13_N8
\TLDM|TT1|LessThan0~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~9_combout\ = (\TLDM|TT1|current_count\(18)) # ((\TLDM|TT1|current_count\(16) & \TLDM|TT1|current_count\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(16),
	datac => \TLDM|TT1|current_count\(18),
	datad => \TLDM|TT1|current_count\(17),
	combout => \TLDM|TT1|LessThan0~9_combout\);

-- Location: FF_X23_Y14_N23
\TLDM|TT1|current_count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~20_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(11));

-- Location: LCCOMB_X24_Y13_N18
\TLDM|TT1|LessThan0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~10_combout\ = (\TLDM|TT1|current_count\(9)) # ((\TLDM|TT1|current_count\(8)) # ((\TLDM|TT1|current_count\(11)) # (\TLDM|TT1|current_count\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(9),
	datab => \TLDM|TT1|current_count\(8),
	datac => \TLDM|TT1|current_count\(11),
	datad => \TLDM|TT1|current_count\(10),
	combout => \TLDM|TT1|LessThan0~10_combout\);

-- Location: LCCOMB_X24_Y13_N6
\TLDM|TT1|LessThan0~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~11_combout\ = (\TLDM|TT1|LessThan0~9_combout\) # ((\TLDM|TT1|current_count\(17) & (\TLDM|TT1|LessThan0~7_combout\ & \TLDM|TT1|LessThan0~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(17),
	datab => \TLDM|TT1|LessThan0~9_combout\,
	datac => \TLDM|TT1|LessThan0~7_combout\,
	datad => \TLDM|TT1|LessThan0~10_combout\,
	combout => \TLDM|TT1|LessThan0~11_combout\);

-- Location: FF_X37_Y12_N21
\TLDM|TT2|current_count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~50_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(26));

-- Location: FF_X37_Y12_N19
\TLDM|TT2|current_count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~48_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(25));

-- Location: FF_X37_Y12_N17
\TLDM|TT2|current_count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~46_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(24));

-- Location: FF_X37_Y12_N31
\TLDM|TT2|current_count[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~60_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(31));

-- Location: LCCOMB_X38_Y12_N8
\TLDM|green_light~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|green_light~0_combout\ = (!\TLDM|TT2|current_count\(31) & ((\TLDM|TT2|current_count\(26)) # ((\TLDM|TT2|current_count\(24) & \TLDM|TT2|current_count\(25)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(24),
	datab => \TLDM|TT2|current_count\(31),
	datac => \TLDM|TT2|current_count\(25),
	datad => \TLDM|TT2|current_count\(26),
	combout => \TLDM|green_light~0_combout\);

-- Location: FF_X37_Y12_N23
\TLDM|TT2|current_count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~52_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(27));

-- Location: FF_X37_Y12_N25
\TLDM|TT2|current_count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~54_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(28));

-- Location: FF_X37_Y12_N27
\TLDM|TT2|current_count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~56_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(29));

-- Location: LCCOMB_X36_Y12_N16
\TLDM|green_light~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|green_light~1_combout\ = (!\TLDM|TT2|current_count\(31) & ((\TLDM|TT2|current_count\(28)) # ((\TLDM|TT2|current_count\(29)) # (\TLDM|TT2|current_count\(27)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(31),
	datab => \TLDM|TT2|current_count\(28),
	datac => \TLDM|TT2|current_count\(29),
	datad => \TLDM|TT2|current_count\(27),
	combout => \TLDM|green_light~1_combout\);

-- Location: FF_X37_Y12_N29
\TLDM|TT2|current_count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~58_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(30));

-- Location: LCCOMB_X38_Y12_N20
\TLDM|green_light~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|green_light~2_combout\ = (\TLDM|green_light~1_combout\) # ((\TLDM|green_light~0_combout\) # ((!\TLDM|TT2|current_count\(31) & \TLDM|TT2|current_count\(30))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|green_light~1_combout\,
	datab => \TLDM|TT2|current_count\(31),
	datac => \TLDM|green_light~0_combout\,
	datad => \TLDM|TT2|current_count\(30),
	combout => \TLDM|green_light~2_combout\);

-- Location: FF_X37_Y12_N7
\TLDM|TT2|current_count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~36_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(19));

-- Location: FF_X37_Y12_N9
\TLDM|TT2|current_count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~38_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(20));

-- Location: LCCOMB_X38_Y12_N30
\TLDM|TT2|LessThan0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~0_combout\ = (\TLDM|TT2|current_count\(20) & (!\TLDM|TT2|current_count\(31) & (\TLDM|TT2|current_count\(19) & \TLDM|TT2|current_count\(25))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(20),
	datab => \TLDM|TT2|current_count\(31),
	datac => \TLDM|TT2|current_count\(19),
	datad => \TLDM|TT2|current_count\(25),
	combout => \TLDM|TT2|LessThan0~0_combout\);

-- Location: FF_X37_Y12_N11
\TLDM|TT2|current_count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~40_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(21));

-- Location: FF_X37_Y12_N13
\TLDM|TT2|current_count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~42_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(22));

-- Location: FF_X37_Y12_N15
\TLDM|TT2|current_count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~44_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(23));

-- Location: LCCOMB_X38_Y12_N2
\TLDM|TT2|LessThan0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~1_combout\ = (\TLDM|TT2|current_count\(23) & (\TLDM|TT2|current_count\(22) & (\TLDM|TT2|LessThan0~0_combout\ & \TLDM|TT2|current_count\(21))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(23),
	datab => \TLDM|TT2|current_count\(22),
	datac => \TLDM|TT2|LessThan0~0_combout\,
	datad => \TLDM|TT2|current_count\(21),
	combout => \TLDM|TT2|LessThan0~1_combout\);

-- Location: FF_X37_Y13_N15
\TLDM|TT2|current_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~12_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(7));

-- Location: FF_X38_Y12_N1
\TLDM|TT2|current_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|current_count[0]~0_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(0));

-- Location: FF_X37_Y13_N3
\TLDM|TT2|current_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~0_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(1));

-- Location: FF_X37_Y13_N5
\TLDM|TT2|current_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~2_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(2));

-- Location: FF_X37_Y13_N7
\TLDM|TT2|current_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~4_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(3));

-- Location: LCCOMB_X38_Y12_N28
\TLDM|TT2|LessThan0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~2_combout\ = (\TLDM|TT2|current_count\(1)) # ((\TLDM|TT2|current_count\(0)) # ((\TLDM|TT2|current_count\(3)) # (\TLDM|TT2|current_count\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(1),
	datab => \TLDM|TT2|current_count\(0),
	datac => \TLDM|TT2|current_count\(3),
	datad => \TLDM|TT2|current_count\(2),
	combout => \TLDM|TT2|LessThan0~2_combout\);

-- Location: FF_X37_Y13_N9
\TLDM|TT2|current_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~6_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(4));

-- Location: FF_X37_Y13_N11
\TLDM|TT2|current_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~8_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(5));

-- Location: FF_X37_Y13_N13
\TLDM|TT2|current_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~10_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(6));

-- Location: LCCOMB_X38_Y12_N26
\TLDM|TT2|LessThan0~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~3_combout\ = (\TLDM|TT2|current_count\(6)) # ((\TLDM|TT2|LessThan0~2_combout\) # ((\TLDM|TT2|current_count\(5)) # (\TLDM|TT2|current_count\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(6),
	datab => \TLDM|TT2|LessThan0~2_combout\,
	datac => \TLDM|TT2|current_count\(5),
	datad => \TLDM|TT2|current_count\(4),
	combout => \TLDM|TT2|LessThan0~3_combout\);

-- Location: FF_X37_Y12_N3
\TLDM|TT2|current_count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~32_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(17));

-- Location: FF_X37_Y13_N25
\TLDM|TT2|current_count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~22_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(12));

-- Location: FF_X37_Y13_N27
\TLDM|TT2|current_count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~24_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(13));

-- Location: FF_X37_Y13_N29
\TLDM|TT2|current_count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~26_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(14));

-- Location: FF_X37_Y13_N31
\TLDM|TT2|current_count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~28_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(15));

-- Location: LCCOMB_X38_Y12_N12
\TLDM|TT2|LessThan0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~4_combout\ = (\TLDM|TT2|current_count\(15) & (\TLDM|TT2|current_count\(14) & (\TLDM|TT2|current_count\(13) & \TLDM|TT2|current_count\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(15),
	datab => \TLDM|TT2|current_count\(14),
	datac => \TLDM|TT2|current_count\(13),
	datad => \TLDM|TT2|current_count\(12),
	combout => \TLDM|TT2|LessThan0~4_combout\);

-- Location: LCCOMB_X38_Y12_N24
\TLDM|TT2|LessThan0~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~5_combout\ = (\TLDM|TT2|current_count\(7) & (\TLDM|TT2|LessThan0~4_combout\ & (\TLDM|TT2|LessThan0~3_combout\ & \TLDM|TT2|current_count\(17))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(7),
	datab => \TLDM|TT2|LessThan0~4_combout\,
	datac => \TLDM|TT2|LessThan0~3_combout\,
	datad => \TLDM|TT2|current_count\(17),
	combout => \TLDM|TT2|LessThan0~5_combout\);

-- Location: FF_X37_Y12_N5
\TLDM|TT2|current_count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~34_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(18));

-- Location: FF_X37_Y12_N1
\TLDM|TT2|current_count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~30_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(16));

-- Location: LCCOMB_X38_Y12_N16
\TLDM|TT2|LessThan0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~6_combout\ = (\TLDM|TT2|current_count\(18)) # ((\TLDM|TT2|current_count\(16) & \TLDM|TT2|current_count\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(16),
	datac => \TLDM|TT2|current_count\(18),
	datad => \TLDM|TT2|current_count\(17),
	combout => \TLDM|TT2|LessThan0~6_combout\);

-- Location: FF_X37_Y13_N17
\TLDM|TT2|current_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~14_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(8));

-- Location: FF_X37_Y13_N19
\TLDM|TT2|current_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~16_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(9));

-- Location: FF_X37_Y13_N21
\TLDM|TT2|current_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~18_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(10));

-- Location: FF_X37_Y13_N23
\TLDM|TT2|current_count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT2|Add0~20_combout\,
	clrn => \TLDM|ALT_INV_tt1_enable~combout\,
	ena => \TLDM|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT2|current_count\(11));

-- Location: LCCOMB_X38_Y12_N22
\TLDM|TT2|LessThan0~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~7_combout\ = (\TLDM|TT2|current_count\(11)) # ((\TLDM|TT2|current_count\(10)) # ((\TLDM|TT2|current_count\(9)) # (\TLDM|TT2|current_count\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|current_count\(11),
	datab => \TLDM|TT2|current_count\(10),
	datac => \TLDM|TT2|current_count\(9),
	datad => \TLDM|TT2|current_count\(8),
	combout => \TLDM|TT2|LessThan0~7_combout\);

-- Location: LCCOMB_X38_Y12_N14
\TLDM|TT2|LessThan0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|LessThan0~8_combout\ = (\TLDM|TT2|LessThan0~6_combout\) # ((\TLDM|TT2|LessThan0~4_combout\ & (\TLDM|TT2|LessThan0~7_combout\ & \TLDM|TT2|current_count\(17))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT2|LessThan0~4_combout\,
	datab => \TLDM|TT2|LessThan0~6_combout\,
	datac => \TLDM|TT2|LessThan0~7_combout\,
	datad => \TLDM|TT2|current_count\(17),
	combout => \TLDM|TT2|LessThan0~8_combout\);

-- Location: LCCOMB_X38_Y12_N10
\TLDM|green_light~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|green_light~3_combout\ = (\TLDM|green_light~2_combout\) # ((\TLDM|TT2|LessThan0~1_combout\ & ((\TLDM|TT2|LessThan0~5_combout\) # (\TLDM|TT2|LessThan0~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|green_light~2_combout\,
	datab => \TLDM|TT2|LessThan0~5_combout\,
	datac => \TLDM|TT2|LessThan0~8_combout\,
	datad => \TLDM|TT2|LessThan0~1_combout\,
	combout => \TLDM|green_light~3_combout\);

-- Location: FF_X23_Y20_N27
\T5|current_count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~56_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(29));

-- Location: LCCOMB_X24_Y20_N0
\TLC|process_0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~0_combout\ = (\T5|current_count\(30)) # ((\T5|current_count\(29)) # (\T5|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(30),
	datac => \T5|current_count\(29),
	datad => \T5|current_count\(28),
	combout => \TLC|process_0~0_combout\);

-- Location: LCCOMB_X21_Y20_N8
\TLC|process_0~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~3_combout\ = (\T5|current_count\(18) & \T5|current_count\(17))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \T5|current_count\(18),
	datad => \T5|current_count\(17),
	combout => \TLC|process_0~3_combout\);

-- Location: FF_X23_Y21_N27
\T5|current_count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~24_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(13));

-- Location: LCCOMB_X22_Y21_N10
\TLC|process_0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~6_combout\ = (\T5|current_count\(13) & (\T5|current_count\(15) & \T5|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(13),
	datac => \T5|current_count\(15),
	datad => \T5|current_count\(12),
	combout => \TLC|process_0~6_combout\);

-- Location: LCCOMB_X22_Y21_N6
\TLC|process_0~15\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~15_combout\ = (\minor_sensor~input_o\ & !\T5|current_count\(31))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \minor_sensor~input_o\,
	datad => \T5|current_count\(31),
	combout => \TLC|process_0~15_combout\);

-- Location: FF_X21_Y17_N27
\TT|current_count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~56_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(29));

-- Location: FF_X21_Y18_N7
\TT|current_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~4_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(3));

-- Location: FF_X21_Y18_N13
\TT|current_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~10_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(6));

-- Location: LCCOMB_X22_Y18_N24
\TT|LessThan0~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~9_combout\ = (\TT|current_count\(18)) # ((\TT|current_count\(16) & \TT|current_count\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(18),
	datac => \TT|current_count\(16),
	datad => \TT|current_count\(17),
	combout => \TT|LessThan0~9_combout\);

-- Location: FF_X21_Y18_N23
\TT|current_count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~20_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(11));

-- Location: LCCOMB_X22_Y18_N26
\TT|LessThan0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~10_combout\ = (\TT|current_count\(8)) # ((\TT|current_count\(10)) # ((\TT|current_count\(9)) # (\TT|current_count\(11))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(8),
	datab => \TT|current_count\(10),
	datac => \TT|current_count\(9),
	datad => \TT|current_count\(11),
	combout => \TT|LessThan0~10_combout\);

-- Location: LCCOMB_X22_Y18_N12
\TT|LessThan0~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~11_combout\ = (\TT|LessThan0~9_combout\) # ((\TT|current_count\(17) & (\TT|LessThan0~7_combout\ & \TT|LessThan0~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(17),
	datab => \TT|LessThan0~7_combout\,
	datac => \TT|LessThan0~10_combout\,
	datad => \TT|LessThan0~9_combout\,
	combout => \TT|LessThan0~11_combout\);

-- Location: FF_X32_Y15_N31
\TLDF|TT1|current_count[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~60_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(31));

-- Location: FF_X32_Y15_N13
\TLDF|TT1|current_count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~42_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(22));

-- Location: FF_X32_Y16_N7
\TLDF|TT1|current_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~4_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(3));

-- Location: FF_X32_Y16_N13
\TLDF|TT1|current_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~10_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(6));

-- Location: FF_X32_Y16_N31
\TLDF|TT1|current_count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~28_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(15));

-- Location: LCCOMB_X31_Y16_N4
\TLDF|TT1|LessThan0~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~9_combout\ = (\TLDF|TT1|current_count\(18)) # ((\TLDF|TT1|current_count\(17) & \TLDF|TT1|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(17),
	datac => \TLDF|TT1|current_count\(16),
	datad => \TLDF|TT1|current_count\(18),
	combout => \TLDF|TT1|LessThan0~9_combout\);

-- Location: FF_X32_Y16_N23
\TLDF|TT1|current_count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~20_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(11));

-- Location: LCCOMB_X31_Y16_N24
\TLDF|TT1|LessThan0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~10_combout\ = (\TLDF|TT1|current_count\(9)) # ((\TLDF|TT1|current_count\(8)) # ((\TLDF|TT1|current_count\(10)) # (\TLDF|TT1|current_count\(11))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(9),
	datab => \TLDF|TT1|current_count\(8),
	datac => \TLDF|TT1|current_count\(10),
	datad => \TLDF|TT1|current_count\(11),
	combout => \TLDF|TT1|LessThan0~10_combout\);

-- Location: LCCOMB_X31_Y16_N22
\TLDF|TT1|LessThan0~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~11_combout\ = (\TLDF|TT1|LessThan0~9_combout\) # ((\TLDF|TT1|current_count\(17) & (\TLDF|TT1|LessThan0~7_combout\ & \TLDF|TT1|LessThan0~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(17),
	datab => \TLDF|TT1|LessThan0~7_combout\,
	datac => \TLDF|TT1|LessThan0~9_combout\,
	datad => \TLDF|TT1|LessThan0~10_combout\,
	combout => \TLDF|TT1|LessThan0~11_combout\);

-- Location: FF_X35_Y15_N21
\TLDF|TT2|current_count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~50_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(26));

-- Location: FF_X35_Y15_N19
\TLDF|TT2|current_count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~48_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(25));

-- Location: FF_X35_Y15_N17
\TLDF|TT2|current_count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~46_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(24));

-- Location: FF_X35_Y15_N31
\TLDF|TT2|current_count[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~60_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(31));

-- Location: LCCOMB_X36_Y16_N4
\TLDF|green_light~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|green_light~0_combout\ = (!\TLDF|TT2|current_count\(31) & ((\TLDF|TT2|current_count\(26)) # ((\TLDF|TT2|current_count\(24) & \TLDF|TT2|current_count\(25)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(24),
	datab => \TLDF|TT2|current_count\(25),
	datac => \TLDF|TT2|current_count\(26),
	datad => \TLDF|TT2|current_count\(31),
	combout => \TLDF|green_light~0_combout\);

-- Location: FF_X35_Y15_N23
\TLDF|TT2|current_count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~52_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(27));

-- Location: FF_X35_Y15_N25
\TLDF|TT2|current_count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~54_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(28));

-- Location: FF_X35_Y15_N27
\TLDF|TT2|current_count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~56_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(29));

-- Location: LCCOMB_X36_Y15_N0
\TLDF|green_light~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|green_light~1_combout\ = (!\TLDF|TT2|current_count\(31) & ((\TLDF|TT2|current_count\(29)) # ((\TLDF|TT2|current_count\(27)) # (\TLDF|TT2|current_count\(28)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(29),
	datab => \TLDF|TT2|current_count\(27),
	datac => \TLDF|TT2|current_count\(28),
	datad => \TLDF|TT2|current_count\(31),
	combout => \TLDF|green_light~1_combout\);

-- Location: FF_X35_Y15_N29
\TLDF|TT2|current_count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~58_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(30));

-- Location: LCCOMB_X36_Y16_N12
\TLDF|green_light~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|green_light~2_combout\ = (\TLDF|green_light~1_combout\) # ((\TLDF|green_light~0_combout\) # ((\TLDF|TT2|current_count\(30) & !\TLDF|TT2|current_count\(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(30),
	datab => \TLDF|green_light~1_combout\,
	datac => \TLDF|green_light~0_combout\,
	datad => \TLDF|TT2|current_count\(31),
	combout => \TLDF|green_light~2_combout\);

-- Location: FF_X35_Y15_N7
\TLDF|TT2|current_count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~36_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(19));

-- Location: LCCOMB_X36_Y16_N26
\TLDF|TT2|LessThan0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~0_combout\ = (\TLDF|TT2|current_count\(19) & (\TLDF|TT2|current_count\(25) & (\TLDF|TT2|current_count\(20) & !\TLDF|TT2|current_count\(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(19),
	datab => \TLDF|TT2|current_count\(25),
	datac => \TLDF|TT2|current_count\(20),
	datad => \TLDF|TT2|current_count\(31),
	combout => \TLDF|TT2|LessThan0~0_combout\);

-- Location: FF_X35_Y16_N27
\TLDF|TT2|current_count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~24_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(13));

-- Location: FF_X23_Y19_N7
\TLC|state.MR\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TLC|state~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.MR~q\);

-- Location: FF_X24_Y17_N31
\T3|current_count[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~60_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(31));

-- Location: LCCOMB_X23_Y19_N10
\TLC|Selector4~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector4~0_combout\ = (\TLC|state.FG~q\) # ((\TLC|state.FGW~q\ & ((\T3|current_count\(31)) # (!\major_sensor~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FG~q\,
	datab => \major_sensor~input_o\,
	datac => \TLC|state.FGW~q\,
	datad => \T3|current_count\(31),
	combout => \TLC|Selector4~0_combout\);

-- Location: FF_X23_Y18_N13
\T3|current_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|current_count[0]~0_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(0));

-- Location: FF_X24_Y17_N7
\T3|current_count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~36_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(19));

-- Location: LCCOMB_X23_Y18_N26
\T3|LessThan0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~8_combout\ = (\T3|current_count\(19)) # ((\T3|current_count\(17)) # (\T3|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(19),
	datac => \T3|current_count\(17),
	datad => \T3|current_count\(18),
	combout => \T3|LessThan0~8_combout\);

-- Location: FF_X24_Y17_N11
\T3|current_count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~40_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(21));

-- Location: FF_X24_Y17_N13
\T3|current_count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~42_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(22));

-- Location: LCCOMB_X23_Y18_N22
\T3|LessThan0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~10_combout\ = (\T3|current_count\(21) & (\T3|current_count\(23) & (\T3|current_count\(22) & \T3|current_count\(20))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(21),
	datab => \T3|current_count\(23),
	datac => \T3|current_count\(22),
	datad => \T3|current_count\(20),
	combout => \T3|LessThan0~10_combout\);

-- Location: LCCOMB_X23_Y19_N6
\TLC|state~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|state~24_combout\ = (\TLC|state.MAW~q\ & \TT|LessThan0~12_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLC|state.MAW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|state~24_combout\);

-- Location: LCCOMB_X38_Y12_N0
\TLDM|TT2|current_count[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT2|current_count[0]~0_combout\ = !\TLDM|TT2|current_count\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLDM|TT2|current_count\(0),
	combout => \TLDM|TT2|current_count[0]~0_combout\);

-- Location: LCCOMB_X23_Y18_N12
\T3|current_count[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|current_count[0]~0_combout\ = !\T3|current_count\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \T3|current_count\(0),
	combout => \T3|current_count[0]~0_combout\);

-- Location: IOIBUF_X41_Y15_N1
\clk~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G9
\clk~inputclkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOOBUF_X0_Y26_N16
\major_lights[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \TLDM|green_light~combout\,
	devoe => ww_devoe,
	o => ww_major_lights(0));

-- Location: IOOBUF_X0_Y27_N9
\major_lights[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \TLDM|Equal1~0_combout\,
	devoe => ww_devoe,
	o => ww_major_lights(1));

-- Location: IOOBUF_X0_Y27_N16
\major_lights[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \TLDM|ALT_INV_red_light~0_combout\,
	devoe => ww_devoe,
	o => ww_major_lights(2));

-- Location: IOOBUF_X0_Y20_N9
\minor_lights[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \TLDF|green_light~combout\,
	devoe => ww_devoe,
	o => ww_minor_lights(0));

-- Location: IOOBUF_X0_Y20_N2
\minor_lights[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \TLDF|Equal1~0_combout\,
	devoe => ww_devoe,
	o => ww_minor_lights(1));

-- Location: IOOBUF_X0_Y21_N23
\minor_lights[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \TLDF|ALT_INV_red_light~0_combout\,
	devoe => ww_devoe,
	o => ww_minor_lights(2));

-- Location: LCCOMB_X21_Y18_N2
\TT|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~0_combout\ = (\TT|current_count\(0) & (\TT|current_count\(1) $ (VCC))) # (!\TT|current_count\(0) & (\TT|current_count\(1) & VCC))
-- \TT|Add0~1\ = CARRY((\TT|current_count\(0) & \TT|current_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(0),
	datab => \TT|current_count\(1),
	datad => VCC,
	combout => \TT|Add0~0_combout\,
	cout => \TT|Add0~1\);

-- Location: LCCOMB_X22_Y19_N8
\TLC|Selector1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector1~0_combout\ = (\TLC|state.MGF~q\) # ((\TLC|state.MGFW~q\ & !\TT|LessThan0~12_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MGF~q\,
	datac => \TLC|state.MGFW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|Selector1~0_combout\);

-- Location: FF_X22_Y19_N9
\TLC|state.MGFW\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|Selector1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.MGFW~q\);

-- Location: IOIBUF_X0_Y25_N1
\major_sensor~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_major_sensor,
	o => \major_sensor~input_o\);

-- Location: LCCOMB_X24_Y18_N2
\T3|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~0_combout\ = (\T3|current_count\(0) & (\T3|current_count\(1) $ (VCC))) # (!\T3|current_count\(0) & (\T3|current_count\(1) & VCC))
-- \T3|Add0~1\ = CARRY((\T3|current_count\(0) & \T3|current_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(0),
	datab => \T3|current_count\(1),
	datad => VCC,
	combout => \T3|Add0~0_combout\,
	cout => \T3|Add0~1\);

-- Location: IOIBUF_X0_Y24_N1
\minor_sensor~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_minor_sensor,
	o => \minor_sensor~input_o\);

-- Location: LCCOMB_X22_Y19_N0
\TLC|state~23\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|state~23_combout\ = (!\TT|LessThan0~12_combout\) # (!\TLC|state.FAW~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FAW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|state~23_combout\);

-- Location: FF_X22_Y19_N1
\TLC|state.Init\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TLC|state~23_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.Init~q\);

-- Location: LCCOMB_X23_Y19_N18
\TLC|Selector3~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector3~0_combout\ = (\TLC|state.MR~q\) # ((\minor_sensor~input_o\ & (!\TLC|state.Init~q\ & !\major_sensor~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MR~q\,
	datab => \minor_sensor~input_o\,
	datac => \TLC|state.Init~q\,
	datad => \major_sensor~input_o\,
	combout => \TLC|Selector3~0_combout\);

-- Location: FF_X23_Y19_N19
\TLC|state.FG\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|Selector3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.FG~q\);

-- Location: LCCOMB_X23_Y19_N8
\TLC|state~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|state~22_combout\ = (\TLC|state.FGFW~q\ & \TT|LessThan0~12_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLC|state.FGFW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|state~22_combout\);

-- Location: FF_X23_Y19_N9
\TLC|state.FA\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|state~22_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.FA~q\);

-- Location: LCCOMB_X22_Y19_N10
\TLC|Selector6~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector6~0_combout\ = (\TLC|state.FA~q\) # ((\TLC|state.FAW~q\ & !\TT|LessThan0~12_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLC|state.FA~q\,
	datac => \TLC|state.FAW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|Selector6~0_combout\);

-- Location: FF_X22_Y19_N11
\TLC|state.FAW\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|Selector6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.FAW~q\);

-- Location: LCCOMB_X22_Y19_N6
\TLC|WideOr10~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr10~0_combout\ = (!\TLC|state.FGFW~q\ & (!\TLC|state.FA~q\ & (!\TLC|state.FGF~q\ & !\TLC|state.FAW~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FGFW~q\,
	datab => \TLC|state.FA~q\,
	datac => \TLC|state.FGF~q\,
	datad => \TLC|state.FAW~q\,
	combout => \TLC|WideOr10~0_combout\);

-- Location: LCCOMB_X23_Y19_N28
\TLC|WideOr13~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr13~0_combout\ = (\TLC|state.FGW~q\) # (!\TLC|WideOr10~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLC|WideOr10~0_combout\,
	datad => \TLC|state.FGW~q\,
	combout => \TLC|WideOr13~0_combout\);

-- Location: FF_X24_Y18_N3
\T3|current_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~0_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(1));

-- Location: LCCOMB_X24_Y18_N4
\T3|Add0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~2_combout\ = (\T3|current_count\(2) & (!\T3|Add0~1\)) # (!\T3|current_count\(2) & ((\T3|Add0~1\) # (GND)))
-- \T3|Add0~3\ = CARRY((!\T3|Add0~1\) # (!\T3|current_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(2),
	datad => VCC,
	cin => \T3|Add0~1\,
	combout => \T3|Add0~2_combout\,
	cout => \T3|Add0~3\);

-- Location: FF_X24_Y18_N5
\T3|current_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~2_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(2));

-- Location: LCCOMB_X24_Y18_N6
\T3|Add0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~4_combout\ = (\T3|current_count\(3) & (\T3|Add0~3\ $ (GND))) # (!\T3|current_count\(3) & (!\T3|Add0~3\ & VCC))
-- \T3|Add0~5\ = CARRY((\T3|current_count\(3) & !\T3|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(3),
	datad => VCC,
	cin => \T3|Add0~3\,
	combout => \T3|Add0~4_combout\,
	cout => \T3|Add0~5\);

-- Location: LCCOMB_X24_Y18_N8
\T3|Add0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~6_combout\ = (\T3|current_count\(4) & (!\T3|Add0~5\)) # (!\T3|current_count\(4) & ((\T3|Add0~5\) # (GND)))
-- \T3|Add0~7\ = CARRY((!\T3|Add0~5\) # (!\T3|current_count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(4),
	datad => VCC,
	cin => \T3|Add0~5\,
	combout => \T3|Add0~6_combout\,
	cout => \T3|Add0~7\);

-- Location: FF_X24_Y18_N9
\T3|current_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~6_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(4));

-- Location: LCCOMB_X24_Y18_N10
\T3|Add0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~8_combout\ = (\T3|current_count\(5) & (\T3|Add0~7\ $ (GND))) # (!\T3|current_count\(5) & (!\T3|Add0~7\ & VCC))
-- \T3|Add0~9\ = CARRY((\T3|current_count\(5) & !\T3|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(5),
	datad => VCC,
	cin => \T3|Add0~7\,
	combout => \T3|Add0~8_combout\,
	cout => \T3|Add0~9\);

-- Location: LCCOMB_X24_Y18_N12
\T3|Add0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~10_combout\ = (\T3|current_count\(6) & (!\T3|Add0~9\)) # (!\T3|current_count\(6) & ((\T3|Add0~9\) # (GND)))
-- \T3|Add0~11\ = CARRY((!\T3|Add0~9\) # (!\T3|current_count\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(6),
	datad => VCC,
	cin => \T3|Add0~9\,
	combout => \T3|Add0~10_combout\,
	cout => \T3|Add0~11\);

-- Location: LCCOMB_X24_Y18_N14
\T3|Add0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~12_combout\ = (\T3|current_count\(7) & (\T3|Add0~11\ $ (GND))) # (!\T3|current_count\(7) & (!\T3|Add0~11\ & VCC))
-- \T3|Add0~13\ = CARRY((\T3|current_count\(7) & !\T3|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(7),
	datad => VCC,
	cin => \T3|Add0~11\,
	combout => \T3|Add0~12_combout\,
	cout => \T3|Add0~13\);

-- Location: FF_X24_Y18_N15
\T3|current_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~12_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(7));

-- Location: LCCOMB_X24_Y18_N16
\T3|Add0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~14_combout\ = (\T3|current_count\(8) & (!\T3|Add0~13\)) # (!\T3|current_count\(8) & ((\T3|Add0~13\) # (GND)))
-- \T3|Add0~15\ = CARRY((!\T3|Add0~13\) # (!\T3|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(8),
	datad => VCC,
	cin => \T3|Add0~13\,
	combout => \T3|Add0~14_combout\,
	cout => \T3|Add0~15\);

-- Location: FF_X24_Y18_N17
\T3|current_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~14_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(8));

-- Location: LCCOMB_X24_Y18_N18
\T3|Add0~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~16_combout\ = (\T3|current_count\(9) & (\T3|Add0~15\ $ (GND))) # (!\T3|current_count\(9) & (!\T3|Add0~15\ & VCC))
-- \T3|Add0~17\ = CARRY((\T3|current_count\(9) & !\T3|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(9),
	datad => VCC,
	cin => \T3|Add0~15\,
	combout => \T3|Add0~16_combout\,
	cout => \T3|Add0~17\);

-- Location: FF_X24_Y18_N19
\T3|current_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~16_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(9));

-- Location: LCCOMB_X24_Y18_N20
\T3|Add0~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~18_combout\ = (\T3|current_count\(10) & (!\T3|Add0~17\)) # (!\T3|current_count\(10) & ((\T3|Add0~17\) # (GND)))
-- \T3|Add0~19\ = CARRY((!\T3|Add0~17\) # (!\T3|current_count\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(10),
	datad => VCC,
	cin => \T3|Add0~17\,
	combout => \T3|Add0~18_combout\,
	cout => \T3|Add0~19\);

-- Location: FF_X24_Y18_N21
\T3|current_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~18_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(10));

-- Location: LCCOMB_X24_Y18_N22
\T3|Add0~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~20_combout\ = (\T3|current_count\(11) & (\T3|Add0~19\ $ (GND))) # (!\T3|current_count\(11) & (!\T3|Add0~19\ & VCC))
-- \T3|Add0~21\ = CARRY((\T3|current_count\(11) & !\T3|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(11),
	datad => VCC,
	cin => \T3|Add0~19\,
	combout => \T3|Add0~20_combout\,
	cout => \T3|Add0~21\);

-- Location: LCCOMB_X24_Y18_N24
\T3|Add0~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~22_combout\ = (\T3|current_count\(12) & (!\T3|Add0~21\)) # (!\T3|current_count\(12) & ((\T3|Add0~21\) # (GND)))
-- \T3|Add0~23\ = CARRY((!\T3|Add0~21\) # (!\T3|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(12),
	datad => VCC,
	cin => \T3|Add0~21\,
	combout => \T3|Add0~22_combout\,
	cout => \T3|Add0~23\);

-- Location: FF_X24_Y18_N25
\T3|current_count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~22_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(12));

-- Location: LCCOMB_X24_Y18_N26
\T3|Add0~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~24_combout\ = (\T3|current_count\(13) & (\T3|Add0~23\ $ (GND))) # (!\T3|current_count\(13) & (!\T3|Add0~23\ & VCC))
-- \T3|Add0~25\ = CARRY((\T3|current_count\(13) & !\T3|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(13),
	datad => VCC,
	cin => \T3|Add0~23\,
	combout => \T3|Add0~24_combout\,
	cout => \T3|Add0~25\);

-- Location: LCCOMB_X24_Y18_N28
\T3|Add0~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~26_combout\ = (\T3|current_count\(14) & (!\T3|Add0~25\)) # (!\T3|current_count\(14) & ((\T3|Add0~25\) # (GND)))
-- \T3|Add0~27\ = CARRY((!\T3|Add0~25\) # (!\T3|current_count\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(14),
	datad => VCC,
	cin => \T3|Add0~25\,
	combout => \T3|Add0~26_combout\,
	cout => \T3|Add0~27\);

-- Location: FF_X24_Y18_N29
\T3|current_count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~26_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(14));

-- Location: LCCOMB_X24_Y18_N30
\T3|Add0~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~28_combout\ = (\T3|current_count\(15) & (\T3|Add0~27\ $ (GND))) # (!\T3|current_count\(15) & (!\T3|Add0~27\ & VCC))
-- \T3|Add0~29\ = CARRY((\T3|current_count\(15) & !\T3|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(15),
	datad => VCC,
	cin => \T3|Add0~27\,
	combout => \T3|Add0~28_combout\,
	cout => \T3|Add0~29\);

-- Location: LCCOMB_X24_Y17_N0
\T3|Add0~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~30_combout\ = (\T3|current_count\(16) & (!\T3|Add0~29\)) # (!\T3|current_count\(16) & ((\T3|Add0~29\) # (GND)))
-- \T3|Add0~31\ = CARRY((!\T3|Add0~29\) # (!\T3|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(16),
	datad => VCC,
	cin => \T3|Add0~29\,
	combout => \T3|Add0~30_combout\,
	cout => \T3|Add0~31\);

-- Location: FF_X24_Y17_N1
\T3|current_count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~30_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(16));

-- Location: LCCOMB_X24_Y17_N2
\T3|Add0~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~32_combout\ = (\T3|current_count\(17) & (\T3|Add0~31\ $ (GND))) # (!\T3|current_count\(17) & (!\T3|Add0~31\ & VCC))
-- \T3|Add0~33\ = CARRY((\T3|current_count\(17) & !\T3|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(17),
	datad => VCC,
	cin => \T3|Add0~31\,
	combout => \T3|Add0~32_combout\,
	cout => \T3|Add0~33\);

-- Location: FF_X24_Y17_N3
\T3|current_count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~32_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(17));

-- Location: LCCOMB_X24_Y17_N4
\T3|Add0~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~34_combout\ = (\T3|current_count\(18) & (!\T3|Add0~33\)) # (!\T3|current_count\(18) & ((\T3|Add0~33\) # (GND)))
-- \T3|Add0~35\ = CARRY((!\T3|Add0~33\) # (!\T3|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(18),
	datad => VCC,
	cin => \T3|Add0~33\,
	combout => \T3|Add0~34_combout\,
	cout => \T3|Add0~35\);

-- Location: FF_X24_Y17_N5
\T3|current_count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~34_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(18));

-- Location: LCCOMB_X24_Y17_N8
\T3|Add0~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~38_combout\ = (\T3|current_count\(20) & (!\T3|Add0~37\)) # (!\T3|current_count\(20) & ((\T3|Add0~37\) # (GND)))
-- \T3|Add0~39\ = CARRY((!\T3|Add0~37\) # (!\T3|current_count\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(20),
	datad => VCC,
	cin => \T3|Add0~37\,
	combout => \T3|Add0~38_combout\,
	cout => \T3|Add0~39\);

-- Location: FF_X24_Y17_N9
\T3|current_count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~38_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(20));

-- Location: LCCOMB_X24_Y17_N14
\T3|Add0~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~44_combout\ = (\T3|current_count\(23) & (\T3|Add0~43\ $ (GND))) # (!\T3|current_count\(23) & (!\T3|Add0~43\ & VCC))
-- \T3|Add0~45\ = CARRY((\T3|current_count\(23) & !\T3|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(23),
	datad => VCC,
	cin => \T3|Add0~43\,
	combout => \T3|Add0~44_combout\,
	cout => \T3|Add0~45\);

-- Location: FF_X24_Y17_N15
\T3|current_count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~44_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(23));

-- Location: LCCOMB_X24_Y17_N16
\T3|Add0~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~46_combout\ = (\T3|current_count\(24) & (!\T3|Add0~45\)) # (!\T3|current_count\(24) & ((\T3|Add0~45\) # (GND)))
-- \T3|Add0~47\ = CARRY((!\T3|Add0~45\) # (!\T3|current_count\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(24),
	datad => VCC,
	cin => \T3|Add0~45\,
	combout => \T3|Add0~46_combout\,
	cout => \T3|Add0~47\);

-- Location: FF_X24_Y17_N17
\T3|current_count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~46_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(24));

-- Location: LCCOMB_X24_Y17_N18
\T3|Add0~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~48_combout\ = (\T3|current_count\(25) & (\T3|Add0~47\ $ (GND))) # (!\T3|current_count\(25) & (!\T3|Add0~47\ & VCC))
-- \T3|Add0~49\ = CARRY((\T3|current_count\(25) & !\T3|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(25),
	datad => VCC,
	cin => \T3|Add0~47\,
	combout => \T3|Add0~48_combout\,
	cout => \T3|Add0~49\);

-- Location: FF_X24_Y17_N19
\T3|current_count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~48_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(25));

-- Location: LCCOMB_X24_Y17_N20
\T3|Add0~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~50_combout\ = (\T3|current_count\(26) & (!\T3|Add0~49\)) # (!\T3|current_count\(26) & ((\T3|Add0~49\) # (GND)))
-- \T3|Add0~51\ = CARRY((!\T3|Add0~49\) # (!\T3|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(26),
	datad => VCC,
	cin => \T3|Add0~49\,
	combout => \T3|Add0~50_combout\,
	cout => \T3|Add0~51\);

-- Location: FF_X24_Y17_N21
\T3|current_count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~50_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(26));

-- Location: LCCOMB_X24_Y17_N22
\T3|Add0~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~52_combout\ = (\T3|current_count\(27) & (\T3|Add0~51\ $ (GND))) # (!\T3|current_count\(27) & (!\T3|Add0~51\ & VCC))
-- \T3|Add0~53\ = CARRY((\T3|current_count\(27) & !\T3|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(27),
	datad => VCC,
	cin => \T3|Add0~51\,
	combout => \T3|Add0~52_combout\,
	cout => \T3|Add0~53\);

-- Location: FF_X24_Y17_N23
\T3|current_count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~52_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(27));

-- Location: FF_X24_Y18_N27
\T3|current_count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~24_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(13));

-- Location: FF_X24_Y18_N31
\T3|current_count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~28_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(15));

-- Location: LCCOMB_X23_Y18_N24
\T3|LessThan0~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~7_combout\ = (\T3|current_count\(16)) # ((\T3|current_count\(14) & (\T3|current_count\(13) & \T3|current_count\(15))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(14),
	datab => \T3|current_count\(13),
	datac => \T3|current_count\(15),
	datad => \T3|current_count\(16),
	combout => \T3|LessThan0~7_combout\);

-- Location: FF_X24_Y18_N23
\T3|current_count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~20_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(11));

-- Location: LCCOMB_X23_Y18_N2
\T3|LessThan0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~4_combout\ = (\T3|current_count\(15) & (\T3|current_count\(14) & \T3|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(15),
	datac => \T3|current_count\(14),
	datad => \T3|current_count\(12),
	combout => \T3|LessThan0~4_combout\);

-- Location: LCCOMB_X23_Y18_N30
\T3|LessThan0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~6_combout\ = (\T3|LessThan0~4_combout\ & ((\T3|current_count\(9)) # ((\T3|current_count\(11)) # (\T3|current_count\(10)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(9),
	datab => \T3|current_count\(11),
	datac => \T3|current_count\(10),
	datad => \T3|LessThan0~4_combout\,
	combout => \T3|LessThan0~6_combout\);

-- Location: FF_X24_Y18_N13
\T3|current_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~10_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(6));

-- Location: FF_X24_Y18_N11
\T3|current_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~8_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(5));

-- Location: FF_X24_Y18_N7
\T3|current_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~4_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(3));

-- Location: LCCOMB_X23_Y18_N6
\T3|LessThan0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~2_combout\ = (\T3|current_count\(0)) # ((\T3|current_count\(2)) # ((\T3|current_count\(1)) # (\T3|current_count\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(0),
	datab => \T3|current_count\(2),
	datac => \T3|current_count\(1),
	datad => \T3|current_count\(3),
	combout => \T3|LessThan0~2_combout\);

-- Location: LCCOMB_X23_Y18_N8
\T3|LessThan0~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~3_combout\ = (\T3|current_count\(4)) # ((\T3|current_count\(6)) # ((\T3|current_count\(5)) # (\T3|LessThan0~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(4),
	datab => \T3|current_count\(6),
	datac => \T3|current_count\(5),
	datad => \T3|LessThan0~2_combout\,
	combout => \T3|LessThan0~3_combout\);

-- Location: LCCOMB_X23_Y18_N28
\T3|LessThan0~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~5_combout\ = (\T3|current_count\(8) & (\T3|current_count\(7) & (\T3|LessThan0~3_combout\ & \T3|LessThan0~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(8),
	datab => \T3|current_count\(7),
	datac => \T3|LessThan0~3_combout\,
	datad => \T3|LessThan0~4_combout\,
	combout => \T3|LessThan0~5_combout\);

-- Location: LCCOMB_X23_Y18_N4
\T3|LessThan0~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~9_combout\ = (\T3|LessThan0~8_combout\) # ((\T3|LessThan0~7_combout\) # ((\T3|LessThan0~6_combout\) # (\T3|LessThan0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|LessThan0~8_combout\,
	datab => \T3|LessThan0~7_combout\,
	datac => \T3|LessThan0~6_combout\,
	datad => \T3|LessThan0~5_combout\,
	combout => \T3|LessThan0~9_combout\);

-- Location: LCCOMB_X24_Y17_N24
\T3|Add0~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~54_combout\ = (\T3|current_count\(28) & (!\T3|Add0~53\)) # (!\T3|current_count\(28) & ((\T3|Add0~53\) # (GND)))
-- \T3|Add0~55\ = CARRY((!\T3|Add0~53\) # (!\T3|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T3|current_count\(28),
	datad => VCC,
	cin => \T3|Add0~53\,
	combout => \T3|Add0~54_combout\,
	cout => \T3|Add0~55\);

-- Location: FF_X24_Y17_N25
\T3|current_count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~54_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(28));

-- Location: LCCOMB_X24_Y17_N26
\T3|Add0~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|Add0~56_combout\ = (\T3|current_count\(29) & (\T3|Add0~55\ $ (GND))) # (!\T3|current_count\(29) & (!\T3|Add0~55\ & VCC))
-- \T3|Add0~57\ = CARRY((\T3|current_count\(29) & !\T3|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(29),
	datad => VCC,
	cin => \T3|Add0~55\,
	combout => \T3|Add0~56_combout\,
	cout => \T3|Add0~57\);

-- Location: FF_X24_Y17_N29
\T3|current_count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~58_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(30));

-- Location: FF_X24_Y17_N27
\T3|current_count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T3|Add0~56_combout\,
	clrn => \TLC|ALT_INV_state.FG~q\,
	ena => \TLC|WideOr13~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T3|current_count\(29));

-- Location: LCCOMB_X23_Y18_N16
\T3|LessThan0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~0_combout\ = (\T3|current_count\(27) & ((\T3|current_count\(24)) # ((\T3|current_count\(26)) # (\T3|current_count\(25)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(27),
	datab => \T3|current_count\(24),
	datac => \T3|current_count\(26),
	datad => \T3|current_count\(25),
	combout => \T3|LessThan0~0_combout\);

-- Location: LCCOMB_X23_Y18_N18
\T3|LessThan0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~1_combout\ = (\T3|current_count\(28)) # ((\T3|current_count\(30)) # ((\T3|current_count\(29)) # (\T3|LessThan0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(28),
	datab => \T3|current_count\(30),
	datac => \T3|current_count\(29),
	datad => \T3|LessThan0~0_combout\,
	combout => \T3|LessThan0~1_combout\);

-- Location: LCCOMB_X23_Y18_N0
\T3|LessThan0~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T3|LessThan0~11_combout\ = (\T3|LessThan0~1_combout\) # ((\T3|LessThan0~10_combout\ & (\T3|current_count\(27) & \T3|LessThan0~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|LessThan0~10_combout\,
	datab => \T3|current_count\(27),
	datac => \T3|LessThan0~9_combout\,
	datad => \T3|LessThan0~1_combout\,
	combout => \T3|LessThan0~11_combout\);

-- Location: LCCOMB_X23_Y19_N24
\TLC|Selector4~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector4~1_combout\ = (\TLC|Selector4~0_combout\) # ((\TLC|state.FGW~q\ & !\T3|LessThan0~11_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|Selector4~0_combout\,
	datac => \TLC|state.FGW~q\,
	datad => \T3|LessThan0~11_combout\,
	combout => \TLC|Selector4~1_combout\);

-- Location: FF_X23_Y19_N25
\TLC|state.FGW\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|Selector4~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.FGW~q\);

-- Location: LCCOMB_X23_Y19_N14
\TLC|state~21\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|state~21_combout\ = (!\T3|current_count\(31) & (\major_sensor~input_o\ & (\TLC|state.FGW~q\ & \T3|LessThan0~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T3|current_count\(31),
	datab => \major_sensor~input_o\,
	datac => \TLC|state.FGW~q\,
	datad => \T3|LessThan0~11_combout\,
	combout => \TLC|state~21_combout\);

-- Location: FF_X23_Y19_N15
\TLC|state.FGF\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|state~21_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.FGF~q\);

-- Location: LCCOMB_X22_Y19_N22
\TLC|Selector5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector5~0_combout\ = (\TLC|state.FGF~q\) # ((\TLC|state.FGFW~q\ & !\TT|LessThan0~12_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLC|state.FGF~q\,
	datac => \TLC|state.FGFW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|Selector5~0_combout\);

-- Location: FF_X22_Y19_N23
\TLC|state.FGFW\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|Selector5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.FGFW~q\);

-- Location: LCCOMB_X22_Y19_N4
\TLC|WideOr11~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr11~1_combout\ = (!\TLC|state.FAW~q\ & (!\TLC|state.MAW~q\ & (!\TLC|state.FGFW~q\ & \TLC|state.Init~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FAW~q\,
	datab => \TLC|state.MAW~q\,
	datac => \TLC|state.FGFW~q\,
	datad => \TLC|state.Init~q\,
	combout => \TLC|WideOr11~1_combout\);

-- Location: LCCOMB_X23_Y19_N4
\TLC|state~19\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|state~19_combout\ = (!\TLC|state.Init~q\ & ((\major_sensor~input_o\) # (!\minor_sensor~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.Init~q\,
	datab => \minor_sensor~input_o\,
	datad => \major_sensor~input_o\,
	combout => \TLC|state~19_combout\);

-- Location: FF_X23_Y19_N5
\TLC|state.MG\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|state~19_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.MG~q\);

-- Location: LCCOMB_X23_Y21_N2
\T5|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~0_combout\ = (\T5|current_count\(0) & (\T5|current_count\(1) $ (VCC))) # (!\T5|current_count\(0) & (\T5|current_count\(1) & VCC))
-- \T5|Add0~1\ = CARRY((\T5|current_count\(0) & \T5|current_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(0),
	datab => \T5|current_count\(1),
	datad => VCC,
	combout => \T5|Add0~0_combout\,
	cout => \T5|Add0~1\);

-- Location: FF_X23_Y21_N3
\T5|current_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~0_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(1));

-- Location: LCCOMB_X23_Y21_N4
\T5|Add0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~2_combout\ = (\T5|current_count\(2) & (!\T5|Add0~1\)) # (!\T5|current_count\(2) & ((\T5|Add0~1\) # (GND)))
-- \T5|Add0~3\ = CARRY((!\T5|Add0~1\) # (!\T5|current_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(2),
	datad => VCC,
	cin => \T5|Add0~1\,
	combout => \T5|Add0~2_combout\,
	cout => \T5|Add0~3\);

-- Location: FF_X23_Y21_N5
\T5|current_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~2_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(2));

-- Location: LCCOMB_X23_Y21_N6
\T5|Add0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~4_combout\ = (\T5|current_count\(3) & (\T5|Add0~3\ $ (GND))) # (!\T5|current_count\(3) & (!\T5|Add0~3\ & VCC))
-- \T5|Add0~5\ = CARRY((\T5|current_count\(3) & !\T5|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(3),
	datad => VCC,
	cin => \T5|Add0~3\,
	combout => \T5|Add0~4_combout\,
	cout => \T5|Add0~5\);

-- Location: LCCOMB_X23_Y21_N8
\T5|Add0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~6_combout\ = (\T5|current_count\(4) & (!\T5|Add0~5\)) # (!\T5|current_count\(4) & ((\T5|Add0~5\) # (GND)))
-- \T5|Add0~7\ = CARRY((!\T5|Add0~5\) # (!\T5|current_count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(4),
	datad => VCC,
	cin => \T5|Add0~5\,
	combout => \T5|Add0~6_combout\,
	cout => \T5|Add0~7\);

-- Location: FF_X23_Y21_N9
\T5|current_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~6_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(4));

-- Location: LCCOMB_X23_Y21_N10
\T5|Add0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~8_combout\ = (\T5|current_count\(5) & (\T5|Add0~7\ $ (GND))) # (!\T5|current_count\(5) & (!\T5|Add0~7\ & VCC))
-- \T5|Add0~9\ = CARRY((\T5|current_count\(5) & !\T5|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(5),
	datad => VCC,
	cin => \T5|Add0~7\,
	combout => \T5|Add0~8_combout\,
	cout => \T5|Add0~9\);

-- Location: LCCOMB_X23_Y21_N12
\T5|Add0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~10_combout\ = (\T5|current_count\(6) & (!\T5|Add0~9\)) # (!\T5|current_count\(6) & ((\T5|Add0~9\) # (GND)))
-- \T5|Add0~11\ = CARRY((!\T5|Add0~9\) # (!\T5|current_count\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(6),
	datad => VCC,
	cin => \T5|Add0~9\,
	combout => \T5|Add0~10_combout\,
	cout => \T5|Add0~11\);

-- Location: LCCOMB_X23_Y21_N14
\T5|Add0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~12_combout\ = (\T5|current_count\(7) & (\T5|Add0~11\ $ (GND))) # (!\T5|current_count\(7) & (!\T5|Add0~11\ & VCC))
-- \T5|Add0~13\ = CARRY((\T5|current_count\(7) & !\T5|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(7),
	datad => VCC,
	cin => \T5|Add0~11\,
	combout => \T5|Add0~12_combout\,
	cout => \T5|Add0~13\);

-- Location: FF_X23_Y21_N15
\T5|current_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~12_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(7));

-- Location: LCCOMB_X23_Y21_N16
\T5|Add0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~14_combout\ = (\T5|current_count\(8) & (!\T5|Add0~13\)) # (!\T5|current_count\(8) & ((\T5|Add0~13\) # (GND)))
-- \T5|Add0~15\ = CARRY((!\T5|Add0~13\) # (!\T5|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(8),
	datad => VCC,
	cin => \T5|Add0~13\,
	combout => \T5|Add0~14_combout\,
	cout => \T5|Add0~15\);

-- Location: FF_X23_Y21_N17
\T5|current_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~14_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(8));

-- Location: LCCOMB_X23_Y21_N18
\T5|Add0~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~16_combout\ = (\T5|current_count\(9) & (\T5|Add0~15\ $ (GND))) # (!\T5|current_count\(9) & (!\T5|Add0~15\ & VCC))
-- \T5|Add0~17\ = CARRY((\T5|current_count\(9) & !\T5|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(9),
	datad => VCC,
	cin => \T5|Add0~15\,
	combout => \T5|Add0~16_combout\,
	cout => \T5|Add0~17\);

-- Location: FF_X23_Y21_N19
\T5|current_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~16_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(9));

-- Location: LCCOMB_X23_Y21_N20
\T5|Add0~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~18_combout\ = (\T5|current_count\(10) & (!\T5|Add0~17\)) # (!\T5|current_count\(10) & ((\T5|Add0~17\) # (GND)))
-- \T5|Add0~19\ = CARRY((!\T5|Add0~17\) # (!\T5|current_count\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(10),
	datad => VCC,
	cin => \T5|Add0~17\,
	combout => \T5|Add0~18_combout\,
	cout => \T5|Add0~19\);

-- Location: FF_X23_Y21_N21
\T5|current_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~18_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(10));

-- Location: LCCOMB_X23_Y21_N22
\T5|Add0~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~20_combout\ = (\T5|current_count\(11) & (\T5|Add0~19\ $ (GND))) # (!\T5|current_count\(11) & (!\T5|Add0~19\ & VCC))
-- \T5|Add0~21\ = CARRY((\T5|current_count\(11) & !\T5|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(11),
	datad => VCC,
	cin => \T5|Add0~19\,
	combout => \T5|Add0~20_combout\,
	cout => \T5|Add0~21\);

-- Location: LCCOMB_X23_Y21_N24
\T5|Add0~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~22_combout\ = (\T5|current_count\(12) & (!\T5|Add0~21\)) # (!\T5|current_count\(12) & ((\T5|Add0~21\) # (GND)))
-- \T5|Add0~23\ = CARRY((!\T5|Add0~21\) # (!\T5|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(12),
	datad => VCC,
	cin => \T5|Add0~21\,
	combout => \T5|Add0~22_combout\,
	cout => \T5|Add0~23\);

-- Location: FF_X23_Y21_N25
\T5|current_count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~22_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(12));

-- Location: LCCOMB_X23_Y21_N28
\T5|Add0~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~26_combout\ = (\T5|current_count\(14) & (!\T5|Add0~25\)) # (!\T5|current_count\(14) & ((\T5|Add0~25\) # (GND)))
-- \T5|Add0~27\ = CARRY((!\T5|Add0~25\) # (!\T5|current_count\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(14),
	datad => VCC,
	cin => \T5|Add0~25\,
	combout => \T5|Add0~26_combout\,
	cout => \T5|Add0~27\);

-- Location: FF_X23_Y21_N29
\T5|current_count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~26_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(14));

-- Location: LCCOMB_X23_Y21_N30
\T5|Add0~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~28_combout\ = (\T5|current_count\(15) & (\T5|Add0~27\ $ (GND))) # (!\T5|current_count\(15) & (!\T5|Add0~27\ & VCC))
-- \T5|Add0~29\ = CARRY((\T5|current_count\(15) & !\T5|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(15),
	datad => VCC,
	cin => \T5|Add0~27\,
	combout => \T5|Add0~28_combout\,
	cout => \T5|Add0~29\);

-- Location: LCCOMB_X23_Y20_N0
\T5|Add0~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~30_combout\ = (\T5|current_count\(16) & (!\T5|Add0~29\)) # (!\T5|current_count\(16) & ((\T5|Add0~29\) # (GND)))
-- \T5|Add0~31\ = CARRY((!\T5|Add0~29\) # (!\T5|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(16),
	datad => VCC,
	cin => \T5|Add0~29\,
	combout => \T5|Add0~30_combout\,
	cout => \T5|Add0~31\);

-- Location: FF_X23_Y20_N1
\T5|current_count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~30_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(16));

-- Location: LCCOMB_X23_Y20_N2
\T5|Add0~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~32_combout\ = (\T5|current_count\(17) & (\T5|Add0~31\ $ (GND))) # (!\T5|current_count\(17) & (!\T5|Add0~31\ & VCC))
-- \T5|Add0~33\ = CARRY((\T5|current_count\(17) & !\T5|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(17),
	datad => VCC,
	cin => \T5|Add0~31\,
	combout => \T5|Add0~32_combout\,
	cout => \T5|Add0~33\);

-- Location: FF_X23_Y20_N3
\T5|current_count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~32_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(17));

-- Location: LCCOMB_X23_Y20_N4
\T5|Add0~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~34_combout\ = (\T5|current_count\(18) & (!\T5|Add0~33\)) # (!\T5|current_count\(18) & ((\T5|Add0~33\) # (GND)))
-- \T5|Add0~35\ = CARRY((!\T5|Add0~33\) # (!\T5|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(18),
	datad => VCC,
	cin => \T5|Add0~33\,
	combout => \T5|Add0~34_combout\,
	cout => \T5|Add0~35\);

-- Location: FF_X23_Y20_N5
\T5|current_count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~34_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(18));

-- Location: LCCOMB_X23_Y20_N6
\T5|Add0~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~36_combout\ = (\T5|current_count\(19) & (\T5|Add0~35\ $ (GND))) # (!\T5|current_count\(19) & (!\T5|Add0~35\ & VCC))
-- \T5|Add0~37\ = CARRY((\T5|current_count\(19) & !\T5|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(19),
	datad => VCC,
	cin => \T5|Add0~35\,
	combout => \T5|Add0~36_combout\,
	cout => \T5|Add0~37\);

-- Location: LCCOMB_X23_Y20_N8
\T5|Add0~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~38_combout\ = (\T5|current_count\(20) & (!\T5|Add0~37\)) # (!\T5|current_count\(20) & ((\T5|Add0~37\) # (GND)))
-- \T5|Add0~39\ = CARRY((!\T5|Add0~37\) # (!\T5|current_count\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(20),
	datad => VCC,
	cin => \T5|Add0~37\,
	combout => \T5|Add0~38_combout\,
	cout => \T5|Add0~39\);

-- Location: FF_X23_Y20_N9
\T5|current_count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~38_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(20));

-- Location: LCCOMB_X23_Y20_N10
\T5|Add0~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~40_combout\ = (\T5|current_count\(21) & (\T5|Add0~39\ $ (GND))) # (!\T5|current_count\(21) & (!\T5|Add0~39\ & VCC))
-- \T5|Add0~41\ = CARRY((\T5|current_count\(21) & !\T5|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(21),
	datad => VCC,
	cin => \T5|Add0~39\,
	combout => \T5|Add0~40_combout\,
	cout => \T5|Add0~41\);

-- Location: LCCOMB_X23_Y20_N12
\T5|Add0~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~42_combout\ = (\T5|current_count\(22) & (!\T5|Add0~41\)) # (!\T5|current_count\(22) & ((\T5|Add0~41\) # (GND)))
-- \T5|Add0~43\ = CARRY((!\T5|Add0~41\) # (!\T5|current_count\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(22),
	datad => VCC,
	cin => \T5|Add0~41\,
	combout => \T5|Add0~42_combout\,
	cout => \T5|Add0~43\);

-- Location: LCCOMB_X23_Y20_N14
\T5|Add0~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~44_combout\ = (\T5|current_count\(23) & (\T5|Add0~43\ $ (GND))) # (!\T5|current_count\(23) & (!\T5|Add0~43\ & VCC))
-- \T5|Add0~45\ = CARRY((\T5|current_count\(23) & !\T5|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(23),
	datad => VCC,
	cin => \T5|Add0~43\,
	combout => \T5|Add0~44_combout\,
	cout => \T5|Add0~45\);

-- Location: FF_X23_Y20_N15
\T5|current_count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~44_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(23));

-- Location: LCCOMB_X23_Y20_N16
\T5|Add0~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~46_combout\ = (\T5|current_count\(24) & (!\T5|Add0~45\)) # (!\T5|current_count\(24) & ((\T5|Add0~45\) # (GND)))
-- \T5|Add0~47\ = CARRY((!\T5|Add0~45\) # (!\T5|current_count\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(24),
	datad => VCC,
	cin => \T5|Add0~45\,
	combout => \T5|Add0~46_combout\,
	cout => \T5|Add0~47\);

-- Location: FF_X23_Y20_N17
\T5|current_count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~46_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(24));

-- Location: LCCOMB_X23_Y20_N18
\T5|Add0~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~48_combout\ = (\T5|current_count\(25) & (\T5|Add0~47\ $ (GND))) # (!\T5|current_count\(25) & (!\T5|Add0~47\ & VCC))
-- \T5|Add0~49\ = CARRY((\T5|current_count\(25) & !\T5|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(25),
	datad => VCC,
	cin => \T5|Add0~47\,
	combout => \T5|Add0~48_combout\,
	cout => \T5|Add0~49\);

-- Location: FF_X23_Y20_N19
\T5|current_count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~48_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(25));

-- Location: LCCOMB_X23_Y20_N20
\T5|Add0~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~50_combout\ = (\T5|current_count\(26) & (!\T5|Add0~49\)) # (!\T5|current_count\(26) & ((\T5|Add0~49\) # (GND)))
-- \T5|Add0~51\ = CARRY((!\T5|Add0~49\) # (!\T5|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(26),
	datad => VCC,
	cin => \T5|Add0~49\,
	combout => \T5|Add0~50_combout\,
	cout => \T5|Add0~51\);

-- Location: FF_X23_Y20_N21
\T5|current_count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~50_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(26));

-- Location: LCCOMB_X22_Y20_N0
\TLC|process_0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~12_combout\ = (\T5|current_count\(27) & (\T5|current_count\(25) & (\T5|current_count\(26) & \T5|current_count\(24))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(27),
	datab => \T5|current_count\(25),
	datac => \T5|current_count\(26),
	datad => \T5|current_count\(24),
	combout => \TLC|process_0~12_combout\);

-- Location: FF_X23_Y20_N7
\T5|current_count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~36_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(19));

-- Location: LCCOMB_X23_Y20_N22
\T5|Add0~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~52_combout\ = (\T5|current_count\(27) & (\T5|Add0~51\ $ (GND))) # (!\T5|current_count\(27) & (!\T5|Add0~51\ & VCC))
-- \T5|Add0~53\ = CARRY((\T5|current_count\(27) & !\T5|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(27),
	datad => VCC,
	cin => \T5|Add0~51\,
	combout => \T5|Add0~52_combout\,
	cout => \T5|Add0~53\);

-- Location: FF_X23_Y20_N23
\T5|current_count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~52_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(27));

-- Location: LCCOMB_X22_Y21_N14
\TLC|process_0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~1_combout\ = (\T5|current_count\(25) & (\T5|current_count\(27) & \T5|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(25),
	datac => \T5|current_count\(27),
	datad => \T5|current_count\(26),
	combout => \TLC|process_0~1_combout\);

-- Location: FF_X23_Y20_N13
\T5|current_count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~42_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(22));

-- Location: FF_X23_Y20_N11
\T5|current_count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~40_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(21));

-- Location: LCCOMB_X22_Y21_N18
\TLC|process_0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~2_combout\ = (\T5|current_count\(23) & (\TLC|process_0~1_combout\ & (\T5|current_count\(22) & \T5|current_count\(21))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(23),
	datab => \TLC|process_0~1_combout\,
	datac => \T5|current_count\(22),
	datad => \T5|current_count\(21),
	combout => \TLC|process_0~2_combout\);

-- Location: LCCOMB_X22_Y21_N22
\TLC|process_0~13\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~13_combout\ = (\TLC|process_0~2_combout\ & ((\T5|current_count\(20)) # (\T5|current_count\(19))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(20),
	datac => \T5|current_count\(19),
	datad => \TLC|process_0~2_combout\,
	combout => \TLC|process_0~13_combout\);

-- Location: FF_X23_Y21_N11
\T5|current_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~8_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(5));

-- Location: FF_X23_Y21_N13
\T5|current_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~10_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(6));

-- Location: LCCOMB_X22_Y21_N24
\T5|current_count[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|current_count[0]~0_combout\ = !\T5|current_count\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \T5|current_count\(0),
	combout => \T5|current_count[0]~0_combout\);

-- Location: FF_X22_Y21_N25
\T5|current_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|current_count[0]~0_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(0));

-- Location: FF_X23_Y21_N7
\T5|current_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~4_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(3));

-- Location: LCCOMB_X22_Y21_N0
\TLC|process_0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~4_combout\ = (\T5|current_count\(2)) # ((\T5|current_count\(0)) # ((\T5|current_count\(3)) # (\T5|current_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(2),
	datab => \T5|current_count\(0),
	datac => \T5|current_count\(3),
	datad => \T5|current_count\(1),
	combout => \TLC|process_0~4_combout\);

-- Location: LCCOMB_X22_Y21_N28
\TLC|process_0~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~5_combout\ = (\T5|current_count\(4)) # ((\T5|current_count\(5)) # ((\T5|current_count\(6)) # (\TLC|process_0~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(4),
	datab => \T5|current_count\(5),
	datac => \T5|current_count\(6),
	datad => \TLC|process_0~4_combout\,
	combout => \TLC|process_0~5_combout\);

-- Location: LCCOMB_X22_Y21_N30
\TLC|process_0~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~7_combout\ = (\TLC|process_0~6_combout\ & (\T5|current_count\(9) & (\T5|current_count\(7) & \TLC|process_0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|process_0~6_combout\,
	datab => \T5|current_count\(9),
	datac => \T5|current_count\(7),
	datad => \TLC|process_0~5_combout\,
	combout => \TLC|process_0~7_combout\);

-- Location: FF_X23_Y21_N31
\T5|current_count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~28_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(15));

-- Location: LCCOMB_X22_Y21_N8
\TLC|process_0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~8_combout\ = (\T5|current_count\(10)) # ((\T5|current_count\(9) & \T5|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(9),
	datac => \T5|current_count\(10),
	datad => \T5|current_count\(8),
	combout => \TLC|process_0~8_combout\);

-- Location: FF_X23_Y21_N23
\T5|current_count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~20_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(11));

-- Location: LCCOMB_X22_Y21_N12
\TLC|process_0~9\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~9_combout\ = (\T5|current_count\(13) & (\T5|current_count\(12) & ((\TLC|process_0~8_combout\) # (\T5|current_count\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(13),
	datab => \T5|current_count\(12),
	datac => \TLC|process_0~8_combout\,
	datad => \T5|current_count\(11),
	combout => \TLC|process_0~9_combout\);

-- Location: LCCOMB_X22_Y21_N16
\TLC|process_0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~10_combout\ = (\T5|current_count\(16)) # ((\T5|current_count\(15) & ((\T5|current_count\(14)) # (\TLC|process_0~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(14),
	datab => \T5|current_count\(16),
	datac => \T5|current_count\(15),
	datad => \TLC|process_0~9_combout\,
	combout => \TLC|process_0~10_combout\);

-- Location: LCCOMB_X22_Y21_N2
\TLC|process_0~11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~11_combout\ = (\TLC|process_0~3_combout\ & (\TLC|process_0~2_combout\ & ((\TLC|process_0~7_combout\) # (\TLC|process_0~10_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|process_0~3_combout\,
	datab => \TLC|process_0~2_combout\,
	datac => \TLC|process_0~7_combout\,
	datad => \TLC|process_0~10_combout\,
	combout => \TLC|process_0~11_combout\);

-- Location: LCCOMB_X22_Y21_N20
\TLC|process_0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|process_0~14_combout\ = (\TLC|process_0~0_combout\) # ((\TLC|process_0~12_combout\) # ((\TLC|process_0~13_combout\) # (\TLC|process_0~11_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|process_0~0_combout\,
	datab => \TLC|process_0~12_combout\,
	datac => \TLC|process_0~13_combout\,
	datad => \TLC|process_0~11_combout\,
	combout => \TLC|process_0~14_combout\);

-- Location: LCCOMB_X22_Y21_N4
\TLC|Selector0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector0~0_combout\ = (\TLC|state.MG~q\) # ((\TLC|state.MGW~q\ & ((!\TLC|process_0~14_combout\) # (!\TLC|process_0~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|process_0~15_combout\,
	datab => \TLC|state.MG~q\,
	datac => \TLC|state.MGW~q\,
	datad => \TLC|process_0~14_combout\,
	combout => \TLC|Selector0~0_combout\);

-- Location: FF_X22_Y21_N5
\TLC|state.MGW\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|Selector0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.MGW~q\);

-- Location: LCCOMB_X22_Y19_N30
\TLC|WideOr11\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr11~combout\ = (!\TLC|state.MG~q\ & (!\TLC|state.MGFW~q\ & (\TLC|WideOr11~1_combout\ & !\TLC|state.MGW~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MG~q\,
	datab => \TLC|state.MGFW~q\,
	datac => \TLC|WideOr11~1_combout\,
	datad => \TLC|state.MGW~q\,
	combout => \TLC|WideOr11~combout\);

-- Location: LCCOMB_X22_Y19_N26
\TLC|WideOr12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr12~combout\ = (\TLC|state.FAW~q\) # ((\TLC|state.MAW~q\) # ((\TLC|state.MGFW~q\) # (\TLC|state.FGFW~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FAW~q\,
	datab => \TLC|state.MAW~q\,
	datac => \TLC|state.MGFW~q\,
	datad => \TLC|state.FGFW~q\,
	combout => \TLC|WideOr12~combout\);

-- Location: FF_X21_Y18_N3
\TT|current_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~0_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(1));

-- Location: LCCOMB_X21_Y18_N4
\TT|Add0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~2_combout\ = (\TT|current_count\(2) & (!\TT|Add0~1\)) # (!\TT|current_count\(2) & ((\TT|Add0~1\) # (GND)))
-- \TT|Add0~3\ = CARRY((!\TT|Add0~1\) # (!\TT|current_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(2),
	datad => VCC,
	cin => \TT|Add0~1\,
	combout => \TT|Add0~2_combout\,
	cout => \TT|Add0~3\);

-- Location: FF_X21_Y18_N5
\TT|current_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~2_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(2));

-- Location: LCCOMB_X21_Y18_N8
\TT|Add0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~6_combout\ = (\TT|current_count\(4) & (!\TT|Add0~5\)) # (!\TT|current_count\(4) & ((\TT|Add0~5\) # (GND)))
-- \TT|Add0~7\ = CARRY((!\TT|Add0~5\) # (!\TT|current_count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(4),
	datad => VCC,
	cin => \TT|Add0~5\,
	combout => \TT|Add0~6_combout\,
	cout => \TT|Add0~7\);

-- Location: FF_X21_Y18_N9
\TT|current_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~6_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(4));

-- Location: LCCOMB_X21_Y18_N10
\TT|Add0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~8_combout\ = (\TT|current_count\(5) & (\TT|Add0~7\ $ (GND))) # (!\TT|current_count\(5) & (!\TT|Add0~7\ & VCC))
-- \TT|Add0~9\ = CARRY((\TT|current_count\(5) & !\TT|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(5),
	datad => VCC,
	cin => \TT|Add0~7\,
	combout => \TT|Add0~8_combout\,
	cout => \TT|Add0~9\);

-- Location: LCCOMB_X21_Y18_N14
\TT|Add0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~12_combout\ = (\TT|current_count\(7) & (\TT|Add0~11\ $ (GND))) # (!\TT|current_count\(7) & (!\TT|Add0~11\ & VCC))
-- \TT|Add0~13\ = CARRY((\TT|current_count\(7) & !\TT|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(7),
	datad => VCC,
	cin => \TT|Add0~11\,
	combout => \TT|Add0~12_combout\,
	cout => \TT|Add0~13\);

-- Location: FF_X21_Y18_N15
\TT|current_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~12_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(7));

-- Location: LCCOMB_X21_Y18_N16
\TT|Add0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~14_combout\ = (\TT|current_count\(8) & (!\TT|Add0~13\)) # (!\TT|current_count\(8) & ((\TT|Add0~13\) # (GND)))
-- \TT|Add0~15\ = CARRY((!\TT|Add0~13\) # (!\TT|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(8),
	datad => VCC,
	cin => \TT|Add0~13\,
	combout => \TT|Add0~14_combout\,
	cout => \TT|Add0~15\);

-- Location: FF_X21_Y18_N17
\TT|current_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~14_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(8));

-- Location: LCCOMB_X21_Y18_N18
\TT|Add0~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~16_combout\ = (\TT|current_count\(9) & (\TT|Add0~15\ $ (GND))) # (!\TT|current_count\(9) & (!\TT|Add0~15\ & VCC))
-- \TT|Add0~17\ = CARRY((\TT|current_count\(9) & !\TT|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(9),
	datad => VCC,
	cin => \TT|Add0~15\,
	combout => \TT|Add0~16_combout\,
	cout => \TT|Add0~17\);

-- Location: FF_X21_Y18_N19
\TT|current_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~16_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(9));

-- Location: LCCOMB_X21_Y18_N20
\TT|Add0~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~18_combout\ = (\TT|current_count\(10) & (!\TT|Add0~17\)) # (!\TT|current_count\(10) & ((\TT|Add0~17\) # (GND)))
-- \TT|Add0~19\ = CARRY((!\TT|Add0~17\) # (!\TT|current_count\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(10),
	datad => VCC,
	cin => \TT|Add0~17\,
	combout => \TT|Add0~18_combout\,
	cout => \TT|Add0~19\);

-- Location: FF_X21_Y18_N21
\TT|current_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~18_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(10));

-- Location: LCCOMB_X21_Y18_N24
\TT|Add0~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~22_combout\ = (\TT|current_count\(12) & (!\TT|Add0~21\)) # (!\TT|current_count\(12) & ((\TT|Add0~21\) # (GND)))
-- \TT|Add0~23\ = CARRY((!\TT|Add0~21\) # (!\TT|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(12),
	datad => VCC,
	cin => \TT|Add0~21\,
	combout => \TT|Add0~22_combout\,
	cout => \TT|Add0~23\);

-- Location: FF_X21_Y18_N25
\TT|current_count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~22_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(12));

-- Location: LCCOMB_X21_Y18_N26
\TT|Add0~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~24_combout\ = (\TT|current_count\(13) & (\TT|Add0~23\ $ (GND))) # (!\TT|current_count\(13) & (!\TT|Add0~23\ & VCC))
-- \TT|Add0~25\ = CARRY((\TT|current_count\(13) & !\TT|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(13),
	datad => VCC,
	cin => \TT|Add0~23\,
	combout => \TT|Add0~24_combout\,
	cout => \TT|Add0~25\);

-- Location: LCCOMB_X21_Y18_N28
\TT|Add0~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~26_combout\ = (\TT|current_count\(14) & (!\TT|Add0~25\)) # (!\TT|current_count\(14) & ((\TT|Add0~25\) # (GND)))
-- \TT|Add0~27\ = CARRY((!\TT|Add0~25\) # (!\TT|current_count\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(14),
	datad => VCC,
	cin => \TT|Add0~25\,
	combout => \TT|Add0~26_combout\,
	cout => \TT|Add0~27\);

-- Location: FF_X21_Y18_N29
\TT|current_count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~26_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(14));

-- Location: LCCOMB_X21_Y18_N30
\TT|Add0~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~28_combout\ = (\TT|current_count\(15) & (\TT|Add0~27\ $ (GND))) # (!\TT|current_count\(15) & (!\TT|Add0~27\ & VCC))
-- \TT|Add0~29\ = CARRY((\TT|current_count\(15) & !\TT|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(15),
	datad => VCC,
	cin => \TT|Add0~27\,
	combout => \TT|Add0~28_combout\,
	cout => \TT|Add0~29\);

-- Location: LCCOMB_X21_Y17_N0
\TT|Add0~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~30_combout\ = (\TT|current_count\(16) & (!\TT|Add0~29\)) # (!\TT|current_count\(16) & ((\TT|Add0~29\) # (GND)))
-- \TT|Add0~31\ = CARRY((!\TT|Add0~29\) # (!\TT|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(16),
	datad => VCC,
	cin => \TT|Add0~29\,
	combout => \TT|Add0~30_combout\,
	cout => \TT|Add0~31\);

-- Location: FF_X21_Y17_N1
\TT|current_count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~30_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(16));

-- Location: LCCOMB_X21_Y17_N2
\TT|Add0~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~32_combout\ = (\TT|current_count\(17) & (\TT|Add0~31\ $ (GND))) # (!\TT|current_count\(17) & (!\TT|Add0~31\ & VCC))
-- \TT|Add0~33\ = CARRY((\TT|current_count\(17) & !\TT|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(17),
	datad => VCC,
	cin => \TT|Add0~31\,
	combout => \TT|Add0~32_combout\,
	cout => \TT|Add0~33\);

-- Location: FF_X21_Y17_N3
\TT|current_count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~32_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(17));

-- Location: LCCOMB_X21_Y17_N4
\TT|Add0~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~34_combout\ = (\TT|current_count\(18) & (!\TT|Add0~33\)) # (!\TT|current_count\(18) & ((\TT|Add0~33\) # (GND)))
-- \TT|Add0~35\ = CARRY((!\TT|Add0~33\) # (!\TT|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(18),
	datad => VCC,
	cin => \TT|Add0~33\,
	combout => \TT|Add0~34_combout\,
	cout => \TT|Add0~35\);

-- Location: FF_X21_Y17_N5
\TT|current_count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~34_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(18));

-- Location: LCCOMB_X21_Y17_N6
\TT|Add0~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~36_combout\ = (\TT|current_count\(19) & (\TT|Add0~35\ $ (GND))) # (!\TT|current_count\(19) & (!\TT|Add0~35\ & VCC))
-- \TT|Add0~37\ = CARRY((\TT|current_count\(19) & !\TT|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(19),
	datad => VCC,
	cin => \TT|Add0~35\,
	combout => \TT|Add0~36_combout\,
	cout => \TT|Add0~37\);

-- Location: LCCOMB_X21_Y17_N8
\TT|Add0~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~38_combout\ = (\TT|current_count\(20) & (!\TT|Add0~37\)) # (!\TT|current_count\(20) & ((\TT|Add0~37\) # (GND)))
-- \TT|Add0~39\ = CARRY((!\TT|Add0~37\) # (!\TT|current_count\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(20),
	datad => VCC,
	cin => \TT|Add0~37\,
	combout => \TT|Add0~38_combout\,
	cout => \TT|Add0~39\);

-- Location: FF_X21_Y17_N9
\TT|current_count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~38_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(20));

-- Location: LCCOMB_X21_Y17_N10
\TT|Add0~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~40_combout\ = (\TT|current_count\(21) & (\TT|Add0~39\ $ (GND))) # (!\TT|current_count\(21) & (!\TT|Add0~39\ & VCC))
-- \TT|Add0~41\ = CARRY((\TT|current_count\(21) & !\TT|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(21),
	datad => VCC,
	cin => \TT|Add0~39\,
	combout => \TT|Add0~40_combout\,
	cout => \TT|Add0~41\);

-- Location: FF_X21_Y17_N11
\TT|current_count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~40_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(21));

-- Location: LCCOMB_X21_Y17_N12
\TT|Add0~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~42_combout\ = (\TT|current_count\(22) & (!\TT|Add0~41\)) # (!\TT|current_count\(22) & ((\TT|Add0~41\) # (GND)))
-- \TT|Add0~43\ = CARRY((!\TT|Add0~41\) # (!\TT|current_count\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(22),
	datad => VCC,
	cin => \TT|Add0~41\,
	combout => \TT|Add0~42_combout\,
	cout => \TT|Add0~43\);

-- Location: LCCOMB_X21_Y17_N14
\TT|Add0~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~44_combout\ = (\TT|current_count\(23) & (\TT|Add0~43\ $ (GND))) # (!\TT|current_count\(23) & (!\TT|Add0~43\ & VCC))
-- \TT|Add0~45\ = CARRY((\TT|current_count\(23) & !\TT|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(23),
	datad => VCC,
	cin => \TT|Add0~43\,
	combout => \TT|Add0~44_combout\,
	cout => \TT|Add0~45\);

-- Location: FF_X21_Y17_N15
\TT|current_count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~44_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(23));

-- Location: LCCOMB_X21_Y17_N16
\TT|Add0~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~46_combout\ = (\TT|current_count\(24) & (!\TT|Add0~45\)) # (!\TT|current_count\(24) & ((\TT|Add0~45\) # (GND)))
-- \TT|Add0~47\ = CARRY((!\TT|Add0~45\) # (!\TT|current_count\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(24),
	datad => VCC,
	cin => \TT|Add0~45\,
	combout => \TT|Add0~46_combout\,
	cout => \TT|Add0~47\);

-- Location: FF_X21_Y17_N17
\TT|current_count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~46_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(24));

-- Location: LCCOMB_X21_Y17_N18
\TT|Add0~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~48_combout\ = (\TT|current_count\(25) & (\TT|Add0~47\ $ (GND))) # (!\TT|current_count\(25) & (!\TT|Add0~47\ & VCC))
-- \TT|Add0~49\ = CARRY((\TT|current_count\(25) & !\TT|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(25),
	datad => VCC,
	cin => \TT|Add0~47\,
	combout => \TT|Add0~48_combout\,
	cout => \TT|Add0~49\);

-- Location: FF_X21_Y17_N19
\TT|current_count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~48_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(25));

-- Location: LCCOMB_X21_Y17_N20
\TT|Add0~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~50_combout\ = (\TT|current_count\(26) & (!\TT|Add0~49\)) # (!\TT|current_count\(26) & ((\TT|Add0~49\) # (GND)))
-- \TT|Add0~51\ = CARRY((!\TT|Add0~49\) # (!\TT|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(26),
	datad => VCC,
	cin => \TT|Add0~49\,
	combout => \TT|Add0~50_combout\,
	cout => \TT|Add0~51\);

-- Location: FF_X21_Y17_N21
\TT|current_count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~50_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(26));

-- Location: LCCOMB_X21_Y17_N22
\TT|Add0~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~52_combout\ = (\TT|current_count\(27) & (\TT|Add0~51\ $ (GND))) # (!\TT|current_count\(27) & (!\TT|Add0~51\ & VCC))
-- \TT|Add0~53\ = CARRY((\TT|current_count\(27) & !\TT|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(27),
	datad => VCC,
	cin => \TT|Add0~51\,
	combout => \TT|Add0~52_combout\,
	cout => \TT|Add0~53\);

-- Location: LCCOMB_X21_Y17_N24
\TT|Add0~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~54_combout\ = (\TT|current_count\(28) & (!\TT|Add0~53\)) # (!\TT|current_count\(28) & ((\TT|Add0~53\) # (GND)))
-- \TT|Add0~55\ = CARRY((!\TT|Add0~53\) # (!\TT|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(28),
	datad => VCC,
	cin => \TT|Add0~53\,
	combout => \TT|Add0~54_combout\,
	cout => \TT|Add0~55\);

-- Location: FF_X21_Y17_N25
\TT|current_count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~54_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(28));

-- Location: LCCOMB_X21_Y17_N28
\TT|Add0~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~58_combout\ = (\TT|current_count\(30) & (!\TT|Add0~57\)) # (!\TT|current_count\(30) & ((\TT|Add0~57\) # (GND)))
-- \TT|Add0~59\ = CARRY((!\TT|Add0~57\) # (!\TT|current_count\(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TT|current_count\(30),
	datad => VCC,
	cin => \TT|Add0~57\,
	combout => \TT|Add0~58_combout\,
	cout => \TT|Add0~59\);

-- Location: FF_X21_Y17_N29
\TT|current_count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~58_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(30));

-- Location: LCCOMB_X21_Y17_N30
\TT|Add0~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|Add0~60_combout\ = \TT|current_count\(31) $ (!\TT|Add0~59\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(31),
	cin => \TT|Add0~59\,
	combout => \TT|Add0~60_combout\);

-- Location: FF_X21_Y17_N31
\TT|current_count[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~60_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(31));

-- Location: FF_X21_Y17_N7
\TT|current_count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~36_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(19));

-- Location: LCCOMB_X22_Y18_N22
\TT|LessThan0~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~3_combout\ = (\TT|current_count\(25) & (!\TT|current_count\(31) & (\TT|current_count\(19) & \TT|current_count\(20))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(25),
	datab => \TT|current_count\(31),
	datac => \TT|current_count\(19),
	datad => \TT|current_count\(20),
	combout => \TT|LessThan0~3_combout\);

-- Location: FF_X21_Y17_N13
\TT|current_count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~42_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(22));

-- Location: LCCOMB_X22_Y18_N16
\TT|LessThan0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~4_combout\ = (\TT|current_count\(23) & (\TT|current_count\(21) & (\TT|LessThan0~3_combout\ & \TT|current_count\(22))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(23),
	datab => \TT|current_count\(21),
	datac => \TT|LessThan0~3_combout\,
	datad => \TT|current_count\(22),
	combout => \TT|LessThan0~4_combout\);

-- Location: LCCOMB_X22_Y18_N8
\TT|LessThan0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~0_combout\ = (!\TT|current_count\(31) & ((\TT|current_count\(26)) # ((\TT|current_count\(25) & \TT|current_count\(24)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(26),
	datab => \TT|current_count\(31),
	datac => \TT|current_count\(25),
	datad => \TT|current_count\(24),
	combout => \TT|LessThan0~0_combout\);

-- Location: FF_X21_Y17_N23
\TT|current_count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~52_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(27));

-- Location: LCCOMB_X22_Y18_N10
\TT|LessThan0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~1_combout\ = (!\TT|current_count\(31) & ((\TT|current_count\(29)) # ((\TT|current_count\(28)) # (\TT|current_count\(27)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(29),
	datab => \TT|current_count\(31),
	datac => \TT|current_count\(28),
	datad => \TT|current_count\(27),
	combout => \TT|LessThan0~1_combout\);

-- Location: LCCOMB_X22_Y18_N4
\TT|LessThan0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~2_combout\ = (\TT|LessThan0~0_combout\) # ((\TT|LessThan0~1_combout\) # ((\TT|current_count\(30) & !\TT|current_count\(31))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(30),
	datab => \TT|current_count\(31),
	datac => \TT|LessThan0~0_combout\,
	datad => \TT|LessThan0~1_combout\,
	combout => \TT|LessThan0~2_combout\);

-- Location: FF_X21_Y18_N31
\TT|current_count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~28_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(15));

-- Location: FF_X21_Y18_N27
\TT|current_count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~24_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(13));

-- Location: LCCOMB_X22_Y18_N20
\TT|LessThan0~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~7_combout\ = (\TT|current_count\(12) & (\TT|current_count\(15) & (\TT|current_count\(13) & \TT|current_count\(14))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(12),
	datab => \TT|current_count\(15),
	datac => \TT|current_count\(13),
	datad => \TT|current_count\(14),
	combout => \TT|LessThan0~7_combout\);

-- Location: LCCOMB_X21_Y19_N24
\TT|current_count[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|current_count[0]~0_combout\ = !\TT|current_count\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TT|current_count\(0),
	combout => \TT|current_count[0]~0_combout\);

-- Location: FF_X21_Y19_N25
\TT|current_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|current_count[0]~0_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(0));

-- Location: LCCOMB_X21_Y18_N0
\TT|LessThan0~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~5_combout\ = (\TT|current_count\(3)) # ((\TT|current_count\(1)) # ((\TT|current_count\(2)) # (\TT|current_count\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(3),
	datab => \TT|current_count\(1),
	datac => \TT|current_count\(2),
	datad => \TT|current_count\(0),
	combout => \TT|LessThan0~5_combout\);

-- Location: FF_X21_Y18_N11
\TT|current_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \TT|Add0~8_combout\,
	clrn => \TLC|ALT_INV_WideOr11~combout\,
	ena => \TLC|WideOr12~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TT|current_count\(5));

-- Location: LCCOMB_X22_Y18_N18
\TT|LessThan0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~6_combout\ = (\TT|current_count\(6)) # ((\TT|current_count\(4)) # ((\TT|LessThan0~5_combout\) # (\TT|current_count\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(6),
	datab => \TT|current_count\(4),
	datac => \TT|LessThan0~5_combout\,
	datad => \TT|current_count\(5),
	combout => \TT|LessThan0~6_combout\);

-- Location: LCCOMB_X22_Y18_N6
\TT|LessThan0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~8_combout\ = (\TT|current_count\(7) & (\TT|LessThan0~7_combout\ & (\TT|current_count\(17) & \TT|LessThan0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|current_count\(7),
	datab => \TT|LessThan0~7_combout\,
	datac => \TT|current_count\(17),
	datad => \TT|LessThan0~6_combout\,
	combout => \TT|LessThan0~8_combout\);

-- Location: LCCOMB_X22_Y18_N30
\TT|LessThan0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TT|LessThan0~12_combout\ = (\TT|LessThan0~2_combout\) # ((\TT|LessThan0~4_combout\ & ((\TT|LessThan0~11_combout\) # (\TT|LessThan0~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TT|LessThan0~11_combout\,
	datab => \TT|LessThan0~4_combout\,
	datac => \TT|LessThan0~2_combout\,
	datad => \TT|LessThan0~8_combout\,
	combout => \TT|LessThan0~12_combout\);

-- Location: LCCOMB_X23_Y19_N16
\TLC|state~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|state~20_combout\ = (\TLC|state.MGFW~q\ & \TT|LessThan0~12_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MGFW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|state~20_combout\);

-- Location: FF_X23_Y19_N17
\TLC|state.MA\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|state~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.MA~q\);

-- Location: LCCOMB_X22_Y19_N18
\TLC|Selector2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|Selector2~0_combout\ = (\TLC|state.MA~q\) # ((\TLC|state.MAW~q\ & !\TT|LessThan0~12_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLC|state.MA~q\,
	datac => \TLC|state.MAW~q\,
	datad => \TT|LessThan0~12_combout\,
	combout => \TLC|Selector2~0_combout\);

-- Location: FF_X22_Y19_N19
\TLC|state.MAW\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|Selector2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.MAW~q\);

-- Location: LCCOMB_X22_Y19_N20
\TLC|WideOr8~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr8~0_combout\ = (!\TLC|state.MGF~q\ & (!\TLC|state.MAW~q\ & (!\TLC|state.MGFW~q\ & !\TLC|state.MA~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MGF~q\,
	datab => \TLC|state.MAW~q\,
	datac => \TLC|state.MGFW~q\,
	datad => \TLC|state.MA~q\,
	combout => \TLC|WideOr8~0_combout\);

-- Location: LCCOMB_X22_Y19_N28
\TLC|WideOr7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr7~combout\ = (\TLC|state.MGF~q\) # ((\TLC|state.MGW~q\) # ((\TLC|state.MGFW~q\) # (\TLC|state.MG~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MGF~q\,
	datab => \TLC|state.MGW~q\,
	datac => \TLC|state.MGFW~q\,
	datad => \TLC|state.MG~q\,
	combout => \TLC|WideOr7~combout\);

-- Location: LCCOMB_X23_Y16_N12
\TLDM|Equal1~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|Equal1~1_combout\ = (\TLC|WideOr8~0_combout\ & \TLC|WideOr7~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLC|WideOr8~0_combout\,
	datad => \TLC|WideOr7~combout\,
	combout => \TLDM|Equal1~1_combout\);

-- Location: LCCOMB_X23_Y20_N24
\T5|Add0~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~54_combout\ = (\T5|current_count\(28) & (!\T5|Add0~53\)) # (!\T5|current_count\(28) & ((\T5|Add0~53\) # (GND)))
-- \T5|Add0~55\ = CARRY((!\T5|Add0~53\) # (!\T5|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(28),
	datad => VCC,
	cin => \T5|Add0~53\,
	combout => \T5|Add0~54_combout\,
	cout => \T5|Add0~55\);

-- Location: FF_X23_Y20_N25
\T5|current_count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~54_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(28));

-- Location: LCCOMB_X23_Y20_N28
\T5|Add0~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~58_combout\ = (\T5|current_count\(30) & (!\T5|Add0~57\)) # (!\T5|current_count\(30) & ((\T5|Add0~57\) # (GND)))
-- \T5|Add0~59\ = CARRY((!\T5|Add0~57\) # (!\T5|current_count\(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \T5|current_count\(30),
	datad => VCC,
	cin => \T5|Add0~57\,
	combout => \T5|Add0~58_combout\,
	cout => \T5|Add0~59\);

-- Location: FF_X23_Y20_N29
\T5|current_count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~58_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(30));

-- Location: LCCOMB_X23_Y20_N30
\T5|Add0~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \T5|Add0~60_combout\ = \T5|current_count\(31) $ (!\T5|Add0~59\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \T5|current_count\(31),
	cin => \T5|Add0~59\,
	combout => \T5|Add0~60_combout\);

-- Location: FF_X23_Y20_N31
\T5|current_count[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \T5|Add0~60_combout\,
	clrn => \TLC|ALT_INV_state.MG~q\,
	ena => \TLC|state.MGW~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \T5|current_count\(31));

-- Location: LCCOMB_X22_Y21_N26
\TLC|state~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|state~18_combout\ = (\TLC|state.MGW~q\ & (!\T5|current_count\(31) & (\minor_sensor~input_o\ & \TLC|process_0~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MGW~q\,
	datab => \T5|current_count\(31),
	datac => \minor_sensor~input_o\,
	datad => \TLC|process_0~14_combout\,
	combout => \TLC|state~18_combout\);

-- Location: FF_X22_Y21_N27
\TLC|state.MGF\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLC|state~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLC|state.MGF~q\);

-- Location: LCCOMB_X23_Y19_N22
\TLDM|comb~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|comb~8_combout\ = (!\TLC|state.MGFW~q\ & (!\TLC|state.MGW~q\ & (!\TLC|state.MG~q\ & !\TLC|state.MGF~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MGFW~q\,
	datab => \TLC|state.MGW~q\,
	datac => \TLC|state.MG~q\,
	datad => \TLC|state.MGF~q\,
	combout => \TLDM|comb~8_combout\);

-- Location: LCCOMB_X22_Y14_N16
\TLDM|TT1|current_count[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|current_count[0]~0_combout\ = !\TLDM|TT1|current_count\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLDM|TT1|current_count\(0),
	combout => \TLDM|TT1|current_count[0]~0_combout\);

-- Location: LCCOMB_X22_Y19_N16
\TLC|WideOr11~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr11~0_combout\ = (!\TLC|state.MGW~q\ & (!\TLC|state.MGFW~q\ & !\TLC|state.MG~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLC|state.MGW~q\,
	datac => \TLC|state.MGFW~q\,
	datad => \TLC|state.MG~q\,
	combout => \TLC|WideOr11~0_combout\);

-- Location: LCCOMB_X22_Y19_N12
\TLDM|red_light~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|red_light~0_combout\ = (\TLC|state.MGF~q\) # ((\TLC|state.MAW~q\) # ((\TLC|state.MA~q\) # (!\TLC|WideOr11~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.MGF~q\,
	datab => \TLC|state.MAW~q\,
	datac => \TLC|WideOr11~0_combout\,
	datad => \TLC|state.MA~q\,
	combout => \TLDM|red_light~0_combout\);

-- Location: LCCOMB_X23_Y16_N10
\TLDM|green_light~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|green_light~4_combout\ = (!\TLC|WideOr8~0_combout\ & (\TLC|WideOr7~combout\ & ((\TLDM|green_light~3_combout\) # (\TLDM|TT1|LessThan0~12_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|green_light~3_combout\,
	datab => \TLDM|TT1|LessThan0~12_combout\,
	datac => \TLC|WideOr8~0_combout\,
	datad => \TLC|WideOr7~combout\,
	combout => \TLDM|green_light~4_combout\);

-- Location: LCCOMB_X23_Y16_N0
\TLDM|tt2_reset~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|tt2_reset~0_combout\ = (\TLDM|red_light~0_combout\ & \TLDM|green_light~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLDM|red_light~0_combout\,
	datad => \TLDM|green_light~4_combout\,
	combout => \TLDM|tt2_reset~0_combout\);

-- Location: CLKCTRL_G10
\TLDM|tt2_reset~0clkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \TLDM|tt2_reset~0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \TLDM|tt2_reset~0clkctrl_outclk\);

-- Location: LCCOMB_X37_Y13_N0
\TLDM|tt1_reset\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|tt1_reset~combout\ = (GLOBAL(\TLDM|tt2_reset~0clkctrl_outclk\) & ((\TLDM|TT1|LessThan0~12_combout\))) # (!GLOBAL(\TLDM|tt2_reset~0clkctrl_outclk\) & (\TLDM|tt1_reset~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|tt1_reset~combout\,
	datac => \TLDM|TT1|LessThan0~12_combout\,
	datad => \TLDM|tt2_reset~0clkctrl_outclk\,
	combout => \TLDM|tt1_reset~combout\);

-- Location: LCCOMB_X24_Y13_N0
\TLDM|tt1_enable\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|tt1_enable~combout\ = (GLOBAL(\TLDM|tt2_reset~0clkctrl_outclk\) & (!\TLDM|TT1|LessThan0~12_combout\)) # (!GLOBAL(\TLDM|tt2_reset~0clkctrl_outclk\) & ((\TLDM|tt1_enable~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|LessThan0~12_combout\,
	datac => \TLDM|tt1_enable~combout\,
	datad => \TLDM|tt2_reset~0clkctrl_outclk\,
	combout => \TLDM|tt1_enable~combout\);

-- Location: FF_X23_Y14_N3
\TLDM|TT1|current_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \TLDM|TT1|current_count[0]~0_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	sload => VCC,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(0));

-- Location: LCCOMB_X23_Y14_N2
\TLDM|TT1|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~0_combout\ = (\TLDM|TT1|current_count\(1) & (\TLDM|TT1|current_count\(0) $ (VCC))) # (!\TLDM|TT1|current_count\(1) & (\TLDM|TT1|current_count\(0) & VCC))
-- \TLDM|TT1|Add0~1\ = CARRY((\TLDM|TT1|current_count\(1) & \TLDM|TT1|current_count\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(1),
	datab => \TLDM|TT1|current_count\(0),
	datad => VCC,
	combout => \TLDM|TT1|Add0~0_combout\,
	cout => \TLDM|TT1|Add0~1\);

-- Location: LCCOMB_X23_Y14_N4
\TLDM|TT1|Add0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~2_combout\ = (\TLDM|TT1|current_count\(2) & (!\TLDM|TT1|Add0~1\)) # (!\TLDM|TT1|current_count\(2) & ((\TLDM|TT1|Add0~1\) # (GND)))
-- \TLDM|TT1|Add0~3\ = CARRY((!\TLDM|TT1|Add0~1\) # (!\TLDM|TT1|current_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(2),
	datad => VCC,
	cin => \TLDM|TT1|Add0~1\,
	combout => \TLDM|TT1|Add0~2_combout\,
	cout => \TLDM|TT1|Add0~3\);

-- Location: FF_X23_Y14_N5
\TLDM|TT1|current_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~2_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(2));

-- Location: LCCOMB_X23_Y14_N6
\TLDM|TT1|Add0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~4_combout\ = (\TLDM|TT1|current_count\(3) & (\TLDM|TT1|Add0~3\ $ (GND))) # (!\TLDM|TT1|current_count\(3) & (!\TLDM|TT1|Add0~3\ & VCC))
-- \TLDM|TT1|Add0~5\ = CARRY((\TLDM|TT1|current_count\(3) & !\TLDM|TT1|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(3),
	datad => VCC,
	cin => \TLDM|TT1|Add0~3\,
	combout => \TLDM|TT1|Add0~4_combout\,
	cout => \TLDM|TT1|Add0~5\);

-- Location: LCCOMB_X23_Y14_N8
\TLDM|TT1|Add0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~6_combout\ = (\TLDM|TT1|current_count\(4) & (!\TLDM|TT1|Add0~5\)) # (!\TLDM|TT1|current_count\(4) & ((\TLDM|TT1|Add0~5\) # (GND)))
-- \TLDM|TT1|Add0~7\ = CARRY((!\TLDM|TT1|Add0~5\) # (!\TLDM|TT1|current_count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(4),
	datad => VCC,
	cin => \TLDM|TT1|Add0~5\,
	combout => \TLDM|TT1|Add0~6_combout\,
	cout => \TLDM|TT1|Add0~7\);

-- Location: FF_X23_Y14_N9
\TLDM|TT1|current_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~6_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(4));

-- Location: LCCOMB_X23_Y14_N12
\TLDM|TT1|Add0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~10_combout\ = (\TLDM|TT1|current_count\(6) & (!\TLDM|TT1|Add0~9\)) # (!\TLDM|TT1|current_count\(6) & ((\TLDM|TT1|Add0~9\) # (GND)))
-- \TLDM|TT1|Add0~11\ = CARRY((!\TLDM|TT1|Add0~9\) # (!\TLDM|TT1|current_count\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(6),
	datad => VCC,
	cin => \TLDM|TT1|Add0~9\,
	combout => \TLDM|TT1|Add0~10_combout\,
	cout => \TLDM|TT1|Add0~11\);

-- Location: LCCOMB_X23_Y14_N14
\TLDM|TT1|Add0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~12_combout\ = (\TLDM|TT1|current_count\(7) & (\TLDM|TT1|Add0~11\ $ (GND))) # (!\TLDM|TT1|current_count\(7) & (!\TLDM|TT1|Add0~11\ & VCC))
-- \TLDM|TT1|Add0~13\ = CARRY((\TLDM|TT1|current_count\(7) & !\TLDM|TT1|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(7),
	datad => VCC,
	cin => \TLDM|TT1|Add0~11\,
	combout => \TLDM|TT1|Add0~12_combout\,
	cout => \TLDM|TT1|Add0~13\);

-- Location: FF_X23_Y14_N15
\TLDM|TT1|current_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~12_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(7));

-- Location: LCCOMB_X23_Y14_N16
\TLDM|TT1|Add0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~14_combout\ = (\TLDM|TT1|current_count\(8) & (!\TLDM|TT1|Add0~13\)) # (!\TLDM|TT1|current_count\(8) & ((\TLDM|TT1|Add0~13\) # (GND)))
-- \TLDM|TT1|Add0~15\ = CARRY((!\TLDM|TT1|Add0~13\) # (!\TLDM|TT1|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(8),
	datad => VCC,
	cin => \TLDM|TT1|Add0~13\,
	combout => \TLDM|TT1|Add0~14_combout\,
	cout => \TLDM|TT1|Add0~15\);

-- Location: FF_X23_Y14_N17
\TLDM|TT1|current_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~14_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(8));

-- Location: LCCOMB_X23_Y14_N18
\TLDM|TT1|Add0~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~16_combout\ = (\TLDM|TT1|current_count\(9) & (\TLDM|TT1|Add0~15\ $ (GND))) # (!\TLDM|TT1|current_count\(9) & (!\TLDM|TT1|Add0~15\ & VCC))
-- \TLDM|TT1|Add0~17\ = CARRY((\TLDM|TT1|current_count\(9) & !\TLDM|TT1|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(9),
	datad => VCC,
	cin => \TLDM|TT1|Add0~15\,
	combout => \TLDM|TT1|Add0~16_combout\,
	cout => \TLDM|TT1|Add0~17\);

-- Location: FF_X23_Y14_N19
\TLDM|TT1|current_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~16_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(9));

-- Location: LCCOMB_X23_Y14_N20
\TLDM|TT1|Add0~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~18_combout\ = (\TLDM|TT1|current_count\(10) & (!\TLDM|TT1|Add0~17\)) # (!\TLDM|TT1|current_count\(10) & ((\TLDM|TT1|Add0~17\) # (GND)))
-- \TLDM|TT1|Add0~19\ = CARRY((!\TLDM|TT1|Add0~17\) # (!\TLDM|TT1|current_count\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(10),
	datad => VCC,
	cin => \TLDM|TT1|Add0~17\,
	combout => \TLDM|TT1|Add0~18_combout\,
	cout => \TLDM|TT1|Add0~19\);

-- Location: FF_X23_Y14_N21
\TLDM|TT1|current_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~18_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(10));

-- Location: LCCOMB_X23_Y14_N24
\TLDM|TT1|Add0~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~22_combout\ = (\TLDM|TT1|current_count\(12) & (!\TLDM|TT1|Add0~21\)) # (!\TLDM|TT1|current_count\(12) & ((\TLDM|TT1|Add0~21\) # (GND)))
-- \TLDM|TT1|Add0~23\ = CARRY((!\TLDM|TT1|Add0~21\) # (!\TLDM|TT1|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(12),
	datad => VCC,
	cin => \TLDM|TT1|Add0~21\,
	combout => \TLDM|TT1|Add0~22_combout\,
	cout => \TLDM|TT1|Add0~23\);

-- Location: FF_X23_Y14_N25
\TLDM|TT1|current_count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~22_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(12));

-- Location: LCCOMB_X23_Y14_N28
\TLDM|TT1|Add0~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~26_combout\ = (\TLDM|TT1|current_count\(14) & (!\TLDM|TT1|Add0~25\)) # (!\TLDM|TT1|current_count\(14) & ((\TLDM|TT1|Add0~25\) # (GND)))
-- \TLDM|TT1|Add0~27\ = CARRY((!\TLDM|TT1|Add0~25\) # (!\TLDM|TT1|current_count\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(14),
	datad => VCC,
	cin => \TLDM|TT1|Add0~25\,
	combout => \TLDM|TT1|Add0~26_combout\,
	cout => \TLDM|TT1|Add0~27\);

-- Location: FF_X23_Y14_N29
\TLDM|TT1|current_count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~26_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(14));

-- Location: LCCOMB_X23_Y14_N30
\TLDM|TT1|Add0~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~28_combout\ = (\TLDM|TT1|current_count\(15) & (\TLDM|TT1|Add0~27\ $ (GND))) # (!\TLDM|TT1|current_count\(15) & (!\TLDM|TT1|Add0~27\ & VCC))
-- \TLDM|TT1|Add0~29\ = CARRY((\TLDM|TT1|current_count\(15) & !\TLDM|TT1|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(15),
	datad => VCC,
	cin => \TLDM|TT1|Add0~27\,
	combout => \TLDM|TT1|Add0~28_combout\,
	cout => \TLDM|TT1|Add0~29\);

-- Location: FF_X23_Y14_N31
\TLDM|TT1|current_count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~28_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(15));

-- Location: LCCOMB_X23_Y13_N0
\TLDM|TT1|Add0~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~30_combout\ = (\TLDM|TT1|current_count\(16) & (!\TLDM|TT1|Add0~29\)) # (!\TLDM|TT1|current_count\(16) & ((\TLDM|TT1|Add0~29\) # (GND)))
-- \TLDM|TT1|Add0~31\ = CARRY((!\TLDM|TT1|Add0~29\) # (!\TLDM|TT1|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(16),
	datad => VCC,
	cin => \TLDM|TT1|Add0~29\,
	combout => \TLDM|TT1|Add0~30_combout\,
	cout => \TLDM|TT1|Add0~31\);

-- Location: FF_X23_Y13_N1
\TLDM|TT1|current_count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~30_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(16));

-- Location: LCCOMB_X23_Y13_N2
\TLDM|TT1|Add0~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~32_combout\ = (\TLDM|TT1|current_count\(17) & (\TLDM|TT1|Add0~31\ $ (GND))) # (!\TLDM|TT1|current_count\(17) & (!\TLDM|TT1|Add0~31\ & VCC))
-- \TLDM|TT1|Add0~33\ = CARRY((\TLDM|TT1|current_count\(17) & !\TLDM|TT1|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(17),
	datad => VCC,
	cin => \TLDM|TT1|Add0~31\,
	combout => \TLDM|TT1|Add0~32_combout\,
	cout => \TLDM|TT1|Add0~33\);

-- Location: FF_X23_Y13_N3
\TLDM|TT1|current_count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~32_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(17));

-- Location: LCCOMB_X23_Y13_N4
\TLDM|TT1|Add0~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~34_combout\ = (\TLDM|TT1|current_count\(18) & (!\TLDM|TT1|Add0~33\)) # (!\TLDM|TT1|current_count\(18) & ((\TLDM|TT1|Add0~33\) # (GND)))
-- \TLDM|TT1|Add0~35\ = CARRY((!\TLDM|TT1|Add0~33\) # (!\TLDM|TT1|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(18),
	datad => VCC,
	cin => \TLDM|TT1|Add0~33\,
	combout => \TLDM|TT1|Add0~34_combout\,
	cout => \TLDM|TT1|Add0~35\);

-- Location: FF_X23_Y13_N5
\TLDM|TT1|current_count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~34_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(18));

-- Location: LCCOMB_X23_Y13_N6
\TLDM|TT1|Add0~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~36_combout\ = (\TLDM|TT1|current_count\(19) & (\TLDM|TT1|Add0~35\ $ (GND))) # (!\TLDM|TT1|current_count\(19) & (!\TLDM|TT1|Add0~35\ & VCC))
-- \TLDM|TT1|Add0~37\ = CARRY((\TLDM|TT1|current_count\(19) & !\TLDM|TT1|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(19),
	datad => VCC,
	cin => \TLDM|TT1|Add0~35\,
	combout => \TLDM|TT1|Add0~36_combout\,
	cout => \TLDM|TT1|Add0~37\);

-- Location: FF_X23_Y13_N7
\TLDM|TT1|current_count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~36_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(19));

-- Location: LCCOMB_X23_Y13_N8
\TLDM|TT1|Add0~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~38_combout\ = (\TLDM|TT1|current_count\(20) & (!\TLDM|TT1|Add0~37\)) # (!\TLDM|TT1|current_count\(20) & ((\TLDM|TT1|Add0~37\) # (GND)))
-- \TLDM|TT1|Add0~39\ = CARRY((!\TLDM|TT1|Add0~37\) # (!\TLDM|TT1|current_count\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(20),
	datad => VCC,
	cin => \TLDM|TT1|Add0~37\,
	combout => \TLDM|TT1|Add0~38_combout\,
	cout => \TLDM|TT1|Add0~39\);

-- Location: FF_X23_Y13_N9
\TLDM|TT1|current_count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~38_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(20));

-- Location: LCCOMB_X23_Y13_N12
\TLDM|TT1|Add0~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~42_combout\ = (\TLDM|TT1|current_count\(22) & (!\TLDM|TT1|Add0~41\)) # (!\TLDM|TT1|current_count\(22) & ((\TLDM|TT1|Add0~41\) # (GND)))
-- \TLDM|TT1|Add0~43\ = CARRY((!\TLDM|TT1|Add0~41\) # (!\TLDM|TT1|current_count\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(22),
	datad => VCC,
	cin => \TLDM|TT1|Add0~41\,
	combout => \TLDM|TT1|Add0~42_combout\,
	cout => \TLDM|TT1|Add0~43\);

-- Location: LCCOMB_X23_Y13_N14
\TLDM|TT1|Add0~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~44_combout\ = (\TLDM|TT1|current_count\(23) & (\TLDM|TT1|Add0~43\ $ (GND))) # (!\TLDM|TT1|current_count\(23) & (!\TLDM|TT1|Add0~43\ & VCC))
-- \TLDM|TT1|Add0~45\ = CARRY((\TLDM|TT1|current_count\(23) & !\TLDM|TT1|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(23),
	datad => VCC,
	cin => \TLDM|TT1|Add0~43\,
	combout => \TLDM|TT1|Add0~44_combout\,
	cout => \TLDM|TT1|Add0~45\);

-- Location: FF_X23_Y13_N15
\TLDM|TT1|current_count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~44_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(23));

-- Location: LCCOMB_X23_Y13_N16
\TLDM|TT1|Add0~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~46_combout\ = (\TLDM|TT1|current_count\(24) & (!\TLDM|TT1|Add0~45\)) # (!\TLDM|TT1|current_count\(24) & ((\TLDM|TT1|Add0~45\) # (GND)))
-- \TLDM|TT1|Add0~47\ = CARRY((!\TLDM|TT1|Add0~45\) # (!\TLDM|TT1|current_count\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(24),
	datad => VCC,
	cin => \TLDM|TT1|Add0~45\,
	combout => \TLDM|TT1|Add0~46_combout\,
	cout => \TLDM|TT1|Add0~47\);

-- Location: FF_X23_Y13_N17
\TLDM|TT1|current_count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~46_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(24));

-- Location: LCCOMB_X23_Y13_N18
\TLDM|TT1|Add0~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~48_combout\ = (\TLDM|TT1|current_count\(25) & (\TLDM|TT1|Add0~47\ $ (GND))) # (!\TLDM|TT1|current_count\(25) & (!\TLDM|TT1|Add0~47\ & VCC))
-- \TLDM|TT1|Add0~49\ = CARRY((\TLDM|TT1|current_count\(25) & !\TLDM|TT1|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(25),
	datad => VCC,
	cin => \TLDM|TT1|Add0~47\,
	combout => \TLDM|TT1|Add0~48_combout\,
	cout => \TLDM|TT1|Add0~49\);

-- Location: FF_X23_Y13_N19
\TLDM|TT1|current_count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~48_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(25));

-- Location: LCCOMB_X23_Y13_N20
\TLDM|TT1|Add0~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~50_combout\ = (\TLDM|TT1|current_count\(26) & (!\TLDM|TT1|Add0~49\)) # (!\TLDM|TT1|current_count\(26) & ((\TLDM|TT1|Add0~49\) # (GND)))
-- \TLDM|TT1|Add0~51\ = CARRY((!\TLDM|TT1|Add0~49\) # (!\TLDM|TT1|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(26),
	datad => VCC,
	cin => \TLDM|TT1|Add0~49\,
	combout => \TLDM|TT1|Add0~50_combout\,
	cout => \TLDM|TT1|Add0~51\);

-- Location: FF_X23_Y13_N21
\TLDM|TT1|current_count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~50_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(26));

-- Location: LCCOMB_X23_Y13_N22
\TLDM|TT1|Add0~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~52_combout\ = (\TLDM|TT1|current_count\(27) & (\TLDM|TT1|Add0~51\ $ (GND))) # (!\TLDM|TT1|current_count\(27) & (!\TLDM|TT1|Add0~51\ & VCC))
-- \TLDM|TT1|Add0~53\ = CARRY((\TLDM|TT1|current_count\(27) & !\TLDM|TT1|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(27),
	datad => VCC,
	cin => \TLDM|TT1|Add0~51\,
	combout => \TLDM|TT1|Add0~52_combout\,
	cout => \TLDM|TT1|Add0~53\);

-- Location: LCCOMB_X23_Y13_N24
\TLDM|TT1|Add0~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~54_combout\ = (\TLDM|TT1|current_count\(28) & (!\TLDM|TT1|Add0~53\)) # (!\TLDM|TT1|current_count\(28) & ((\TLDM|TT1|Add0~53\) # (GND)))
-- \TLDM|TT1|Add0~55\ = CARRY((!\TLDM|TT1|Add0~53\) # (!\TLDM|TT1|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(28),
	datad => VCC,
	cin => \TLDM|TT1|Add0~53\,
	combout => \TLDM|TT1|Add0~54_combout\,
	cout => \TLDM|TT1|Add0~55\);

-- Location: FF_X23_Y13_N25
\TLDM|TT1|current_count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~54_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(28));

-- Location: LCCOMB_X23_Y13_N28
\TLDM|TT1|Add0~58\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~58_combout\ = (\TLDM|TT1|current_count\(30) & (!\TLDM|TT1|Add0~57\)) # (!\TLDM|TT1|current_count\(30) & ((\TLDM|TT1|Add0~57\) # (GND)))
-- \TLDM|TT1|Add0~59\ = CARRY((!\TLDM|TT1|Add0~57\) # (!\TLDM|TT1|current_count\(30)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|current_count\(30),
	datad => VCC,
	cin => \TLDM|TT1|Add0~57\,
	combout => \TLDM|TT1|Add0~58_combout\,
	cout => \TLDM|TT1|Add0~59\);

-- Location: FF_X23_Y13_N29
\TLDM|TT1|current_count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~58_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(30));

-- Location: LCCOMB_X23_Y13_N30
\TLDM|TT1|Add0~60\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|Add0~60_combout\ = \TLDM|TT1|current_count\(31) $ (!\TLDM|TT1|Add0~59\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(31),
	cin => \TLDM|TT1|Add0~59\,
	combout => \TLDM|TT1|Add0~60_combout\);

-- Location: FF_X23_Y13_N31
\TLDM|TT1|current_count[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~60_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(31));

-- Location: LCCOMB_X24_Y13_N14
\TLDM|TT1|LessThan0~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~3_combout\ = (\TLDM|TT1|current_count\(25) & (\TLDM|TT1|current_count\(19) & (!\TLDM|TT1|current_count\(31) & \TLDM|TT1|current_count\(20))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(25),
	datab => \TLDM|TT1|current_count\(19),
	datac => \TLDM|TT1|current_count\(31),
	datad => \TLDM|TT1|current_count\(20),
	combout => \TLDM|TT1|LessThan0~3_combout\);

-- Location: FF_X23_Y13_N13
\TLDM|TT1|current_count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~42_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(22));

-- Location: LCCOMB_X24_Y13_N24
\TLDM|TT1|LessThan0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~4_combout\ = (\TLDM|TT1|current_count\(21) & (\TLDM|TT1|LessThan0~3_combout\ & (\TLDM|TT1|current_count\(22) & \TLDM|TT1|current_count\(23))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(21),
	datab => \TLDM|TT1|LessThan0~3_combout\,
	datac => \TLDM|TT1|current_count\(22),
	datad => \TLDM|TT1|current_count\(23),
	combout => \TLDM|TT1|LessThan0~4_combout\);

-- Location: LCCOMB_X24_Y13_N22
\TLDM|TT1|LessThan0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~0_combout\ = (!\TLDM|TT1|current_count\(31) & ((\TLDM|TT1|current_count\(26)) # ((\TLDM|TT1|current_count\(25) & \TLDM|TT1|current_count\(24)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(31),
	datab => \TLDM|TT1|current_count\(26),
	datac => \TLDM|TT1|current_count\(25),
	datad => \TLDM|TT1|current_count\(24),
	combout => \TLDM|TT1|LessThan0~0_combout\);

-- Location: FF_X23_Y13_N23
\TLDM|TT1|current_count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~52_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(27));

-- Location: LCCOMB_X24_Y13_N10
\TLDM|TT1|LessThan0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~1_combout\ = (!\TLDM|TT1|current_count\(31) & ((\TLDM|TT1|current_count\(29)) # ((\TLDM|TT1|current_count\(27)) # (\TLDM|TT1|current_count\(28)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(29),
	datab => \TLDM|TT1|current_count\(27),
	datac => \TLDM|TT1|current_count\(31),
	datad => \TLDM|TT1|current_count\(28),
	combout => \TLDM|TT1|LessThan0~1_combout\);

-- Location: LCCOMB_X24_Y13_N26
\TLDM|TT1|LessThan0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~2_combout\ = (\TLDM|TT1|LessThan0~0_combout\) # ((\TLDM|TT1|LessThan0~1_combout\) # ((!\TLDM|TT1|current_count\(31) & \TLDM|TT1|current_count\(30))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(31),
	datab => \TLDM|TT1|current_count\(30),
	datac => \TLDM|TT1|LessThan0~0_combout\,
	datad => \TLDM|TT1|LessThan0~1_combout\,
	combout => \TLDM|TT1|LessThan0~2_combout\);

-- Location: LCCOMB_X24_Y13_N4
\TLDM|TT1|LessThan0~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~7_combout\ = (\TLDM|TT1|current_count\(13) & (\TLDM|TT1|current_count\(12) & (\TLDM|TT1|current_count\(14) & \TLDM|TT1|current_count\(15))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(13),
	datab => \TLDM|TT1|current_count\(12),
	datac => \TLDM|TT1|current_count\(14),
	datad => \TLDM|TT1|current_count\(15),
	combout => \TLDM|TT1|LessThan0~7_combout\);

-- Location: FF_X23_Y14_N13
\TLDM|TT1|current_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~10_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(6));

-- Location: FF_X23_Y14_N1
\TLDM|TT1|current_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	asdata => \TLDM|TT1|Add0~0_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	sload => VCC,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(1));

-- Location: FF_X23_Y14_N7
\TLDM|TT1|current_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDM|TT1|Add0~4_combout\,
	clrn => \TLDM|ALT_INV_tt1_reset~combout\,
	ena => \TLDM|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDM|TT1|current_count\(3));

-- Location: LCCOMB_X23_Y14_N0
\TLDM|TT1|LessThan0~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~5_combout\ = (\TLDM|TT1|current_count\(2)) # ((\TLDM|TT1|current_count\(0)) # ((\TLDM|TT1|current_count\(1)) # (\TLDM|TT1|current_count\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(2),
	datab => \TLDM|TT1|current_count\(0),
	datac => \TLDM|TT1|current_count\(1),
	datad => \TLDM|TT1|current_count\(3),
	combout => \TLDM|TT1|LessThan0~5_combout\);

-- Location: LCCOMB_X24_Y13_N2
\TLDM|TT1|LessThan0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~6_combout\ = (\TLDM|TT1|current_count\(5)) # ((\TLDM|TT1|current_count\(4)) # ((\TLDM|TT1|current_count\(6)) # (\TLDM|TT1|LessThan0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(5),
	datab => \TLDM|TT1|current_count\(4),
	datac => \TLDM|TT1|current_count\(6),
	datad => \TLDM|TT1|LessThan0~5_combout\,
	combout => \TLDM|TT1|LessThan0~6_combout\);

-- Location: LCCOMB_X24_Y13_N12
\TLDM|TT1|LessThan0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~8_combout\ = (\TLDM|TT1|current_count\(17) & (\TLDM|TT1|current_count\(7) & (\TLDM|TT1|LessThan0~7_combout\ & \TLDM|TT1|LessThan0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|current_count\(17),
	datab => \TLDM|TT1|current_count\(7),
	datac => \TLDM|TT1|LessThan0~7_combout\,
	datad => \TLDM|TT1|LessThan0~6_combout\,
	combout => \TLDM|TT1|LessThan0~8_combout\);

-- Location: LCCOMB_X24_Y13_N16
\TLDM|TT1|LessThan0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|TT1|LessThan0~12_combout\ = (\TLDM|TT1|LessThan0~2_combout\) # ((\TLDM|TT1|LessThan0~4_combout\ & ((\TLDM|TT1|LessThan0~11_combout\) # (\TLDM|TT1|LessThan0~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|TT1|LessThan0~11_combout\,
	datab => \TLDM|TT1|LessThan0~4_combout\,
	datac => \TLDM|TT1|LessThan0~2_combout\,
	datad => \TLDM|TT1|LessThan0~8_combout\,
	combout => \TLDM|TT1|LessThan0~12_combout\);

-- Location: LCCOMB_X24_Y13_N28
\TLDM|green_light~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|green_light~5_combout\ = (\TLDM|green_light~4_combout\ & (!\TLDM|TT1|LessThan0~12_combout\)) # (!\TLDM|green_light~4_combout\ & ((\TLDM|green_light~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLDM|TT1|LessThan0~12_combout\,
	datac => \TLDM|green_light~4_combout\,
	datad => \TLDM|green_light~combout\,
	combout => \TLDM|green_light~5_combout\);

-- Location: LCCOMB_X23_Y16_N14
\TLDM|green_light\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|green_light~combout\ = (!\TLDM|comb~8_combout\ & ((\TLDM|Equal1~1_combout\) # (\TLDM|green_light~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDM|Equal1~1_combout\,
	datab => \TLDM|comb~8_combout\,
	datad => \TLDM|green_light~5_combout\,
	combout => \TLDM|green_light~combout\);

-- Location: LCCOMB_X23_Y16_N26
\TLDM|Equal1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDM|Equal1~0_combout\ = (!\TLC|WideOr8~0_combout\ & !\TLC|WideOr7~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLC|WideOr8~0_combout\,
	datad => \TLC|WideOr7~combout\,
	combout => \TLDM|Equal1~0_combout\);

-- Location: LCCOMB_X22_Y19_N2
\TLDF|Equal1~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|Equal1~1_combout\ = (!\TLC|state.FAW~q\ & ((\TLC|state.FG~q\) # (\TLC|state.FGW~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FAW~q\,
	datab => \TLC|state.FG~q\,
	datad => \TLC|state.FGW~q\,
	combout => \TLDF|Equal1~1_combout\);

-- Location: LCCOMB_X22_Y19_N14
\TLDF|Equal1~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|Equal1~2_combout\ = (!\TLC|state.FGFW~q\ & (!\TLC|state.FGF~q\ & (!\TLC|state.FA~q\ & \TLDF|Equal1~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FGFW~q\,
	datab => \TLC|state.FGF~q\,
	datac => \TLC|state.FA~q\,
	datad => \TLDF|Equal1~1_combout\,
	combout => \TLDF|Equal1~2_combout\);

-- Location: LCCOMB_X32_Y16_N2
\TLDF|TT1|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~0_combout\ = (\TLDF|TT1|current_count\(0) & (\TLDF|TT1|current_count\(1) $ (VCC))) # (!\TLDF|TT1|current_count\(0) & (\TLDF|TT1|current_count\(1) & VCC))
-- \TLDF|TT1|Add0~1\ = CARRY((\TLDF|TT1|current_count\(0) & \TLDF|TT1|current_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(0),
	datab => \TLDF|TT1|current_count\(1),
	datad => VCC,
	combout => \TLDF|TT1|Add0~0_combout\,
	cout => \TLDF|TT1|Add0~1\);

-- Location: LCCOMB_X36_Y16_N10
\TLDF|TT2|current_count[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|current_count[0]~0_combout\ = !\TLDF|TT2|current_count\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLDF|TT2|current_count\(0),
	combout => \TLDF|TT2|current_count[0]~0_combout\);

-- Location: LCCOMB_X31_Y16_N26
\TLDF|tt1_enable\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|tt1_enable~combout\ = (GLOBAL(\TLDF|tt2_reset~0clkctrl_outclk\) & ((!\TLDF|TT1|LessThan0~12_combout\))) # (!GLOBAL(\TLDF|tt2_reset~0clkctrl_outclk\) & (\TLDF|tt1_enable~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|tt2_reset~0clkctrl_outclk\,
	datab => \TLDF|tt1_enable~combout\,
	datad => \TLDF|TT1|LessThan0~12_combout\,
	combout => \TLDF|tt1_enable~combout\);

-- Location: FF_X36_Y16_N11
\TLDF|TT2|current_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|current_count[0]~0_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(0));

-- Location: LCCOMB_X35_Y16_N2
\TLDF|TT2|Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~0_combout\ = (\TLDF|TT2|current_count\(1) & (\TLDF|TT2|current_count\(0) $ (VCC))) # (!\TLDF|TT2|current_count\(1) & (\TLDF|TT2|current_count\(0) & VCC))
-- \TLDF|TT2|Add0~1\ = CARRY((\TLDF|TT2|current_count\(1) & \TLDF|TT2|current_count\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(1),
	datab => \TLDF|TT2|current_count\(0),
	datad => VCC,
	combout => \TLDF|TT2|Add0~0_combout\,
	cout => \TLDF|TT2|Add0~1\);

-- Location: LCCOMB_X35_Y16_N4
\TLDF|TT2|Add0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~2_combout\ = (\TLDF|TT2|current_count\(2) & (!\TLDF|TT2|Add0~1\)) # (!\TLDF|TT2|current_count\(2) & ((\TLDF|TT2|Add0~1\) # (GND)))
-- \TLDF|TT2|Add0~3\ = CARRY((!\TLDF|TT2|Add0~1\) # (!\TLDF|TT2|current_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(2),
	datad => VCC,
	cin => \TLDF|TT2|Add0~1\,
	combout => \TLDF|TT2|Add0~2_combout\,
	cout => \TLDF|TT2|Add0~3\);

-- Location: FF_X35_Y16_N5
\TLDF|TT2|current_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~2_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(2));

-- Location: LCCOMB_X35_Y16_N6
\TLDF|TT2|Add0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~4_combout\ = (\TLDF|TT2|current_count\(3) & (\TLDF|TT2|Add0~3\ $ (GND))) # (!\TLDF|TT2|current_count\(3) & (!\TLDF|TT2|Add0~3\ & VCC))
-- \TLDF|TT2|Add0~5\ = CARRY((\TLDF|TT2|current_count\(3) & !\TLDF|TT2|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(3),
	datad => VCC,
	cin => \TLDF|TT2|Add0~3\,
	combout => \TLDF|TT2|Add0~4_combout\,
	cout => \TLDF|TT2|Add0~5\);

-- Location: LCCOMB_X35_Y16_N8
\TLDF|TT2|Add0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~6_combout\ = (\TLDF|TT2|current_count\(4) & (!\TLDF|TT2|Add0~5\)) # (!\TLDF|TT2|current_count\(4) & ((\TLDF|TT2|Add0~5\) # (GND)))
-- \TLDF|TT2|Add0~7\ = CARRY((!\TLDF|TT2|Add0~5\) # (!\TLDF|TT2|current_count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(4),
	datad => VCC,
	cin => \TLDF|TT2|Add0~5\,
	combout => \TLDF|TT2|Add0~6_combout\,
	cout => \TLDF|TT2|Add0~7\);

-- Location: FF_X35_Y16_N9
\TLDF|TT2|current_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~6_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(4));

-- Location: LCCOMB_X35_Y16_N10
\TLDF|TT2|Add0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~8_combout\ = (\TLDF|TT2|current_count\(5) & (\TLDF|TT2|Add0~7\ $ (GND))) # (!\TLDF|TT2|current_count\(5) & (!\TLDF|TT2|Add0~7\ & VCC))
-- \TLDF|TT2|Add0~9\ = CARRY((\TLDF|TT2|current_count\(5) & !\TLDF|TT2|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(5),
	datad => VCC,
	cin => \TLDF|TT2|Add0~7\,
	combout => \TLDF|TT2|Add0~8_combout\,
	cout => \TLDF|TT2|Add0~9\);

-- Location: LCCOMB_X35_Y16_N12
\TLDF|TT2|Add0~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~10_combout\ = (\TLDF|TT2|current_count\(6) & (!\TLDF|TT2|Add0~9\)) # (!\TLDF|TT2|current_count\(6) & ((\TLDF|TT2|Add0~9\) # (GND)))
-- \TLDF|TT2|Add0~11\ = CARRY((!\TLDF|TT2|Add0~9\) # (!\TLDF|TT2|current_count\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(6),
	datad => VCC,
	cin => \TLDF|TT2|Add0~9\,
	combout => \TLDF|TT2|Add0~10_combout\,
	cout => \TLDF|TT2|Add0~11\);

-- Location: LCCOMB_X35_Y16_N14
\TLDF|TT2|Add0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~12_combout\ = (\TLDF|TT2|current_count\(7) & (\TLDF|TT2|Add0~11\ $ (GND))) # (!\TLDF|TT2|current_count\(7) & (!\TLDF|TT2|Add0~11\ & VCC))
-- \TLDF|TT2|Add0~13\ = CARRY((\TLDF|TT2|current_count\(7) & !\TLDF|TT2|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(7),
	datad => VCC,
	cin => \TLDF|TT2|Add0~11\,
	combout => \TLDF|TT2|Add0~12_combout\,
	cout => \TLDF|TT2|Add0~13\);

-- Location: FF_X35_Y16_N15
\TLDF|TT2|current_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~12_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(7));

-- Location: LCCOMB_X35_Y16_N16
\TLDF|TT2|Add0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~14_combout\ = (\TLDF|TT2|current_count\(8) & (!\TLDF|TT2|Add0~13\)) # (!\TLDF|TT2|current_count\(8) & ((\TLDF|TT2|Add0~13\) # (GND)))
-- \TLDF|TT2|Add0~15\ = CARRY((!\TLDF|TT2|Add0~13\) # (!\TLDF|TT2|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(8),
	datad => VCC,
	cin => \TLDF|TT2|Add0~13\,
	combout => \TLDF|TT2|Add0~14_combout\,
	cout => \TLDF|TT2|Add0~15\);

-- Location: FF_X35_Y16_N17
\TLDF|TT2|current_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~14_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(8));

-- Location: LCCOMB_X35_Y16_N18
\TLDF|TT2|Add0~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~16_combout\ = (\TLDF|TT2|current_count\(9) & (\TLDF|TT2|Add0~15\ $ (GND))) # (!\TLDF|TT2|current_count\(9) & (!\TLDF|TT2|Add0~15\ & VCC))
-- \TLDF|TT2|Add0~17\ = CARRY((\TLDF|TT2|current_count\(9) & !\TLDF|TT2|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(9),
	datad => VCC,
	cin => \TLDF|TT2|Add0~15\,
	combout => \TLDF|TT2|Add0~16_combout\,
	cout => \TLDF|TT2|Add0~17\);

-- Location: FF_X35_Y16_N19
\TLDF|TT2|current_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~16_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(9));

-- Location: LCCOMB_X35_Y16_N20
\TLDF|TT2|Add0~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~18_combout\ = (\TLDF|TT2|current_count\(10) & (!\TLDF|TT2|Add0~17\)) # (!\TLDF|TT2|current_count\(10) & ((\TLDF|TT2|Add0~17\) # (GND)))
-- \TLDF|TT2|Add0~19\ = CARRY((!\TLDF|TT2|Add0~17\) # (!\TLDF|TT2|current_count\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(10),
	datad => VCC,
	cin => \TLDF|TT2|Add0~17\,
	combout => \TLDF|TT2|Add0~18_combout\,
	cout => \TLDF|TT2|Add0~19\);

-- Location: FF_X35_Y16_N21
\TLDF|TT2|current_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~18_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(10));

-- Location: LCCOMB_X35_Y16_N22
\TLDF|TT2|Add0~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~20_combout\ = (\TLDF|TT2|current_count\(11) & (\TLDF|TT2|Add0~19\ $ (GND))) # (!\TLDF|TT2|current_count\(11) & (!\TLDF|TT2|Add0~19\ & VCC))
-- \TLDF|TT2|Add0~21\ = CARRY((\TLDF|TT2|current_count\(11) & !\TLDF|TT2|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(11),
	datad => VCC,
	cin => \TLDF|TT2|Add0~19\,
	combout => \TLDF|TT2|Add0~20_combout\,
	cout => \TLDF|TT2|Add0~21\);

-- Location: FF_X35_Y16_N23
\TLDF|TT2|current_count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~20_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(11));

-- Location: LCCOMB_X36_Y16_N28
\TLDF|TT2|LessThan0~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~7_combout\ = (\TLDF|TT2|current_count\(8)) # ((\TLDF|TT2|current_count\(11)) # ((\TLDF|TT2|current_count\(10)) # (\TLDF|TT2|current_count\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(8),
	datab => \TLDF|TT2|current_count\(11),
	datac => \TLDF|TT2|current_count\(10),
	datad => \TLDF|TT2|current_count\(9),
	combout => \TLDF|TT2|LessThan0~7_combout\);

-- Location: LCCOMB_X35_Y16_N24
\TLDF|TT2|Add0~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~22_combout\ = (\TLDF|TT2|current_count\(12) & (!\TLDF|TT2|Add0~21\)) # (!\TLDF|TT2|current_count\(12) & ((\TLDF|TT2|Add0~21\) # (GND)))
-- \TLDF|TT2|Add0~23\ = CARRY((!\TLDF|TT2|Add0~21\) # (!\TLDF|TT2|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(12),
	datad => VCC,
	cin => \TLDF|TT2|Add0~21\,
	combout => \TLDF|TT2|Add0~22_combout\,
	cout => \TLDF|TT2|Add0~23\);

-- Location: FF_X35_Y16_N25
\TLDF|TT2|current_count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~22_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(12));

-- Location: LCCOMB_X35_Y16_N28
\TLDF|TT2|Add0~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~26_combout\ = (\TLDF|TT2|current_count\(14) & (!\TLDF|TT2|Add0~25\)) # (!\TLDF|TT2|current_count\(14) & ((\TLDF|TT2|Add0~25\) # (GND)))
-- \TLDF|TT2|Add0~27\ = CARRY((!\TLDF|TT2|Add0~25\) # (!\TLDF|TT2|current_count\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(14),
	datad => VCC,
	cin => \TLDF|TT2|Add0~25\,
	combout => \TLDF|TT2|Add0~26_combout\,
	cout => \TLDF|TT2|Add0~27\);

-- Location: FF_X35_Y16_N29
\TLDF|TT2|current_count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~26_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(14));

-- Location: LCCOMB_X35_Y16_N30
\TLDF|TT2|Add0~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~28_combout\ = (\TLDF|TT2|current_count\(15) & (\TLDF|TT2|Add0~27\ $ (GND))) # (!\TLDF|TT2|current_count\(15) & (!\TLDF|TT2|Add0~27\ & VCC))
-- \TLDF|TT2|Add0~29\ = CARRY((\TLDF|TT2|current_count\(15) & !\TLDF|TT2|Add0~27\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(15),
	datad => VCC,
	cin => \TLDF|TT2|Add0~27\,
	combout => \TLDF|TT2|Add0~28_combout\,
	cout => \TLDF|TT2|Add0~29\);

-- Location: FF_X35_Y16_N31
\TLDF|TT2|current_count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~28_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(15));

-- Location: LCCOMB_X36_Y16_N14
\TLDF|TT2|LessThan0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~4_combout\ = (\TLDF|TT2|current_count\(13) & (\TLDF|TT2|current_count\(14) & (\TLDF|TT2|current_count\(15) & \TLDF|TT2|current_count\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(13),
	datab => \TLDF|TT2|current_count\(14),
	datac => \TLDF|TT2|current_count\(15),
	datad => \TLDF|TT2|current_count\(12),
	combout => \TLDF|TT2|LessThan0~4_combout\);

-- Location: LCCOMB_X35_Y15_N0
\TLDF|TT2|Add0~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~30_combout\ = (\TLDF|TT2|current_count\(16) & (!\TLDF|TT2|Add0~29\)) # (!\TLDF|TT2|current_count\(16) & ((\TLDF|TT2|Add0~29\) # (GND)))
-- \TLDF|TT2|Add0~31\ = CARRY((!\TLDF|TT2|Add0~29\) # (!\TLDF|TT2|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(16),
	datad => VCC,
	cin => \TLDF|TT2|Add0~29\,
	combout => \TLDF|TT2|Add0~30_combout\,
	cout => \TLDF|TT2|Add0~31\);

-- Location: FF_X35_Y15_N1
\TLDF|TT2|current_count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~30_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(16));

-- Location: LCCOMB_X35_Y15_N2
\TLDF|TT2|Add0~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~32_combout\ = (\TLDF|TT2|current_count\(17) & (\TLDF|TT2|Add0~31\ $ (GND))) # (!\TLDF|TT2|current_count\(17) & (!\TLDF|TT2|Add0~31\ & VCC))
-- \TLDF|TT2|Add0~33\ = CARRY((\TLDF|TT2|current_count\(17) & !\TLDF|TT2|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(17),
	datad => VCC,
	cin => \TLDF|TT2|Add0~31\,
	combout => \TLDF|TT2|Add0~32_combout\,
	cout => \TLDF|TT2|Add0~33\);

-- Location: FF_X35_Y15_N3
\TLDF|TT2|current_count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~32_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(17));

-- Location: LCCOMB_X36_Y16_N6
\TLDF|TT2|LessThan0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~6_combout\ = (\TLDF|TT2|current_count\(18)) # ((\TLDF|TT2|current_count\(17) & \TLDF|TT2|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(18),
	datab => \TLDF|TT2|current_count\(17),
	datad => \TLDF|TT2|current_count\(16),
	combout => \TLDF|TT2|LessThan0~6_combout\);

-- Location: LCCOMB_X36_Y16_N2
\TLDF|TT2|LessThan0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~8_combout\ = (\TLDF|TT2|LessThan0~6_combout\) # ((\TLDF|TT2|current_count\(17) & (\TLDF|TT2|LessThan0~7_combout\ & \TLDF|TT2|LessThan0~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(17),
	datab => \TLDF|TT2|LessThan0~7_combout\,
	datac => \TLDF|TT2|LessThan0~4_combout\,
	datad => \TLDF|TT2|LessThan0~6_combout\,
	combout => \TLDF|TT2|LessThan0~8_combout\);

-- Location: LCCOMB_X35_Y15_N4
\TLDF|TT2|Add0~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~34_combout\ = (\TLDF|TT2|current_count\(18) & (!\TLDF|TT2|Add0~33\)) # (!\TLDF|TT2|current_count\(18) & ((\TLDF|TT2|Add0~33\) # (GND)))
-- \TLDF|TT2|Add0~35\ = CARRY((!\TLDF|TT2|Add0~33\) # (!\TLDF|TT2|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(18),
	datad => VCC,
	cin => \TLDF|TT2|Add0~33\,
	combout => \TLDF|TT2|Add0~34_combout\,
	cout => \TLDF|TT2|Add0~35\);

-- Location: FF_X35_Y15_N5
\TLDF|TT2|current_count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~34_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(18));

-- Location: LCCOMB_X35_Y15_N8
\TLDF|TT2|Add0~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~38_combout\ = (\TLDF|TT2|current_count\(20) & (!\TLDF|TT2|Add0~37\)) # (!\TLDF|TT2|current_count\(20) & ((\TLDF|TT2|Add0~37\) # (GND)))
-- \TLDF|TT2|Add0~39\ = CARRY((!\TLDF|TT2|Add0~37\) # (!\TLDF|TT2|current_count\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT2|current_count\(20),
	datad => VCC,
	cin => \TLDF|TT2|Add0~37\,
	combout => \TLDF|TT2|Add0~38_combout\,
	cout => \TLDF|TT2|Add0~39\);

-- Location: FF_X35_Y15_N9
\TLDF|TT2|current_count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~38_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(20));

-- Location: LCCOMB_X35_Y15_N10
\TLDF|TT2|Add0~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~40_combout\ = (\TLDF|TT2|current_count\(21) & (\TLDF|TT2|Add0~39\ $ (GND))) # (!\TLDF|TT2|current_count\(21) & (!\TLDF|TT2|Add0~39\ & VCC))
-- \TLDF|TT2|Add0~41\ = CARRY((\TLDF|TT2|current_count\(21) & !\TLDF|TT2|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(21),
	datad => VCC,
	cin => \TLDF|TT2|Add0~39\,
	combout => \TLDF|TT2|Add0~40_combout\,
	cout => \TLDF|TT2|Add0~41\);

-- Location: LCCOMB_X35_Y15_N12
\TLDF|TT2|Add0~42\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|Add0~42_combout\ = (\TLDF|TT2|current_count\(22) & (!\TLDF|TT2|Add0~41\)) # (!\TLDF|TT2|current_count\(22) & ((\TLDF|TT2|Add0~41\) # (GND)))
-- \TLDF|TT2|Add0~43\ = CARRY((!\TLDF|TT2|Add0~41\) # (!\TLDF|TT2|current_count\(22)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(22),
	datad => VCC,
	cin => \TLDF|TT2|Add0~41\,
	combout => \TLDF|TT2|Add0~42_combout\,
	cout => \TLDF|TT2|Add0~43\);

-- Location: FF_X35_Y15_N15
\TLDF|TT2|current_count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~44_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(23));

-- Location: FF_X35_Y15_N13
\TLDF|TT2|current_count[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~42_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(22));

-- Location: FF_X35_Y15_N11
\TLDF|TT2|current_count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~40_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(21));

-- Location: LCCOMB_X36_Y16_N30
\TLDF|TT2|LessThan0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~1_combout\ = (\TLDF|TT2|LessThan0~0_combout\ & (\TLDF|TT2|current_count\(23) & (\TLDF|TT2|current_count\(22) & \TLDF|TT2|current_count\(21))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|LessThan0~0_combout\,
	datab => \TLDF|TT2|current_count\(23),
	datac => \TLDF|TT2|current_count\(22),
	datad => \TLDF|TT2|current_count\(21),
	combout => \TLDF|TT2|LessThan0~1_combout\);

-- Location: FF_X35_Y16_N7
\TLDF|TT2|current_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~4_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(3));

-- Location: FF_X35_Y16_N3
\TLDF|TT2|current_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~0_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(1));

-- Location: LCCOMB_X36_Y16_N24
\TLDF|TT2|LessThan0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~2_combout\ = (\TLDF|TT2|current_count\(0)) # ((\TLDF|TT2|current_count\(2)) # ((\TLDF|TT2|current_count\(3)) # (\TLDF|TT2|current_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(0),
	datab => \TLDF|TT2|current_count\(2),
	datac => \TLDF|TT2|current_count\(3),
	datad => \TLDF|TT2|current_count\(1),
	combout => \TLDF|TT2|LessThan0~2_combout\);

-- Location: FF_X35_Y16_N11
\TLDF|TT2|current_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~8_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(5));

-- Location: FF_X35_Y16_N13
\TLDF|TT2|current_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT2|Add0~10_combout\,
	clrn => \TLDF|ALT_INV_tt1_enable~combout\,
	ena => \TLDF|tt1_reset~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT2|current_count\(6));

-- Location: LCCOMB_X36_Y16_N8
\TLDF|TT2|LessThan0~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~3_combout\ = (\TLDF|TT2|current_count\(4)) # ((\TLDF|TT2|LessThan0~2_combout\) # ((\TLDF|TT2|current_count\(5)) # (\TLDF|TT2|current_count\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(4),
	datab => \TLDF|TT2|LessThan0~2_combout\,
	datac => \TLDF|TT2|current_count\(5),
	datad => \TLDF|TT2|current_count\(6),
	combout => \TLDF|TT2|LessThan0~3_combout\);

-- Location: LCCOMB_X36_Y16_N0
\TLDF|TT2|LessThan0~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT2|LessThan0~5_combout\ = (\TLDF|TT2|current_count\(17) & (\TLDF|TT2|LessThan0~4_combout\ & (\TLDF|TT2|LessThan0~3_combout\ & \TLDF|TT2|current_count\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT2|current_count\(17),
	datab => \TLDF|TT2|LessThan0~4_combout\,
	datac => \TLDF|TT2|LessThan0~3_combout\,
	datad => \TLDF|TT2|current_count\(7),
	combout => \TLDF|TT2|LessThan0~5_combout\);

-- Location: LCCOMB_X36_Y16_N22
\TLDF|green_light~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|green_light~3_combout\ = (\TLDF|green_light~2_combout\) # ((\TLDF|TT2|LessThan0~1_combout\ & ((\TLDF|TT2|LessThan0~8_combout\) # (\TLDF|TT2|LessThan0~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|green_light~2_combout\,
	datab => \TLDF|TT2|LessThan0~8_combout\,
	datac => \TLDF|TT2|LessThan0~1_combout\,
	datad => \TLDF|TT2|LessThan0~5_combout\,
	combout => \TLDF|green_light~3_combout\);

-- Location: LCCOMB_X22_Y19_N24
\TLC|WideOr9~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLC|WideOr9~0_combout\ = (\TLC|state.FGFW~q\) # ((\TLC|state.FG~q\) # ((\TLC|state.FGF~q\) # (\TLC|state.FGW~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FGFW~q\,
	datab => \TLC|state.FG~q\,
	datac => \TLC|state.FGF~q\,
	datad => \TLC|state.FGW~q\,
	combout => \TLC|WideOr9~0_combout\);

-- Location: LCCOMB_X23_Y19_N20
\TLDF|green_light~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|green_light~4_combout\ = (!\TLC|WideOr10~0_combout\ & (\TLC|WideOr9~0_combout\ & ((\TLDF|TT1|LessThan0~12_combout\) # (\TLDF|green_light~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|LessThan0~12_combout\,
	datab => \TLDF|green_light~3_combout\,
	datac => \TLC|WideOr10~0_combout\,
	datad => \TLC|WideOr9~0_combout\,
	combout => \TLDF|green_light~4_combout\);

-- Location: LCCOMB_X23_Y19_N12
\TLDF|tt2_reset~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|tt2_reset~0_combout\ = (\TLDF|green_light~4_combout\ & ((\TLC|state.FGW~q\) # ((\TLC|state.FG~q\) # (!\TLC|WideOr10~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|state.FGW~q\,
	datab => \TLC|state.FG~q\,
	datac => \TLC|WideOr10~0_combout\,
	datad => \TLDF|green_light~4_combout\,
	combout => \TLDF|tt2_reset~0_combout\);

-- Location: CLKCTRL_G14
\TLDF|tt2_reset~0clkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \TLDF|tt2_reset~0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \TLDF|tt2_reset~0clkctrl_outclk\);

-- Location: LCCOMB_X35_Y16_N0
\TLDF|tt1_reset\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|tt1_reset~combout\ = (GLOBAL(\TLDF|tt2_reset~0clkctrl_outclk\) & ((\TLDF|TT1|LessThan0~12_combout\))) # (!GLOBAL(\TLDF|tt2_reset~0clkctrl_outclk\) & (\TLDF|tt1_reset~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|tt1_reset~combout\,
	datac => \TLDF|tt2_reset~0clkctrl_outclk\,
	datad => \TLDF|TT1|LessThan0~12_combout\,
	combout => \TLDF|tt1_reset~combout\);

-- Location: FF_X32_Y16_N1
\TLDF|TT1|current_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	asdata => \TLDF|TT1|Add0~0_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	sload => VCC,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(1));

-- Location: LCCOMB_X32_Y16_N4
\TLDF|TT1|Add0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~2_combout\ = (\TLDF|TT1|current_count\(2) & (!\TLDF|TT1|Add0~1\)) # (!\TLDF|TT1|current_count\(2) & ((\TLDF|TT1|Add0~1\) # (GND)))
-- \TLDF|TT1|Add0~3\ = CARRY((!\TLDF|TT1|Add0~1\) # (!\TLDF|TT1|current_count\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(2),
	datad => VCC,
	cin => \TLDF|TT1|Add0~1\,
	combout => \TLDF|TT1|Add0~2_combout\,
	cout => \TLDF|TT1|Add0~3\);

-- Location: FF_X32_Y16_N5
\TLDF|TT1|current_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~2_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(2));

-- Location: LCCOMB_X32_Y16_N8
\TLDF|TT1|Add0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~6_combout\ = (\TLDF|TT1|current_count\(4) & (!\TLDF|TT1|Add0~5\)) # (!\TLDF|TT1|current_count\(4) & ((\TLDF|TT1|Add0~5\) # (GND)))
-- \TLDF|TT1|Add0~7\ = CARRY((!\TLDF|TT1|Add0~5\) # (!\TLDF|TT1|current_count\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(4),
	datad => VCC,
	cin => \TLDF|TT1|Add0~5\,
	combout => \TLDF|TT1|Add0~6_combout\,
	cout => \TLDF|TT1|Add0~7\);

-- Location: FF_X32_Y16_N9
\TLDF|TT1|current_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~6_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(4));

-- Location: LCCOMB_X32_Y16_N10
\TLDF|TT1|Add0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~8_combout\ = (\TLDF|TT1|current_count\(5) & (\TLDF|TT1|Add0~7\ $ (GND))) # (!\TLDF|TT1|current_count\(5) & (!\TLDF|TT1|Add0~7\ & VCC))
-- \TLDF|TT1|Add0~9\ = CARRY((\TLDF|TT1|current_count\(5) & !\TLDF|TT1|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(5),
	datad => VCC,
	cin => \TLDF|TT1|Add0~7\,
	combout => \TLDF|TT1|Add0~8_combout\,
	cout => \TLDF|TT1|Add0~9\);

-- Location: LCCOMB_X32_Y16_N14
\TLDF|TT1|Add0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~12_combout\ = (\TLDF|TT1|current_count\(7) & (\TLDF|TT1|Add0~11\ $ (GND))) # (!\TLDF|TT1|current_count\(7) & (!\TLDF|TT1|Add0~11\ & VCC))
-- \TLDF|TT1|Add0~13\ = CARRY((\TLDF|TT1|current_count\(7) & !\TLDF|TT1|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(7),
	datad => VCC,
	cin => \TLDF|TT1|Add0~11\,
	combout => \TLDF|TT1|Add0~12_combout\,
	cout => \TLDF|TT1|Add0~13\);

-- Location: FF_X32_Y16_N15
\TLDF|TT1|current_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~12_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(7));

-- Location: LCCOMB_X32_Y16_N16
\TLDF|TT1|Add0~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~14_combout\ = (\TLDF|TT1|current_count\(8) & (!\TLDF|TT1|Add0~13\)) # (!\TLDF|TT1|current_count\(8) & ((\TLDF|TT1|Add0~13\) # (GND)))
-- \TLDF|TT1|Add0~15\ = CARRY((!\TLDF|TT1|Add0~13\) # (!\TLDF|TT1|current_count\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(8),
	datad => VCC,
	cin => \TLDF|TT1|Add0~13\,
	combout => \TLDF|TT1|Add0~14_combout\,
	cout => \TLDF|TT1|Add0~15\);

-- Location: FF_X32_Y16_N17
\TLDF|TT1|current_count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~14_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(8));

-- Location: LCCOMB_X32_Y16_N18
\TLDF|TT1|Add0~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~16_combout\ = (\TLDF|TT1|current_count\(9) & (\TLDF|TT1|Add0~15\ $ (GND))) # (!\TLDF|TT1|current_count\(9) & (!\TLDF|TT1|Add0~15\ & VCC))
-- \TLDF|TT1|Add0~17\ = CARRY((\TLDF|TT1|current_count\(9) & !\TLDF|TT1|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(9),
	datad => VCC,
	cin => \TLDF|TT1|Add0~15\,
	combout => \TLDF|TT1|Add0~16_combout\,
	cout => \TLDF|TT1|Add0~17\);

-- Location: FF_X32_Y16_N19
\TLDF|TT1|current_count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~16_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(9));

-- Location: LCCOMB_X32_Y16_N20
\TLDF|TT1|Add0~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~18_combout\ = (\TLDF|TT1|current_count\(10) & (!\TLDF|TT1|Add0~17\)) # (!\TLDF|TT1|current_count\(10) & ((\TLDF|TT1|Add0~17\) # (GND)))
-- \TLDF|TT1|Add0~19\ = CARRY((!\TLDF|TT1|Add0~17\) # (!\TLDF|TT1|current_count\(10)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(10),
	datad => VCC,
	cin => \TLDF|TT1|Add0~17\,
	combout => \TLDF|TT1|Add0~18_combout\,
	cout => \TLDF|TT1|Add0~19\);

-- Location: FF_X32_Y16_N21
\TLDF|TT1|current_count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~18_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(10));

-- Location: LCCOMB_X32_Y16_N24
\TLDF|TT1|Add0~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~22_combout\ = (\TLDF|TT1|current_count\(12) & (!\TLDF|TT1|Add0~21\)) # (!\TLDF|TT1|current_count\(12) & ((\TLDF|TT1|Add0~21\) # (GND)))
-- \TLDF|TT1|Add0~23\ = CARRY((!\TLDF|TT1|Add0~21\) # (!\TLDF|TT1|current_count\(12)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(12),
	datad => VCC,
	cin => \TLDF|TT1|Add0~21\,
	combout => \TLDF|TT1|Add0~22_combout\,
	cout => \TLDF|TT1|Add0~23\);

-- Location: FF_X32_Y16_N25
\TLDF|TT1|current_count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~22_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(12));

-- Location: LCCOMB_X32_Y16_N26
\TLDF|TT1|Add0~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~24_combout\ = (\TLDF|TT1|current_count\(13) & (\TLDF|TT1|Add0~23\ $ (GND))) # (!\TLDF|TT1|current_count\(13) & (!\TLDF|TT1|Add0~23\ & VCC))
-- \TLDF|TT1|Add0~25\ = CARRY((\TLDF|TT1|current_count\(13) & !\TLDF|TT1|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(13),
	datad => VCC,
	cin => \TLDF|TT1|Add0~23\,
	combout => \TLDF|TT1|Add0~24_combout\,
	cout => \TLDF|TT1|Add0~25\);

-- Location: LCCOMB_X32_Y16_N28
\TLDF|TT1|Add0~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~26_combout\ = (\TLDF|TT1|current_count\(14) & (!\TLDF|TT1|Add0~25\)) # (!\TLDF|TT1|current_count\(14) & ((\TLDF|TT1|Add0~25\) # (GND)))
-- \TLDF|TT1|Add0~27\ = CARRY((!\TLDF|TT1|Add0~25\) # (!\TLDF|TT1|current_count\(14)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(14),
	datad => VCC,
	cin => \TLDF|TT1|Add0~25\,
	combout => \TLDF|TT1|Add0~26_combout\,
	cout => \TLDF|TT1|Add0~27\);

-- Location: FF_X32_Y16_N29
\TLDF|TT1|current_count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~26_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(14));

-- Location: LCCOMB_X32_Y15_N0
\TLDF|TT1|Add0~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~30_combout\ = (\TLDF|TT1|current_count\(16) & (!\TLDF|TT1|Add0~29\)) # (!\TLDF|TT1|current_count\(16) & ((\TLDF|TT1|Add0~29\) # (GND)))
-- \TLDF|TT1|Add0~31\ = CARRY((!\TLDF|TT1|Add0~29\) # (!\TLDF|TT1|current_count\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(16),
	datad => VCC,
	cin => \TLDF|TT1|Add0~29\,
	combout => \TLDF|TT1|Add0~30_combout\,
	cout => \TLDF|TT1|Add0~31\);

-- Location: FF_X32_Y15_N1
\TLDF|TT1|current_count[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~30_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(16));

-- Location: LCCOMB_X32_Y15_N2
\TLDF|TT1|Add0~32\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~32_combout\ = (\TLDF|TT1|current_count\(17) & (\TLDF|TT1|Add0~31\ $ (GND))) # (!\TLDF|TT1|current_count\(17) & (!\TLDF|TT1|Add0~31\ & VCC))
-- \TLDF|TT1|Add0~33\ = CARRY((\TLDF|TT1|current_count\(17) & !\TLDF|TT1|Add0~31\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(17),
	datad => VCC,
	cin => \TLDF|TT1|Add0~31\,
	combout => \TLDF|TT1|Add0~32_combout\,
	cout => \TLDF|TT1|Add0~33\);

-- Location: FF_X32_Y15_N3
\TLDF|TT1|current_count[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~32_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(17));

-- Location: LCCOMB_X32_Y15_N4
\TLDF|TT1|Add0~34\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~34_combout\ = (\TLDF|TT1|current_count\(18) & (!\TLDF|TT1|Add0~33\)) # (!\TLDF|TT1|current_count\(18) & ((\TLDF|TT1|Add0~33\) # (GND)))
-- \TLDF|TT1|Add0~35\ = CARRY((!\TLDF|TT1|Add0~33\) # (!\TLDF|TT1|current_count\(18)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(18),
	datad => VCC,
	cin => \TLDF|TT1|Add0~33\,
	combout => \TLDF|TT1|Add0~34_combout\,
	cout => \TLDF|TT1|Add0~35\);

-- Location: FF_X32_Y15_N5
\TLDF|TT1|current_count[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~34_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(18));

-- Location: LCCOMB_X32_Y15_N6
\TLDF|TT1|Add0~36\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~36_combout\ = (\TLDF|TT1|current_count\(19) & (\TLDF|TT1|Add0~35\ $ (GND))) # (!\TLDF|TT1|current_count\(19) & (!\TLDF|TT1|Add0~35\ & VCC))
-- \TLDF|TT1|Add0~37\ = CARRY((\TLDF|TT1|current_count\(19) & !\TLDF|TT1|Add0~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(19),
	datad => VCC,
	cin => \TLDF|TT1|Add0~35\,
	combout => \TLDF|TT1|Add0~36_combout\,
	cout => \TLDF|TT1|Add0~37\);

-- Location: LCCOMB_X32_Y15_N8
\TLDF|TT1|Add0~38\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~38_combout\ = (\TLDF|TT1|current_count\(20) & (!\TLDF|TT1|Add0~37\)) # (!\TLDF|TT1|current_count\(20) & ((\TLDF|TT1|Add0~37\) # (GND)))
-- \TLDF|TT1|Add0~39\ = CARRY((!\TLDF|TT1|Add0~37\) # (!\TLDF|TT1|current_count\(20)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(20),
	datad => VCC,
	cin => \TLDF|TT1|Add0~37\,
	combout => \TLDF|TT1|Add0~38_combout\,
	cout => \TLDF|TT1|Add0~39\);

-- Location: FF_X32_Y15_N9
\TLDF|TT1|current_count[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~38_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(20));

-- Location: LCCOMB_X32_Y15_N10
\TLDF|TT1|Add0~40\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~40_combout\ = (\TLDF|TT1|current_count\(21) & (\TLDF|TT1|Add0~39\ $ (GND))) # (!\TLDF|TT1|current_count\(21) & (!\TLDF|TT1|Add0~39\ & VCC))
-- \TLDF|TT1|Add0~41\ = CARRY((\TLDF|TT1|current_count\(21) & !\TLDF|TT1|Add0~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(21),
	datad => VCC,
	cin => \TLDF|TT1|Add0~39\,
	combout => \TLDF|TT1|Add0~40_combout\,
	cout => \TLDF|TT1|Add0~41\);

-- Location: LCCOMB_X32_Y15_N14
\TLDF|TT1|Add0~44\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~44_combout\ = (\TLDF|TT1|current_count\(23) & (\TLDF|TT1|Add0~43\ $ (GND))) # (!\TLDF|TT1|current_count\(23) & (!\TLDF|TT1|Add0~43\ & VCC))
-- \TLDF|TT1|Add0~45\ = CARRY((\TLDF|TT1|current_count\(23) & !\TLDF|TT1|Add0~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(23),
	datad => VCC,
	cin => \TLDF|TT1|Add0~43\,
	combout => \TLDF|TT1|Add0~44_combout\,
	cout => \TLDF|TT1|Add0~45\);

-- Location: FF_X32_Y15_N15
\TLDF|TT1|current_count[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~44_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(23));

-- Location: FF_X32_Y15_N11
\TLDF|TT1|current_count[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~40_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(21));

-- Location: FF_X32_Y15_N7
\TLDF|TT1|current_count[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~36_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(19));

-- Location: LCCOMB_X32_Y15_N16
\TLDF|TT1|Add0~46\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~46_combout\ = (\TLDF|TT1|current_count\(24) & (!\TLDF|TT1|Add0~45\)) # (!\TLDF|TT1|current_count\(24) & ((\TLDF|TT1|Add0~45\) # (GND)))
-- \TLDF|TT1|Add0~47\ = CARRY((!\TLDF|TT1|Add0~45\) # (!\TLDF|TT1|current_count\(24)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(24),
	datad => VCC,
	cin => \TLDF|TT1|Add0~45\,
	combout => \TLDF|TT1|Add0~46_combout\,
	cout => \TLDF|TT1|Add0~47\);

-- Location: FF_X32_Y15_N17
\TLDF|TT1|current_count[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~46_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(24));

-- Location: LCCOMB_X32_Y15_N18
\TLDF|TT1|Add0~48\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~48_combout\ = (\TLDF|TT1|current_count\(25) & (\TLDF|TT1|Add0~47\ $ (GND))) # (!\TLDF|TT1|current_count\(25) & (!\TLDF|TT1|Add0~47\ & VCC))
-- \TLDF|TT1|Add0~49\ = CARRY((\TLDF|TT1|current_count\(25) & !\TLDF|TT1|Add0~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(25),
	datad => VCC,
	cin => \TLDF|TT1|Add0~47\,
	combout => \TLDF|TT1|Add0~48_combout\,
	cout => \TLDF|TT1|Add0~49\);

-- Location: FF_X32_Y15_N19
\TLDF|TT1|current_count[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~48_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(25));

-- Location: LCCOMB_X31_Y16_N10
\TLDF|TT1|LessThan0~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~3_combout\ = (!\TLDF|TT1|current_count\(31) & (\TLDF|TT1|current_count\(20) & (\TLDF|TT1|current_count\(19) & \TLDF|TT1|current_count\(25))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(31),
	datab => \TLDF|TT1|current_count\(20),
	datac => \TLDF|TT1|current_count\(19),
	datad => \TLDF|TT1|current_count\(25),
	combout => \TLDF|TT1|LessThan0~3_combout\);

-- Location: LCCOMB_X31_Y16_N20
\TLDF|TT1|LessThan0~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~4_combout\ = (\TLDF|TT1|current_count\(22) & (\TLDF|TT1|current_count\(23) & (\TLDF|TT1|current_count\(21) & \TLDF|TT1|LessThan0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(22),
	datab => \TLDF|TT1|current_count\(23),
	datac => \TLDF|TT1|current_count\(21),
	datad => \TLDF|TT1|LessThan0~3_combout\,
	combout => \TLDF|TT1|LessThan0~4_combout\);

-- Location: LCCOMB_X32_Y15_N20
\TLDF|TT1|Add0~50\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~50_combout\ = (\TLDF|TT1|current_count\(26) & (!\TLDF|TT1|Add0~49\)) # (!\TLDF|TT1|current_count\(26) & ((\TLDF|TT1|Add0~49\) # (GND)))
-- \TLDF|TT1|Add0~51\ = CARRY((!\TLDF|TT1|Add0~49\) # (!\TLDF|TT1|current_count\(26)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(26),
	datad => VCC,
	cin => \TLDF|TT1|Add0~49\,
	combout => \TLDF|TT1|Add0~50_combout\,
	cout => \TLDF|TT1|Add0~51\);

-- Location: FF_X32_Y15_N21
\TLDF|TT1|current_count[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~50_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(26));

-- Location: LCCOMB_X32_Y15_N22
\TLDF|TT1|Add0~52\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~52_combout\ = (\TLDF|TT1|current_count\(27) & (\TLDF|TT1|Add0~51\ $ (GND))) # (!\TLDF|TT1|current_count\(27) & (!\TLDF|TT1|Add0~51\ & VCC))
-- \TLDF|TT1|Add0~53\ = CARRY((\TLDF|TT1|current_count\(27) & !\TLDF|TT1|Add0~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(27),
	datad => VCC,
	cin => \TLDF|TT1|Add0~51\,
	combout => \TLDF|TT1|Add0~52_combout\,
	cout => \TLDF|TT1|Add0~53\);

-- Location: LCCOMB_X32_Y15_N24
\TLDF|TT1|Add0~54\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~54_combout\ = (\TLDF|TT1|current_count\(28) & (!\TLDF|TT1|Add0~53\)) # (!\TLDF|TT1|current_count\(28) & ((\TLDF|TT1|Add0~53\) # (GND)))
-- \TLDF|TT1|Add0~55\ = CARRY((!\TLDF|TT1|Add0~53\) # (!\TLDF|TT1|current_count\(28)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \TLDF|TT1|current_count\(28),
	datad => VCC,
	cin => \TLDF|TT1|Add0~53\,
	combout => \TLDF|TT1|Add0~54_combout\,
	cout => \TLDF|TT1|Add0~55\);

-- Location: FF_X32_Y15_N25
\TLDF|TT1|current_count[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~54_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(28));

-- Location: LCCOMB_X32_Y15_N26
\TLDF|TT1|Add0~56\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|Add0~56_combout\ = (\TLDF|TT1|current_count\(29) & (\TLDF|TT1|Add0~55\ $ (GND))) # (!\TLDF|TT1|current_count\(29) & (!\TLDF|TT1|Add0~55\ & VCC))
-- \TLDF|TT1|Add0~57\ = CARRY((\TLDF|TT1|current_count\(29) & !\TLDF|TT1|Add0~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(29),
	datad => VCC,
	cin => \TLDF|TT1|Add0~55\,
	combout => \TLDF|TT1|Add0~56_combout\,
	cout => \TLDF|TT1|Add0~57\);

-- Location: FF_X32_Y15_N29
\TLDF|TT1|current_count[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~58_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(30));

-- Location: FF_X32_Y15_N23
\TLDF|TT1|current_count[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~52_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(27));

-- Location: FF_X32_Y15_N27
\TLDF|TT1|current_count[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~56_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(29));

-- Location: LCCOMB_X31_Y16_N8
\TLDF|TT1|LessThan0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~1_combout\ = (!\TLDF|TT1|current_count\(31) & ((\TLDF|TT1|current_count\(28)) # ((\TLDF|TT1|current_count\(27)) # (\TLDF|TT1|current_count\(29)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(31),
	datab => \TLDF|TT1|current_count\(28),
	datac => \TLDF|TT1|current_count\(27),
	datad => \TLDF|TT1|current_count\(29),
	combout => \TLDF|TT1|LessThan0~1_combout\);

-- Location: LCCOMB_X31_Y16_N6
\TLDF|TT1|LessThan0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~0_combout\ = (!\TLDF|TT1|current_count\(31) & ((\TLDF|TT1|current_count\(26)) # ((\TLDF|TT1|current_count\(25) & \TLDF|TT1|current_count\(24)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(31),
	datab => \TLDF|TT1|current_count\(25),
	datac => \TLDF|TT1|current_count\(26),
	datad => \TLDF|TT1|current_count\(24),
	combout => \TLDF|TT1|LessThan0~0_combout\);

-- Location: LCCOMB_X31_Y16_N14
\TLDF|TT1|LessThan0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~2_combout\ = (\TLDF|TT1|LessThan0~1_combout\) # ((\TLDF|TT1|LessThan0~0_combout\) # ((!\TLDF|TT1|current_count\(31) & \TLDF|TT1|current_count\(30))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(31),
	datab => \TLDF|TT1|current_count\(30),
	datac => \TLDF|TT1|LessThan0~1_combout\,
	datad => \TLDF|TT1|LessThan0~0_combout\,
	combout => \TLDF|TT1|LessThan0~2_combout\);

-- Location: FF_X32_Y16_N27
\TLDF|TT1|current_count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~24_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(13));

-- Location: LCCOMB_X31_Y16_N28
\TLDF|TT1|LessThan0~7\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~7_combout\ = (\TLDF|TT1|current_count\(15) & (\TLDF|TT1|current_count\(14) & (\TLDF|TT1|current_count\(12) & \TLDF|TT1|current_count\(13))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(15),
	datab => \TLDF|TT1|current_count\(14),
	datac => \TLDF|TT1|current_count\(12),
	datad => \TLDF|TT1|current_count\(13),
	combout => \TLDF|TT1|LessThan0~7_combout\);

-- Location: LCCOMB_X33_Y16_N0
\TLDF|TT1|current_count[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|current_count[0]~0_combout\ = !\TLDF|TT1|current_count\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLDF|TT1|current_count\(0),
	combout => \TLDF|TT1|current_count[0]~0_combout\);

-- Location: FF_X32_Y16_N3
\TLDF|TT1|current_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \TLDF|TT1|current_count[0]~0_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	sload => VCC,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(0));

-- Location: LCCOMB_X32_Y16_N0
\TLDF|TT1|LessThan0~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~5_combout\ = (\TLDF|TT1|current_count\(3)) # ((\TLDF|TT1|current_count\(0)) # ((\TLDF|TT1|current_count\(1)) # (\TLDF|TT1|current_count\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(3),
	datab => \TLDF|TT1|current_count\(0),
	datac => \TLDF|TT1|current_count\(1),
	datad => \TLDF|TT1|current_count\(2),
	combout => \TLDF|TT1|LessThan0~5_combout\);

-- Location: FF_X32_Y16_N11
\TLDF|TT1|current_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \TLDF|TT1|Add0~8_combout\,
	clrn => \TLDF|ALT_INV_tt1_reset~combout\,
	ena => \TLDF|tt1_enable~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \TLDF|TT1|current_count\(5));

-- Location: LCCOMB_X31_Y16_N0
\TLDF|TT1|LessThan0~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~6_combout\ = (\TLDF|TT1|current_count\(6)) # ((\TLDF|TT1|LessThan0~5_combout\) # ((\TLDF|TT1|current_count\(5)) # (\TLDF|TT1|current_count\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(6),
	datab => \TLDF|TT1|LessThan0~5_combout\,
	datac => \TLDF|TT1|current_count\(5),
	datad => \TLDF|TT1|current_count\(4),
	combout => \TLDF|TT1|LessThan0~6_combout\);

-- Location: LCCOMB_X31_Y16_N12
\TLDF|TT1|LessThan0~8\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~8_combout\ = (\TLDF|TT1|current_count\(17) & (\TLDF|TT1|current_count\(7) & (\TLDF|TT1|LessThan0~7_combout\ & \TLDF|TT1|LessThan0~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|current_count\(17),
	datab => \TLDF|TT1|current_count\(7),
	datac => \TLDF|TT1|LessThan0~7_combout\,
	datad => \TLDF|TT1|LessThan0~6_combout\,
	combout => \TLDF|TT1|LessThan0~8_combout\);

-- Location: LCCOMB_X31_Y16_N18
\TLDF|TT1|LessThan0~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|TT1|LessThan0~12_combout\ = (\TLDF|TT1|LessThan0~2_combout\) # ((\TLDF|TT1|LessThan0~4_combout\ & ((\TLDF|TT1|LessThan0~11_combout\) # (\TLDF|TT1|LessThan0~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|TT1|LessThan0~11_combout\,
	datab => \TLDF|TT1|LessThan0~4_combout\,
	datac => \TLDF|TT1|LessThan0~2_combout\,
	datad => \TLDF|TT1|LessThan0~8_combout\,
	combout => \TLDF|TT1|LessThan0~12_combout\);

-- Location: LCCOMB_X31_Y16_N16
\TLDF|green_light~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|green_light~5_combout\ = (\TLDF|green_light~4_combout\ & (!\TLDF|TT1|LessThan0~12_combout\)) # (!\TLDF|green_light~4_combout\ & ((\TLDF|green_light~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011100100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|green_light~4_combout\,
	datab => \TLDF|TT1|LessThan0~12_combout\,
	datad => \TLDF|green_light~combout\,
	combout => \TLDF|green_light~5_combout\);

-- Location: LCCOMB_X23_Y19_N0
\TLDF|comb~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|comb~0_combout\ = (\TLC|WideOr10~0_combout\ & (((!\TLC|state.FG~q\ & !\TLC|state.FGW~q\)))) # (!\TLC|WideOr10~0_combout\ & (!\TLC|WideOr9~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000100011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLC|WideOr9~0_combout\,
	datab => \TLC|WideOr10~0_combout\,
	datac => \TLC|state.FG~q\,
	datad => \TLC|state.FGW~q\,
	combout => \TLDF|comb~0_combout\);

-- Location: LCCOMB_X23_Y19_N2
\TLDF|green_light\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|green_light~combout\ = (!\TLDF|comb~0_combout\ & ((\TLDF|Equal1~2_combout\) # (\TLDF|green_light~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \TLDF|Equal1~2_combout\,
	datac => \TLDF|green_light~5_combout\,
	datad => \TLDF|comb~0_combout\,
	combout => \TLDF|green_light~combout\);

-- Location: LCCOMB_X23_Y19_N26
\TLDF|Equal1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|Equal1~0_combout\ = (!\TLC|WideOr10~0_combout\ & !\TLC|WideOr9~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \TLC|WideOr10~0_combout\,
	datad => \TLC|WideOr9~0_combout\,
	combout => \TLDF|Equal1~0_combout\);

-- Location: LCCOMB_X23_Y19_N30
\TLDF|red_light~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \TLDF|red_light~0_combout\ = (\TLC|state.FG~q\) # ((\TLC|state.FGW~q\) # (!\TLC|WideOr10~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \TLC|state.FG~q\,
	datac => \TLC|state.FGW~q\,
	datad => \TLC|WideOr10~0_combout\,
	combout => \TLDF|red_light~0_combout\);
END structure;


