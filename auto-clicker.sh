#!/bin/bash

click() {
    sleep 0.1
    xdotool click 1  # Requer xdotool para emular o clique do mouse
}

echo "Pressione 'x' e Enter para parar o loop."

while true; do
    click
    read -n 1 -t 0.01 key  # Lê um único caractere com timeout de 0.1 segundos
    if [[ $key == "x" ]]; then
        echo "Parando o loop."
        break
    fi
done
