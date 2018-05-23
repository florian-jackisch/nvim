#!/usr/bin/env python3

import os
import shutil
import subprocess

completers = ['--clang-completer']

if shutil.which('cargo'):
    completers.append('--rust-completer')
if shutil.which('go'):
    completers.append('--go-completer')

script_dir = os.path.dirname(os.path.realpath(__file__))
ycm_dir = os.path.join(script_dir, 'plugged/YouCompleteMe')

print('cd', ycm_dir)
print(' '.join(['python3', './install.py', *completers]))
subprocess.call(['python3', './install.py', *completers], cwd=ycm_dir)
