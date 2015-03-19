## This file creates the function createLabels which works to acquire node labels
## and ID numbers applied to a specific file in coding done in RQDA for use in 
## Gephi as part of the Qualitative Network Analytical Method.
## The function produces a file nodeLabels.csv that, you will be surprised to 
## learn, can be imported into Gephi to produce node labels as part of network 
## visualisation.

## createLabels is passed two arguments: the file id and the code category - 
## called file_ID and codeLayer respectively - that may be objects or simply 
## entered as integers (e.g. createLabels(3, 1)). This requires knowledge of 
## exactly which file and code category you wish to obtain code labels from.

## The function has three prerequisites before execution:
## 1. The working directory must be set to that containing the .rqda file you 
## wish to interrogate;
## 2. The .rqda file must be opened using the following function:
## openProject("filepath", updateGUI=FALSE);
## 3. The package dplyr must be installed in R, so it can be called;


createLabels <- function(file_ID, codeLayer) {
        library(dplyr)
        
        fullList <- RQDAQuery("SELECT coding.cid, coding.fid, freecode.name, 
                treecode.catid FROM coding JOIN freecode ON 
                coding.cid=freecode.id JOIN treecode ON coding.cid=treecode.cid 
                WHERE coding.status='1'") 
        
        nodeLabels <- filter(fullList, fid==file_ID, catid==codeLayer)
        nodeLabels <- unique(nodeLabels)
        colnames(nodeLabels) <- c("id", "file", "label", "codeLayer")
        nodeLabels <- nodeLabels[, c(1, 3, 4, 2)]
        
        write.csv(nodeLabels, file="nodeLabels.csv", row.names=FALSE)
}





