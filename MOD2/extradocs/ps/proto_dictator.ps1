# Configurar la codificación de la consola a UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.OutputEncoding = [System.Text.Encoding]::UTF8

# Función para mostrar el mensaje de inicio
function Show-StartMessage {
    cls
    [Console]::WriteLine("¡Bienvenido al juego de Dictador!")
    [Console]::WriteLine("Eres el dictador de un pequeño país y debes tomar decisiones difíciles.")
    [Console]::WriteLine("Tu objetivo es maximizar el control y la satisfacción del pueblo mientras gestionas los recursos.")
    [Console]::WriteLine("Presiona cualquier tecla para comenzar...")
    [void][System.Console]::ReadKey($true)
}

# Función para mostrar el estado actual
function Show-CurrentStatus {
    cls
    [Console]::WriteLine("Estado actual:")
    [Console]::WriteLine("------------------")
    [Console]::WriteLine("Control: $control%")
    [Console]::WriteLine("Satisfacción del pueblo: $satisfaction%")
    [Console]::WriteLine("Recursos disponibles: $resources unidades")
    [Console]::WriteLine("`n¿Qué deseas hacer?")
}

# Función para tomar decisiones de reparto
function Make-Decision {
    [Console]::WriteLine("1. Repartir recursos equitativamente a la población")
    [Console]::WriteLine("2. Tomar todos los recursos para ti")
    [Console]::WriteLine("3. Aumentar la seguridad, pero a costa de recursos")
    [Console]::WriteLine("4. Repartir recursos entre los militares para asegurar el control")
    $decision = Read-Host "Ingresa el número de la opción que deseas escoger (1-4)"
    
    switch ($decision) {
        1 {
            # Repartir recursos equitativamente
            $resources -= 20
            $satisfaction += 10
            $control += 5
            [Console]::WriteLine("Has repartido recursos equitativamente. La satisfacción del pueblo ha aumentado.")
        }
        2 {
            # Tomar todos los recursos
            $resources = 0
            $control += 20
            [Console]::WriteLine("Has tomado todos los recursos para ti. El control ha aumentado, pero el pueblo está descontento.")
            $satisfaction -= 10
        }
        3 {
            # Aumentar seguridad
            $resources -= 10
            $control += 10
            [Console]::WriteLine("Has aumentado la seguridad, pero has perdido algunos recursos.")
        }
        4 {
            # Repartir recursos entre los militares
            $resources -= 15
            $control += 15
            [Console]::WriteLine("Has repartido recursos entre los militares para mantener el control.")
        }
        default {
            [Console]::WriteLine("Opción no válida, elige una opción entre 1 y 4.")
        }
    }
}

# Función principal del juego
function Play-Dictator {
    $control = 50  # Control inicial
    $satisfaction = 50  # Satisfacción del pueblo
    $resources = 100  # Recursos iniciales

    while ($resources -gt 0 -and $satisfaction -gt 0) {
        Show-CurrentStatus
        Make-Decision
        
        # Chequear condiciones de fin de juego
        if ($control -gt 100) {
            [Console]::WriteLine("`n¡Felicidades! Has ganado el control total.")
            break
        }
        
        if ($satisfaction -lt 20) {
            [Console]::WriteLine("`nEl pueblo está muy descontento. Has perdido el control.")
            break
        }

        if ($resources -le 0) {
            [Console]::WriteLine("`nTe has quedado sin recursos. El pueblo se ha rebelado.")
            break
        }

        [Console]::WriteLine("`nPresiona cualquier tecla para continuar...")
        [void][System.Console]::ReadKey($true)
    }

    [Console]::WriteLine("`nJuego terminado. Tu puntuación final es:")
    [Console]::WriteLine("Control: $control%")
    [Console]::WriteLine("Satisfacción del pueblo: $satisfaction%")
    [Console]::WriteLine("Recursos disponibles: $resources")
}

# Mostrar el mensaje de inicio y comenzar el juego
Show-StartMessage
Play-Dictator
