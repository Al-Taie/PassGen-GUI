# IMPORTED LIBRARIES
from PySide2.QtCore import Signal, QObject, QRunnable
import traceback
import sys
import timeit


# THREAD SIGNALS
class WorkerSignals(QObject):
    finished = Signal()
    error = Signal(tuple)
    result = Signal(object)
    progress = Signal(int)


# CUSTOM THREAD CLASS
class Worker(QRunnable):
    def __init__(self, func, quantity=1, *args, **kwargs) -> None:
        super(Worker, self).__init__()
        self.quantity = quantity
        self.func = func
        self.args = args
        self.kwargs = kwargs
        self.signals = WorkerSignals()

        # Add the callback to our kwargs
        self.kwargs['progress_callback'] = self.signals.progress

    def run(self) -> None:
        try:
            # start = timeit.default_timer()
            result = list(map(self.func, [None]*self.quantity))
            # end = timeit.default_timer()
            # print(end-start)

        except Exception:
            # traceback.print_exc()
            exctype, value = sys.exc_info()[:2]
            self.signals.error.emit((exctype, value, traceback.format_exc()))
        else:
            self.signals.result.emit(result)
        finally:
            try:
                self.signals.finished.emit()
            except RuntimeError:
                return

    def stop(self) -> None:
        self.terminate()
