from Cython.Build import cythonize
import subprocess
import sys

from distutils.core import setup
from distutils.extension import Extension

if 'install' in sys.argv:
    subprocess.call('wget https://github.com/jmcnamara/libxlsxwriter/archive/master.zip && unzip master.zip', shell=True)
    subprocess.call('cd libxlsxwriter-master && make && make install', shell=True)
    subprocess.call('rm -rf libxlsxwriter-master && rm master.zip', shell=True)
    subprocess.call('cp /usr/local/lib/libxlsxwriter.so /usr/lib', shell=True)
    subprocess.call('python setup.py build_ext --inplace', shell=True)
ext_modules = cythonize([
    Extension("cpexcel", ["src/cpexcel.pyx"], libraries=["xlsxwriter"])])

setup(
  name = "cpexcel",
  ext_modules = cythonize(ext_modules)
)
