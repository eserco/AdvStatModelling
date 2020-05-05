#droplevels function removes the any other factor level when applied to a subset so that any further statistical anaysis do not see all of the factor levels which might have 0 observations


#tapply

tapply(some column,list of how you want to branch out columns, function-itcan be any function)

https://www.youtube.com/watch?v=evMjmM3ADJo
https://www2.stat.duke.edu/courses/Spring00/sta242/handouts/beesIII.pdf
http://stat545.com/block013_plyr-ddply.html
https://www.youtube.com/watch?v=u7TxjUI4PRI
https://www.youtube.com/watch?v=sKW2umonEvY
https://www.youtube.com/watch?v=4S2HdMVFgU8
http://blog.minitab.com/blog/adventures-in-statistics-2/regression-analysis-how-to-interpret-the-constant-y-intercept
https://www.theanalysisfactor.com/interpret-the-intercept/
  #bu son link cok onemli
  https://stats.stackexchange.com/questions/120030/interpretation-of-betas-when-there-are-multiple-categorical-variables

{r} [linked phrase] https://stats.stackexchange.com/questions/120030/interpretation-of-betas-when-there-are-multiple-categorical-variables

```{r}
#summary(lm(y~Sex+Race, d))
# ...
# Coefficients:
#             Estimate Std. Error  t value Pr(>|t|)    
# (Intercept)        1   3.85e-16 2.60e+15  2.4e-16 ***
# SexFemale          2   4.44e-16 4.50e+15  < 2e-16 ***
# RaceBlack          4   4.44e-16 9.01e+15  < 2e-16 ***
# ...
# Warning message:
#   In summary.lm(lm(y ~ Sex + Race, d)) :
#   essentially perfect fit: summary may be unreliable
#The thing to recognize about this situation is that, without an interaction #term, we are assuming parallel lines. Thus, the Estimate for the (Intercept) #is the mean of white males. The Estimate for SexFemale is the difference #between the mean of females and the mean of males. The Estimate for RaceBlack #is the difference between the mean of blacks and the mean of whites. Again, #because a model without an interaction term assumes that the effects are #strictly additive (the lines are strictly parallel), the mean of black females #is then the mean of white males plus the difference between the mean of #females and the mean of males plus the difference between the mean of blacks #and the mean of whites.
```