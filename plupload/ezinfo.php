<?php
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: plupload
// SOFTWARE RELEASE: 0.1
// COPYRIGHT NOTICE: Copyright (C) 2010 Contactivity B.V.
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >

//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

/*! \file ezinfo.php


  \class enhancedezbinaryfile ezinfo.php
  \brief The class EnhancedeZBinaryFileType allows files to used as a 
   collected information datatype.  These files will be temporary, will
   be written to var/storage but will not be written to the database.
   Used in conjuction with a kernel hack it can be used to easily send
   the information collector the file as an e-mail attachment.

*/

class pluploadInfo
{
    static function info()
    {
        return array(
            'Name' => "plupload",
            'Version' => "0.1",
            'Copyright' => "Copyright (c) 2010 Contactivity B.V.",
            'Info_url' => "http://www.contactivity.com",
            'License' => "GNU General Public License v2.0",
            'Includes the following third-party software' => array( 'Name' => 'plupload',
                                                                    'Version' => '1.2',
                                                                    'Copyright' => 'Copyright (C) 2010, Moxiecode Systems AB, All rights reserved.',
                                                                    'License' => 'GNU Lesser General Public License v2'
								 ,),

	);
    }
}

?>

