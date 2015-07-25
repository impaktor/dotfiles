# -*- shell-script -*-

# Change default line style:
# http://newsgroups.derkeiler.com/Archive/Comp/comp.graphics.apps.gnuplot/2006-06/msg00043.html

# set style line 1 lc rgb "red"     lw 1
# set style line 2 lc rgb "blue"    lw 1
# set style line 3 lc rgb "magenta" lw 1
# set style line 4 lc rgb "cyan"    lw 1
# set style line 5 lc rgb "green"   lw 1
# set style line 6 lc rgb "purple"  lw 1
# set style line 7 lc rgb "black"   lw 1

set style data linespoints

# pink
# olivegreen

# and then issue the magic command
set style increment user

set termoption dashed  # have X11 allow dashed lines as well
