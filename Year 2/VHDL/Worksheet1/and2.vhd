-------------------------------------------------------------------------------
-- Title      : and2
-- Project    : 
-------------------------------------------------------------------------------
-- File       : and2.vhd
-- Author     : G502_BSc/CompSysInt  <j2-johns@lab2012.uwe.ac.uk>
-- Company    : 
-- Created    : 2012-09-27
-- Last update: 2012-09-27
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 2 input logical AND gate
-------------------------------------------------------------------------------
-- Copyright (c) 2012 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2012-09-27  1.0      j2-johns	Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity and2 is

port (
  x, y : in  std_logic;                  -- inputs
  z   : out std_logic);                 -- output
end and2;

architecture ex1 of and2 is

begin  -- ex1

  z <= x and y;

end ex1;
