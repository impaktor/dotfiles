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

#b3b3b3
#a6d854
#8da0cb
#e78ac3
#66c2a5
#e5c494
#ffd92f

choose(n,k) = gamma(n+1) / (gamma(k+1) * gamma(n-k+1))
binomial(k,p,n) = choose(n,k) * p**k * (1-p)**(n-k)
poisson(k,lambda) = lambda**k / gamma(k+1) * exp(-lambda)
gauss(x,mu,sigma) = 1./sqrt(pi*2*sigma**2) * exp(-(x-mu)**2/(2*sigma**2))
