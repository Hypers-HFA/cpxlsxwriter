cimport cexcel as cp

cdef class Format:
    cdef cp.lxw_format *_c_format

    def __cinit__(self, WorkBook workbook):
        self._c_format = cp.workbook_add_format(workbook._c_workbook)

    def set_bold(self):
        cp.format_set_bold(self._c_format)

    def set_font_color(self, color):
        _color = int(color.replace('#', '0x').encode('utf8'), 16)
        cp.format_set_font_color(self._c_format, _color)

    def set_font_size(self, int size):
        cp.format_set_font_size(self._c_format, size)

    def set_font_name(self, name):
        cp.format_set_font_name(self._c_format, name.encode('utf8'))

    def set_bg_color(self, color):
        _color = int(color.replace('#', '0x').encode('utf8'), 16)
        cp.format_set_bg_color(self._c_format, _color)

    def set_border_color(self, color):
        _color = int(color.replace('#', '0x').encode('utf8'), 16)
        cp.format_set_border_color(self._c_format, _color)

    def set_border(self, border):
        cp.format_set_border(self._c_format, border)

    def set_italic(self):
        cp.format_set_italic(self._c_format)

    def set_pattern(self, int pattern):
        cp.format_set_pattern(self._c_format, pattern)

    def set_underline(self, int style):
        cp.format_set_underline(self._c_format, style)

    def set_align(self, str alignment):
        if alignment == 'left':
            _alignment = 1
        elif alignment == 'right':
            _alignment = 3
        else:
            _alignment = 2
        cp.format_set_align(self._c_format, _alignment)


cdef class WorkSheet:
    cdef:
        cp.lxw_worksheet *_c_worksheet
        cp.lxw_format *_c_format

    def __cinit__(self, WorkBook workbook, str sheetname):
        self._c_worksheet = cp.workbook_add_worksheet(workbook._c_workbook, sheetname)
        self._c_format = NULL

    def write(self, cp.lxw_row_t row, cp.lxw_col_t col, string, Format format):
        cp.worksheet_write_string(self._c_worksheet, row, col, unicode(string).encode('utf8'), format._c_format)

    def write_string(self, cp.lxw_row_t row, cp.lxw_col_t col, string, Format format):
        cp.worksheet_write_string(self._c_worksheet, row, col, string.encode('utf8'), format._c_format)

    def write_header(self, cp.lxw_row_t row, cp.lxw_col_t col, string, Format format):
        cp.worksheet_write_string(self._c_worksheet, row, col, string.encode('utf8'), format._c_format)

    def write_number(self, cp.lxw_row_t row, cp.lxw_col_t col, number, Format format):
        cp.worksheet_write_number(self._c_worksheet, row, col, number, format._c_format)

    def write_sp_num(self, cp.lxw_row_t row, cp.lxw_col_t col, number, Format format):
        if isinstance(number, basestring):  # '--', '0   (0%)'
            cp.worksheet_write_string(self._c_worksheet, row, col, number, format._c_format)
        else:
            cp.worksheet_write_number(self._c_worksheet, row, col, number, format._c_format)

    def write_formula(self, cp.lxw_row_t row, cp.lxw_col_t col, str formula, Format format):
        cp.worksheet_write_formula(self._c_worksheet, row, col, formula, format._c_format)

    def set_column(self, cp.lxw_col_t first_col, cp.lxw_col_t last_col, double width):
        cp.worksheet_set_column(self._c_worksheet, first_col, last_col, width, self._c_format)

    def write_row(self, int first_col, int last_col, int row, data_set):
        for col, data in zip(range(first_col, last_col), data_set):
            cp.worksheet_write_string(self._c_worksheet, row, col, data, self._c_format)

    def write_col(self, int first_row, int last_row, int col, data_set):
        for row, data in zip(range(first_row, last_row), data_set):
            cp.worksheet_write_string(self._c_worksheet, row, col, data, self._c_format)

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

    def add_worksheet(self, sheetname):
        ws = WorkSheet(self, sheetname.encode('utf8'))
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

cdef class Chart:
    cdef cp.lxw_chart  *_c_chart
    def __cinit__(self, WorkBook workbook, int chart_type):
        self._c_chart = cp.workbook_add_chart(workbook._c_workbook, chart_type)
