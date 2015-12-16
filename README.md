Installation
============

Windows
-------

``` r
install.packages("hydroMaps", 
    repos = c("http://owi.usgs.gov/R", "http://cran.us.r-project.org"))
```

Mac and Unix
------------

`hydroMaps` depends on the R packages `sp`,`rgeos`, and `rgdal` all of which require an external library gdal to be installed. See :

<https://www.mapbox.com/tilemill/docs/guides/gdal/>

``` r
install.packages("hydroMaps", 
    repos = c("http://owi.usgs.gov/R", "http://cran.us.r-project.org"))
```

[![Build Status](https://travis-ci.org/USGS-R/hydroMaps.svg)](https://travis-ci.org/USGS-R/hydroMaps)

Contribute
==========

In order to contribute to this code, we recommend the following workflow:

1.  "fork" this repository to your own personal github account

2.  clone the github repository to your computer:

    $git clone [https://github.com/{username}/hydroMaps.git](https://github.com/{username}/hydroMaps.git)

3.  modify code or add new functionality, save the code

4.  add the repository master to a remote master called "upstream"

    $cd hydroMaps

    $git remote add upstream <https://github.com/USGS-R/hydroMaps.git>

5.  before pushing your changes to your repository, pull in the current version of the USGS-R master:

    $git fetch upstream

6.  merge these differences with your own "master" version:

    $git merge upstream/master

7.  push your changes to your github repository, in addition to changes made by pulling in the GLEON master:

    $git push

8.  submit a pull request to USGS-R master using your account at github.com

Disclaimer
==========

This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey, an agency of the United States Department of Interior. For more information, see the [official USGS copyright policy](http://www.usgs.gov/visual-id/credit_usgs.html#copyright/ "official USGS copyright policy")

Although this software program has been used by the U.S. Geological Survey (USGS), no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png)](http://creativecommons.org/publicdomain/zero/1.0/)
