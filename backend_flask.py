from flask import Flask, jsonify, render_template
from flask_cors import CORS

app = Flask(__name__, template_folder='templates')
CORS(app)

API_NAME = 'REMF API'
API_VERSION = '0.1'

@app.route("/")
def home():
    return '{0} - version: {1}'.format(API_NAME, API_VERSION)

@app.route('/status')
def status():
    VAR1 = {
        'api': API_NAME,
        'version': API_VERSION,
        'message': 'Servidor OK'
    }
    return jsonify(VAR1)

@app.route('/teste/')
def erro_test():
    return 'Error: Get value of Integer'

@app.route('/teste/<int:number>')
@app.route('/teste/<number>')
def teste(number):
    VALOR = 0

    if type(number) is int:
        VALOR = number * 3
    else:
        return erro_test()

    MSG = '{0} * 3 = {1}'.format(number, VALOR)
    VAR1 = {
        'api': API_NAME,
        'version': API_VERSION,
        'number': '{0}'.format(number),
        'message': MSG
    }

    return jsonify(VAR1)
    
@app.errorhandler(404)
def page_not_found():
    return 'This page does not exist', 404


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=7881)
