#Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution
profit <- revenue - expenses
profitAfterTax <- profit - (round(profit*0.3,2))
AfterTaxProfitMargin <- profitAfterTax/revenue
goodMonths <- profitAfterTax > mean(profitAfterTax)
table(goodMonths)
badMonths <- profitAfterTax < mean(profitAfterTax)
table(badMonths)
bestMonth <- which.max(profitAfterTax) #dec
worstMonth <- which.min(profitAfterTax) #mar
#worstMonth <- !bestMonth

roundProfit <- round(profit)
roundProfitAfterTax <- round(profitAfterTax)
AfterTaxProfitMarginPercent <- round(AfterTaxProfitMargin,2)*100

#figures in $1000's of dollars
revenue.1000 <- round(revenue/1000)
expenses.1000 <- round(expenses/1000)
roundProfit.1000 <- round(roundProfit/1000)
roundProfitAfterTax.1000 <- round(roundProfitAfterTax/1000)

#present
revenue.1000
expenses.1000
roundProfit.1000
AfterTaxProfitMarginPercent
roundProfitAfterTax.1000
goodMonths
badMonths
bestMonth
worstMonth

#matrix
rbind(revenue.1000,
      expenses.1000,
      roundProfit.1000,
      AfterTaxProfitMarginPercent,
      roundProfitAfterTax.1000,
      goodMonths,
      badMonths,
      bestMonth,
      worstMonth)