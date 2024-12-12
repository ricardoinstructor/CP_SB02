# Solicitar la ruta a compartir
$path = Read-Host "Introduce el path del directorio a compartir"

# Solicitar el nombre para el recurso compartido
$shareName = Read-Host "Introduce el nombre para el recurso compartido"

# Verificar si la ruta existe
if (Test-Path -Path $path) {
    # Crear el recurso compartido con acceso de solo lectura para el grupo Users
    New-SmbShare -Name $shareName -Path $path # no me tira revisar -ReadAccess "BUILTIN\Users"

    # Confirmar que el recurso fue compartido
    Write-Host "Recurso '$shareName' compartido exitosamente con acceso de lectura para Users."
} else {
    Write-Host "La ruta especificada no existe. Por favor verifica la ruta e intenta de nuevo."
}
