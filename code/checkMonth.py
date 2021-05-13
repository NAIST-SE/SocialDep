#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr 22 17:35:28 2021

@author: kanchanok
"""


# calculate the spearman's correlation between two variables

from scipy.stats import spearmanr
import csv
from tqdm import tqdm

update_list = []
degree_list = []
"""
# prepare data
with open("Date_Info_Dependency_Degree.csv", "r", encoding = "ISO-8859-1") as s_file:
    s_reader = csv.reader(s_file, delimiter=',')
    for p in s_reader:
        update_list.append([p[5]])
        degree_list.append([p[10]])
# calculate spearman's correlation
coef, p = spearmanr(update_list, degree_list)
print('Spearmans correlation coefficient: %.3f' % coef)
# interpret the significance
alpha = 0.05
if p > alpha:
	print('Samples are uncorrelated (fail to reject H0) p=%.3f' % p)
else:
	print('Samples are correlated (reject H0) p=%.3f' % p)
    
"""

from datetime import datetime   

num_months_list = []
info_list = []
finallist = []
def countMonths(name, dt, update, create, degree):
    num_months = (dt.year - update.year) * 12 + (dt.month - update.month)
    num_up_create_months = (update.year - create.year) * 12 + (update.month - create.month)
    print(num_months)
    print(num_up_create_months)
    info_list.append([name, num_months, num_up_create_months, degree])
    return num_months

def convertStrDT(dt_str):
    return datetime.strptime(dt_str[:-4],'%Y-%m-%d %H:%M:%S')

# prepare data
with open("Date_RubyGems_Info_Collaboration_Degree.csv", "r", encoding = "ISO-8859-1") as s_file:
    s_reader = csv.reader(s_file, delimiter=',')
    next(s_reader)
    for p in s_reader:
        update_list.append([p[6]])
        num_months_list.append([countMonths(p[2],datetime.today(), convertStrDT(p[6]), convertStrDT(p[4]), p[10])])
        #num_months_list.append([countMonths(convertStrDT(p[6]),convertStrDT(p[4]) )])
        degree_list.append([p[10]])
# calculate spearman's correlation
coef, p = spearmanr(num_months_list, degree_list)
print('Spearmans correlation coefficient: %.3f' % coef)
# interpret the significance
alpha = 0.05
if p > alpha:
	print('Samples are uncorrelated (fail to reject H0) p=%.3f' % p)
else:
	print('Samples are correlated (reject H0) p=%.3f' % p)


with open("New_RubyGems1.1_Projects_with_Info_withCheckPageRank.csv", "r", encoding = "ISO-8859-1") as info_file:
    info_reader = csv.reader(info_file, delimiter=',')
    next(info_reader)
    for f in tqdm(info_reader):
        for p in info_list:
            if f[0] == p[0]:
                finallist.append([f[0], f[1], f[2], f[3], f[4], f[5], f[6], f[7], f[8], f[9],
                                  f[10], f[11], f[12], f[13], f[14], f[15], f[16], p[1], p[2], p[3]])
                
with open('Info_RubyGems1.1_Model(update).csv', 'a') as writeFiledp:
        print('open final file')
        writerDP = csv.writer(writeFiledp)
        writerDP.writerow(['Name', 'Homepage URL', 'Repository URL', 'Versions Count', 'SourceRank',
                           'Dependent Projects Count', 'Dependent Repositories Count', 'Repository ID',
                           'Repository Fork_boolean','Repository Size','Repository Stars Count',
                           'Repository Issues enabled_boolean', 'Repository Forks Count',
                           'Repository Open Issues Count', 'Repository Watchers Count', 'Repository Contributors Count',
                           'pageranks', 'Today_UpDate', 'Update_Create', 'Degree'])
        writerDP.writerows(finallist)
    

    
    
    
    
    