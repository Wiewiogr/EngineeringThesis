from flask import Flask, request, jsonify

import users

app = Flask(__name__)

users_manager = users.Users()


@app.route('/user/<name>/history')
def user_all_history(name):
    return jsonify(users_manager.get_user_history(str(name)))  # !!


@app.route('/user/<name>/history/elements/<number>')
def user_last_history(name, number):
    return jsonify(users_manager.get_user_history(str(name)))  # !!!


@app.route('/user/<name>/history/from/<time_from>')
def user_history_from(name, time_from):
    pass


@app.route('/user/<name>/history/from/<time_from>/to/<time_to>')
def user_history_from_to(name, time_from, time_to):
    pass


@app.route('/user/<name>/commit/id/<id>')
def get_changes_in_commit(name, id):
    pass


@app.route('/user/<name>/commit/from/<time_from>/')
def get_commits_from(name, time_from):
    pass


@app.route('/user/<name>/commit/from/<time_from>/to/<time_to>')
def get_commits_from_to(name, time_from, time_to):
    pass


@app.route('/user/<name>/file/<file_name>/commit/')
def get_file_commits(name, file_name):
    pass


@app.route('/user/<name>/file/<file_name>/commit/from/<time_from>')
def get_file_commits_from(name, file_name, time_from):
    pass


@app.route('/user/<name>/file/<file_name>/commit/from/<time_from>/to/<time_to>')
def get_file_commits_from_to(name, file_name, time_from, time_to):
    pass


# content/<id>
# listing/tree ls -R

@app.route('/user/<name>/newest_file')
def user_last_modified_file(name):
    return jsonify(users_manager.get_last_modified_file(str(name)))


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
