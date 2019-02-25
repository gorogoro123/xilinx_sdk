#https://stackoverflow.com/questions/2110864/handling-numbers-with-leading-zeros-in-tcl
proc forceInteger { x } {
    set count [scan $x %d%s n rest]
    if { $count <= 0 || ( $count == 2 && ![string is space $rest] ) } {
        return -code error "not an integer: \"$x\""
    }
    return $n
}

proc make_header {} {
	set ret [clock format [clock seconds] -format {%Y/%m/%d/%H/%M/%S}]
	puts $ret

	set dst [split $ret '/']

	set fd [open ../src/config.h w]
	puts $fd [format "#ifndef _config_h_"]
	puts $fd [format "#define _config_h_"]
	puts $fd [format ""]
	puts $fd [format "#define DATE_YEAR  (%d)" [forceInteger [lindex $dst 0]]]
	puts $fd [format "#define DATE_MONTH (%d)" [forceInteger [lindex $dst 1]]]
	puts $fd [format "#define DATE_DAY   (%d)" [forceInteger [lindex $dst 2]]]
	puts $fd [format "#define DATE_HOUR  (%d)" [forceInteger [lindex $dst 3]]]
	puts $fd [format "#define DATE_MIN   (%d)" [forceInteger [lindex $dst 4]]]
	puts $fd [format "#define DATE_SEC   (%d)" [forceInteger [lindex $dst 5]]]
	puts $fd [format ""]
	puts $fd [format "#endif /* _config_h_ */"]
	close $fd
}

make_header

exit 0
