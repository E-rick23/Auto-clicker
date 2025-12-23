#include <windows.h>
#include <iostream>

int main() {
    std::cout << "Pressione F6 para ativar/desativar o clicker. F7 para sair." << std::endl;

    bool clicking = false;

    // Estrutura para o evento de clique (otimizada para reuso)
    INPUT inputs[2] = {};
    
    // Configura o botão pressionado (Down)
    inputs[0].type = INPUT_MOUSE;
    inputs[0].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    
    // Configura o botão solto (Up)
    inputs[1].type = INPUT_MOUSE;
    inputs[1].mi.dwFlags = MOUSEEVENTF_LEFTUP;

    while (true) {
        // Verifica se F7 foi pressionado para fechar
        if (GetAsyncKeyState(VK_F7) & 0x8000) {
            break;
        }

        // Toggle com F6 (Lógica simples para evitar flip-flop rápido demais)
        if (GetAsyncKeyState(VK_F6) & 1) {
            clicking = !clicking;
            std::cout << (clicking ? "Ativado" : "Pausado") << std::endl;
        }

        if (clicking) {
            // SendInput é a função mais rápida da WinAPI para injeção de input
            // Envia o Down e o Up em um único batch para eficiência
            SendInput(2, inputs, sizeof(INPUT));
            
            // IMPORTANTE: Sem um pequeno delay, você pode travar o PC ou a aplicação alvo
            // Sleep(1) = 1 milissegundo. Para velocidade INSANA, remova ou use Sleep(0).
            // Sleep(1); 
        }
    }

    return 0;
}