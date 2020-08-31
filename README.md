# tidyQ - analyze RT-qPCR data with tidyverse and ggplot.

*tidyQ* is a package developed by graduate students of Michigan State University to streamline the analysis of real-time quantitative polymerase chain reaction (RT-qPCR) data gathered from ThermoFisher StepOnePlus RT-PCR or QuantStudio5 RT-PCR machines using delta-delta CT method.

This package streamlines importing of your RAW data .xlsx file from the machine to generating Fold change based on the reference gene (i.e. GAPDH), and endogenous control (i.e. non-treated).  

# Limitations
Currently, cannot process multiple reference genes

*Package Pipeline: *
1. Import .xls and/or .xlsx files using importQ()
2. Average CT values of triplicate technical replications using avgQ()
3. Clean up data file into tidy format using cleanQ()
4. calculate delta CT using deltaQ()
5. calculate fold change using ddQ(). (optional step: calculate log2FC using mutate)
6. Plot your data using ggplot.
