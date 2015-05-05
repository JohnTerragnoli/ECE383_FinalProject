# ECE383_FinalProject





#Milestone 1

##Detailed Architecture


**Level-1** 

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Level_1.png "level 1")

 
**Finite State Machine**
![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/FSM.png "level 1")


**Datapath and Control Unit**
![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Datapath%20and%20Control.png "level 1")

Lengths: The bit lengths of the signals cannot be designated in the schematic above; I could not figure out how to do this with the software I was using.  Additionally, I’m not sure exactly how large I would like the signals to be, so much of the following are generous assumptions.  

-	colIndex  = 10 bits unsigned
-	rowIndex = 10 bits unsigned
-	LUTvalue = 2 bits unsigned
-	whatOn = 2 bits std_logic_vector
-	row = 10 bits unsigned
-	column = 10 bits unsigned.  
-	Cw = 5 bits std_logic_vector
-	Sw = 3 bits std_logic_vector
-	Tdms = 3 bits std_logic_vector
-	Tdmsb = 3 bits std_logic_vector
-	IR Signal = 1 bit std_logic
-	Btns = 5 bits std_logic_vector


##Unit Test Plan

In order to successfully complete Milestone 1, the following tasks have to be finished.

-	Get the grid to show up 
-	Create a testbench for the FSM to ensure that it is running and outputting as expected.  
-	Be able to read appropriate values from the LUT and display them on the screen.  Test this by filling the LUT with predetermined values and seeing if they are displayed as expected.  


**Get Grid to Appear**

The first option was very easy to accomplish, as this was largely taken from Lab02 functionality, except the hash marks were removed.  

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Blank%20Grid.JPG "blank grid")


**Begin Finite State Machine (FSM)**

The testbench was made for the FSM, which was built according to the schematic shown in the [Detailed Architecture](https://github.com/JohnTerragnoli/ECE383_FinalProject/blob/master/README.md#detailed-architecture) section.  This construction is rudimentary, however, and will likely be changed as more is created within the datapath.  The screenshot of the operational FSM machine can be seen below:  

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/FSM%20works.PNG "blank grid")

The states change according to the input just as the FSM schematic [above](https://github.com/JohnTerragnoli/ECE383_FinalProject/blob/master/README.md#detailed-architecture) describes.  




**Read Stored Value and Draw on Monitor**

The third objective was slightly more difficult to achieve.  

1. First, the correct signals needed to be passed from the scopeface module, where pixels are assigned and drawn, to the datapath to be able to assign them specific colors based on game inputs.  This was done with ease and according to the picture of the datapath created in the plan. 
2. Next, the logic for determining the row and column indexes of the grid was created.  A testbench was created to ensure that the correct indexes were being referenced when running through all of the rows and columns.  An two instances of the output are shown below: 


A visual representation of what indexes should appear with what pixels is shown below: 

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/GridMap_1.JPG "gridMap")

When referencing the pixel at row = 75 and column = 104, the appropriate indexes of 1 and 1 for the row and column are output.  

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Index%20Proof%201.PNG "correct column shows up")

When referencing the pixel at row = 125 and column = 11, the index of 15 is used for each.  15 will be tied to the value 0 in the LUT, which will produce the color black.  This case shows that when either the row or the column or both are off the grid then it will only produce black on the screen.  

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Index%20Proof%202.PNG "blank referenced when off oscope")

NOTE: to achieve these simulation results, the pixel clock had to be replaced with the clk signal in the vga instatiation.  With the pixel clock in place, row and column would always get returned as UUUUUUUUUU.  


To see if the indexes could be used to draw on specific spaces, the following code was written in the datapath.  It is supposed to write a blue square at the index (1,1) and a red square at (1,2), where the index is (row,column).  

```
whatOn <= 
	"0001" when ((rowIndex = "0001") and (colIndex = "0001")) else
	"0010" when ((rowIndex = "0001") and (colIndex = "0010")) else
	"0000"; 
```

The output of this code can be seen below.  It is exactly what was expected.

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/One%20Blue%20One%20Red.JPG "blank referenced when off oscope")


Then, this same function was done using BRAM as the LUT.  Values were preloaded into BRAM and fed into the whatOn signal based on the appropriate index of the grid.  The code usd to create a checkered pattern can be seen below: 

