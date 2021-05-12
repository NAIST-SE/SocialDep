#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 20 21:09:37 2021

@author: kanchanok
"""

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

df = pd.read_csv('Date_Info_Dependency_Degree.csv')
df['Updated Timestamp']= pd.to_datetime(df['Updated Timestamp'])


fig, ax = plt.subplots(figsize = (12,6))    
#fig = sns.scatterplot(x = "Updated Timestamp", y = "PageRank", data = df, hue="Ecosystem", ax=ax, palette = sns.color_palette("Set2",n_colors=3))
fig = sns.scatterplot(x="Updated Timestamp", y="Degree", data = df)
#x_dates = df['Updated Timestamp'].dt.strftime('%Y').sort_values().unique()
#ax.set_xticklabels(labels=x_dates, rotation=45, ha='right')
ax.xaxis.set_major_locator(mdates.YearLocator())
ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y'))
plt.savefig('plot_PyPIDependScatter.png')

#sns.scatterplot(data=df, x="Latest Release Publish Timestamp", y="PageRank", hue="color")


"""
df = pd.read_csv('Date_Info_Collaboration_Degree.csv')
#df['Updated Timestamp']= pd.to_datetime(df['Updated Timestamp'])


fig, ax = plt.subplots(figsize = (12,6))    
#fig = sns.scatterplot(x = "Updated Timestamp", y = "PageRank", data = df, hue="Ecosystem", ax=ax, palette = sns.color_palette("Set2",n_colors=3))
fig = sns.boxplot(x="C_Year", y="Degree", data = df)
#x_dates = df['Updated Timestamp'].dt.strftime('%Y').sort_values().unique()
#ax.set_xticklabels(labels=x_dates, rotation=45, ha='right')
#ax.xaxis.set_major_locator(mdates.YearLocator())
#ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y'))
plt.savefig('plot_PyPICollabBoxplot_Create.png')

"""
