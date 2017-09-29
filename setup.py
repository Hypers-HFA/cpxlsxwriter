from Cython.Build import cythonize
import sys
import subprocess

from distutils.core import setup
from distutils.extension import Extension


def lib():
    mkdir = 'mkdir -p /usr/include && mkdir -p /usr/lib'
    cp = 'cp lib/* /usr/lib/ && cp include/* /usr/include/'
    subprocess.call(mkdir, shell=True)
    subprocess.call(cp, shell=True)
    subprocess.call('python setup.py build_ext --inplace', shell=True)


if 'build_ext' not in sys.argv:
    lib()
ext_modules = cythonize(
    [Extension("cpexcel", ["src/cpexcel.pyx"], libraries=["xlsxwriter"])])

setup(name="cpexcel", ext_modules=cythonize(ext_modules))
