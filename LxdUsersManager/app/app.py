from flask import Flask, request, jsonify

import users

app = Flask(__name__)

users_manager = users.Users()


@app.route('/user/<name>/history')
def user_last_history(name):
    return jsonify(users_manager.get_user_history(str(name)))


@app.route('/user', methods=['POST'])
def create_user():
    content = request.get_json()
    name = content['username']
    password = content['password']
    users_manager.create_user(str(name), str(password))
    return "ok"


@app.route('/user/<name>', methods=['DELETE'])
def delete_user(name):
    users_manager.remove_user(str(name))
    return "delete user " + name


@app.route('/user/<name>/entered')
def user_entered(name):
    users_manager.notify_user_entered(str(name))
    return "ok"


@app.route('/user/<name>/exited')
def user_exited(name):
    users_manager.notify_user_exited(str(name))
    return "ok"


@app.route('/connected')
def connected_users():
    result = users_manager.get_list_of_connected_users()
    print result
    return jsonify(result)
