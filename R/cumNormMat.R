#' Cumulative sum scaling factors.
#' 
#' Calculates each column's quantile and calculates the sum up to and including
#' that quantile.
#' 
#' 
#' @param obj A matrix or MRexperiment object.
#' @param p The pth quantile.
#' @param sl The value to scale by (default=1000).
#' @return Returns a matrix normalized by scaling counts up to and including
#' the pth quantile.
#' @seealso \code{\link{fitZig}} \code{\link{cumNorm}}
#' @examples
#' 
#' data(mouseData)
#' head(cumNormMat(mouseData))
#' 
cumNormMat <-
function(obj,p= cumNormStatFast(obj),sl = 1000){
####################################################################################
#   Calculates each column's quantile
#    and calculated the sum up to and
#    including that quantile.
####################################################################################
	x = returnAppropriateObj(obj,FALSE,FALSE)
    xx=x
	xx[x==0] <- NA
	
	qs=colQuantiles(xx,probs=p,na.rm=TRUE)
	
	newMat<-sapply(1:ncol(xx), function(i) {
				   xx=(x[,i]-.Machine$double.eps)
				   sum(xx[xx<=qs[i]])
				   })
	nmat<-sweep(x,2,newMat/sl,"/")
	return(nmat)
}
