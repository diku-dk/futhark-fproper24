set terminal pdfcairo size 3.2in,7in
set output plotfile
set autoscale fix
set lmargin 20.5
set rmargin 5
set tmargin 1
set bmargin 2
set ytics nomirror # Removes marks.
set xtics nomirror # Removes marks.
set xtics rotate by 90 left
set xtics center offset 0,-0.5

set yrange [0:*]          # start at zero, find max from the data
set style fill solid 0.2  # solid color boxes
unset key                 # turn off all titles

boxheight = 1
set offsets 0,0,0.5,0.5
set xrange [0.4:1.8]
set arrow from 0.6, graph 0 to 0.6, graph 1 front nohead lw 1 lc rgb 'black'
set arrow from 0.8, graph 0 to 0.8, graph 1 front nohead lw 1 lc rgb 'black'
set arrow from 1, graph 0 to 1, graph 1 front nohead lw 1 lc rgb 'black'
set arrow from 1, graph 0 to 1, graph 1 front nohead lw 2 lc rgb 'black'
set arrow from 1.2, graph 0 to 1.2, graph 1 front nohead lw 1 lc rgb 'black'
set arrow from 1.4, graph 0 to 1.4, graph 1 front nohead lw 1 lc rgb 'black'
set arrow from 1.6, graph 0 to 1.6, graph 1 front nohead lw 1 lc rgb 'black'
set format x "%0.1f"
unset pointintervalbox
plot datafile using (0.5*$2):0:(0.5*$2):(boxheight/2.):ytic(strcol(1)) with boxxyerror lc 'black', \
     '' using 2:($0):3:(0) with xyerrorbars pt 0 lw 2, \
     '' using (1.8):0:(sprintf("%.2f", $2)) with labels offset 2.5,0
