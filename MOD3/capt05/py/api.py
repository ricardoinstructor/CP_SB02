# app.py

from flask import Flask, jsonify
import random
import sys

app = Flask(__name__)

# Función para generar números aleatorios dentro de un rango
def get_random_value(low, high):
    return random.randint(low, high)

# Ruta principal: Información de ayuda sobre la API
@app.route('/')
def help():
    return """
    <h1>Bienvenido a la API de Datos Aleatorios</h1>
    <p>Esta API proporciona datos aleatorios para los siguientes endpoints:</p>
    <ul>
        <li><code>/usuarios</code>: Devuelve un número aleatorio entre 0 y 35.</li>
        <li><code>/precio</code>: Devuelve un número aleatorio entre 46 y 57.</li>
        <li><code>/plazas_libres</code>: Devuelve la diferencia entre 35 y el valor de /usuarios.</li>
    </ul>
    <p>Ejemplo de uso: <code>http://localhost:<puerto>/usuarios</code></p>
    """

# Endpoint /usuarios
@app.route('/usuarios', methods=['GET'])
def usuarios():
    usuarios = get_random_value(0, 35)
    return jsonify({"usuarios": usuarios})

# Endpoint /precio
@app.route('/precio', methods=['GET'])
def precio():
    precio = get_random_value(46, 57)
    return jsonify({"precio": precio})

# Endpoint /plazas_libres
@app.route('/plazas_libres', methods=['GET'])
def plazas_libres():
    usuarios = get_random_value(0, 35)
    plazas_libres = 35 - usuarios
    return jsonify({"plazas_libres": plazas_libres})

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Uso: python app.py <puerto>")
        sys.exit(1)

    try:
        port = int(sys.argv[1])
    except ValueError:
        print("El puerto debe ser un número entero.")
        sys.exit(1)

    app.run(host='0.0.0.0', port=port)
