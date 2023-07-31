# this script reads a list of signals where faults must be injected
#

if {[file exists "signals"] == 1} then {
   #puts "injecting faults!"
   set fault [open "signals" r]
   set signals [read $fault]
   set lines [split $signals "\n"]
   close $fault

   foreach line $lines {
	 set tokens [split $line " "]
     set number [llength $line]
	 if { $number == 4 } { 
       set force_cmd [format "force %s %s %s %s -cancel 1000 ms" [lindex $tokens 0] [lindex $tokens 1] [lindex $tokens 2] [lindex $tokens 3]]
     }
     if { $number ==6 } {
       set force_cmd [format "force -freeze %s %s @%s%s -cancel @%s%s" [lindex $tokens 0] [lindex $tokens 1] [lindex $tokens 2] [lindex $tokens 3] [lindex $tokens 4] [lindex $tokens 5]]
     }
     puts $force_cmd
     eval $force_cmd
   }
   set file_handle [open "signals" w]
   puts -nonewline $file_handle ""
   close $file_handle   
} else {
   puts "no fault injection"
}

#tx(1) 0 1 ms 2 ms

#force -freeze test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC_AP/coreRouter/tx 0 1ms -cancel @2ms
#/test_bench/HeMPS/slave2x1/RouterCCwrapped/RouterCC_AP/coreRouter/tx
#force -freeze /test_bench/HeMPS/slave2x0/RouterCCwrapped/RouterCC/rx 2#100000000 @ 1 ms -cancel @2ms