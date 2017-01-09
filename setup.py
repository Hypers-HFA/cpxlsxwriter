# from distutils.core import setup, Extension
# setup(name='helloworld', version='1.0',\
#         ext_modules=[Extension('helloworld', ['hello.c'], \
#         library_dirs=['/home/linlin/Desktop/libxlsxwriter-master/lib'],
#         libraries=['xlsxwriter'])])

# import setuptools
from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize


ext_modules = cythonize([
    Extension("cpxlsxwriter", ["src/cpxlsxwriter.pyx"],
              libraries=["xlsxwriter"])])

setup(
  name = "cpxlsxwriter",
  ext_modules = cythonize(ext_modules)
)