```
sampleMemory: BRAM_SDP_MACRO
		generic map (
			BRAM_SIZE => "18Kb", 				-- Target BRAM, "9Kb" or "18Kb"
			DEVICE => "SPARTAN6", 				-- Target device: "VIRTEX5", "VIRTEX6", "SPARTAN6"
			DO_REG => 0, 							-- Optional output register disabled
			INIT => X"000000000000000000",	-- Initial values on output port
			INIT_FILE => "NONE",					-- Not sure how to initialize the RAM from a file
			WRITE_WIDTH => 18, 					-- Valid values are 1-36
			READ_WIDTH => 18, 					-- Valid values are 1-36
			SIM_COLLISION_CHECK => "NONE",	-- Simulation collision check
			SRVAL => X"000000000000000000",	-- Set/Reset value for port output
			
			INIT_00 => X"0001000200010002000100020001000200010002000100020001000200010002",
			INIT_01 => X"0002000100020001000200010002000100020001000200010002000100020001",
			INIT_02 => X"0001000200010002000100020001000200010002000100020001000200010002",
			INIT_03 => X"0002000100020001000200010002000100020001000200010002000100020001",
			INIT_04 => X"0001000200010002000100020001000200010002000100020001000200010002",
			INIT_05 => X"0002000100020001000200010002000100020001000200010002000100020001",
			INIT_06 => X"0001000200010002000100020001000200010002000100020001000200010002",
			INIT_07 => X"0002000100020001000200010002000100020001000200010002000100020001")
			
			
		port map (
			DO => whatOn_18,					-- Output read data port, width defined by READ_WIDTH parameter
			RDADDR => std_logic_vector(RdAddr),		-- Input address, width defined by port depth
			RDCLK => clk,	 				-- 1-bit input clock
			RST => (not reset),				-- active high reset
			RDEN => '1',					-- read enable 
			REGCE => '1',					-- 1-bit input read output register enable - ignored
			DI => X"0000" & std_logic_vector(whoseTurn),	-- Input data port, width defined by WRITE_WIDTH parameter
			WE => "11",						-- since RAM is byte read, this determines high or low byte
			WRADDR => std_logic_vector(WrAddr),		-- Input write address, width defined by write port depth
			WRCLK => clk,		 			-- 1-bit input write clock
			WREN => '0');				-- 1-bit input write port enable
```


This created the desired checkered output on the monitor, as seen in the picture below: 


![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Checkered.JPG "checkered pattern")


**Selection Marker**

The selection marker is supposed to be above the column currently being considered.  If the user clicks the choose column button while the marker is above a certain a column, then the game piece will be droped into that column.  The purpose of this section is to get the marker to appear on the screen in yellow above the fifth column and then move left or right based on the button presses on the FPGA board. 

The button logic created in Lab02 was used for this.  To test that this logic works, a testbench was created to see if the markerColumn signal, the place holder for the where the marker will appear, will respond appropriately to button presses.  A screenshot of the markerColumn working correctly can be seen below: 
	
![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/columnMarker_working.PNG "marker working")

Note: 00010 and 01000 represent left and right button presses, respectively.  The 0th column is on the left side and the 9th is on the far right side.  







#Milestone 2

The main purpose of the second milestone was to be able to use the buttons on the FPGA to make boxes appear on the screen.  The specific goals are shown below: 

 - To be able to fill up the LUT table by making button presses on the FPGA board.  Assuming Milestone 1 worked correctly, the LUT should properly display on the screen.  This can just be done by making button presses.  If it seems to not be working well, I will take a step back and create a test bench with simulated button presses to see how the LUT table is filling up.
 - Ensure that the pieces are filled in from the bottom.  Test by selecting a column multiple times in a row.  
 - Two different color pieces.  At first just start with one color and then switch to two.    

