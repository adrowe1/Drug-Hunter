# Drug-Hunter
R-shiny tools for preparing and interpreting high throughput drug screens

### Brief overview of TODOs and functions
1. given a library of drugs to choose from, and a map of the well coordinates for each compound, create a picking list to distribute titrations of compounds between the necessary number of 384 well plates. 
  - make this flexible in terms of number of titrations, adding blank controls and the number of wells in the plates - potentially have a list of standard plate sizes to choose between.
  - set a seed for randomization so repeated generations of the same setup give a standard result.  
  - at some point it would be nice to use the originating drug library description from the supplier as the initial data source, so users can simply put in the url from the supplier, or a product code, to create the picking list. 
  - store this picking pattern in a sqlite database file - alternatives should be flexibly available, but this will be a reasonable default setup. we just need to be sure that the data is always retrievable. It should also be downloadable by the user for extra safety. 
  - need to be able to store custom annotations for drug libraries for clustering purposes later. 
  - picking list needs to be given a unique ID that can then be used in combination with other results from the plate reading robot to cross reference data instantaneously - probably best to expect the uniqueID to be included in the filename, and have a graceful failure mode in case information is lost along the way. Graceful failure should allow manual upload of the original picking file in a standard format. 
2. manually define the picking file and annotations either from the stored alternatives, or by uploading them where necessary. standardized format(s) will be necessary here and the choice of adding them to the existing database of picking data and annotations
3. import and visually inspect a set of plates for a single sample.
  - perform a checksum (tools::md5sum()) on the imported file and store this in a database alongside the filename and date, for future use. Also require healthy donor or patient radio button to classify. generate a unique random ID for the sample, and offer possibility of editing this.
  - offer the option of storing the data in the database for later use. use the checksum to determine whether already imported. require a brief descriptor of sample before it can be saved.
4. Inspect a sample, plot, sort by drug efficiency, search a single drug or a set of drugs and plot, cluster by annotation and plot
5. download a report containing results. 
6. potential to add genetic information to annotations.
7. Setup choose USER and store user info in DB with relevant files


## Structure of data files for upload

```
|-data.zip
   |
   |-donor 1
   |  |-dispensing
   |  |  |-\*Transfer\*.csv
   |  |-plates 
   |     |-*1.csv
   |     |-*2.csv
   |     |- ...
   |
   |-donor 2
        |-dispensing
        |  |-\*Transfer\*.csv
        |-plates 
           |-*1.csv
           |-*2.csv
           |- ...
 
```



### Build package containing the necessary functions

filter data for outliers

best fit function for drug response

cluster by annotation
