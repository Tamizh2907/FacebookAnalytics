# FacebookAnalytics

## Background information about the scripts

In the munge folder, the preprocessing scripts are placed. The script "01-readzipped" contains the code to convert zipped file to data frames and the script "02-preprocessing" contains the code of two clusters. 

In the src folder, the preprocessing script "Analysis" contains the code to analyse every aspect of data from various angles to different questions and being used in 'RMarkdown' to generate report.  The script "Keyplotimages" contains the code which are being used in structural abstract. The output images are stored in graphs folder. 

## Steps to run this project:

1. Open RStudio.

2. Set the working directory to the path '/where/you/have/the/folder/FacebookAnalytics'.

3. Open the markdown file 'FacebookAnalytics.Rmd' from /FacebookAnalytics/reports/ 

4. Knit the file to execute the project - This will munge your preprocessing script using ProjectTemplate and generate a report using the instructions given in markdown script.

5. The output report will be generated in pdf format in the 'reports' folder under the parent folder.