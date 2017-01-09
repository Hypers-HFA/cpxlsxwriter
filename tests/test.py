import unittest

import cpxlsxwrite
class TestWorkBook(unittest.TestCase):
    def setUp(self):
        self.wb = cpxlsxwriter.WorkBook('test.xlsx')
        self.ws = wb.add_worksheet('test')

    def test_write_string(self):
        self.ws.write_string(0, 0, 'test')

    def tearDown(self):
        wb.close()