Here is the link to the [Level-1 design schematics](https://github.com/JohnTerragnoli/ECE383_FinalProject#detailed-architecture).  These schematics are located earlier in this repository. These schematics were used to actualize the three goals of Milestone 2.  




**Getting the Marker to Move**

The first part of the design was to get the visual marker located above the graph moving in response to the button presses.  In order to do this, a signal was created which would pass in the column index of the marker from the datapath all the way down to the scopeface module.  Inside the scopeface module, the number of the index was used to draw a yellow box above that specific column.  This was done by converting the column index into a pixel location with a LUT.  The logic for changing the column index of the marker in response to the left and right button were done in the datapath.  Therefore, pressing either th left or the right buttons on the FPGA would change the index, which would change the pixel location on the screen where the marker was drawn, which would make the marker move across the screen.  This entire process was initiated with a testbench.  once the testbench appeared to be working correctly, a .bit file was generated and tested on the FPGA.  


![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/markerColumn_tb.PNG "markerColumn works correctly")

Notice that the inputs are in blue and the internal signal is in green.  

Also, it is apparent that one up the buttons being pressed is labeled as "enabled."  This was to fix the debouncing issues with the FPGA buttons.  Once a directional button or the select button is chosen, the top button (the enable button) must be hit before a directional button or the select button can be hit again.  This keeps the marker from shooting across the screen or dropping a piece in a column multiple times on accident.  

Also, the marker was initialized to appear in the middle of the screen.  



**Deciding Write Location**
At first, I thought it would be best to develop a system so that the piece, whatever color it may be, is always written to the correct space.  The easiest way I could imagine this working would be to have a signal dedicated to how "full" each column was.  Then, when the marker is over a specific column, the program would just reference the specific signal keeping track of how full the column is.  How full the column is directly correlates into the row index the program should write to.  Ideally, when the select button is hit then, the program will write the color of whose turn it is to the index currently being referenced from the column fill signals, as well as the column index.  

The testbench below verifies how the "fill" signals can keep track of the appropriate row to write to when the market is hoving over a specific column.  

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Filling%20working.PNG "Fills working")


Note, that as the same column is chosen multiple times in a row, the chooseRow, or the first half of the writing index, is updated.  This means that the row index of where the program is writing to in the BRAM as the marker moves up and down and as spots are chosen throughout the game.  Because the chooseCol index is changing also, the program is keeping track of the correct spot to write to with respect to the column currently being considered.

After running this testbench, I generated the .bit file and uploaded it to the FPGA.  The LUT loaded and displayed on the screen exactly as expected.  Thus, the functionality for Milestone 2 was achieved.  The video of this occuring can be seen below: 

[Milestone 2 Functionality](https://www.youtube.com/watch?v=dBCBkZQb4JY&feature=youtu.be)



##Required Functionality

When I started to go for Required Functionality, I realized there were two errors with the Milestone 2 code.  These errors are shown below: 

1. BRAM is not wiped when reset is hit, meaning that old pieces are still on the screen after a reset
2. the top piece can be changed different colors when the row is completely full if that column is selected again.  


**BRAM not Wiped**
This is not the most essential issue with the game.  The rest of the game is not actually affected if the reset is never hit.  This issue will be addressed last.  


**Stabilize Top Piece**
Fixing this issue was easy.  When the row of the column was above a certain point, the ability to change colors was restricted.  However, this gave rise to another issue.  When the same column was selected, even though it was full, the color in that column wouldn't change, however, if the player moved left of right, it could change the color of the top piece in other columns to be the same as the color of the last piece in the full column.  To fix this secondary issue, I dediced to recheck my write enable signal for the BRAM.  If it is only enabled when the select button is hit this should fix the issue.  
When I checked the enable signal, it turns out that it was tied to always be high.  Realizing this, I simply created a finalizing signal, which would only be high if a viable move was actually made.  

HAD TO CHANGE THE FSM



##Steps to Required Functionality


###Identical BRAM for a Win Check
CREATED A SECOND BRAM FOR CHECKING IF A WIN HAS OCCURED. WANT THIS LOGIC TO HAPPEN IN ANOTHER MODULE BECAUSE THE CODE FOR IT IS LONG

MAKE SURE CAN READ AND WRITE FROM THE BRAM

DID THIS BY USING THE SAME WRITE SIGNALS, AND READING IN A SIMLAR FASHION

USED A PRELOADED BRAM WITH ALL BLUE, BUT NOTHING IN THE LUT WHICH IS NOT SHOWN ON THE SCREEN

TESTBENCH PROVING THIS CAN OCCUR IS SHOWN BELOW:::::

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Basic%20Check%20Top.PNG "Testbench Basic Check")

![alt tag](https://raw.githubusercontent.com/JohnTerragnoli/ECE383_FinalProject/master/Pictures/Basic%20Check%20Bottom.PNG "Testbench Basic Check2")




#B Functionality 

First, the IR signals from the remotes needed to be decoded.  

Screenshots from the remote can be seen below: 

REMOTE SCREENSHOTS. 


##ANALIZE THE SIGNAL

NOTICE THERE IS A INDEFINTE HIGH, TWO STARTING PARTS, AND 






##Code

The code used to complete Milestone 1 can be seen [here](https://github.com/JohnTerragnoli/ECE383_FinalProject/tree/master/Code).  
