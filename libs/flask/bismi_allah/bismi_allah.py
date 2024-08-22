# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed Rassoul Allah

from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/", methods=['GET'])
def bismi_allah():
    return render_template('bismi_allah.html')

@app.route("/", methods=['POST'])
def bismi_allah_post():
    return request.form.get('bismi_allah_input_text')

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=False, port=5000)

