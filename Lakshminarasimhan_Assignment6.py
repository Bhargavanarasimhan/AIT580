# -*- coding: utf-8 -*-
"""
Created on Mon Feb 25 22:54:19 2019

@author: Bhargav
"""
import pandas as pd
import numpy as np

# Qn 1
address=pd.read_csv("hurricanes.csv",sep='|')
address.describe()
print(address)
list(address)

#Qn 2
np.corrcoef(address.Central_Pressure_mb,address.Max_Winds_kt)
data = address[['Central_Pressure_mb','Max_Winds_kt']]
correlation = data.corr(method='pearson')

#Visualization of data
import matplotlib.pyplot as plt

plt.hist(address['Month'], label="Month Statistics")
plt.xlabel('Months')
plt.ylabel('Occurences') 
plt.show()

address[['Central_Pressure_mb']].boxplot()
plt.title('Box Plot of Central_Pressure_mb', color='black')
plt.xlabel('Central_Pressure_mb', color='black')
plt.ylabel('Distribution')


address[['Central_Pressure_mb']].boxplot()
plt.title('Box Plot of Central_Pressure', color='black')
plt.xlabel('Central_Pressure_mb', color='black')
plt.ylabel('Distribution')

address[['Max_Winds_kt']].boxplot()
plt.title('Box Plot of Max_Winds_kt', color='black')
plt.xlabel('Max_Winds_kt', color='black')
plt.ylabel('Distribution')


plt.bar(address['Max_Winds_kt'], label="Max_Winds_kt",histtype='bar')
plt.xlabel('Max_Winds_kt')
plt.ylabel('Occurences') 
plt.show()
#----------------------#
#Part 1 Qn 3

import matplotlib.pyplot as plt

plt.scatter(address['Highest_Category'], address['Max_Winds_kt'],color='red')
plt.title('Scatter plot \n Highest_Category vs Max_Winds_kt')
plt.xlabel('Highest_Category')
plt.ylabel('Max_Winds_kt')
plt.show()

import matplotlib.pyplot as plt

plt.scatter(address['Central_Pressure_mb'], address['Max_Winds_kt'],color='red')
plt.title('Scatter plot \n Central_Pressure_mb vs Max_Winds_kt')
plt.xlabel('Central_Pressure_mb')
plt.ylabel('Max_Winds_kt')
plt.show()


#Handling missing data. 
import numpy as np
import pandas as pd

np.random.seed(0)
missing_values_count = address.isnull().sum()

#Count of missing values
total_cells = np.product(address.shape)
total_missing = missing_values_count.sum()

#After dropping the data with na
df_no_missing = address.dropna()
df_no_missing


#part 2
import pandas as pd
import requests
from bs4 import BeautifulSoup
#from tabulate import tabulate

res = requests.get("https://www.top500.org/statistics/sublist/")
soup = BeautifulSoup(res.content,'lxml')
#print(soup.title)
table = soup.find_all('table')[0] 
df = pd.read_html(str(table))[0]
df = df.drop(df.index[[0]])#print(data)

rank = df["Rank"].tolist()
system = df["System"].tolist()
cores = df["Cores"].tolist()
rmax = df["Rmax (TFlop/s)"].tolist()
rpeak = df["Rpeak (TFlop/s)"].tolist()
power = df["Power (kW)"].tolist()

type(df)

top500_df = pd.DataFrame(
    {'Rank': rank,
     'System': system,
     'Cores': cores,
     'Rmax': rmax,
     'Rpeak': rpeak,
     'Power': power,
     })

top500_df.to_csv("top 500.csv",index=False)

#merged_list = df + df2 + df3 + df4 + df5 + df6 + df7+ df8 + df9 + df10
#merged_df = pd.concat( [df,df2,df3,df4,df5,df6,df7,df8,df9,df10]

#C Describing the relationship between Cores vs Rpeak and Cores vs Power

desc_NaN = top500_df.describe(include='all')

top500_df["Cores"] = top500_df.Cores.astype(float)
top500_df["Rmax"] = top500_df.Rmax.astype(float)
top500_df["Rpeak"] = top500_df.Rpeak.astype(float)
top500_df["Power"] = top500_df.Power.astype(float)
top500_df.Power = top500_df.Power.fillna(top500_df.Power.mean())

desc_withoutNaN = top500_df.describe(include='all')

plt.scatter(top500_df['Rpeak'],top500_df['Cores'])
plt.xlabel('Rpeak')
plt.ylabel('Cores')
plt.title('Cores vs Rpeak')
plt.show()

plt.scatter(top500_df['Power'],top500_df['Cores'])
plt.xlabel('Power')
plt.ylabel('Cores')
plt.title('Cores vs Power')
plt.show()
