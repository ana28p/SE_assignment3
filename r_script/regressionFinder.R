vif_filter <- function(elements) {
  
  output = list("added_lines", "removed_lines", "no_files", "sources")
  for (i1 in input) {
    for (i2 in input) {
      for (o1 in output) {
        if (i1 != i2) {
          res = vif(lm(as.formula(paste(o1, "~", i1, "+", i2, sep = "")), data=elements))
          print(res)
          if (res > 3.0) {
            return(i2);
          }
        }
      }
    }
  }
  return("");
}

library(car)
eclipseSet = TRUE

this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

#read data
if (eclipseSet) {
  base_elements <- read.csv(file="../csv_data/eclipse_data.csv")
} else {
  base_elements <- read.csv(file="../csv_data/libreoffice_data.csv")
}

#take list length and the number of elements to be removed from the beginning and end of the lists

#keep base
elements <- base_elements

var_percentage <- 2

change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

cat("Initial length: ", data_length)

#remove elements

#order by ecosystem_tenure
elements <- elements[order(elements$ecosystem_tenure), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by changes
elements <- elements[order(elements$changes), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by review_tenure
elements <- elements[order(elements$review_tenure), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by reviews
elements <- elements[order(elements$reviews), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by added_lines
elements <- elements[order(elements$added_lines), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by removed_lines
elements <- elements[order(elements$removed_lines), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by no_files
elements <- elements[order(elements$no_files), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by sources
elements <- elements[order(elements$sources), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by blocking_tenure
elements <- elements[order(elements$blocking_tenure), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)
elements_to_remove <- as.integer(data_length * var_percentage / 100)

#order by blocking_activity
elements <- elements[order(elements$blocking_activity), ]
#remove from the end 
elements <- elements[c(-(data_length - elements_to_remove + 1): -data_length), ]
#remove from the beginning 
elements <- elements[c(-1:-elements_to_remove), ]

#recalculate
change_ids <- elements$change_id
data_length <- length(change_ids)

cat("After remove length: ", data_length)

#finally order by change_id
elements <- elements[order(elements$change_id), ]

#filter to high vif values

# Show that the vif values are below 3.0 for all values
print(vif(lm(review_time~ecosystem_tenure+change_id+review_tenure+reviews+blocking_tenure+blocking_activity+added_lines+removed_lines+sources, data=elements)))

# Add the log columns
input = list("ecosystem_tenure", "change_id", "review_tenure", "reviews", "blocking_tenure", "blocking_activity", "added_lines", "removed_lines", "sources")
for (c in input) {
  nc = paste(c, "log", sep = "")
  elements[[nc]] <- log(elements[[c]] + 0.5) 
}

reg = lm(review_time~ecosystem_tenure+change_id+review_tenure+reviews+blocking_tenure+blocking_activity+added_lines+removed_lines+sources+
                     ecosystem_tenurelog+change_idlog+review_tenurelog+reviewslog+blocking_tenurelog+blocking_activitylog+added_lineslog+
                      removed_lineslog+sourceslog, data=elements)
print(reg)
plot(fitted(reg), residuals(reg), xlab="Fitted", ylab="Residuals")
plot(qqnorm(residuals(reg), ylab="Residuals"))
summary(reg, signif.stars=TRUE)
summary(reg)$adj.r.squared	
anova(reg)

#print summary
#summary(base_elements)
#summary(elements)

