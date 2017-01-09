
cdef extern from "xlsxwriter/format.h":
    ctypedef struct lxw_error:
        pass

    ctypedef int uint8_t
    ctypedef int uint16_t
    ctypedef int int16_t
    ctypedef int uint32_t
    ctypedef int lxw_color_t

    void format_set_align(lxw_format *format, uint8_t alignment);
    void format_set_hidden(lxw_format *format);

    void format_set_text_wrap(lxw_format *format);
    void format_set_rotation(lxw_format *format, int16_t angle);
    void format_set_indent(lxw_format *format, uint8_t level);
    void format_set_shrink(lxw_format *format);
    void format_set_pattern(lxw_format *format, uint8_t index);
    void format_set_bg_color(lxw_format *format, lxw_color_t color);
    void format_set_fg_color(lxw_format *format, lxw_color_t color);
    void format_set_border(lxw_format *format, uint8_t style);
    void format_set_bottom(lxw_format *format, uint8_t style);
    void format_set_top(lxw_format *format, uint8_t style);
    void format_set_left(lxw_format *format, uint8_t style);
    void format_set_right(lxw_format *format, uint8_t style);
    void format_set_border_color(lxw_format *format, lxw_color_t color);
    void format_set_top_color(lxw_format *format, lxw_color_t color);
    void format_set_left_color(lxw_format *format, lxw_color_t color);
    void format_set_num_format_index(lxw_format *format, uint8_t index);
    void format_set_right_color(lxw_format *format, lxw_color_t color);

    void format_set_diag_type(lxw_format *format, uint8_t value);
    void format_set_diag_color(lxw_format *format, lxw_color_t color);
    void format_set_diag_border(lxw_format *format, uint8_t value);
    void format_set_font_outline(lxw_format *format);
    void format_set_font_shadow(lxw_format *format);
    void format_set_font_family(lxw_format *format, uint8_t value);
    void format_set_font_charset(lxw_format *format, uint8_t value);
    void format_set_font_scheme(lxw_format *format, const char *font_scheme);
    void format_set_font_condense(lxw_format *format);
    void format_set_font_extend(lxw_format *format);
    void format_set_reading_order(lxw_format *format, uint8_t value);
    void format_set_theme(lxw_format *format, uint8_t value);
    void format_set_num_format(lxw_format *format, const char *num_format);
    void format_set_font_script(lxw_format *format, uint8_t style);
    void format_set_underline(lxw_format *format, uint8_t style);
    void format_set_italic(lxw_format *format);
    void format_set_bold(lxw_format *format);
    void format_set_font_color(lxw_format *format, lxw_color_t color);
    void format_set_font_size(lxw_format *format, uint16_t size);
    void format_set_font_name(lxw_format *format, const char *font_name);
    void format_set_unlocked(lxw_format *format);
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



    lxw_error worksheet_write_formula(lxw_worksheet * worksheet,
    lxw_row_t row,
    lxw_col_t col,
    const char * formula,
    lxw_format * format
    )

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

    lxw_format *workbook_add_format(lxw_workbook *workbook);

    lxw_chart *workbook_add_chart(lxw_workbook *workbook, uint8_t chart_type);

cdef extern from "xlsxwriter/chart.h":
    ctypedef struct lxw_chart:
        pass

cdef extern from "xlsxwriter/custom.h":
    lxw_format *get_my_style(lxw_workbook *workbook, int name)
