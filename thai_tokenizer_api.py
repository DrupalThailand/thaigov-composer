from flask import Flask, request, jsonify
from flask_cors import CORS
import deepcut
import logging

app = Flask(__name__)
CORS(app)  # Enable CORS

# ตั้งค่า logging
logging.basicConfig(level=logging.INFO)

@app.route('/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok'}), 200

@app.route('/tokenize', methods=['POST'])
def tokenize():
    data = request.get_json()
    text = data.get('text', '')
    app.logger.info(f'Received text: {text}')

    tokens = deepcut.tokenize(text)
    result = {'tokenized': ' '.join(tokens)}
    app.logger.info(f'Tokenized result: {result}')

    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
