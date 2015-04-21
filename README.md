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
2. Next, the logic for determining the row and column indexes of the grid was created.  
