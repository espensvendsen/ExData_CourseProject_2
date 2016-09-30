fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "NEI_data.zip"
if(!file.exists(zipFile)) {
  download.file(fileUrl,destfile = zipFile, method = "curl")
  unzip(zipFile)
}