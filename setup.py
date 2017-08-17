from Cython.Build import cythonize
import subprocess
import sys

from distutils.core import setup
from distutils.extension import Extension

if 'build_ext' in sys.argv:
    subprocess.call(['wget', 'https://github.com/jmcnamara/libxlsxwriter/archive/master.zip'])
    subprocess.call(['unzip', 'master.zip'])
    subprocess.call(['cd', 'libxlsxwriter-master', '&&', 'make', '&&', 'make install'])
    subprocess.call(['rm', '-rf', 'libxlsxwriter-master', '&&', 'rm', 'master.zip'])
    subprocess.call(['cp', '/usr/local/lib/libxlsxwriter.so', '/usr/lib/'])
ext_modules = cythonize([
    Extension("cpexcel", ["src/cpexcel.pyx"], libraries=["xlsxwriter"])])

setup(
  name = "cpexcel",
  ext_modules = cythonize(ext_modules)
)
