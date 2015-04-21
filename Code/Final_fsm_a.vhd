----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:33 04/17/2015 
-- Design Name: 
-- Module Name:    Final_fsm_a - Behavioral 
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

entity Final_fsm_a is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  btns : in std_logic_vector (4 downto 0);  
           sw : in  STD_LOGIC_VECTOR (3 downto 0);
           cw : out  STD_LOGIC_VECTOR (4 downto 0));
end Final_fsm_a;



architecture Behavioral of Final_fsm_a is


--creates the different types of states
type stateType is (init, waitChoose, moveRight, moveLeft, checkValid,writeToken,checkEnd, endScreen); 
signal state: stateType; 
	
	
begin




--SW-------------------------------------------
	--sw(0) = valid or not
	--sw(1) = end of game or not
-----------------------------------------------
--	cw <= "00000"; 
	
	--NEXT STATE LOGIC
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(reset = '0') then 
				state <= init;
			else 
			
			
				CASE state is 

					when init =>
					
					
						state <= waitChoose; 
						
					when waitChoose =>
						--need buttons in this module
						if(btns = "00010") then 
							state <= moveLeft; 
						elsif(btns = "01000") then 
							state <= moveRight; 
						elsif(btns = "10000") then 
							state <= checkValid; 
						else
							state <= waitChoose; 
						end if; 
							
						
						
					when moveRight =>
						--do the logic to keep the marker on the screen in the datapath.  
						state <= waitChoose; 
					
					when moveLeft =>
						state <= waitChoose; 
					
					when checkValid =>
						if(sw(0) = '0') then 
							state <= waitChoose; 
						elsif(sw(0) = '1') then 
							state <= writeToken; 
						end if; 
						
					when writeToken =>
						state <= checkEnd; 
						
					when checkEnd =>
						if(sw(1) = '0') then
							state <= waitChoose; 
						elsif(sw(1) = '1') then 
							state <= endScreen; 
						end if; 
						
					when endScreen =>
						if(reset = '0') then 
							state <= init; 
						end if; 

					end case; 
				end if; 
		end if;
	end process;
	
	
--CW-----------------------------------------------------
	--cw(0) : 0 means keep playing 1 means winning screen
	--cw(1) : 0 means stay put 1 is move marker left
	--cw(2) : 0 is stay put 1 is move marker right
	--cw(3) : 0 is save color to that column and change turn
	--cw(4) : currently unused.  
---------------------------------------------------------
	
	--output logic
	cw <= 
			"00000" when (state = init) else
			"00000" when (state = waitChoose) else
			"00010" when (state = moveLeft) else
			"00100" when (state = moveRight) else
			"00000" when (state = checkValid) else
			"01000" when (state = writeToken) else
			"00000" when (state = checkEnd) else
			"00001" when (state = endScreen) else
			"00000";
	
	
	
	
end Behavioral;

