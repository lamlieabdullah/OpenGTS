import urllib2

# Using readline()
file1 = open('gps-recording-1616230035942.nmea', 'r')
count = 0
while True:
    count += 1

    # Get next line from file
    line = file1.readline()

    # if line is empty
    # end of file is reached
    if not line:
        break

    if line.find("$GPRMC") != -1:
        webUrl = urllib2.urlopen("http://192.168.182.143:8080/gprmc/Data?id=1234&gprmc="+line)
        print "result code: " + str(webUrl.getcode())


file1.close()
