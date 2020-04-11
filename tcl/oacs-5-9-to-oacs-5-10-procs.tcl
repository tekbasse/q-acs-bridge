ad_library {
    routines for adapting to an evolving OpenACS Framework
    @creation-date 11 April 2020
}

namespace util {}

adp_proc -public util::random {

}

# Following from acs-tcl/tcl/utilities-procs.tcl

namespace eval util {}
namespace eval oacs_util {}

ad_proc -public util::random_init {seed} {
    Seed the random number generator.
} {
    nsv_set rand ia 9301
    nsv_set rand ic 49297
    nsv_set rand im 233280
    nsv_set rand seed $seed
}


ad_proc -public util::random {} {
    Return a pseudo-random number between 0 and 1. The reason to have
    this proc is that seeding can be controlled by the user and the
    generation is independent from tcl.

    @see util::random_init
} {
    nsv_set rand seed [expr {([nsv_get rand seed] * [nsv_get rand ia] + [nsv_get rand ic]) % [nsv_get rand im]}]
    return [expr {[nsv_get rand seed]/double([nsv_get rand im])}]
}


ad_proc -public util::random_range {range} {
    Returns a pseudo-random number between 0 and range.

    @return integer
} {
    incr range
    return [expr {int([util::random] * $range) % $range}]
}


ad_proc -public util::min { args } {
    Returns the minimum of a list of numbers. Example: <code>min 2 3 1.5</code> returns 1.5.

    Since Tcl8.5, numerical min and max are among the math functions
    supported by expr. The reason why this proc is still around is
    that it supports also non-numerical values in the list, in a way
    that is not so easily replaceable by a lsort idiom (but could).

    @see expr
    @see lsort

    @author Ken Mayer (kmayer@bitwrangler.com)
    @creation-date 26 September 2002
} {
    set min [lindex $args 0]
    foreach arg $args {
        if { $arg < $min } {
            set min $arg
        }
    }
    return $min
}


ad_proc -public util::max { args } {
    Returns the maximum of a list of numbers. Example: <code>max 2 3 1.5</code> returns 3.

    Since Tcl8.5, numerical min and max are among the math functions
    supported by expr. The reason why this proc is still around is
    that it supports also non-numerical values in the list, in a way
    that is not so easily replaceable by a lsort idiom (but could).

    @see expr
    @see lsort

    @author Lars Pind (lars@pinds.com)
    @creation-date 31 August 2000
} {
    set max [lindex $args 0]
    foreach arg $args {
        if { $arg > $max } {
            set max $arg
        }
    }
    return $max
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
