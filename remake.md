Microtiter plate graphs remake
================
Yujia Liu
7/21/2020

## HW03: Microtiter plate graphs remake

As is described in [Readme](README.md), the purpose of the project is to
examine the expression of CDSes upstream and downstream the **coupling
sequence**. The expression of the entire operon is regulated by the pLac
promoter, which is induced by IPTG (Isopropyl
β-D-1-thiogalactopyranoside).

## Step 0: Data manipulation

This step is done in Excel. The raw microtiter plate data comes in pure
text, and contains **3 measurements**: fluorescence in the wavelength of
green, fluorescence in the wavelength of red, and the absorption at 600
nm. We use the following equation to normalize the fluorescence signal:

  
![
Fluo\_n = \\frac{Fluo - Fluo\_{empty}}{Abs - Abs\_{blank}}
](https://latex.codecogs.com/png.latex?%0AFluo_n%20%3D%20%5Cfrac%7BFluo%20-%20Fluo_%7Bempty%7D%7D%7BAbs%20-%20Abs_%7Bblank%7D%7D%0A
"
Fluo_n = \\frac{Fluo - Fluo_{empty}}{Abs - Abs_{blank}}
")  

where *Fluo* means fluorescence and *Abs* means absorption. *empty* are
the wells innoculated with cells but are not supplemented with the
inducer chemical(IPTG here). *blank* are wells with only buffer. I used
*uncertainty propagation* to achieve the standard deviation of
normalized fluorescence signal.

## Step 1: import data from Excel

First, load the packages:

``` r
library(ggplot2)
library(readxl)
library(latex2exp)
```

Then, use `readxl` functions to read Excel data:

``` r
rfp <- read_excel("microtiter_data.xlsx",
           col_types = rep("numeric", 8),
           sheet = "RFP_processed")

gfp <- read_excel("microtiter_data.xlsx",
           col_types = rep("numeric", 8),
           sheet = "GFP_processed")

str(rfp)
```

    ## tibble [60 x 8] (S3: tbl_df/tbl/data.frame)
    ##  $ Time   : num [1:60] 0 0 0 0 0 0 0.5 0.5 0.5 0.5 ...
    ##  $ Inducer: num [1:60] 1e+03 1e+02 1e+01 1e+00 1e-01 1e-02 1e+03 1e+02 1e+01 1e+00 ...
    ##  $ CP1    : num [1:60] -493250 -739560 -1051370 -247842 -120544 ...
    ##  $ CP2    : num [1:60] -2494211 -1350679 -2223390 -1358081 -1702423 ...
    ##  $ CP3    : num [1:60] -3011995 -2606655 -2928238 -2600547 -3421700 ...
    ##  $ CP1.std: num [1:60] 1460477 1413195 1292767 1262347 1460764 ...
    ##  $ CP2.std: num [1:60] 2413524 2312942 2387478 2326631 2446023 ...
    ##  $ CP3.std: num [1:60] 2543877 2470815 2395893 2765028 2542449 ...

``` r
str(gfp)
```

    ## tibble [60 x 8] (S3: tbl_df/tbl/data.frame)
    ##  $ Time   : num [1:60] 0 0 0 0 0 0 0.5 0.5 0.5 0.5 ...
    ##  $ Inducer: num [1:60] 1e+03 1e+02 1e+01 1e+00 1e-01 1e-02 1e+03 1e+02 1e+01 1e+00 ...
    ##  $ CP1    : num [1:60] 4052205 3643817 2199804 1223000 1184784 ...
    ##  $ CP2    : num [1:60] 3105598 2772303 1607235 813555 696814 ...
    ##  $ CP3    : num [1:60] 4139595 4453009 2422330 1163678 870579 ...
    ##  $ CP1.std: num [1:60] 1252464 1491205 724019 757774 800390 ...
    ##  $ CP2.std: num [1:60] 1371540 1432565 1298800 1317006 1432362 ...
    ##  $ CP3.std: num [1:60] 1800020 1530498 1431548 1557895 1481762 ...

*RFP* stands for Red Fluorescence Protein, which represents the red Fluo
signal. *GFP* ditto.

## Step 2: Plot fluorescence signals against time

After the spike of the inducer, the number of fluorescence proteins in
cells is expected to increase, until it hits a plateau (a stationary
phase).

Below are two separate graphs dealing with RFP signals and GFP signals.
In the original design (see the dataframe structure above), I treated
CP1, CP2, and CP3 as different columns, which refer to different designs
of coupling sequences. In order to make faceted graphs, I used `rbind`
to stack these columns into a new dataframe.

``` r
# To make faceted graphs, CP1, CP2, CP3 columns will has to be merged
nrow = nrow(rfp)

cp1_extract <- rfp[, c("Time", "CP1", "CP1.std", "Inducer")]
colnames(cp1_extract)[2:3] <- c("Value", "Std")
cp1_extract$CP <- rep("CP1", nrow)

cp2_extract <- rfp[, c("Time", "CP2", "CP2.std", "Inducer")]
colnames(cp2_extract)[2:3] <- c("Value", "Std")
cp2_extract$CP <- rep("CP2", nrow)

cp3_extract <- rfp[, c("Time", "CP3", "CP3.std", "Inducer")]
colnames(cp3_extract)[2:3] <- c("Value", "Std")
cp3_extract$CP <- rep("CP3", nrow)

cp_extract <- rbind(cp1_extract, cp2_extract, cp3_extract)

ggplot(cp_extract, aes(x = Time, y = Value, color = as.factor(Inducer))) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = Value - Std, ymax = Value + Std)) +
  labs(color = TeX("Inducer\nconcentration/$\\mu$M"),
       x = "Time/h", y = "Fluorescence/AU", title = "RFP vs time") +
  facet_wrap(vars(CP), scale="free_y") +
  theme(plot.title = element_text(hjust = 0.5))
```

<img src="remake_files/figure-gfm/red fluo against time-1.png" width="100%" />

``` r
# To make faceted graphs, CP1, CP2, CP3 columns will has to be merged
nrow = nrow(gfp)

cp1_extract <- gfp[, c("Time", "CP1", "CP1.std", "Inducer")]
colnames(cp1_extract)[2:3] <- c("Value", "Std")
cp1_extract$CP <- rep("CP1", nrow)

cp2_extract <- gfp[, c("Time", "CP2", "CP2.std", "Inducer")]
colnames(cp2_extract)[2:3] <- c("Value", "Std")
cp2_extract$CP <- rep("CP2", nrow)

cp3_extract <- gfp[, c("Time", "CP3", "CP3.std", "Inducer")]
colnames(cp3_extract)[2:3] <- c("Value", "Std")
cp3_extract$CP <- rep("CP3", nrow)

cp_extract <- rbind(cp1_extract, cp2_extract, cp3_extract)

ggplot(cp_extract, aes(x = Time, y = Value, color = as.factor(Inducer))) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = Value - Std, ymax = Value + Std)) +
  labs(color = TeX("Inducer\nconcentration/$\\mu$M"),
       x = "Time/h", y = "Fluorescence/AU", title = "GFP vs time") +
  facet_wrap(vars(CP), scale="free_y") +
  theme(plot.title = element_text(hjust = 0.5))
```

<img src="remake_files/figure-gfm/green fluo against time-1.png" width="100%" />

Yes, as you can see, there are some quite discomforting error bars at
the beginning of the red fluorescence signal measurements. Also, this
part the signal is lower than the empty group, which is likely to be an
error in the measuring process. Thus, for the RFP measurement, we only
used data sampled **after 4 hours**.

Also, these plots are not the same ones as the old graphs from README.
My initial goal was to imitate those plots, but that would actually
require more knowledge in data wrangling. For this assignment, I just
plot these fluorescence signals against time.
