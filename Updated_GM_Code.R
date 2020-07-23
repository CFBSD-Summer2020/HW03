library(geomorph)
library(ggplot2)

files3d <- list.files(path="RSCA Only/")

#turn data into a 3D array
arr3d <- array(dim=c(21, 9, length(files3d))) #create blank array

for(i in 1:length(files3d)){
  arr3d[,,i] <- as.matrix(read.csv(file=paste0("RSCA Only/", files3d[i]), header = FALSE))
}
GPA_arr <- array(dim = c(17, 3, length(files3d)))
GPA_arr[,,] <- as.numeric(arr3d[c(3:10,13:21), 4:6,])

#general procrustes
GPA_SCA <- gpagen(GPA_arr, PrinAxes = TRUE, ProcD = TRUE, Proj = TRUE)

#principle components analysis
PCA <- gm.prcomp(GPA_SCA$coords)

#adding species and genera lables (and other info if you want from an excel sheet)
Scaps <- read.csv("Labled Specimens RSCA.csv", header=TRUE)
coords <- c("x", "y", "z")
dimnames(GPA_SCA$coords) <- list(rownames(GPA_SCA$coords[,1,]), coords, rownames(files3d))

#add the excel sheet data to the PCA or GPA by creating a data frame
SCA_df <- data.frame(PCA = PCA$x,
                             Species = Scaps$Species,
                             Genus = Scaps$Genus,
                             Sex = Scaps$Sex,
                             Side = Scaps$Side,
                             Specimen = Scaps$Specimen.Number,
                             Color = Scaps$GenusColor,
                             Locomotion = Scaps$Locomotion)

#plot it
ggplot(SCA_df, aes(x=PCA.Comp1, y=PCA.Comp2)) + 
  geom_point(aes(shape = Locomotion, color = Genus), size = 5) + 
  theme_classic(base_size = 22) +
  scale_color_brewer(palette="Set2") +
  scale_shape_manual(values = c(15, 16, 17, 18, 8)) +
  theme(legend.position = "right", legend.title = element_blank()) + 
    xlab("PC 1 (32.4%)") + 
    ylab("PC 2 (23.6%)") + 
    coord_fixed() + 
    scale_y_continuous(labels = scales::number_format(accuracy = 0.1))
