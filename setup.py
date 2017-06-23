from Cython.Build import cythonize

from distutils.core import setup
from distutils.extension import Extension

ext_modules = cythonize([
    Extension("cpexcel", ["src/cpexcel.pyx"], libraries=["xlsxwriter"])])

setup(
  name = "cpexcel",
  ext_modules = cythonize(ext_modules)
)
