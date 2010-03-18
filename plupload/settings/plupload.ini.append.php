<?php /* #?ini charset="iso-8859-1"?

[pluploadSettings]

#unless multipleRuntimes=enabled, only the first Runtime will be used
availableRuntimes[]
availableRuntimes[]=flash
availableRuntimes[]=gears
availableRuntimes[]=silverlight
availableRuntimes[]=html5
availableRuntimes[]=browserplus
availableRuntimes[]=html4

multipleRuntimes=disabled

#Should be unique since we may be cleaning up and we don't want to break anything.
DownloadPath=original/plupload
#I'm not sure this should be done... but this should only be cleaning up failed uploads. With a successful upload, files will be removed when the are made into an object.  But it may be worth keeping around just in case some files are stranded ugly.  Just have to make sure that IF the download path is the the same as where a delayed cronjob is going to be handling an upload that the maxFileAge is big enough to handle that.  Keep in mind too that if someone malicious has a lot of time to waste they can upload junk until var is full and then your server will stop working well - if at all.  Unless of course your download directory is not part of /var.
removeTempFiles=enabled
maxFileAge=60

#Not sure what the setTimeLimit does - I think it's the max time for a chunk since the test file I sent took 10 minutes while this was set to 5 and another upload failed twice at around the 10 minute mark.  Default in the code is 5.
setTimeLimit=15

[default]
JavaScriptList[]=jquery.js
#JavaScriptList[]=plupload.min.js
JavaScriptList[]=jquery.plupload.queue.min.js
#JavaScriptList[]=jquery.plupload.single.min.js
JavaScriptList[]=plupload.full.min.js

#Must be false in the template so that we can capture it and use it in the php - unless the multipart option is set in which case the unique_names can be used but it'll break for safari users.  Depends on which of your users you'd prefer to piss off.
unique_names=false
max_file_size=1.2gb
chunk_size=10mb
filters[]
filters[image]=jpg,gif,png
filters[Multimedia]=avi,flv,wmv,mp4,mp3
filters[iso]=iso,img
filters[archive]=zip,tgz,gz,tar,bzip2

#this is for the built-in resize of an image file... probably not many reasons to use with ez
#resize (true/false) width/height/quality - if any are not set it won't do it
resize[]
resize[width]=320
resize[height]=240
resize[quality]=90

#I really only tested well with flash - so be warned.
[flash]
#JavaScriptList[]=plupload.flash.min.js
#unique_names (should be false so that we can capture it - or capture it some other way)
max_file_size=700mb
#chunk_size
#filters -> title -> extensions
resize[]

[gears]
JavaScriptList[]=gears_init.js
JavaScriptList[]=plupload.gears.min.js

[silverlight]

[html5]
JavaScriptList[]=plupload.html5.min.js

[browserplus]
JavaScriptList[]=browserplus-min.js
JavaScriptList[]=plupload.browserplus.min.js

[html4]
JavaScriptList[]=plupload.html4.min.js
*/ ?>