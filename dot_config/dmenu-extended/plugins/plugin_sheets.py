import dmenu_extended
import sys
import os

file_prefs = dmenu_extended.path_prefs + '/SheetsDirs.json'

class extension(dmenu_extended.dmenu):

    title = 'Sheets'
    is_submenu = True


    def create_default_sheets(self):
        default = { 'dirs': [] }
        self.save_json(file_prefs, default)


    def load_sheets(self):
        sheets = self.load_json(file_prefs)
        if sheets == False:
            self.create_default_sheets()
            sheets = self.load_json(file_prefs)

        return sheets


    def run(self, inputText):

        self.sheets = self.load_sheets()

        items, paths = [], []
        for d in self.sheets['dirs']:
            dir = os.path.abspath(d)
            if os.path.isdir(dir):
                for dirpath, dirnames, filenames in os.walk(dir):
                    for f in filenames:
                        path = os.path.join(dirpath, f)
                        short_name = path.replace(dir + '/', '', 1)
                        items.append(short_name)
                        paths.append(path)

        item_editPrefs = self.prefs['indicator_edit'] + ' Edit sheets directories'
        items.append(item_editPrefs)

        sheet = self.menu(items, prompt='Select sheet: ')

        if sheet == item_editPrefs:
            self.open_file(file_prefs)
        elif sheet == '':
            sys.exit()
        else:
            try:
                ix = items.index(sheet)
                self.open_file(paths[ix])
            except:
                sys.exit()

