----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:29:27 04/17/2015 
-- Design Name: 
-- Module Name:    Final_DP - Behavioral 
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

entity Final_DP is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
           sw : out  STD_LOGIC_VECTOR (3 downto 0);
           cw : in  STD_LOGIC_VECTOR (4 downto 0);
           IRsignal : in  STD_LOGIC;
           btns : in  STD_LOGIC_VECTOR (4 downto 0));
end Final_DP;


architecture Behavioral of Final_DP is

	signal row : unsigned (11 downto 0); 
	signal column : unsigned (11 downto 0); 
	signal whatOn : std_logic_vector(1 downto 0); 
	
	signal colIndex_calc : unsigned (11 downto 0); 
	signal rowIndex_calc: unsigned (11 downto 0); 	
	signal colIndex : unsigned (3 downto 0); 
	signal rowIndex : unsigned (3 downto 0); 
	
	signal onGrid : std_logic;
	
	
	--made up LUT?  
--	type array_type2 is array (7 downto 0) of std_logic_vector(1 downto 0); 




begin


	video_int :  video 
		 Port map ( clk => clk, 
				  reset =>reset,
				  whatOn => whatOn, 
				  tmds => tmds, 
				  tmdsb => tmdsb, 
				  row => row, 
				  column => column,
				  v_synch_out => open);
	




--test to see if it will color the square (1,1)
--whatOn <= "01" when ((rowIndex = "0001") and (colIndex = "0001")) else
--			 "10" when ((rowIndex = "0001") and (colIndex = "0010")) else
--			"00"; 






--INDEX DECODING----------------------------------------------------------------
	rowIndex <= rowIndex_calc(3 downto 0); 
	colIndex <= colIndex_calc(3 downto 0); 	
		  
		  
		 
	colIndex_calc <= ((column-20)/60) when (onGrid = '1') else
			"111111111111";
	
	rowIndex_calc <= ((row-20)/50) when (onGrid = '1') else
			"111111111111";  


	onGrid <= '1' when((row>=20) and (column>=20) and (row<=420) and (column<=620))
				else '0';
----------------------------------------------------------------------------------

end Behavioral;

