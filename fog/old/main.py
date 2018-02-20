import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


def fog_season(data_frame):
    month_list = range(1, 13)
    fog_count = []

    for m in month_list:
        fog_count.append(
            data_frame[(data_frame['wx'].str.contains("Fog")) & (data_frame.obs_time.dt.month == m)].shape[0])

    station_name = data_frame.iloc[0].station_id
    plt.bar(month_list, fog_count)
    # plt.xticks(m)
    plt.title('{} Airport - Fog reports per month'.format(station_name))
    plt.savefig('{}_fog_seasonality.png'.format(station_name))
    plt.clf()


def rearrange(data_frame):
    # replacing 'Fog', 'Partial Fog' etc occurrences for 1's, other for 0's
    wx_types = list(data_frame.presentwx.unique())
    fog_types = []

    for i in wx_types:
        if 'FG' in i:
            fog_types.append(i)
            wx_types.remove(i)

    data_frame.presentwx = data_frame.presentwx.replace(fog_types, 1)
    data_frame.presentwx = data_frame.presentwx.replace(wx_types, 0)

    # removing consecutive observations of fog
    del_indexes = []
    for index, row in data_frame[0:-1].iterrows():
        if row.presentwx == 1 and data_frame.iloc[index + 1].presentwx == 1:
            del_indexes.append(index)

    data_frame = data_frame.drop(data_frame.index[del_indexes])

    # placing features from X hours before in current line
    lead_hours = 6

    tmpf = (lead_hours+1)*['M']
    dwpf = (lead_hours+1)*['M']
    relh = (lead_hours+1)*['M']
    drct = (lead_hours+1)*['M']
    sknt = (lead_hours+1)*['M']
    alti = (lead_hours+1)*['M']

    for index, row in data_frame[lead_hours:-1].iterrows():
        valid_time = row['valid'] - pd.Timedelta(hours=lead_hours, minutes=row['valid'].minute)
        lead_row = data_frame.loc[data_frame['valid'] == valid_time]

        try:
            tmpf.append(lead_row['tmpf'].values[0])
        except:
            tmpf.append('M')

        try:
            dwpf.append(lead_row['dwpf'].values[0])
        except:
            dwpf.append('M')

        try:
            relh.append(lead_row['relh'].values[0])
        except:
            relh.append('M')

        try:
            drct.append(lead_row['drct'].values[0])
        except:
            drct.append('M')

        try:
            sknt.append(lead_row['sknt'].values[0])
        except:
            sknt.append('M')

        try:
            alti.append(lead_row['alti'].values[0])
        except:
            alti.append('M')


    data_frame['tmpf_{}h'.format(lead_hours)] = np.asarray(tmpf)
    data_frame['dwpf_{}h'.format(lead_hours)] = np.asarray(dwpf)
    data_frame['relh_{}h'.format(lead_hours)] = np.asarray(relh)
    data_frame['drct_{}h'.format(lead_hours)] = np.asarray(drct)
    data_frame['sknt_{}h'.format(lead_hours)] = np.asarray(sknt)
    data_frame['alti_{}h'.format(lead_hours)] = np.asarray(alti)

    return data_frame


# column_names = ['station_id', 'obs_time', 'wx', 'rh', 't', 'td', 'wdir', 'wspeed', 'pressure']
column_names = ['station', 'valid', 'tmpf', 'dwpf', 'relh', 'drct', 'sknt', 'p01i', 'alti', 'mslp', 'vsby', 'gust',
                'skyc1', 'skyc2', 'skyc3', 'skyc4', 'skyl1', 'skyl2', 'skyl3', 'skyl4', 'presentwx', 'metar']

usecols = ['station', 'valid', 'tmpf', 'dwpf', 'relh', 'drct', 'sknt', 'p01i', 'alti', 'vsby', 'presentwx']

df = pd.read_csv('./SBPA.csv', names=column_names, skiprows=6, parse_dates=['valid'], usecols=usecols,
                 date_parser=lambda x: pd.datetime.strptime(x, '%Y-%m-%d %H:%M'))

df = rearrange(df)
