#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan  5 16:59:52 2021

@author: kanchanok
"""

import csv
from collections import defaultdict
import time
import pandas  as pd
'''
df1 = pd.read_csv("projects-1.6.0-2020-01-12.csv")
df2 = pd.read_csv("projects_with_repository_fields-1.6.0-2020-01-12.csv")
df1 = df1[['Name', 'Homepage URL', 'Repository URL', 'Versions Count', 'SourceRank',
                           'Dependent Projects', 'Dependent Repositories', 'Repository ID']]
df2 = df2[['Name','Repository Fork','Repository Size','Repository Stars',
                           'Repository Issues enabled', 'Repository Forks',
                           'Repository Open Issues', 'Repository Watchers', 'Repository Contributors']]
df = df1.set_index('Name').join(df2.set_index('Name')).reset_index()
df.to_csv('test.csv')
print("fff")
'''
t0 = time.time() # เวลาเริ่มต้น
proj = []
allName = []
pypifile = {}
with open("projects-1.6.0-2020-01-12.csv", "r") as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for lines in csv_reader:
        if  lines[1] == "Rubygems" :
            proj.append([lines[0],lines[2], lines[7], lines[9], lines[10],
                         lines[11], lines[15],lines[19], lines[20]])
    with open("projects_with_repository_fields-1.6.0-2020-01-12.csv", "r") as name_file:
        name_reader = csv.reader(name_file, delimiter=',')
        for line in name_reader:
            if  line[1] == "Rubygems":
                pypifile[line[0]] = (line[0],line[2], line[24], line[29], line[30], line[32],
                          line[35], line[37], line[39], line[43])
    for pr in proj:
        if pr[0] in pypifile:
            allName.append([pr[1], pr[2], pr[3], 
                            pr[4], pr[5], pr[6], pr[7], pr[8],
                            pypifile[pr[0]][2],
                            pypifile[pr[0]][3], pypifile[pr[0]][4],
                            pypifile[pr[0]][5], pypifile[pr[0]][6],
                            pypifile[pr[0]][7], pypifile[pr[0]][8],
                            pypifile[pr[0]][9]])
    print(allName)        
    with open('New_RubyGems_Projects_with_Info.csv', 'a') as writeFile:
          writer = csv.writer(writeFile, dialect='excel')
          writer.writerow(['Name', 'Homepage URL', 'Repository URL', 'Versions Count', 'SourceRank',
                           'Dependent Projects Count', 'Dependent Repositories Count', 'Repository ID',
                           'Repository Fork_boolean','Repository Size','Repository Stars Count',
                           'Repository Issues enabled_boolean', 'Repository Forks Count',
                           'Repository Open Issues Count', 'Repository Watchers Count', 'Repository Contributors Count'
                           ])
          writer.writerows(allName)
    writeFile.close()

finallist_1 = []
finallist_2 = []
with open("New_RubyGems_Projects_with_Info.csv", "r") as name_file:
    name_reader = csv.reader(name_file, delimiter=',')
    file = {}
    for lines in name_reader:
        file[lines[0]] = (lines[0], lines[1], lines[2], lines[3], lines[4], lines[5],lines[6],
                          lines[7], lines[8], lines[9], lines[10], lines[11],lines[12], lines[13],
                          lines[14], lines[15])
        
    pageRank_1_1file = []
    with open("RubyGems1.1.csv", "r") as dp_file:
        dp_reader = csv.reader(dp_file, delimiter=',')
        for line in dp_reader:
            pageRank_1_1file.append([line[0],line[1], line[11]])
        for vr in pageRank_1_1file:
            if vr[0] in file :
                finallist_1.append([file[vr[0]][0],file[vr[0]][1], file[vr[0]][2],
                                  file[vr[0]][3],file[vr[0]][4], file[vr[0]][5],
                                  file[vr[0]][6],file[vr[0]][7], file[vr[0]][8],
                                  file[vr[0]][9],file[vr[0]][10], file[vr[0]][11],
                                  file[vr[0]][12],file[vr[0]][13], file[vr[0]][14],
                                  file[vr[0]][15], vr[2]])  
                     
    with open('New_RubyGems1.1_Projects_with_Info_withCheckPageRank.csv', 'a') as writeFiledp:
        print('open final file')
        writerDP = csv.writer(writeFiledp)
        writerDP.writerow(['Name', 'Homepage URL', 'Repository URL', 'Versions Count', 'SourceRank',
                           'Dependent Projects Count', 'Dependent Repositories Count', 'Repository ID',
                           'Repository Fork_boolean','Repository Size','Repository Stars Count',
                           'Repository Issues enabled_boolean', 'Repository Forks Count',
                           'Repository Open Issues Count', 'Repository Watchers Count', 'Repository Contributors Count',
                           'pageranks'
                           ])
        writerDP.writerows(finallist_1)
    writeFiledp.close()   

    pageRank_1_2file = []
    with open("RubyGems1.2.csv", "r") as dp_file:
        dp_reader = csv.reader(dp_file, delimiter=',')
        for line in dp_reader:
            pageRank_1_2file.append([line[0],line[1],line[10]])
        for vr in pageRank_1_2file:
            if vr[0] in file :
                finallist_2.append([file[vr[0]][0],file[vr[0]][1], file[vr[0]][2],
                                  file[vr[0]][3],file[vr[0]][4], file[vr[0]][5],
                                  file[vr[0]][6],file[vr[0]][7], file[vr[0]][8],
                                  file[vr[0]][9],file[vr[0]][10], file[vr[0]][11],
                                  file[vr[0]][12],file[vr[0]][13], file[vr[0]][14],
                                   file[vr[0]][15], vr[2]])  
                     
    with open('New_RubyGems1.2_Projects_with_Info_withCheckPageRank.csv', 'a') as writeFiledp:
        print('open final file')
        writerDP = csv.writer(writeFiledp)
        writerDP.writerow(['Name', 'Homepage URL', 'Repository URL', 'Versions Count', 'SourceRank',
                           'Dependent Projects Count', 'Dependent Repositories Count', 'Repository ID',
                           'Repository Fork_boolean','Repository Size','Repository Stars Count',
                           'Repository Issues enabled_boolean', 'Repository Forks Count',
                           'Repository Open Issues Count', 'Repository Watchers Count', 'Repository Contributors Count',
                           'pageranks'
                           ])
        writerDP.writerows(finallist_2)
    writeFiledp.close()       
print("time: ")
print(time.time() - t0) 
