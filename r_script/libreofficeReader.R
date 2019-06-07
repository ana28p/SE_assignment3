
#read data
base_elements <- read.csv(file.path("../csv_data/", "libreoffice_data.csv"))

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

#print summary
summary(base_elements)
summary(elements)
