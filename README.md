# tidyQ - analyze RT-qPCR data with tidyverse and ggplot.

*tidyQ* is a package developed by PhDs Michigan State University in Cell and Molecular Biology program to streamline the analysis of real-time quantitative polymerase chain reaction (RT-qPCR) data gathered from ThermoFisher StepOnePlus RT-PCR or QuantStudio5 RT-PCR machines using delta-delta CT method.

This package streamlines importing of your RAW data .xlsx file from the machine to generating Fold change based on the reference gene (i.e. GAPDH), and endogenous control (i.e. non-treated).  

## __Package Pipeline:__
1. Import .xls and/or .xlsx files using __importQ()__
2. Average CT values of triplicate technical replications using __avgQ()__
3. Clean up data file into tidy format using __cleanQ()__
4. Calculate delta CT using __deltaQ()__
5. Calculate fold change using __ddQ()__. (optional step: calculate log2FC using mutate)
6. Plot your data using ggplot.


