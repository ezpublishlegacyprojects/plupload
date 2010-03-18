/*
    plupload for eZ publish
    Developed by Steven E. Bailey and Sebastiaan van der Vliet
    Contactivity bv, Leiden the Netherlands
    
    http://www.contactivity.com, info@contactivity.com
    

    This file may be distributed and/or modified under the terms of the
    GNU General Public License" version 2 as published by the Free
    Software Foundation and appearing in the file LICENSE.GPL included in
    the packaging of this file.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    The "GNU General Public License" (GPL) is available at
    http://www.gnu.org/copyleft/gpl.html.
*/


plupload: Version: 0.1 Beta
-------------------------------------

1. Context
----------
This extension was developed to make it possible to upload large files using
Moxiecode's plupload (http://www.plupload.com/).  This makes is possible to
upload multi-gig files without being constrained by apache or php size limits.

2. Features
-----------
There are lots of options - many of which haven't been thought out entirely or
may be completely incorrectly implemented.

3. Example of use
-----------------
Take a look at http://www.plupload.com/example_all_runtimes.php

4. Known bugs, limitations, etc.
-----------------------------
The extension has the following limitations and bugs:
- this is still beta software.  Not a google-type beta either.  Look at the 
  TODO.txt - lots and lots to do.  The Moxiecode plupload code is also still
  in heavy development so things there can still change significantly.
- I've barely tested anything except for the flash runtime.  This does not
  always work either for unkown reasons - although maddeningly enough it always
  PRETENDS it does.  See the next item.
- I haven't figured out how to handle the javascript errors yet so if anything
  fails it will happily report that it is 100%    done.
- there should be a check of filetype in upload.php - otherwise someone could
  just craft a post that will ignore the filetype limitations - but since the
  filetypes are dependent on the runtime and the runtime type is never passed to
  upload, it maybe is better just to hard-code it depending on how people actually
  want to use this.

  
5. Feedback
--------------------------------
Please send all your remarks, comments and suggestions for improvement to
info@contactivity.com.  Paid support is also available.


6. Disclaimer
-------------------------
This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

7. Installation

1) Put this extension's folder in the "extension" directory under the root of
   the ezp site.

2) Open the appropriate site.ini and add ActiveExtensions[]=plupload (in the
   case of the override site.ini) or ActiveAccessExtension[]=plupload to the
   [ExtensionSettings] block.

3) This will add a plupload icon to the webtoolbar on the frontend at locations
   where the user has write permission and the     object is a container.  On the
   backend a similar button will be put in the right menu.  Both can be disabled 
   in the settings folder.  Alternatively go to <site_url>/plupload/widget/<node_id>
   and if the permissions are correct you'll get the widget(s).


8. Version history:
-------------------------------
* Release 0.1 Beta: initial release