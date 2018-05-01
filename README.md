demtables
================

R Markdown
----------

`demtables` is a simple package for making demographic tables from data.frames.

### Installation

Installation is simplest through `devtools::install_github`. The package depends on `dplyr`, `tidyr`, `htmlTable`, and `formula.tools`.

``` r
devtools::install_github('sean-cho/demtables')
```

### Usage

The main workhorse of the `demtables` package is the function `dem_table` which takes a `data.frame` and `expression` as an argument.

``` r
library(demtables)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(survival)
data(ovarian)
ovarian %>% 
  mutate(resid.ds = ifelse(resid.ds == 1,'no','yes'), rx = factor(rx)) %>% 
  dem_table(rx ~ .)
```

    ## Loading required package: tidyr

    ## Loading required package: formula.tools

    ## Warning: package 'formula.tools' was built under R version 3.4.4

    ##       [,1]       [,2]  [,3]             [,4]             [,5]    
    ##  [1,] ""         ""    "1"              "2"              "pvalue"
    ##  [2,] "N"        ""    "13"             "13"             ""      
    ##  [3,] "Futime"   ""    ""               ""               ""      
    ##  [4,] ""         ""    "517.31 (346.9)" "681.77 (324.7)" "0.22"  
    ##  [5,] "Fustat"   ""    ""               ""               ""      
    ##  [6,] ""         ""    "0.54 (0.5)"     "0.38 (0.5)"     "0.45"  
    ##  [7,] "Age"      ""    ""               ""               ""      
    ##  [8,] ""         ""    "55.73 (13.5)"   "56.60 (5.4)"    "0.83"  
    ##  [9,] "Resid.ds" ""    ""               ""               ""      
    ## [10,] ""         "no"  "5"              "6"              "1.00"  
    ## [11,] ""         "yes" "8"              "7"              ""      
    ## [12,] "Ecog.ps"  ""    ""               ""               ""      
    ## [13,] ""         ""    "1.46 (0.5)"     "1.46 (0.5)"     "1.00"

Alternatively, you could select specific variables.

``` r
ovarian %>% 
  mutate(resid.ds = ifelse(resid.ds == 1,'no','yes'), rx = factor(rx)) %>% 
  dem_table(rx ~ age + resid.ds)
```

    ##      [,1]       [,2]  [,3]           [,4]          [,5]    
    ## [1,] ""         ""    "1"            "2"           "pvalue"
    ## [2,] "N"        ""    "13"           "13"          ""      
    ## [3,] "Age"      ""    ""             ""            ""      
    ## [4,] ""         ""    "55.73 (13.5)" "56.60 (5.4)" "0.83"  
    ## [5,] "Resid.ds" ""    ""             ""            ""      
    ## [6,] ""         "no"  "5"            "6"           "1.00"  
    ## [7,] ""         "yes" "8"            "7"           ""

The `make_dem_table` and `view_dem_table` functions create HTML tables that will be displayed in the Viewer if you use RStudio. `make_dem_table` can be used directly in HTML Markdowns.

``` r
ovarian %>% 
  mutate(resid.ds = ifelse(resid.ds == 1,'no','yes'), rx = factor(rx)) %>% 
  make_dem_table(rx ~ age + resid.ds, 'Ovarian data')
```

    ## Loading required package: htmlTable

<!--html_preserve-->
<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<th colspan="5" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Ovarian data
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
1
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
2
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
pvalue
</td>
</tr>
<tr style="background-color: #f7f7f7;">
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
N
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
13
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
13
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
</td>
</tr>
<tr>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
Age
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
</tr>
<tr style="background-color: #f7f7f7;">
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
55.73 (13.5)
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
56.60 (5.4)
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
0.83
</td>
</tr>
<tr>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
Resid.ds
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; text-align: center;">
</td>
</tr>
<tr style="background-color: #f7f7f7;">
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
no
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
5
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
6
</td>
<td style="padding-left: .5em; padding-right: .5em; background-color: #f7f7f7; text-align: center;">
1.00
</td>
</tr>
<tr>
<td style="padding-left: .5em; padding-right: .5em; border-bottom: 2px solid grey; text-align: center;">
</td>
<td style="padding-left: .5em; padding-right: .5em; border-bottom: 2px solid grey; text-align: center;">
yes
</td>
<td style="padding-left: .5em; padding-right: .5em; border-bottom: 2px solid grey; text-align: center;">
8
</td>
<td style="padding-left: .5em; padding-right: .5em; border-bottom: 2px solid grey; text-align: center;">
7
</td>
<td style="padding-left: .5em; padding-right: .5em; border-bottom: 2px solid grey; text-align: center;">
</td>
</tr>
</tbody>
</table>
<!--/html_preserve-->
