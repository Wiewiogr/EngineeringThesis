from flask import Flask, request, jsonify
from flask.ext.cors import CORS
import configuration

import users

app = Flask(__name__)
cors = CORS(app)


users_manager = users.Users(configuration.options.users_db_path)


@app.route('/user/<name>/start', methods=['POST'])
def user_container_start(name):
    users_manager.change_container_status(str(name), "start")
    return "ok"


@app.route('/user/<name>/stop', methods=['POST'])
def user_container_stop(name):
    users_manager.change_container_status(str(name), "stop")
    return "ok"


@app.route('/user/<name>/history')
def user_all_history(name):
    return jsonify(users_manager.get_all_user_history(str(name)))


@app.route('/user/<name>/history/elements/<number>')
def user_last_history(name, number):
    return jsonify(users_manager.get_user_history(str(name), number))


@app.route('/user/<name>/history/from/<time_from>')
def user_history_from(name, time_from):
    return jsonify(users_manager.get_user_history_from_to(str(name), str(time_from), ""))


@app.route('/user/<name>/history/from/<time_from>/to/<time_to>')
def user_history_from_to(name, time_from, time_to):
    return jsonify(users_manager.get_user_history_from_to(str(name), str(time_from), str(time_to)))


@app.route('/user/<name>/commit/id/<id>')
def get_changes_in_commit(name, id):
    return jsonify(users_manager.get_changes_in_commit(str(name), str(id)))


@app.route('/user/<name>/files/')
def list_files(name):
    return jsonify(users_manager.list_files(str(name), ""))


@app.route('/user/<name>/files/commit/id/<id>')
def list_files_in_commit(name, id):
    return jsonify(users_manager.list_files(str(name), str(id)))


@app.route('/user/<name>/files/prefix/<prefix>')
def list_prefixed_files(name, prefix):
    return jsonify(users_manager.list_files_prefixed_with(str(name), str(prefix), ""))


@app.route('/user/<name>/files/prefix/<prefix>/commit/id/<id>')
def list_prefixed_files_in_commit(name, prefix, id):
    return jsonify(users_manager.list_files_prefixed_with(str(name), str(prefix), str(id)))


@app.route('/user/<user_name>/files/name/<file_name>')
def get_file_content(user_name, file_name):
    return jsonify(users_manager.get_file_content(str(user_name), str(file_name), ""))


@app.route('/user/<user_name>/files/name/<file_name>/commit/id/<id>')
def get_file_content_in_commit(user_name, file_name, id):
    return jsonify(users_manager.get_file_content(str(user_name), str(file_name), str(id)))


@app.route('/user/<name>/commits/')
def get_commits(name):
    return jsonify(users_manager.get_commits(str(name), "", ""))


@app.route('/user/<name>/commits/from/<time_from>/')
def get_commits_from(name, time_from):
    return jsonify(users_manager.get_commits(str(name), str(time_from), ""))


@app.route('/user/<name>/commits/from/<time_from>/to/<time_to>')
def get_commits_from_to(name, time_from, time_to):
    return jsonify(users_manager.get_commits(str(name), str(time_from), str(time_to)))


@app.route('/user/<name>/file/<file_name>/commits/')
def get_file_commits(name, file_name):
    return jsonify(users_manager.get_file_commits(str(name), str(file_name),  "", ""))


@app.route('/user/<name>/file/<file_name>/commits/from/<time_from>')
def get_file_commits_from(name, file_name, time_from):
    return jsonify(users_manager.get_file_commits(str(name), str(file_name),  str(time_from), ""))


@app.route('/user/<name>/file/<file_name>/commits/from/<time_from>/to/<time_to>')
def get_file_commits_from_to(name, file_name, time_from, time_to):
    return jsonify(users_manager.get_file_commits(str(name), str(file_name),  str(time_from), str(time_to)))


@app.route('/user', methods=['POST'])
def create_user():
    content = request.get_json()
    name = content['username']
    password = content['password']
    users_manager.create_user(str(name), str(password))
    return "ok"


@app.route('/user/snapshot', methods=['POST'])
def save_snapshot():
    content = request.get_json()
    path = content['path']
    print('saving to path: ' + path)
    users_manager.save_snapshot(str(path))
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


# @app.route('/connected')
# def connected_users():
#     result = users_manager.get_list_of_connected_users()
#     print result
#     return jsonify(result)

@app.route('/user')
def get_users():
    result = users_manager.get_users()
    print result
    return jsonify(result)
