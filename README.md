# ECE383_FinalProject


#Problem History
1. ERROR:NgdBuild:604 - logical block 'fsm' with type 'Final_fsm_a' could not be
   resolved. A pin name misspelling can cause this, a missing edif or ngc file,
   case mismatch between the block name and the edif or ngc file name, or the
   misspelling of a type name. Symbol 'Final_fsm_a' is not supported in target
   'spartan6'.
why is this occuring?  Happens whenever an output in a specific module is not designated in the module.  Like assign output <= "0000" just to have this in the begin statement so you stop getting this error while you're hooking everything up.  
