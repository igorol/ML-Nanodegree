import pandas as pd
import numpy as np
import sys


def prepare_data(infile):
    # parsing data from CSV file
    dateparse = lambda x: pd.datetime.strptime(x, '%Y-%m-%d %H:%M')  # date parsing function
    columns = [1, 4, 5, 6, 7, 8, 10, 12]  # columns to keep
    data = pd.read_csv(infile, low_memory=False, skiprows=5, parse_dates=['valid'], date_parser=dateparse,
                       usecols=columns)
    data = data.drop_duplicates()
    data = data.replace('M', np.NaN)
    data = data.dropna(0, how='any')
    for col in data.columns[1:]:
        data[col] = data[col].astype(float)

    # removing unreasonable values
    for col in data.columns:
        if col[0:4] in ['tmpf', 'dwpf']:
            data = data.drop(data[data[col].values > 150].index)
        if col[0:4] in ['relh', 'sknt']:
            data = data.drop(data[data[col].values > 100].index)
        if col[0:4] in ['alti']:
            data = data.drop(data[data[col].values < 25].index)

    # creating extra columns, filling new columns with nan's
    list_vars = ['tmpf', 'dwpf', 'relh', 'drct', 'sknt', 'alti', 'vsby']
    list_hours = ['1 hour', '2 hour', '3 hour', '4 hour', '5 hour', '6 hour', '7 hour', '8 hour', '9 hour', '10 hour',
                  '11 hour', '12 hour']
    extracols = ['{} {}'.format(var, hour) for var in list_vars for hour in list_hours]
    
    print data.shape
    for col in extracols:
        data[col] = np.nan

    data_copy = data
    print data.shape
    for tup in data_copy.itertuples():
        sys.stdout.write('\r{}/{}'.format(tup.Index, data.shape[0]))
        sys.stdout.flush()

        # the loop below retrieves data from 3,4,5,6,etc hours before [ "- pd.Timedelta(..)" is the key thing ]
        for var in extracols:
            try:
                if tup.valid.minute <= 30:
                    value = data.loc[data['valid'] == tup.valid - pd.Timedelta(
                        ' '.join((var.split(' ')[1], var.split(' ')[2]))) - pd.Timedelta(
                        str(tup.valid.minute) + ' minute')][var.split(' ')[0]]

                else:
                    value = data.loc[data['valid'] == tup.valid - pd.Timedelta(
                        ' '.join((var.split(' ')[1], var.split(' ')[2]))) + pd.Timedelta('1 hour')][var.split(' ')[0]]
                data.set_value(tup.Index, var, value)
            except ValueError:
                data.set_value(tup.Index, var, np.nan)

    data.to_csv(infile.split('.')[0] + '.csv')


infilelist = [
#    'SUMU.txt',
#    'SAEZ.txt',
#    'SBPA.txt'
    'SBRJ.txt',
    'SBCT.txt'
]

for f in infilelist:
    print '\nPreparing {}\n'.format(f)
    prepare_data(f)


def check(infile, station):
    data = pd.read_csv(infile, low_memory=False, skiprows=5)
    for tup in data.itertuples():
        if tup.station != station:
            print tup.Index + 7



