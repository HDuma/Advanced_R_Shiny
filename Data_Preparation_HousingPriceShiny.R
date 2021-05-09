#   load the data
load(url("https://github.com/HDuma/Advanced_R_Shiny/blob/main/CountyHousingPriceData.RData?raw=true"))
load(url("https://github.com/HDuma/Advanced_R_Shiny/blob/main/StateHousingPriceData.RData?raw=true"))
load(url("https://github.com/HDuma/Advanced_R_Shiny/blob/main/US_HousingPriceData.RData?raw=true"))


#    let's merge our data together so that we only have one data file we need to work with. 
#   STATE DATA - rename the columns 
colnames(States_AnnualHousePriceIndex)
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "Annual Change (%)"] <- "State_Annual_Change"
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "HPI"] <- "State_HPI"
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "HPI with 1990 base"] <- "State_HPI_1990_base"
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "HPI with 2000 base"] <- "State_HPI_2000_base"

#   remove the first column "state" from the states data since we already have an abbreviation column we will use to merge the data 
States_AnnualHousePriceIndex = States_AnnualHousePriceIndex[-c(1)]

#   now change the name of the abbreviation column to state since we'll be merging based on that column
names(States_AnnualHousePriceIndex)[names(States_AnnualHousePriceIndex) == "Abbreviation"] <- "State"


#    merge this with the dataframes using a left join so that we have a  large data set
Final_Data = data.frame(left_join(Counties_AnnualHousePriceIndex, States_AnnualHousePriceIndex, by = c("State", "Year")))

#   now let's remove any duplicate columns 
Final_Data = Final_Data[-c(3,9)]

#   US DATA - rename the columns to identify 
colnames(US_AnnualHousePriceIndex)
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "Annual Change (%)"] <- "US_Annual_Change"
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "HPI"] <- "US_HPI%"
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "HPI with 1990 base"] <- "US_HPI_1990_base"
names(US_AnnualHousePriceIndex)[names(US_AnnualHousePriceIndex) == "HPI with 2000 base"] <- "USHPI_2000_base"

#   change year variable to numeric so we can perform the merge
US_AnnualHousePriceIndex$Year = as.numeric(US_AnnualHousePriceIndex$Year)

#    merge this with the dataframes using a left join so that we have a  large data set
Final_Data = left_join(Final_Data, US_AnnualHousePriceIndex, by = c("Year"))

#   Save the data 
save(Final_Data,  file = "Final_Data.RData")