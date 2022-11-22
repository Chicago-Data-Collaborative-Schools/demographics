import csv
import sys

STANDARDIZE = {'01': '1',
               '02': '2',
               "02'": '2',
               '03': '3',
               '04': '4',
               '05': '5',
               '06': '6',
               '07': '7',
               '08': '8',
               '09': '9',
               '10.0': '10',
               'Schools': 'School',
               'School Name': 'School'}


reader = csv.reader(sys.stdin)

original_header = next(reader)
header = [STANDARDIZE.get(col, col) for col in original_header]

writer = csv.writer(sys.stdout)

writer.writerow(header)
writer.writerows(reader)
