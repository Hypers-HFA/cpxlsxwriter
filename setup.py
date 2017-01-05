# from distutils.core import setup, Extension
# setup(name='helloworld', version='1.0',\
#         ext_modules=[Extension('helloworld', ['hello.c'], \
#         library_dirs=['/home/linlin/Desktop/libxlsxwriter-master/lib'],
#         libraries=['xlsxwriter'])])

from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize


ext_modules = cythonize([
    Extension("excel", ["excel.pyx"],
              libraries=["xlsxwriter"], include_dirs=['include'])])

setup(
  name = "py_c_xlsxwriter",
  ext_modules = cythonize(ext_modules)
)
