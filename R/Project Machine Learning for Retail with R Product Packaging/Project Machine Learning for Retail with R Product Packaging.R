# Petunjuk Penyelesaian Project
library(arules)
transaksi_tabular <- read.transactions(file="https://storage.googleapis.com/dqlab-dataset/transaksi_dqlab_retail.tsv", format="single", sep="\t", cols=c(1,2), skip=1)
write(transaksi_tabular, file="test_project_retail_1.txt", sep=",")

# Output Awal: Statistik Top 10
library(arules)
transaksi <- read.transactions(file="transaksi_dqlab_retail.tsv", format="single", sep="\t", cols=c(1,2), skip=1)
data_item <- itemFrequency(transaksi, type="absolute")
data_item <- sort(data_item, decreasing = TRUE)
data_item <- data_item[1:10]
data_item <- data.frame("Nama Produk"=names(data_item), "Jumlah"=data_item, row.names=NULL)
print(data_item)
write.csv(data_item, file="top10_item_retail.txt")

# Output Awal: Statistik Bottom 10
library(arules)
nama_file <- "transaksi_dqlab_retail.tsv"
transaksi_tabular <- read.transactions(file=nama_file, format="single", sep="\t", cols=c(1,2), skip=1)
itemurut <- sort(itemFrequency(transaksi_tabular, type="absolute"), decreasing = FALSE)[1:10]
sorteditem <- data.frame("Nama Produk"=names(itemurut), Jumlah=itemurut, row.names=NULL)
sorteditem 
write.csv(sorteditem, file="bottom10_item_retail.txt")

# Mendapatkan Kombinasi Produk yang menarik
library(arules)
nama_file <- "transaksi_dqlab_retail.tsv"
transaksi_tabular <- read.transactions(file=nama_file, format="single", sep="\t", cols=c(1,2), skip=1)
apriori_rules <- apriori(transaksi_tabular, 
                         parameter=list(supp=10/length(transaksi_tabular), conf=0.5, minlen=2, maxlen=3))
apriori_rules <- head(sort(apriori_rules, by='lift', decreasing = T),n=10)
inspect(apriori_rules)
write(apriori_rules, file="kombinasi_retail.txt")

# Mencari Paket Produk yang bisa dipasangkan dengan Item Slow-Moving
library(arules)
nama_file <- "transaksi_dqlab_retail.tsv"
transaksi_tabular <- read.transactions(file=nama_file, format="single", sep="\t", cols=c(1,2), skip=1)
jumlah_transaksi<-length(transaksi_tabular)
jumlah_kemunculan_minimal <- 10
apriori_rules <- apriori(
  transaksi_tabular,
  parameter= list(supp=jumlah_kemunculan_minimal/jumlah_transaksi,
                  conf=0.1, minlen=2, maxlen=3))
## Filter
apriori_rules1 <- subset(apriori_rules, lift > 1 & rhs %in% "Tas Makeup")
apriori_rules1 <- sort(apriori_rules1, by='lift', decreasing = T)[1:3]
apriori_rules2 <- subset(apriori_rules, lift > 1 & rhs %in% "Baju Renang Pria Anak-anak")
apriori_rules2 <- sort(apriori_rules2, by='lift', decreasing = T)[1:3]
apriori_rules <- c(apriori_rules1, apriori_rules2)
inspect(apriori_rules)
write(apriori_rules,file="kombinasi_retail_slow_moving.txt")
