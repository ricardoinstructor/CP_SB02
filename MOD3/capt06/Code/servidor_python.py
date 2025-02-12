# server.py

import http.server
import socketserver
import platform
import sys
import socket

def obtener_nombre_equipo():
    """Obtiene el nombre del equipo donde se ejecuta el programa."""
    return socket.gethostname()

class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        self.usuario = kwargs.pop('usuario')
        super().__init__(*args, **kwargs)

    def do_GET(self):
        """Maneja las solicitudes GET devolviendo el nombre de usuario y el nombre del equipo."""
        self.send_response(200)  # Respuesta OK
        self.send_header('Content-type', 'text/html; charset=utf-8')
        self.end_headers()

        # Obtener información
        nombre_equipo = obtener_nombre_equipo()
        respuesta = f"""
        <html>
            <head>
                <title>Información del Servidor</title>
            </head>
            <body>
                <h1>Información del Servidor</h1>
                <p>Nombre de Usuario: {self.usuario}</p>
                <p>Nombre del Equipo: {nombre_equipo}</p>
            </body>
        </html>
        """

        # Enviar respuesta al cliente
        self.wfile.write(respuesta.encode('utf-8'))

def iniciar_servidor(puerto, usuario):
    """Inicia el servidor HTTP en el puerto especificado."""
    with socketserver.TCPServer(("", puerto), lambda *args, **kwargs: MyHttpRequestHandler(*args, usuario=usuario, **kwargs)) as httpd:
        print(f"Servidor iniciado en el puerto {puerto}. Nombre de usuario: {usuario}")
        try:
            httpd.serve_forever()  # Mantener el servidor en ejecución
        except KeyboardInterrupt:
            print("\nServidor detenido.")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python server.py <puerto> <nombre_de_usuario>")
        sys.exit(1)

    try:
        puerto = int(sys.argv[1])
        usuario = sys.argv[2]
        iniciar_servidor(puerto, usuario)
    except ValueError:
        print("El puerto debe ser un número entero.")
        sys.exit(1)
