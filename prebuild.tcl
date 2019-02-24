proc make_header {} {
	set cmd {date +%Y/%m/%d/%H/%M/%S}
	puts $cmd

	set ret [eval exec $cmd]
	puts $ret

	set dst [split $ret '/']

	set fd [open ../src/config.h w]
	puts $fd [format "#ifndef _config_h_"]
	puts $fd [format "#define _config_h_"]
	puts $fd [format ""]
	puts $fd [format "#define DATE_YEAR  (%d)" [lindex $dst 0]]
	puts $fd [format "#define DATE_MONTH (%d)" [lindex $dst 1]]
	puts $fd [format "#define DATE_DAY   (%d)" [lindex $dst 2]]
	puts $fd [format "#define DATE_HOUR  (%d)" [lindex $dst 3]]
	puts $fd [format "#define DATE_MIN   (%d)" [lindex $dst 4]]
	puts $fd [format "#define DATE_SEC   (%d)" [lindex $dst 5]]
	puts $fd [format ""]
	puts $fd [format "#endif /* _config_h_ */"]
	close $fd
}

make_header

exit 0
