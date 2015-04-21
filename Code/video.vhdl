----------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer: C2C John Paul Terragnoli
-- 
-- Create Date:    13:58:31 01/22/2015 
-- Module Name:    video - structural 
-- Project Name: lab01
-- Target Devices: ATLYS Spartan 6
-- Tool versions: 1.0
-- Description: Converts signals into outputs on the screen (output as HDMI).  
--				Does so by counting through all of the pixels on the screen.  
--
-- Dependencies: VGA, doubleCounter, counter, h_synch, v_synch, scopeFace
--
-- Revision: none				
-- Version 1.0 - File Created
-- Additional Comments: none
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;
use work.lab2Parts.all;	


entity video is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  whatOn : in std_logic_vector(1 downto 0); 
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
			  row: out unsigned(11 downto 0);
			  column: out unsigned(11 downto 0);
			  v_synch_out : out std_logic);
end video;

architecture structure of video is

	signal red, green, blue: STD_LOGIC_VECTOR(7 downto 0);
	signal pixel_clk, serialize_clk, serialize_clk_n, blank, h_sync, v_sync: STD_LOGIC;
	signal n_reset, clock_s, red_s, green_s, blue_s: STD_LOGIC;
	signal h_synch, v_synch: STD_LOGIC;

	component vga is
	Port(	clk: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			whatOn: in std_logic_vector(1 downto 0); 
			h_sync : out  STD_LOGIC;
			v_sync : out  STD_LOGIC; 
			blank : out  STD_LOGIC;
			r: out STD_LOGIC_VECTOR(7 downto 0);
			g: out STD_LOGIC_VECTOR(7 downto 0);
			b: out STD_LOGIC_VECTOR(7 downto 0);
			row: out unsigned(11 downto 0);
			column: out unsigned(11 downto 0));
	end component;

begin

	v_synch_out <= v_synch; 
	------------------------------------------------------------------------------
	-- The reset for the digital clock manager is active high (see page 7) here:
	-- http://www.xilinx.com/support/documentation/application_notes/xapp462.pdf
	-- However, the logical choice for a reset on the Digilent Atlys board is the 
	-- red button labeledl "RESET" connected to pin T15, is nominally logic 1 and 
	-- pulled logic 0 when is pressed. 	Hence, we need to invert the reset.
	------------------------------------------------------------------------------
	n_reset <= not reset;

	------------------------------------------------------------------------------
	-- The digital clock manager is a built-in function on the Spartan 6 chip.
	-- Consequently you will need to include UNISIM.VComponents.all; at the top.
	-- This clock divider creates a 12.5Mhz pixel clock from 100MHz clock. 
	------------------------------------------------------------------------------
	inst_DCM_pixel: DCM
	generic map(	CLKFX_MULTIPLY => 2,
						CLKFX_DIVIDE   => 8,
						CLK_FEEDBACK   => "1X")
	port map(		clkin => clk,
						rst   => n_reset,
						clkfx => pixel_clk,
						clkfx180 => open);

	------------------------------------------------------------------------------
	-- This clock divider creates HDMI serial output clock
	------------------------------------------------------------------------------
    inst_DCM_serialize: DCM
    generic map(	CLKFX_MULTIPLY => 10, -- 5x speed of pixel clock
						CLKFX_DIVIDE   => 8,
						CLK_FEEDBACK   => "1X")
    port map(		clkin => clk,
						rst   => n_reset,
						clkfx => serialize_clk,
						clkfx180 => serialize_clk_n);

	------------------------------------------------------------------------------
	-- H and V synch are used to interface to the DVID module
	------------------------------------------------------------------------------
	Inst_vga: vga
		PORT MAP(	clk => pixel_clk,
--		PORT MAP(	clk => clk,
						reset => reset,
						whatOn => whatOn,
						h_sync => h_sync,
						v_sync => v_sync,
						blank => blank,
						r => red,
						g => green,
						b => blue,
						row => row,
						column => column); 

	------------------------------------------------------------------------------
	-- This module was provided to us free of charge.  It converts a VGA signal
	-- into DVID/HDMI signal.
	------------------------------------------------------------------------------	 
    inst_dvid: entity work.dvid 
		port map(	clk       => serialize_clk,
						clk_n     => serialize_clk_n, 
						clk_pixel => pixel_clk,
						red_p     => red,
						green_p   => green,
						blue_p    => blue,
						blank     => blank,
						hsync     => h_sync,
						vsync     => v_sync,
						red_s     => red_s,
						green_s   => green_s,
						blue_s    => blue_s,
						clock_s   => clock_s		);


	------------------------------------------------------------------------------
	-- This HDMI signals are high speed so buffer to insure signal integrity.
	------------------------------------------------------------------------------
	OBUFDS_blue  : OBUFDS port map
        ( O  => TMDS(0), OB => TMDSB(0), I  => blue_s  );
	OBUFDS_red   : OBUFDS port map
        ( O  => TMDS(1), OB => TMDSB(1), I  => green_s );
	OBUFDS_green : OBUFDS port map
        ( O  => TMDS(2), OB => TMDSB(2), I  => red_s   );
	OBUFDS_clock : OBUFDS port map
        ( O  => TMDS(3), OB => TMDSB(3), I  => clock_s );

end structure;
