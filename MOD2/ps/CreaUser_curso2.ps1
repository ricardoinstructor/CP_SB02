# Definir el nombre de usuario y la contraseña
$userName = "curso2"
$password = "qwerty@1234"

# Convertir la contraseña a un formato SecureString
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Crear el nuevo usuario
New-LocalUser -Name $userName -Password $securePassword -FullName "Curso DOS" -Description "Usuario de ejemplo"

# Agregar el usuario al grupo de Administradores (opcional)
Add-LocalGroupMember -Group "Administradores" -Member $userName

# Confirmar la creación del usuario
Write-Host "Usuario '$userName' creado con éxito."
