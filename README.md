# ECE383_FinalProject


#Problem History
1. ERROR:NgdBuild:604 - logical block 'fsm' with type 'Final_fsm_a' could not be
   resolved. A pin name misspelling can cause this, a missing edif or ngc file,
   case mismatch between the block name and the edif or ngc file name, or the
   misspelling of a type name. Symbol 'Final_fsm_a' is not supported in target
   'spartan6'.
why is this occuring?  Happens whenever an output in a specific module is not designated in the module.  Like assign output <= "0000" just to have this in the begin statement so you stop getting this error while you're hooking everything up.  











#Milestone 1

In order to successfully complete milestone 1, the following tasks have to be finished.

-	Get the grid to show up 
-	Create a testbench for the FSM to ensure that it is running and outputting as expected.  
-	Be able to read appropriate values from the LUT and display them on the screen.  Test this by filling the LUT with predetermined values and seeing if they are displayed as expected.  



The first option was very easy to accomplish, as this was largely taken from Lab02 functionality.  

INSERT PICTURE OF GRID SHOWING UP ON SCREEN



TALK ABOUT FSM TESTBENCH




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
