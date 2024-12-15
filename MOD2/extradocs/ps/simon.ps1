# Codificación en UTF8para las tildes de salidas de texto
$OutputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Definimos una lista de colores (puedes agregar más si lo deseas)
$colores = @("Red", "Green", "Blue", "Yellow")

# Generamos una secuencia aleatoria de colores
$secuenciaAleatoria = Get-Random -InputObject $colores -Count 5

# Mostramos la secuencia al usuario
Write-output "¡Atención! Simón dice:"
$secuenciaAleatoria | ForEach-Object {
    Write-Host $_ -ForegroundColor $_
    Start-Sleep -Seconds 1
    Clear-Host
}

# El usuario debe repetir la secuencia
Write-Host "Repite la secuencia ingresando los colores uno por uno:"

# Leemos la entrada del usuario
$entradaUsuario = Read-Host "Ingresa los colores separados por comas"

# Convertimos la entrada del usuario en un array
#$entradaUsuario = $entradaUsuario -split ","
$entradaUsuario = $entradaUsuario.Trim().Split(',')
#

# Comparamos la entrada del usuario con la secuencia original
if ((Compare-Object $entradaUsuario $secuenciaAleatoria -Property Value).Count -eq 0) {
  Write-Host "¡Excelente! Has repetido correctamente la secuencia."
} else {
  Write-Host "¡Oops! Algo salió mal. Inténtalo de nuevo."
  #verificamos entradas y secuencia
  Write-Host $entradaUsuario
  Write-Host $secuenciaAleatoria
}

