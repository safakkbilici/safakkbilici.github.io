N <- 3
m <- 3
a <- 2
b <- 2

#par(mfrow=c(1,1))
#par(mar = c(1, 1, .0001, .0001))

dev.off()
graphics.off()

mu <- seq(from=0.01,to=0.99,by=0.01)
plot(mu,dbinom(N,m,mu),type="l",lwd = 3, col="red",xlab = expression(mu),ylab = expression(paste('f(y|', mu, ')')))
legend('topleft', inset = .02, legend = expression(paste("Likelihood Bin(m|N,",mu,")")), col = c('red'), lwd = 2)

plot(mu,dbeta(mu,N+a,N-m+b),type="l",lwd = 3,col="blue",xlab = expression(mu),ylab = expression(paste('f(', mu, '|y)')))
legend('topleft', inset = .02, legend = expression(paste("Posterior Beta(",mu,"|m+a,l+b)")), col = c('blue'), lwd = 2)

plot(mu,dbeta(mu,a,b),type="l",lwd = 3,col="black",xlab = expression(mu),ylab = expression(paste('f(', mu, ')')))
legend('topleft', inset = .02, legend = expression(paste("Prior Beta(a,b)")), col = c('black'), lwd = 2)
