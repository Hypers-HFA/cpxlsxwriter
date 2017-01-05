cimport cexcel

cdef class WorkBook:
    cdef cexcel.lxw_workbook *_c_workbook
    cdef cexcel.lxw_worksheet *_c_worksheet
    cdef cexcel.lxw_format *_c_header
    cdef cexcel.lxw_format *_c_str
    cdef cexcel.lxw_format *_c_num
    cdef cexcel.lxw_format *cformat
    def __cinit__(self, const char *filename):
        self._c_workbook = cexcel.new_workbook(filename)
        self._c_header = cexcel.get_my_style(self._c_workbook, 0)
        self._c_str = cexcel.get_my_style(self._c_workbook, 1)
        self._c_num = cexcel.get_my_style(self._c_workbook, 2)

    def add_worksheet(self, const char *sheetname):
        self._c_worksheet = cexcel.workbook_add_worksheet(self._c_workbook, sheetname)
        return self

    def write_header(self, cexcel.lxw_row_t row, cexcel.lxw_col_t col, const char *string):
        cexcel.worksheet_write_string(self._c_worksheet, row, col, string, self._c_header)

    def write_string(self, cexcel.lxw_row_t row, cexcel.lxw_col_t col, const char *string):
        cexcel.worksheet_write_string(self._c_worksheet, row, col, string, self._c_str)

    def write_number(self, cexcel.lxw_row_t row, cexcel.lxw_col_t col, number):
        if number in {'--', ''}:
            cexcel.worksheet_write_string(self._c_worksheet, row, col, number, self._c_num)
        else:
            cexcel.worksheet_write_number(self._c_worksheet, row, col, number, self._c_num)

    def write_percent(self, cexcel.lxw_row_t row, cexcel.lxw_col_t col, const char *string):
        cexcel.worksheet_write_string(self._c_worksheet, row, col, string, self._c_num)

    def close(self):
        cexcel.workbook_close(self._c_workbook)

    def set_column(self, cexcel.lxw_col_t first_col, cexcel.lxw_col_t last_col, double width):
        cexcel.worksheet_set_column(self._c_worksheet, first_col, last_col, width, NULL)
