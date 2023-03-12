# duckdb_geo_h3
Docker build image for duckdb [v0.7.2-dev654 / 28f4d18](
https://github.com/duckdb/duckdb/suites/11494602367/artifacts/593995249)

I implement reproducible build process for [h3-duckdb](https://github.com/isaacbrodsky/h3-duckdb)&[geo](https://github.com/handstuyennn/geo) from https://tech.marksblogg.com/duckdb-geospatial-gis.html

```
D select h33, sum(ST_Length(ST_GEOGFROMWKB(geometryWkb))) from read_parquet('/home/acc/dev/map/geo.parquet') where geometryWkb is not null and tags['highway'][1]='track' group by 1;
┌───────┬───────────────────────────────────────────────┐
│  h33  │ sum(st_length(st_geogfromwkb("geometryWkb"))) │
│ int16 │                    double                     │
├───────┼───────────────────────────────────────────────┤
│ 25634 │                             591354.6198661786 │
│ 25995 │                            2087004.1434180145 │
│ 25764 │                             1049905.996415525 │
│ 25650 │                            1232874.4981788746 │
│ 25651 │                             984170.6038726934 │
│ 25998 │                            2550170.6254819124 │
│ 25884 │                             1361010.549222998 │
│ 25994 │                             4589396.966791306 │
│ 25886 │                             278820.1729879511 │
│ 26013 │                            2635588.2442770144 │
│ 25653 │                             4298819.343774465 │
│ 25654 │                             294403.3974479538 │
│ 25880 │                            2524897.3071747706 │
│ 25883 │                            2813583.6432150486 │
│ 25638 │                             342583.6748140638 │
│ 26008 │                            1937.7820936282155 │
│ 26009 │                             810734.6096638087 │
│ 32767 │                             633793.9993871903 │
│ 25648 │                             2656510.213806998 │
│ 25985 │                             41990.62205641365 │
│ 25992 │                            364308.49002035003 │
│ 25993 │                               1922862.8948708 │
│ 25765 │                             2166909.581600278 │
│ 25873 │                             63442.23116663468 │
│ 25622 │                             725180.8785390726 │
│ 25652 │                             776266.8420215213 │
│ 25649 │                             730418.3148142402 │
│ 25620 │                             35708.53782083622 │
│ 25881 │                             303434.9795517275 │
├───────┴───────────────────────────────────────────────┤
│ 29 rows                                     2 columns │
└───────────────────────────────────────────────────────┘
Run Time (s): real 0.282 user 1.998260 sys 0.063365
```

```
D select sum(ST_Area(ST_MAKEPOLYGON(ST_GEOGFROMWKB(geometryWkb)))) from read_parquet('/home/acc/dev/map/geo.parquet') where geometryWkb is not null and closed and length(pointIdxs)>=3;
┌─────────────────────────────────────────────────────────────┐
│ sum(st_area(st_makepolygon(st_geogfromwkb("geometryWkb")))) │
│                           double                            │
├─────────────────────────────────────────────────────────────┤
│                                           35535595344.83139 │
└─────────────────────────────────────────────────────────────┘
Run Time (s): real 0.613 user 4.299176 sys 0.195895
```
