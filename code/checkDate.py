#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 20 14:31:47 2021

@author: kanchanok
"""

import csv
import time
from tqdm import tqdm
t0 = time.time() # เวลาเริ่มต้น
csv.field_size_limit(100000000)
proj_list = []
date_list = []
rank_list = []

with open("projects-1.6.0-2020-01-12.csv", "r", encoding = "ISO-8859-1") as p_file:
    p_reader = csv.reader(p_file, delimiter=',')
    for p in p_reader:
        if p[1] == 'Rubygems':
            date_split = p[3].split(' ')
            year_split= date_split[0].split('-')
            year = year_split[0]
            udate_split = p[4].split(' ')
            uyear_split= udate_split[0].split('-')
            uyear = uyear_split[0]
            proj_list.append([p[0], p[2], year, p[3], uyear, p[4], p[9], p[12]]) #'ID', 'Project Name', 'Created Timestamp' ,'Updated Timestamp','Repository URL', 'Latest Release Publish Timestamp'

with open("RubyGems1.2.csv", "r", encoding = "ISO-8859-1") as s_file:
    s_reader = csv.reader(s_file, delimiter=',')
    for p in s_reader:
        rank_list.append([p[0], p[10], p[7], 'RubyGems']) #'ID', 'PageRank', Degree
print("pass")
"""
with open("New_Maven1.2_Projects_with_Info_withCheckPageRank.csv", "r", encoding = "ISO-8859-1") as w_file:
    w_reader = csv.reader(w_file, delimiter=',')
    for p in w_reader:
        rank_list.append([p[0], p[16], 'Maven']) #'Name', 'PageRank'
print("pass")

with open("New_RubyGems1.2_Projects_with_Info_withCheckPageRank.csv", "r", encoding = "ISO-8859-1") as f_file:
    f_reader = csv.reader(f_file, delimiter=',')
    for p in f_reader:
        rank_list.append([p[0], p[16], 'RubyGems']) #'Name', 'PageRank'
print("pass")
"""
print(len(proj_list))
print(len(rank_list))
for rank in tqdm(rank_list):
    for pro in proj_list:
        if rank[0] == pro[1]:
            date_list.append([pro[0], rank[3], pro[1], pro[2], pro[3], pro[4], pro[5], pro[6], pro[7], rank[1], rank[2]])
            
            
with open('Date_RubyGems_Info_Dependency_Degree.csv', 'a') as repo:
    print('open repo file found')
    writerF = csv.writer(repo)
    writerF.writerow(['ID', 'Ecosystem', 'Project Name', 'C_Year', 'Created Timestamp ', 'U_Year', 'Updated Timestamp', 'Repository URL', 'Latest Release Publish Timestamp', 'PageRank', 'Degree'])
    writerF.writerows(date_list)
repo.close()

print("time: ")
print(time.time() - t0)

"""
with open("projects-1.6.0-2020-01-12.csv", "r", encoding = "ISO-8859-1") as p_file:
    p_reader = csv.reader(p_file, delimiter=',')
    for p in p_reader:
        if p[1] == 'Pypi' or p[1] == 'Maven' or p[1] == 'Rubygems':
            proj_list.append([p[0], p[2], p[4], p[9], p[12]]) #'ID', 'Project Name', 'Updated Timestamp','Repository URL', 'Latest Release Publish Timestamp'

with open("Pypi1.1.csv", "r", encoding = "ISO-8859-1") as s_file:
    s_reader = csv.reader(s_file, delimiter=',')
    for p in s_reader:
        rank_list.append([p[0], p[12], p[9], 'PyPI']) #'ID', 'PageRank', Degree
print("pass")

with open("New_Maven1.1_Projects_with_Info_withCheckPageRank.csv", "r", encoding = "ISO-8859-1") as w_file:
    w_reader = csv.reader(w_file, delimiter=',')
    for p in w_reader:
        rank_list.append([p[0], p[16], 'Maven']) #'Name', 'PageRank'
print("pass")

with open("New_RubyGems1.1_Projects_with_Info_withCheckPageRank.csv", "r", encoding = "ISO-8859-1") as f_file:
    f_reader = csv.reader(f_file, delimiter=',')
    for p in f_reader:
        rank_list.append([p[0], p[16], 'RubyGems']) #'Name', 'PageRank'
print("pass")

print(len(proj_list))
print(len(rank_list))
for rank in tqdm(rank_list):
    for pro in proj_list:
        if rank[0] == pro[1]:
            date_list.append([pro[0], rank[2], pro[1], pro[2], pro[3], pro[4], rank[1]])
            
            
with open('Date_Info_Collaboration.csv', 'a') as repo:
    print('open repo file found')
    writerF = csv.writer(repo)
    writerF.writerow(['ID', 'Ecosystem', 'Project Name', 'Updated Timestamp', 'Repository URL', 'Latest Release Publish Timestamp', 'PageRank'])
    writerF.writerows(date_list)
repo.close()

print("time: ")
print(time.time() - t0)
"""
            