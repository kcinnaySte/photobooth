from shutil import copyfile
import os
import time

mountpath = "/media/pi/"
sourcepath = "/var/www/html/images/"
configpath = "/var/www/html/my.config.php"


while True:
    targetpathlist = os.listdir(mountpath)
    for targetpath in targetpathlist:
        targetpath = mountpath + targetpath + "/"
        #print ("Pfad ist: " + targetpath)
        directory = os.listdir(sourcepath)
        if ".backupconfig" in os.listdir(targetpath):
            os.remove(targetpath + ".backupconfig")
            copyfile(configpath, targetpath + "my.config.php")
            os.system("umount " + targetpath)

        if ".delete" in os.listdir(targetpath):
            os.remove(targetpath + ".delete")
            print ("Alle Daten werden geloescht")
            logfile = open(targetpath + "del.txt","w")
            logfile.write("Loeschen hat begonnen\n")
            for file in directory:
                copyfile(sourcepath + file, targetpath + file )
                os.remove(sourcepath + file)
                print ("Datei " + file + " geloscht!")
                logfile.write("Datei " + file + " kopiert und geloscht\n")
            logfile.write("*** Vorgang abgeschlossen ***\n")
            logfile.close()
            os.system("umount " + targetpath)
        else:
            #print ("TryCopy")
            for file in directory:
                copyfile(sourcepath + file, targetpath + file )
                print ("Datei " + sourcepath + file + " kopiert nach " + targetpath + file ) 
    time.sleep(10)