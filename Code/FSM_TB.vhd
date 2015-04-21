--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:09:31 04/21/2015
-- Design Name:   
-- Module Name:   C:/Users/C16John.Terragnoli/Documents/Junior year/Academics/Second Semester/ECE 383/ISE Projects/Final_Project_a/FSM_TB.vhd
-- Project Name:  Final_Project_a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Final_fsm_a
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FSM_TB IS
END FSM_TB;
 
ARCHITECTURE behavior OF FSM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Final_fsm_a
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         btns : IN  std_logic_vector(4 downto 0);
         sw : IN  std_logic_vector(3 downto 0);
         cw : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal btns : std_logic_vector(4 downto 0) := (others => '0');
   signal sw : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal cw : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Final_fsm_a PORT MAP (
          clk => clk,
          reset => reset,
          btns => btns,
          sw => sw,
          cw => cw
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

		RESET <= '1', '0' after 100 ns, '1' after 120 ns; 
		
		btns <= "01000", "00000" after 20 ns, "00010" after 30 ns, "00000" after 40 ns, "10000" after 50 ns; 
		
		sw(0) <= '0', '1' after 35 ns; 
		
		sw(1) <= '0', '1' after 80 ns; 
		
		
		
		
		
		wait;
   end process;

END;
