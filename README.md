# MMS-of-fermented-milk
This repository provides the code and data we used to analyze microbe-metabolite-sensory relationship of fermented milk.<br>
## GMPT
Analysis casual microbes for different sensoy phenotype of fermented milk<br>
### Workflow
1. Differential abundance analysis: `aldex2.R`<br>
2. Select microbe with abs effect size > 0.5: `select.R`<br>
3. Calculate the spearman correlation of microbe and scores: `spearman_corr.R`<br>
### Data
1. results from aldex2 and select placed in: `./CHE`, `./FER`, `./FRU`, `./MIL`<br>
2. input data of spearman : `Correlation.xlsx`<br>
## mmvec
Explore the conditional probabilitiy of microbes and metabolites<br>
1. script: `run_mmvec.sh`<br>
2. data: `./data`<br>
3. result: `./result`<br>
## Requirements
1. [ALDEx2](https://github.com/ggloor/ALDEx2_dev)
2. [mmvec](https://github.com/biocore/mmvec)
