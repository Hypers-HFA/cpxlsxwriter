cimport cpxlsxwriter as cp


cdef class Format:
    cdef cp.lxw_format *_c_format

    def __cinit__(self, WorkBook workbook):
        self._c_format = cp.workbook_add_format(workbook._c_workbook)

    def set_bold(self):
        cp.format_set_bold(self._c_format)

    def set_font_color(self, str color):
        cp.format_set_font_color(self._c_format, color)

    def set_font_size(self, int size):
        cp.format_set_font_size(self._c_format, size)

    def set_font_name(self, str name):
        cp.format_set_font_name(self._c_format, name)

    def set_italic(self):
        cp.format_set_italic(self._c_format)

    def set_underline(self, int style):
        cp.format_set_underline(self._c_format, style)

    def set_align(self, int alignment):
        cp.format_set_align(self._c_format, alignment)

    # def __getattr__(self, name):  # if any method didn't defined, just call from cpxlsxwriter, and add self._cformat to the func's args
    #     func = getattr(cp, 'format_{}'.format(name))
    #     from functools import partial
    #     func = partial(func, self._cformat)
    #     return func

cdef class WorkSheet:
    cdef:
        cp.lxw_worksheet *_c_worksheet
        cp.lxw_format *_c_format

    def __cinit__(self, WorkBook workbook, str sheetname):
        self._c_worksheet = cp.workbook_add_worksheet(workbook._c_workbook, sheetname)
        self._c_format = NULL

    def write(self, cp.lxw_row_t row, cp.lxw_col_t col, string):
        cp.worksheet_write_string(self._c_worksheet, row, col, str(string), self._c_format)

    def write_string(self, cp.lxw_row_t row, cp.lxw_col_t col, str string):
        cp.worksheet_write_string(self._c_worksheet, row, col, string, self._c_format)

    def write_number(self, cp.lxw_row_t row, cp.lxw_col_t col, number):
        cp.worksheet_write_number(self._c_worksheet, row, col, number, self._c_format)

    def write_formula(self, cp.lxw_row_t row, cp.lxw_col_t col, str formula):
        cp.worksheet_write_formula(self._c_worksheet, row, col, formula, self._c_format)

    def set_column(self, cp.lxw_col_t first_col, cp.lxw_col_t last_col, double width):
        cp.worksheet_set_column(self._c_worksheet, first_col, last_col, width, self._c_format)

    def write_row(self, int first_col, int last_col, int row, data_set):
        for col, data in zip(range(first_col, last_col), data_set):
            cp.worksheet_write_string(self._c_worksheet, row, col, data, self._c_format)

    def write_col(self, int first_row, int last_row, int col, data_set):
        for row, data in zip(range(first_row, last_row), data_set):
            cp.worksheet_write_string(self._c_worksheet, row, col, data, self._c_format)


cdef class Chart:
    cdef cp.lxw_chart  *_c_chart
    def __cinit__(self, WorkBook workbook, int chart_type):
        self._c_chart = cp.workbook_add_chart(workbook._c_workbook, chart_type)

cdef class WorkBook:
    cdef cp.lxw_workbook *_c_workbook
    cdef:
        list formats
        list charts
        list worksheets
    def __cinit__(self, str filename):
        self._c_workbook = cp.new_workbook(filename)
        self.worksheets = []
        self.formats = []
        self.charts = []

    def add_worksheet(self, str sheetname):
        ws = WorkSheet(self, sheetname)
        self.worksheets.append(ws)
        return ws

    def add_chart(self, int chart_type):
        chart = Chart(self, chart_type)
        self.charts.append(chart)
        return chart

    def add_format(self):
        format = Format(self)
        self.formats.append(format)
        return format

    def close(self):
        cp.workbook_close(self._c_workbook)
