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

