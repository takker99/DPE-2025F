#
#   coding : utf-8
# -------------------------------------------------------------------------------
#   Name : RTK_decoder_ver2022.py
#   purpose : RTK raw data to csv data
#   author : Takehiko Ito a.k.a. Sabotenn
#   created : 02/June/2020
#   updated : 06/April/2022
# -------------------------------------------------------------------------------


# import
import sys
import numpy as np
import pandas as pd
import warnings
import os
warnings.simplefilter('ignore', FutureWarning)


# Reading
args = sys.argv
rawfile = args[1]
# print(rawfile)
# rawdata = pd.read_csv(rawfile, delimiter=‘w’, encoding=‘shift_jis’, header=None, names=[‘A’])
rawdata = pd.read_csv(rawfile, delimiter='w',
                      encoding='shift_jis', header=None, names=['A'])
# rawdata = pd.read_csv("VRS直_2021-12-23-18-30-28.rtk",'w', encoding='shift_jis', header=None, names=['A'])

G1 = (rawdata.query('A.str.contains("GG1,")', engine='python').reset_index(
    drop=True)['A'].str.split(',', expand=True))
G2 = (rawdata.query('A.str.contains("GG2,")', engine='python').reset_index(
    drop=True)['A'].str.split(',', expand=True))
G3 = (rawdata.query('A.str.contains("GG3,")', engine='python').reset_index(
    drop=True)['A'].str.split(',', expand=True))
G5 = (rawdata.query('A.str.contains("GG5,")', engine='python').reset_index(
    drop=True)['A'].str.split(',', expand=True))

G1 = G1.drop([0, 1, 3, 9, 10, 11, 12, 13, 14, 15], axis=1)
G2 = G2.drop([0, 6], axis=1)
G3 = G3.drop([0, 6], axis=1)
G5 = G5.drop([0, 1, 2, 11], axis=1)


# Merge
data = pd.concat([G1, G2, G3, G5], axis=1)


# Naming
list = ["No.", "Start-time", "End-time", "Epoch", "Satellites", "Antenna",                                                                                           # GG1
        # GG2
        "Plane-Cartesian-coordinate-X", "Plane-Cartesian-coordinate-Y", "Ellipsoidal-height", "Geoid-height", "Elevation",
        # GG3
        "GRS-80-latitude", "GRS-80-longitude", "3D-Cartesian-coordinate-X", "3D-Cartesian-coordinate-Y", "3D-Cartesian-coordinate-Z",
        # GG5
        "DX", "Standard-deviation(DX)", "DY", "Standard-deviation(DY)", "DZ", "Standard-deviation(DZ)", "Diagonal-distance", "Standard-deviation(Diagonal-distance)",
        ]

data.columns = list


# Calculation of Latitude and Longitude
df_lat60 = data.loc[:, "GRS-80-latitude"].str.split('-', expand=True)
df_lon60 = data.loc[:, "GRS-80-longitude"].str.split('-', expand=True)

list_lat60 = ["lat1", "lat2", "lat3"]
list_lon60 = ["lon1", "lon2", "lon3"]
df_lat60.columns = list_lat60
df_lon60.columns = list_lon60

df_lat60['lat1'] = df_lat60['lat1'].astype(float)
df_lat60['lat2'] = df_lat60['lat2'].astype(float) / 60
df_lat60['lat3'] = df_lat60['lat3'].astype(float) / 3600
df_lon60['lon1'] = df_lon60['lon1'].astype(float)
df_lon60['lon2'] = df_lon60['lon2'].astype(float) / 60
df_lon60['lon3'] = df_lon60['lon3'].astype(float) / 3600

lat10 = df_lat60['lat1'] + df_lat60['lat2'] + df_lat60['lat3']
lon10 = df_lon60['lon1'] + df_lon60['lon2'] + df_lon60['lon3']


# Merge
data2 = pd.concat([data, lat10, lon10], axis=1)


# Naming
list2 = ["No.", "Start-time", "End-time", "Epoch", "Satellites", "Antenna",                                                                                          # GG1
         # GG2
         "Plane-Cartesian-coordinate-X", "Plane-Cartesian-coordinate-Y", "Ellipsoidal-height", "Geoid-height", "Elevation",
         # GG3
         "latitude-60base(GRS-80)", "longitude-60base(GRS-80)", "3D-Cartesian-coordinate-X", "3D-Cartesian-coordinate-Y", "3D-Cartesian-coordinate-Z",
         # GG5
         "DX", "Standard-deviation(DX)", "DY", "Standard-deviation(DY)", "DZ", "Standard-deviation(DZ)", "Diagonal-distance", "Standard-deviation(Diagonal-distance)",
         "latitude-decimal(GRS-80)", "longitude-decimal(GRS-80)"
         ]

data2.columns = list2
data3 = data2[["No.", "Start-time", "End-time", "Elevation",
               "latitude-decimal(GRS-80)", "longitude-decimal(GRS-80)"]]

# Output
data2.to_csv(os.path.join(os.path.dirname(__file__),
             "../dist/RTK_output.csv"), index=False)
data3.to_csv(os.path.join(os.path.dirname(__file__),
             "../dist/RTK_output_GIS.csv"), index=False)


# # Other data
# A <- X[X$GA=="GG1",]
# B <- X[X$GA=="GG2",]
# C <- X[X$GA=="GG3",]
# D <- X[X$GA=="GG4",]
# E <- X[X$GA=="GG5",]
# F <- X[X$GA=="GG7",]
# G <- X[X$GA=="GG9",]
# H <- X[X$GA=="GG10",]


# Naming
# list = ["行名","観測グループ名","測点NO","測点名称","観測開始時刻","観測終了時刻","エポック数","合計使用衛星数","アンテナ高","アンテナ高","10","11",
#         "平面直角座標X","平面直角座標Y","楕円体高さ","ジオイド高","標高","19","20","21","22","23","24","GRS-80緯度","GRS-80経度",
#         "三次元直行座標X","三次元直行座標Y","三次元直行座標Z","29","30","31","32","33","34","三次元直行座標X","三次元直行座標Y","三次元直行座標Z",
#         "緯度","経度","楕円体高","41","42","43","44","45","解の種類","バイアス決定比","DX","標準偏差(DX)","DY","標準偏差(DY)","DZ","標準偏差(DZ)",
#         "斜距離","標準偏差(斜距離)","56","？","分散・共分散行列(DX-DX)","分散・共分散行列(DY-DY)","分散・共分散行列(DZ-DZ)",
#         "分散・共分散行列(DX-DY)","分散・共分散行列(DX-DZ)","分散・共分散行列(DY-DZ)","64","65","66","67","G衛星(GPS)","R衛星(GLONASS)",
#         "J衛星(QZSS)","E衛星(Galileo)","?","73","74","75","76","77","78","?","?","81","82","83","84","85","86","87","88")
#         ]
