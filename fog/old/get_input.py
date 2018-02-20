import urllib
import json
import time
import fileinput

from datetime import datetime, timedelta

apikey = 'c3c07c4e84f54713807c4e84f58713b0'


def extract_from_api_twc(daystart, dayend, stationlist):
    coordinates = stationlist[1]
    lat = coordinates[0]
    lon = coordinates[1]
    url = 'https://api.weather.com/v1/geocode/{}/{}/observations/historical.json?units=m&startDate={}&endDate' \
          '={}&apiKey={}'.format(lat, lon, daystart, dayend, apikey)

    record = json.loads(urllib.urlopen(url).read())

    station_id = stationlist[0]

    print station_id

    outfile = open('{}.csv'.format(station_id), 'a+')

    for t in reversed(xrange(len(record['observations']))):
        obs_time = time.strftime('%Y%m%d%H%M', time.gmtime(record['observations'][t]['valid_time_gmt']))

        try:
            wx = record['observations'][t]['wx_phrase']
        except:
            wx = 'None'

        try:
            rh = record['observations'][t]['rh']
        except:
            rh = 'None'

        try:
            t = record['observations'][t]['temp']
        except:
            t = 'None'

        try:
            td = record['observations'][t]['dewPt']
        except:
            td = 'None'

        try:
            wdir = record['observations'][t]['wdir']
        except:
            wdir = 'None'

        try:
            wspeed = record['observations'][t]['wspd']
        except:
            wspeed = 'None'

        try:
            pressure = record['observations'][t]['pressure']
        except:
            pressure = 'None'

        string = '{},{},{},{},{},{},{},{},{} \n'.format(station_id, obs_time, wx, rh, t, td, wdir, wspeed, pressure)
        outfile.writelines(string)

    outfile.close()


# def extract_from_api_redemet():
#
#     url = 'http://www.redemet.aer.mil.br/api/consulta_automatica/index.php?local=sbbr,sbgl,sbsp&msg=metar&data_ini=2015031911&data_fim=2015031911'

def add_headers(stations_dic):
    for key in stations_dic.iterkeys():
        for line in fileinput.input(files=['{}.csv'.format(key)], inplace=True):
            if fileinput.isfirstline():
                print 'station_id, obs_time, wx, rh, t, td, wdir, wspeed, pressure'
            print line,


if __name__ == '__main__':

    stations = {
        'SBGL': [-22.8154, -43.2610],
        'SBGR': [-23.4321, -46.4695],
        'SBRJ': [-22.9105, -43.1631],
        'SBPA': [-29.9944, -51.1714],
        'SBFL': [-27.6705, -48.5472],
        'SBCT': [-25.5285, -49.1758],
        'SBSP': [-23.6267, -46.6554],
        'SUMU': [-34.8384, -56.0308],
        'SAEZ': [-34.8222, -58.5358],
        'SCIP': [-27.1648, -109.4218],
        'SCEL': [-33.3930, -70.7858],
        'SAZS': [-41.1512, -71.1575],
        'SCCI': [-53.0026, -70.8546],
        'SGAS': [-25.2476, -57.5192],
        'SBBH': [-19.8512, -43.9506],
        'SBCF': [-19.6351, -43.9659],
        'SBNF': [-26.8667, -48.6333],
        'SBFI': [-25.5952, -54.4878],
        'SLLP': [-16.5133, -68.1923],
        'SAWH': [-54.8441, -68.3082]
    }

    day_end = datetime(2017, 7, 28)

    while day_end >= datetime(1980, 1, 1):
        day_start = day_end - timedelta(days=30)
        print 'Downloading period, {} to {}'.format(day_start, day_end)

        for key, value in stations.iteritems():
            try:
                extract_from_api_twc(day_start.strftime("%Y%m%d"), day_end.strftime("%Y%m%d"), [key, value])
            except:
                print 'Error getting station {}, period {}:{}'.format(key, day_start, day_end)

        day_end -= timedelta(days=31)

    add_headers(stations)
