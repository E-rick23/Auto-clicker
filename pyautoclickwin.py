import time
import threading
import keyboard
import ctypes

# --- Settings ---
DELAY = 0.01  # keep low values like 0.01 ou 0.001
TECLA_INICIAR_PARAR = 'f6'
TECLA_SAIR = 'f7'

# Windows API constants for left mouse click
MOUSEEVENTF_LEFTDOWN = 0x0002
MOUSEEVENTF_LEFTUP = 0x0004

class FastAutoClicker(threading.Thread):
    def __init__(self, delay):
        super().__init__()
        self.delay = delay
        self.clicando = False
        self.programa_rodando = True

    def iniciar(self):
        self.clicando = True
        print("Auto-clicker ON")

    def parar(self):
        self.clicando = False
        print("Auto-clicker OFF")

    def sair(self):
        self.parar()
        self.programa_rodando = False

    def run(self):
        while self.programa_rodando:
            while self.clicando:
                # Calls Windows API directly to press and release the buttons
                ctypes.windll.user32.mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
                ctypes.windll.user32.mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
                
                # This avoids system lag, commenting it may unlock full speed, but may also cause stuttering (most games don't even recognize as much clicks.)
                time.sleep(self.delay)
            time.sleep(0.1)

# Starts the thread
click_thread = FastAutoClicker(DELAY)
click_thread.start()

def alternar_cliques(e):
    if click_thread.clicando:
        click_thread.parar()
    else:
        click_thread.iniciar()

keyboard.on_press_key(TECLA_INICIAR_PARAR, alternar_cliques)

print("="*35)
print("Auto-Clicker")
print(f"Press [{TECLA_INICIAR_PARAR.upper()}] to start/pause")
print(f"Press [{TECLA_SAIR.upper()}] to stop the program")
print("="*35)

while True:
    if keyboard.is_pressed(TECLA_SAIR):
        print("Closing...")
        click_thread.sair()
        break
    time.sleep(0.1)