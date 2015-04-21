--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

package lab2Parts is


component Final_fsm_a is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  btns : in std_logic_vector (4 downto 0); 
           sw : in  STD_LOGIC_VECTOR (3 downto 0);
           cw : out  STD_LOGIC_VECTOR (4 downto 0));
end component;



component Final_DP 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
           sw : out  STD_LOGIC_VECTOR (3 downto 0);
           cw : in  STD_LOGIC_VECTOR (4 downto 0);
           IRsignal : in  STD_LOGIC;
           btns : in  STD_LOGIC_VECTOR (4 downto 0));
end component;


	component video is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  whatOn : in std_logic_vector(1 downto 0); 
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
			  row: out unsigned(11 downto 0);
			  column: out unsigned(11 downto 0);
			  v_synch_out: out std_logic);
	end component;
	
component bram_sdp is
	Port (	clk: in  STD_LOGIC;
				reset : in  STD_LOGIC;
				cw: std_logic_vector(5 downto 0));
end component;


component counter is
    Port ( clk 	: 	in  STD_LOGIC;
           reset 	: 	in  STD_LOGIC;
           ctrl 	: 	in  STD_LOGIC_vector(1 downto 0);
			  rollover: in  unsigned(9 downto 0);
			  roll	: 	out std_logic;
           Q		: 	out unsigned(9 downto 0));
end component;


component sign2unsign is
	Port (	A : in std_logic_vector(17 downto 0);
				Y : out unsigned(17 downto 0));
	
end component;



component comparator is
    Port ( Left : in  std_logic_vector (9 downto 0);
           Right : in  unsigned (9 downto 0);
           LessThan : out  STD_LOGIC;
           Equal : out  STD_LOGIC;
           GreaterThan : out  STD_LOGIC);
end component;



--older components

--	component counter
--		Port ( clk: 	in  STD_LOGIC;
--				 reset: 	in  STD_LOGIC;
--				 crtl	: 	in  STD_LOGIC;
--				 valueCountTo:  in  unsigned(11 downto 0);
--				 roll	:  out std_logic;
--				 Q	: 	out unsigned(11 downto 0));
--	end component;


end lab2Parts;