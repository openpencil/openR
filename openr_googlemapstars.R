#### Option 1 ####
library(jsonlite)
library(dplyr)

# read in .json data
# Google ->; Takeout ->; Google Maps (My Places) ->; Saved Places.json
# https://en.wikipedia.org/wiki/Google_Takeout

txt = '~/projects/Saved Places.json'
dat = fromJSON(txt, flatten = TRUE)

# keep the useful parts
df_feat = flatten(dat$features)
df_dat = df_feat %>%
  select(`properties.Location.Business Name`,
         `properties.Location.Address`,
         `properties.Location.Geo Coordinates.Latitude`,
         `properties.Location.Geo Coordinates.Longitude`
  )

# subset to specific geographies
# method 1, grep for state in address (easier)

dat_jap = df_dat %>%
  filter(grepl(pattern='Japan',x=properties.Location.Address))

# export to a csv spreadsheet
write.csv(dat_jap,file='~/projects//dat_jap.csv',row.names=FALSE)

# upload csv into Google My Maps to share

#### Option 2 ####
# To export your Google Maps starred locations:
# Go to Google Bookmarks: https://www.google.com/bookmarks/
# On the bottom left, click "Export bookmarks": https://www.google.com/bookmarks/bookmarks.html?hl=en
# After downloading the html file, hack it with a script.

