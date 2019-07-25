#!/bin/python3

import math
import os
import random
import re
import sys

if __name__ == '__main__':
    n = int(input().strip())

    if n % 2 != 0: #odd
        print('Weird')
    elif n % 2 == 0 and n in range(2,6):
        print('Not Weird')
    elif n % 2 == 0 and n in range(6,21):
        print('Weird')
    elif n % 2 == 0 and n > 20:
        print('Not Weird')
########################################################################
if __name__ == '__main__':
    a = int(input())
    b = int(input())

    print(a//b) #divisão com resultado inteiro
    print(a/b)

########################################################################
# We add a Leap Day on February 29, almost every four years. The leap day is an extra, or intercalary day and we add it to the shortest month of the year, February. 
# In the Gregorian calendar three criteria must be taken into account to identify leap years:

# The year can be evenly divided by 4, is a leap year, unless:
# The year can be evenly divided by 100, it is NOT a leap year, unless:
# The year is also evenly divisible by 400. Then it is a leap year.
# This means that in the Gregorian calendar, the years 2000 and 2400 are leap years, while 1800, 1900, 2100, 2200, 2300 and 2500 are NOT leap years.

def is_leap(year):
    leap = False
    if year % 4 == 0:
        if year % 100 == 0:
            if year % 400 == 0:
                return True
            return False
        return True
    else:
        return False

    return leap

year = int(input())
print(is_leap(year))

########################################################################
 print(*range(1,n+1), sep='')

 ########################################################################
ar = [10, 20, 20, 10, 10, 30, 50, 10, 20]

mydict = {}
for i in ar:
    if i not in mydict:
        mydict[i] = 1
    else:
        mydict[i] += 1

counter = 0
for i in mydict.values():
    counter += i//2

print(counter)   

########################################################################


