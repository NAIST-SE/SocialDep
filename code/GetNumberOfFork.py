#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 14 18:49:17 2021

@author: kanchanok
"""

import csv
from collections import defaultdict
import time

t0 = time.time() # เวลาเริ่มต้น

finallist_1 = []
finallist_2 = []
with open("RubyGems1.1_Projects_with_Info_withCheckPageRank.csv", "r") as name_file:
    name_reader = csv.reader(name_file, delimiter=',')
    file = {}
    for lines in name_reader:
        file[lines[0]] = (lines[0], lines[1], lines[2], lines[3], lines[4], lines[5],lines[6],
                          lines[7], lines[8], lines[9], lines[10], lines[11],lines[12], lines[13],
                          lines[14])
        
    pageRank_1_1file = []
    with open("projects_with_repository_fields-1.6.0-2020-01-12.csv", "r") as dp_file:
        dp_reader = csv.reader(dp_file, delimiter=',')
        for line in dp_reader:
            if line[1] == "Rubygems":
                pageRank_1_1file.append([line[2], line[24], line[35]])
            
        for vr in pageRank_1_1file:
            if vr[0] in file :
                finallist_1.append([file[vr[0]][0],file[vr[0]][1], file[vr[0]][2],
                                  file[vr[0]][3],file[vr[0]][4], file[vr[0]][5],
                                  file[vr[0]][6],file[vr[0]][7], file[vr[0]][8],
                                  file[vr[0]][9],file[vr[0]][10], file[vr[0]][11],
                                  file[vr[0]][12],file[vr[0]][13], file[vr[0]][14],
                                  vr[1], vr[2]])  
                     
with open('RubyGems1.1_Projects_with_Fork.csv', 'a') as writeFiledp:
    print('open final file')
    writerDP = csv.writer(writeFiledp)
    writerDP.writerow(['Name', 'Created Timestamp', 'Updated Timestamp', 'Homepage URL',
                           'Licenses', 'Repository URL', 'Versions Count', 'SourceRank',
                           'Latest Release Publish Timestamp', 'Latest Release Number',
                           'Dependent Projects Count', 'Status', 'Last synced Timestamp',
                           'Dependent Repositories Count', 'Repository ID',
                           'Repository Fork(boolean)', 'Repository Forks Count'])
    writerDP.writerows(finallist_1)
writeFiledp.close()   

'''
pageRank_1_2file = []
with open("RubyGems1.2.csv", "r") as dp_file:
        dp_reader = csv.reader(dp_file, delimiter=',')
        for line in dp_reader:
            pageRank_1_2file.append([line[0],line[1]])
        for vr in pageRank_1_2file:
            if vr[0] in file :
                finallist_2.append([file[vr[0]][0],file[vr[0]][1], file[vr[0]][2],
                                  file[vr[0]][3],file[vr[0]][4], file[vr[0]][5],
                                  file[vr[0]][6],file[vr[0]][7], file[vr[0]][8],
                                  file[vr[0]][9],file[vr[0]][10], file[vr[0]][11],
                                  file[vr[0]][12],file[vr[0]][13], file[vr[0]][14]])  
                     
with open('RubyGems1.2_Projects_with_Info_withCheckPageRank.csv', 'a') as writeFiledp:
    print('open final file')
    writerDP = csv.writer(writeFiledp)
    writerDP.writerow(['Name', 'Created Timestamp', 'Updated Timestamp', 'Homepage URL',
                           'Licenses', 'Repository URL', 'Versions Count', 'SourceRank',
                           'Latest Release Publish Timestamp', 'Latest Release Number',
                           'Dependent Projects Count', 'Status', 'Last synced Timestamp',
                           'Dependent Repositories Count', 'Repository ID'])
    writerDP.writerows(finallist_2)
writeFiledp.close() 
'''      
print("time: ")
print(time.time() - t0) 
