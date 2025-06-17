# Longfin Snapshot ESP Methods

## Page 1

### Life History Information and Conceptual Model

Text included under the life history section is a collaborative result of discussions with the Research Track Working Group, life history subgroup, and Squid Squad, as well as literature review and pertinent information from other working papers included in the 2026 stock assessment.
The life cycle conceptual model was produced in Google slides (https://docs.google.com/presentation/d/1tvOgQ4hzIol4jEuNMC144ieRSAM8K4CBUagFskLK8js/edit?slide=id.g305a4b6bdb4_0_1#slide=id.g305a4b6bdb4_0_1) and saved as a PNG in the ‘images’ folder to be read into ‘report_card_template.qmd’

### SQUIBS Plot

The age frequency plot from SQUIBS was made by Sarah Salois. Code to reproduce this plot is unavailable, however updated SQUIBS data may be obtained from Gina Scott (gina.scott@noaa.gov).

### Risk Assessment Information and Plot

Implications on longfin squid came from the 2025 MAFMC Risk Assessment document (https://static1.squarespace.com/static/511cdc7fe4b00307a2628ac6/t/67d45b1680e8654ecaf1b98e/1741970199497/b_Draft+MAB_RiskAssess_2025.pdf). Tables 1 and 2 describe all risk elements and categorization. Tables 10 and 12 highlight the scores of each risk element on a species level.
Information from Tables 10 and 12 (number of low, low-mod, mod-high, and high risk elements) are used as parameters in the function ‘plot_risk_longfin.R’ in the ‘scripts’ folder. This function produces the risk bar chart.

## Page 2

### Commercial Indicators (landings, # vessels, revenue)

Raw commercial data from the CAMS database as well as implications to longfin was provided by Samantha Werner (samantha.werner@noaa.gov). Please reach out to Samantha for commercial data for any further iterations of this Snapshot ESP. Data for the 2026 longfin ESP can be found under ‘inputs’ as ‘SOCIEOECONOMIC_COMMERCIAL_INDICATORS_FINAL.csv’. Code to plot commercial indicators is located in the ‘scripts’ folder in ‘plot_com_indicators.R’.

### Western Gulf Stream Index

Values for the western Gulf Stream Index are updated annually as part of the State of the Ecosystem Report. Raw data is found in the ecodata package as `ecodata::gsi`. Code to plot the GSI indicator is located in the ‘scripts’ folder in ‘plot_gsi_indicator.R’.

### Bottom Temperature 

GLORYS monthly bottom temperature in the ECOMON regions was provided to the working group by Kim Hyde (kimberly.hyde@noaa.gov) and Joe Caracappa (joseph.caracappa@noaa.gov). Data used for the 2026 longfin ESP is in the ‘inputs’ folder as ‘GLORYS_monthly_BottomT_ECOMON6_1993_2024.csv’. Code to subset the data into the Mid-Atlantic Bight and Southern New England regions and plot the time series is in the ‘scripts’ folder as ‘plot_bottomT_indicator.R’. 

## Snapshot Rendering

`report_card_template.qmd` can be edited to produce the first page of the Snapshot ESP. `tex_template.tex` is a necessary helper file, which can be updated if desired. Rendering `test_longfin_report_card.qmd` will produce a PDF (report_card_template.pdf).

`table_template.Rmd` can be run to create the summary table of indicator data. `table_template.xlsx` should  be updated with relevant indicator information, including file paths to figures. `table_template.Rmd` should not be updated.
Plotting code to run and save images for each indicator (bottomT, GSI, commercial) can be found in the 'scripts' folder. The function `plt_indicator` in `plot_indicator_ts.R` is used to plot all indicator time series, however each individual plot_xxx.R file should be used to plot the time series for that specific indicator. 




This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.
