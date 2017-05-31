"""
This file is used by the YouCompleteMe extension to provide C / C++
autocompletion.

If a  is in the folder and a file matches an entry
of the database, the flags from the database are used. If there is no entry
for the current header file in the compilation database but a related cpp file
has flags, those flags are used. If no entry can be found,  will be
used.
"""

import os
import ycm_core


flags = [
    '-x',
    'c++',
    '-DNDEBUG',
    '-Wall',
    '-Werror',
    '-Wextra',
    '-std=c++14',
]

def FlagsForFile(filename, **kwargs):
    return {'flags': flags, 'do_cache': True}
