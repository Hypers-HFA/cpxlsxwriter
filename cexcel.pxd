
cdef extern from "xlsxwriter/format.h":
    ctypedef struct lxw_error:
        pass

cdef extern from "xlsxwriter/common.h":

    ctypedef int lxw_col_t
    ctypedef int lxw_row_t
    ctypedef struct lxw_format:
        pass

cdef extern from "xlsxwriter/worksheet.h":
    ctypedef struct lxw_worksheet:
        pass

    lxw_error worksheet_write_string(lxw_worksheet *worksheet,
                                    lxw_row_t row,
                                    lxw_col_t col,
                                    const char *string,
                                    lxw_format *cformat);

    lxw_error worksheet_write_number(lxw_worksheet *worksheet,
                                    lxw_row_t row,
                                    lxw_col_t col,
                                    double number,
                                    lxw_format *cformat);


    lxw_error worksheet_set_column(lxw_worksheet *worksheet,
                                lxw_col_t first_col,
                                lxw_col_t last_col,
                                double width, lxw_format *format);

cdef extern from "xlsxwriter/workbook.h":
    ctypedef struct lxw_workbook:
        pass
    ctypedef struct  lxw_workbookoptions:
        pass

    lxw_workbook *new_workbook(const char *filename);

    lxw_worksheet *workbook_add_worksheet(lxw_workbook *workbook,
                                        const char *sheetname);

    lxw_error workbook_close(lxw_workbook *workbook);

cdef extern from "xlsxwriter/custom.h":
    lxw_format *get_my_style(lxw_workbook *workbook, int name)
