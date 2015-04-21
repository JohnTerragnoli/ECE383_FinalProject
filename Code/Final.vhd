----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:39:49 04/17/2015 
-- Design Name: 
-- Module Name:    Final - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;
use work.lab2Parts.all;	

entity Final is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
           IRsignal : in  STD_LOGIC;
           btns : in  STD_LOGIC_VECTOR (4 downto 0));
end Final;

architecture Behavioral of Final is

	signal sw : STD_LOGIC_VECTOR (3 downto 0);
	signal cw : STD_LOGIC_VECTOR (4 downto 0);


begin

	datapath: Final_DP 
		 Port map( clk => clk, 
				  reset => reset, 
				  tmds => tmds,
				  tmdsb => tmdsb,
				  sw => sw, 
				  cw => cw, 
				  IRsignal => '0',  --this will be for later!!!  should hook this up to a jb pin.  
				  btns => btns);
	



	fsm: Final_fsm_a
		Port map(clk => clk, 
				reset => reset, 
				btns => btns,
				sw => sw, 
				cw => cw); 

				  
end Behavioral;


