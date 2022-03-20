# IMPORTED LIBRARIES
from os.path import join, exists
from PySide2.QtCore import QObject, Signal, Slot, Property, QThreadPool
import os
import random
import string
from typing import Text
from src.threadpool import Worker, WorkerSignals
import numpy as np
from PySide2.QtGui import QGuiApplication, QCursor, QPixmap


os.system('cls')


# PASSWORDS GENERATOR 
class Generator:
    def __init__(self) -> None:
        self._length = 8
        self._quantity = 1
        self.digits = list(string.digits)
        self.symbols = list(string.punctuation)
        self.uppercase = list(string.ascii_uppercase)
        self.lowercase = list(string.ascii_lowercase)
        self.characters = [self.uppercase, self.lowercase,
                           self.digits, []]
        self._is_running = False
        self._is_symbol = False
        self._is_uppercase = True
        self._is_lowercase = True
        self._is_digit = True

    def generate(self, *args) -> Text:
        chars = []
        _ = list(map(chars.extend, self.characters))
        
        suffix = random.choices(chars, k=self.length-1)
        np.random.shuffle(suffix)

        prefix = random.choices(self.uppercase)
        password = ''.join(prefix+suffix)
        self._is_running = False
        return password


# BACKEND SIGNALS
class Bsignals(QObject):
    runningChanged = Signal(bool)
    symbolChanged = Signal(bool)
    upperChanged = Signal(bool)
    lowerChanged = Signal(bool)
    digitChanged = Signal(bool)
    lengthChanged = Signal(int)
    quantityChanged = Signal(int)
    result = Signal(list)
    error = Signal(tuple)

    def __init__(self, parent=None) -> None:
        super().__init__(parent=parent)


# BACKEND 
class Backend(Generator, Bsignals, WorkerSignals):
    def __init__(self) -> None:
        Generator.__init__(self)
        Bsignals.__init__(self)
        self.signals = WorkerSignals()
        self.threadpool = QThreadPool()
        self.list_items = list()
        self._connections()
        
    def _connections(self) -> None:
        self.runningChanged.connect(self.do_work)
        # self.symbolChanged.connect(lambda var: print('Symbol', var))
        # self.upperChanged.connect(lambda var: print('Capital', var))
        # self.lowerChanged.connect(lambda var: print('Small', var))
        # self.digitChanged.connect(lambda var: print('Digit', var))
        # self.lengthChanged.connect(lambda var: print('Length', var))
        # self.quantityChanged.connect(lambda var: print('Quantity', var))

    def error_occored(self, error) -> None:
        self.error.emit(error)
        self._is_running = False

    @Slot(int, int)
    def move_cursor(self, x, y) -> None:
        QCursor.setPos(x, y)
        path = QPixmap('D:/WorkSpace/qtDesigner/QtCreator/My Projects/PassGen/res/images/hi.png')
        QGuiApplication.setOverrideCursor(path.scaledToWidth(45))

    @Slot()
    def restore_cursor(self, *args) -> None:
        path = QPixmap('D:/WorkSpace/qtDesigner/QtCreator/My Projects/PassGen/res/images/arrow.png')
        QGuiApplication.restoreOverrideCursor()
        QGuiApplication.setOverrideCursor(path.scaledToWidth(15))

    @staticmethod
    def is_folder() -> Text:
        filedir = join(os.getcwd(), 'Passwords')
        
        if not exists(filedir):
            os.mkdir(filedir)
        return filedir

    @Slot()  
    def export(self, filename='passlist.txt') -> None:
        filedir = self.is_folder()  
        filename = join(filedir, filename)
        
        with open(filename, 'w') as wf:
            wf.write('\n'.join(self.list_items))

    @Slot()
    def copy(self) -> None:
        clipboard = QGuiApplication.clipboard()
        clipboard.setText('\n'.join(self.list_items))

    @Slot()
    def folder(self) -> None:
        filedir = self.is_folder() 
        os.startfile(filedir)

    def result_handle(self, result):
        self.result.emit(result)
        self.list_items = result

    def do_work(self) -> None:
        worker = Worker(func=self.generate, quantity=self._quantity)
        # worker.signals.finished.connect(lambda: print(f'Finish'))
        # worker.signals.progress.connect()
        worker.signals.error.connect(self.error_occored)
        worker.signals.result.connect(self.result_handle)
        # Execute
        self.threadpool.start(worker)

    @Property(bool, notify=Bsignals.runningChanged)
    def is_running(self) -> bool:
        return self._is_running
    
    @is_running.setter
    def is_running(self, status) -> None:
        if self._is_running == status:
            return
        
        self._is_running = status
        self.runningChanged.emit(status)
    
    @Property(bool, notify=Bsignals.upperChanged)
    def is_uppercase(self) -> bool:
        return self._is_uppercase
    
    @is_uppercase.setter
    def is_uppercase(self, status) -> None:
        if status:
            self.characters[0] = self.uppercase
        else:
            self.characters[0] = []
        
        self._is_uppercase = status
        self.upperChanged.emit(status)
        
    @Property(bool, notify=Bsignals.lowerChanged)
    def is_lowercase(self) -> bool:
        return self._is_lowercase
    
    @is_lowercase.setter
    def is_lowercase(self, status) -> None:
        if status:
            self.characters[1] = self.lowercase
        else:
            self.characters[1] = []
        
        self._is_lowercase = status
        self.lowerChanged.emit(status)
        
    @Property(bool, notify=Bsignals.digitChanged)
    def is_digit(self) -> bool:
        return self._is_digit
    
    @is_digit.setter
    def is_digit(self, status) -> None: 
        if status:
            self.characters[2] = self.digits
        else:
            self.characters[2] = []
        
        self._is_digit = status
        self.digitChanged.emit(status)

    @Property(bool, notify=Bsignals.symbolChanged)
    def is_symbol(self) -> bool:
        return self._is_symbol
    
    @is_symbol.setter
    def is_symbol(self, status) -> None:
        if status:
            self.characters[3] = self.symbols
        else:
            self.characters[3] = []
        
        self._is_symbol = status
        self.symbolChanged.emit(status)

    @Property(int, notify=Bsignals.lengthChanged)
    def length(self) -> int:
        return self._length
    
    @length.setter
    def length(self, value) -> None:
        if self._length == value:
            return
        
        self._length = value
        self.lengthChanged.emit(value)

    @Property(int, notify=Bsignals.quantityChanged)
    def quantity(self) -> int:
        return self._quantity
    
    @quantity.setter
    def quantity(self, value) -> None:
        if self._quantity == value:
            return
        
        self._quantity = value
        self.quantityChanged.emit(value)

