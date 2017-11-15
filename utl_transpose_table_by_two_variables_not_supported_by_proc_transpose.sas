SAS transpose table by two variables (not supported vt proc transpose)

INPUT
====

Up to 40 obs WORK.HAVE total obs=4

Obs    MAKNAME    MLONAME    TCODE    COUNT    PERCENT

 1     ABARTH       124      Miss        5        5.1
 2     ABARTH       124      Hit        94       94.9
 3     FIAT         124      Miss       30       12.0
 4     FIAT         124      Hit       220       88.0


WORKING CODE
============

   %utl_gather(begin,var,val,MAKName MLOName tcode,havXpo,valformat=6.2);

   Proc Corresp Data=havXpo Observed dim=1 cross=both;
    ods output observed=havsum;
    table makname mloname, tcode var;
    weight val;

OUTPUT
======
                 HIT___     HIT___    MISS___    MISS___
    LABEL         COUNT    PERCENT     COUNT     PERCENT    SUM

    ABARTH * 124    94       94.9         5         5.1     199
    FIAT * 124     220       88.0        30        12.0     350

    Sum            314      182.9        35        17.1     549

see
https://stackoverflow.com/questions/47199907/transpose-table-by-two-variables

for gather Alea Iacta
https://github.com/clindocu/sas-macros-r-functions

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

data have;
 input makname $ mloname $ tcode $ count percent;
 cards4;
 ABARTH  124     Miss  5     5.1
 ABARTH  124     Hit   94    94.9
 FIAT    124     Miss  30    12
 FIAT    124     Hit   220   88
;;;;
run;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_gather(begin,var,val,MAKName MLOName tcode,havXpo,valformat=6.2);

Ods Exclude All;
Proc Corresp Data=havXpo Observed dim=1 cross=both;
 ods output observed=havSum;
 table makname mloname, tcode var;
 weight val;
run;quit;
Ods Select All;



