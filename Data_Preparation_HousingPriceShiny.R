#   load the data
load(url("https://github.com/HDuma/Advanced_R_Shiny/blob/main/StateHousingPriceData.RData?raw=true"))
load(url("https://github.com/HDuma/Advanced_R_Shiny/blob/main/US_HousingPriceData.RData?raw=true"))


#    let's merge our data together so that we only have one data file we need to work with. 
#   STATE DATA - rename the columns 
colnames(States_AnnualHousePriceIndex)
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "Annual Change (%)"] <- "State_Annual_Change"
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "HPI"] <- "State_HPI"
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "HPI with 1990 base"] <- "State_HPI_1990_base"
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "HPI with 2000 base"] <- "State_HPI_2000_base"

#   US DATA - rename the columns to identify 
colnames(US_AnnualHousePriceIndex)
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "Annual Change (%)"] <- "US_Annual_Change"
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "HPI"] <- "US_HPI%"
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "HPI with 1990 base"] <- "US_HPI_1990_base"
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "HPI with 2000 base"] <- "USHPI_2000_base"

#   change year variable to numeric so we can perform the merge
US_AnnualHousePriceIndex$Year = as.numeric(US_AnnualHousePriceIndex$Year)

#    merge this with the dataframes using a left join so that we have a  large data set
Final_Data = left_join(States_AnnualHousePriceIndex, US_AnnualHousePriceIndex, by = c("Year"))

# now bring in the dataset that contains the lat and long data of each state and conduct a merge with the final data.set
LAT_LONG_Data <- read_excel("~/Desktop/Gradute_School/Advanced R Programming/Project 2 - Shiny/LAT_LONG_Data.xlsx")

# remove the name column, it is unnecessary
LAT_LONG_Data = LAT_LONG_Data[-c(4)]

# rename the state column to a capital S
names(LAT_LONG_Data)[names(LAT_LONG_Data) == "state"] <- "Abbreviation"

# merge the data now
Final_Data = left_join(Final_Data, LAT_LONG_Data, by = "Abbreviation")

# remove missing data 
Final_Data = na.omit(Final_Data)
                       
#   Save the data 
save(Final_Data,  file = "Final_Data.RData")
