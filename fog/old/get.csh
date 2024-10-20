#!/bin/csh
#################################################################
# Csh Script to retrieve 268 online Data files of 'ds336.0',
# total 12.77G. This script uses 'wget' to download data.
#
# Highlight this script by Select All, Copy and Paste it into a file;
# make the file executable and run it on command line.
#
# You need pass in your password as a parameter to execute
# this script; or you can set an environment variable RDAPSWD
# if your Operating System supports it.
#
# Contact tcram@ucar.edu (Thomas Cram) for further assistance.
#################################################################

set pswd = $1
if(x$pswd == x && `env | grep RDAPSWD` != '') then
 set pswd = $RDAPSWD
endif
if(x$pswd == x) then
 echo
 echo Usage: $0 YourPassword
 echo
 exit 1
endif
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
 set opt = 'wget --no-check-certificate'
else
 set opt = 'wget'
endif
set opt1 = '-O Authentication.log --save-cookies auth.rda_ucar_edu --post-data'
set opt2 = "email=igoro@br.ibm.com&passwd=$pswd&action=login"
$opt $opt1="$opt2" https://rda.ucar.edu/cgi-bin/login
set opt1 = "-N --load-cookies auth.rda_ucar_edu"
set opt2 = "$opt $opt1 http://rda.ucar.edu/data/ds336.0/"
set filelist = ( \
  surface/200804/20080408/Surface_METAR_20080408_0000.nc \
  surface/200804/20080409/Surface_METAR_20080409_0000.nc \
  surface/200804/20080410/Surface_METAR_20080410_0000.nc \
  surface/200804/20080411/Surface_METAR_20080411_0000.nc \
  surface/200804/20080412/Surface_METAR_20080412_0000.nc \
  surface/200804/20080413/Surface_METAR_20080413_0000.nc \
  surface/200804/20080414/Surface_METAR_20080414_0000.nc \
  surface/200804/20080415/Surface_METAR_20080415_0000.nc \
  surface/200804/20080416/Surface_METAR_20080416_0000.nc \
  surface/200804/20080417/Surface_METAR_20080417_0000.nc \
  surface/200804/20080418/Surface_METAR_20080418_0000.nc \
  surface/200804/20080419/Surface_METAR_20080419_0000.nc \
  surface/200804/20080420/Surface_METAR_20080420_0000.nc \
  surface/200804/20080421/Surface_METAR_20080421_0000.nc \
  surface/200804/20080422/Surface_METAR_20080422_0000.nc \
  surface/200804/20080423/Surface_METAR_20080423_0000.nc \
  surface/200804/20080424/Surface_METAR_20080424_0000.nc \
  surface/200804/20080425/Surface_METAR_20080425_0000.nc \
  surface/200804/20080426/Surface_METAR_20080426_0000.nc \
  surface/200804/20080427/Surface_METAR_20080427_0000.nc \
  surface/200804/20080428/Surface_METAR_20080428_0000.nc \
  surface/200804/20080429/Surface_METAR_20080429_0000.nc \
  surface/200804/20080430/Surface_METAR_20080430_0000.nc \
  surface/200805/20080501/Surface_METAR_20080501_0000.nc \
  surface/200805/20080502/Surface_METAR_20080502_0000.nc \
  surface/200805/20080503/Surface_METAR_20080503_0000.nc \
  surface/200805/20080504/Surface_METAR_20080504_0000.nc \
  surface/200805/20080505/Surface_METAR_20080505_0000.nc \
  surface/200805/20080506/Surface_METAR_20080506_0000.nc \
  surface/200805/20080507/Surface_METAR_20080507_0000.nc \
  surface/200805/20080508/Surface_METAR_20080508_0000.nc \
  surface/200805/20080509/Surface_METAR_20080509_0000.nc \
  surface/200805/20080510/Surface_METAR_20080510_0000.nc \
  surface/200805/20080511/Surface_METAR_20080511_0000.nc \
  surface/200805/20080512/Surface_METAR_20080512_0000.nc \
  surface/200805/20080513/Surface_METAR_20080513_0000.nc \
  surface/200805/20080514/Surface_METAR_20080514_0000.nc \
  surface/200805/20080515/Surface_METAR_20080515_0000.nc \
  surface/200805/20080516/Surface_METAR_20080516_0000.nc \
  surface/200805/20080517/Surface_METAR_20080517_0000.nc \
  surface/200805/20080518/Surface_METAR_20080518_0000.nc \
  surface/200805/20080519/Surface_METAR_20080519_0000.nc \
  surface/200805/20080520/Surface_METAR_20080520_0000.nc \
  surface/200805/20080521/Surface_METAR_20080521_0000.nc \
  surface/200805/20080522/Surface_METAR_20080522_0000.nc \
  surface/200805/20080523/Surface_METAR_20080523_0000.nc \
  surface/200805/20080524/Surface_METAR_20080524_0000.nc \
  surface/200805/20080525/Surface_METAR_20080525_0000.nc \
  surface/200805/20080526/Surface_METAR_20080526_0000.nc \
  surface/200805/20080527/Surface_METAR_20080527_0000.nc \
  surface/200805/20080528/Surface_METAR_20080528_0000.nc \
  surface/200805/20080529/Surface_METAR_20080529_0000.nc \
  surface/200805/20080530/Surface_METAR_20080530_0000.nc \
  surface/200805/20080531/Surface_METAR_20080531_0000.nc \
  surface/200806/20080601/Surface_METAR_20080601_0000.nc \
  surface/200806/20080602/Surface_METAR_20080602_0000.nc \
  surface/200806/20080603/Surface_METAR_20080603_0000.nc \
  surface/200806/20080604/Surface_METAR_20080604_0000.nc \
  surface/200806/20080605/Surface_METAR_20080605_0000.nc \
  surface/200806/20080606/Surface_METAR_20080606_0000.nc \
  surface/200806/20080607/Surface_METAR_20080607_0000.nc \
  surface/200806/20080608/Surface_METAR_20080608_0000.nc \
  surface/200806/20080609/Surface_METAR_20080609_0000.nc \
  surface/200806/20080610/Surface_METAR_20080610_0000.nc \
  surface/200806/20080611/Surface_METAR_20080611_0000.nc \
  surface/200806/20080612/Surface_METAR_20080612_0000.nc \
  surface/200806/20080613/Surface_METAR_20080613_0000.nc \
  surface/200806/20080614/Surface_METAR_20080614_0000.nc \
  surface/200806/20080615/Surface_METAR_20080615_0000.nc \
  surface/200806/20080616/Surface_METAR_20080616_0000.nc \
  surface/200806/20080617/Surface_METAR_20080617_0000.nc \
  surface/200806/20080618/Surface_METAR_20080618_0000.nc \
  surface/200806/20080619/Surface_METAR_20080619_0000.nc \
  surface/200806/20080620/Surface_METAR_20080620_0000.nc \
  surface/200806/20080621/Surface_METAR_20080621_0000.nc \
  surface/200806/20080622/Surface_METAR_20080622_0000.nc \
  surface/200806/20080623/Surface_METAR_20080623_0000.nc \
  surface/200806/20080624/Surface_METAR_20080624_0000.nc \
  surface/200806/20080625/Surface_METAR_20080625_0000.nc \
  surface/200806/20080626/Surface_METAR_20080626_0000.nc \
  surface/200806/20080627/Surface_METAR_20080627_0000.nc \
  surface/200806/20080628/Surface_METAR_20080628_0000.nc \
  surface/200806/20080629/Surface_METAR_20080629_0000.nc \
  surface/200806/20080630/Surface_METAR_20080630_0000.nc \
  surface/200807/20080701/Surface_METAR_20080701_0000.nc \
  surface/200807/20080702/Surface_METAR_20080702_0000.nc \
  surface/200807/20080703/Surface_METAR_20080703_0000.nc \
  surface/200807/20080704/Surface_METAR_20080704_0000.nc \
  surface/200807/20080705/Surface_METAR_20080705_0000.nc \
  surface/200807/20080706/Surface_METAR_20080706_0000.nc \
  surface/200807/20080707/Surface_METAR_20080707_0000.nc \
  surface/200807/20080708/Surface_METAR_20080708_0000.nc \
  surface/200807/20080709/Surface_METAR_20080709_0000.nc \
  surface/200807/20080710/Surface_METAR_20080710_0000.nc \
  surface/200807/20080711/Surface_METAR_20080711_0000.nc \
  surface/200807/20080712/Surface_METAR_20080712_0000.nc \
  surface/200807/20080713/Surface_METAR_20080713_0000.nc \
  surface/200807/20080714/Surface_METAR_20080714_0000.nc \
  surface/200807/20080715/Surface_METAR_20080715_0000.nc \
  surface/200807/20080716/Surface_METAR_20080716_0000.nc \
  surface/200807/20080717/Surface_METAR_20080717_0000.nc \
  surface/200807/20080718/Surface_METAR_20080718_0000.nc \
  surface/200807/20080719/Surface_METAR_20080719_0000.nc \
  surface/200807/20080720/Surface_METAR_20080720_0000.nc \
  surface/200807/20080721/Surface_METAR_20080721_0000.nc \
  surface/200807/20080722/Surface_METAR_20080722_0000.nc \
  surface/200807/20080723/Surface_METAR_20080723_0000.nc \
  surface/200807/20080724/Surface_METAR_20080724_0000.nc \
  surface/200807/20080725/Surface_METAR_20080725_0000.nc \
  surface/200807/20080726/Surface_METAR_20080726_0000.nc \
  surface/200807/20080727/Surface_METAR_20080727_0000.nc \
  surface/200807/20080728/Surface_METAR_20080728_0000.nc \
  surface/200807/20080729/Surface_METAR_20080729_0000.nc \
  surface/200807/20080730/Surface_METAR_20080730_0000.nc \
  surface/200807/20080731/Surface_METAR_20080731_0000.nc \
  surface/200808/20080801/Surface_METAR_20080801_0000.nc \
  surface/200808/20080802/Surface_METAR_20080802_0000.nc \
  surface/200808/20080803/Surface_METAR_20080803_0000.nc \
  surface/200808/20080804/Surface_METAR_20080804_0000.nc \
  surface/200808/20080805/Surface_METAR_20080805_0000.nc \
  surface/200808/20080806/Surface_METAR_20080806_0000.nc \
  surface/200808/20080807/Surface_METAR_20080807_0000.nc \
  surface/200808/20080808/Surface_METAR_20080808_0000.nc \
  surface/200808/20080809/Surface_METAR_20080809_0000.nc \
  surface/200808/20080810/Surface_METAR_20080810_0000.nc \
  surface/200808/20080811/Surface_METAR_20080811_0000.nc \
  surface/200808/20080812/Surface_METAR_20080812_0000.nc \
  surface/200808/20080813/Surface_METAR_20080813_0000.nc \
  surface/200808/20080814/Surface_METAR_20080814_0000.nc \
  surface/200808/20080815/Surface_METAR_20080815_0000.nc \
  surface/200808/20080816/Surface_METAR_20080816_0000.nc \
  surface/200808/20080817/Surface_METAR_20080817_0000.nc \
  surface/200808/20080818/Surface_METAR_20080818_0000.nc \
  surface/200808/20080819/Surface_METAR_20080819_0000.nc \
  surface/200808/20080820/Surface_METAR_20080820_0000.nc \
  surface/200808/20080821/Surface_METAR_20080821_0000.nc \
  surface/200808/20080822/Surface_METAR_20080822_0000.nc \
  surface/200808/20080823/Surface_METAR_20080823_0000.nc \
  surface/200808/20080824/Surface_METAR_20080824_0000.nc \
  surface/200808/20080825/Surface_METAR_20080825_0000.nc \
  surface/200808/20080826/Surface_METAR_20080826_0000.nc \
  surface/200808/20080827/Surface_METAR_20080827_0000.nc \
  surface/200808/20080828/Surface_METAR_20080828_0000.nc \
  surface/200808/20080829/Surface_METAR_20080829_0000.nc \
  surface/200808/20080830/Surface_METAR_20080830_0000.nc \
  surface/200808/20080831/Surface_METAR_20080831_0000.nc \
  surface/200809/20080901/Surface_METAR_20080901_0000.nc \
  surface/200809/20080902/Surface_METAR_20080902_0000.nc \
  surface/200809/20080903/Surface_METAR_20080903_0000.nc \
  surface/200809/20080904/Surface_METAR_20080904_0000.nc \
  surface/200809/20080905/Surface_METAR_20080905_0000.nc \
  surface/200809/20080906/Surface_METAR_20080906_0000.nc \
  surface/200809/20080907/Surface_METAR_20080907_0000.nc \
  surface/200809/20080908/Surface_METAR_20080908_0000.nc \
  surface/200809/20080909/Surface_METAR_20080909_0000.nc \
  surface/200809/20080910/Surface_METAR_20080910_0000.nc \
  surface/200809/20080911/Surface_METAR_20080911_0000.nc \
  surface/200809/20080912/Surface_METAR_20080912_0000.nc \
  surface/200809/20080913/Surface_METAR_20080913_0000.nc \
  surface/200809/20080914/Surface_METAR_20080914_0000.nc \
  surface/200809/20080915/Surface_METAR_20080915_0000.nc \
  surface/200809/20080916/Surface_METAR_20080916_0000.nc \
  surface/200809/20080917/Surface_METAR_20080917_0000.nc \
  surface/200809/20080918/Surface_METAR_20080918_0000.nc \
  surface/200809/20080919/Surface_METAR_20080919_0000.nc \
  surface/200809/20080920/Surface_METAR_20080920_0000.nc \
  surface/200809/20080921/Surface_METAR_20080921_0000.nc \
  surface/200809/20080922/Surface_METAR_20080922_0000.nc \
  surface/200809/20080923/Surface_METAR_20080923_0000.nc \
  surface/200809/20080924/Surface_METAR_20080924_0000.nc \
  surface/200809/20080925/Surface_METAR_20080925_0000.nc \
  surface/200809/20080926/Surface_METAR_20080926_0000.nc \
  surface/200809/20080927/Surface_METAR_20080927_0000.nc \
  surface/200809/20080928/Surface_METAR_20080928_0000.nc \
  surface/200809/20080929/Surface_METAR_20080929_0000.nc \
  surface/200809/20080930/Surface_METAR_20080930_0000.nc \
  surface/200810/20081001/Surface_METAR_20081001_0000.nc \
  surface/200810/20081002/Surface_METAR_20081002_0000.nc \
  surface/200810/20081003/Surface_METAR_20081003_0000.nc \
  surface/200810/20081004/Surface_METAR_20081004_0000.nc \
  surface/200810/20081005/Surface_METAR_20081005_0000.nc \
  surface/200810/20081006/Surface_METAR_20081006_0000.nc \
  surface/200810/20081007/Surface_METAR_20081007_0000.nc \
  surface/200810/20081008/Surface_METAR_20081008_0000.nc \
  surface/200810/20081009/Surface_METAR_20081009_0000.nc \
  surface/200810/20081010/Surface_METAR_20081010_0000.nc \
  surface/200810/20081011/Surface_METAR_20081011_0000.nc \
  surface/200810/20081012/Surface_METAR_20081012_0000.nc \
  surface/200810/20081013/Surface_METAR_20081013_0000.nc \
  surface/200810/20081014/Surface_METAR_20081014_0000.nc \
  surface/200810/20081015/Surface_METAR_20081015_0000.nc \
  surface/200810/20081016/Surface_METAR_20081016_0000.nc \
  surface/200810/20081017/Surface_METAR_20081017_0000.nc \
  surface/200810/20081018/Surface_METAR_20081018_0000.nc \
  surface/200810/20081019/Surface_METAR_20081019_0000.nc \
  surface/200810/20081020/Surface_METAR_20081020_0000.nc \
  surface/200810/20081021/Surface_METAR_20081021_0000.nc \
  surface/200810/20081022/Surface_METAR_20081022_0000.nc \
  surface/200810/20081023/Surface_METAR_20081023_0000.nc \
  surface/200810/20081024/Surface_METAR_20081024_0000.nc \
  surface/200810/20081025/Surface_METAR_20081025_0000.nc \
  surface/200810/20081026/Surface_METAR_20081026_0000.nc \
  surface/200810/20081027/Surface_METAR_20081027_0000.nc \
  surface/200810/20081028/Surface_METAR_20081028_0000.nc \
  surface/200810/20081029/Surface_METAR_20081029_0000.nc \
  surface/200810/20081030/Surface_METAR_20081030_0000.nc \
  surface/200810/20081031/Surface_METAR_20081031_0000.nc \
  surface/200811/20081101/Surface_METAR_20081101_0000.nc \
  surface/200811/20081102/Surface_METAR_20081102_0000.nc \
  surface/200811/20081103/Surface_METAR_20081103_0000.nc \
  surface/200811/20081104/Surface_METAR_20081104_0000.nc \
  surface/200811/20081105/Surface_METAR_20081105_0000.nc \
  surface/200811/20081106/Surface_METAR_20081106_0000.nc \
  surface/200811/20081107/Surface_METAR_20081107_0000.nc \
  surface/200811/20081108/Surface_METAR_20081108_0000.nc \
  surface/200811/20081109/Surface_METAR_20081109_0000.nc \
  surface/200811/20081110/Surface_METAR_20081110_0000.nc \
  surface/200811/20081111/Surface_METAR_20081111_0000.nc \
  surface/200811/20081112/Surface_METAR_20081112_0000.nc \
  surface/200811/20081113/Surface_METAR_20081113_0000.nc \
  surface/200811/20081114/Surface_METAR_20081114_0000.nc \
  surface/200811/20081115/Surface_METAR_20081115_0000.nc \
  surface/200811/20081116/Surface_METAR_20081116_0000.nc \
  surface/200811/20081117/Surface_METAR_20081117_0000.nc \
  surface/200811/20081118/Surface_METAR_20081118_0000.nc \
  surface/200811/20081119/Surface_METAR_20081119_0000.nc \
  surface/200811/20081120/Surface_METAR_20081120_0000.nc \
  surface/200811/20081121/Surface_METAR_20081121_0000.nc \
  surface/200811/20081122/Surface_METAR_20081122_0000.nc \
  surface/200811/20081123/Surface_METAR_20081123_0000.nc \
  surface/200811/20081124/Surface_METAR_20081124_0000.nc \
  surface/200811/20081125/Surface_METAR_20081125_0000.nc \
  surface/200811/20081126/Surface_METAR_20081126_0000.nc \
  surface/200811/20081127/Surface_METAR_20081127_0000.nc \
  surface/200811/20081128/Surface_METAR_20081128_0000.nc \
  surface/200811/20081129/Surface_METAR_20081129_0000.nc \
  surface/200811/20081130/Surface_METAR_20081130_0000.nc \
  surface/200812/20081201/Surface_METAR_20081201_0000.nc \
  surface/200812/20081202/Surface_METAR_20081202_0000.nc \
  surface/200812/20081203/Surface_METAR_20081203_0000.nc \
  surface/200812/20081204/Surface_METAR_20081204_0000.nc \
  surface/200812/20081205/Surface_METAR_20081205_0000.nc \
  surface/200812/20081206/Surface_METAR_20081206_0000.nc \
  surface/200812/20081207/Surface_METAR_20081207_0000.nc \
  surface/200812/20081208/Surface_METAR_20081208_0000.nc \
  surface/200812/20081209/Surface_METAR_20081209_0000.nc \
  surface/200812/20081210/Surface_METAR_20081210_0000.nc \
  surface/200812/20081211/Surface_METAR_20081211_0000.nc \
  surface/200812/20081212/Surface_METAR_20081212_0000.nc \
  surface/200812/20081213/Surface_METAR_20081213_0000.nc \
  surface/200812/20081214/Surface_METAR_20081214_0000.nc \
  surface/200812/20081215/Surface_METAR_20081215_0000.nc \
  surface/200812/20081216/Surface_METAR_20081216_0000.nc \
  surface/200812/20081217/Surface_METAR_20081217_0000.nc \
  surface/200812/20081218/Surface_METAR_20081218_0000.nc \
  surface/200812/20081219/Surface_METAR_20081219_0000.nc \
  surface/200812/20081220/Surface_METAR_20081220_0000.nc \
  surface/200812/20081221/Surface_METAR_20081221_0000.nc \
  surface/200812/20081222/Surface_METAR_20081222_0000.nc \
  surface/200812/20081223/Surface_METAR_20081223_0000.nc \
  surface/200812/20081224/Surface_METAR_20081224_0000.nc \
  surface/200812/20081225/Surface_METAR_20081225_0000.nc \
  surface/200812/20081226/Surface_METAR_20081226_0000.nc \
  surface/200812/20081227/Surface_METAR_20081227_0000.nc \
  surface/200812/20081228/Surface_METAR_20081228_0000.nc \
  surface/200812/20081229/Surface_METAR_20081229_0000.nc \
  surface/200812/20081230/Surface_METAR_20081230_0000.nc \
  surface/200812/20081231/Surface_METAR_20081231_0000.nc \
)
while($#filelist > 0)
 set syscmd = "$opt2$filelist[1]"
 echo "$syscmd ..."
 $syscmd
 shift filelist
end

rm -f auth.rda_ucar_edu Authentication.log
exit 0