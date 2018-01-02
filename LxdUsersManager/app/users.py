import shelve

import scriptsExecutor


def create_user_object(name):
    return {
        "name": name,
        "numberOfConnections": 0
    }


def increase_number_of_connections(user):
    return {
        "name": user["name"],
        "numberOfConnections": user["numberOfConnections"] + 1
    }


def decrease_number_of_connections(user):
    return {
        "name": user["name"],
        "numberOfConnections": user["numberOfConnections"] - 1
    }


path_to_repos = "/root/repos"


class Users:
    def __init__(self):
        self.db = shelve.open("users")

    def create_user(self, name, password):
        scriptsExecutor.create_user(name, password)
        self.db[name] = create_user_object(name)
        self.db.sync()

    def remove_user(self, name):
        scriptsExecutor.remove_user(name)
        del self.db[name]

    def get_user_history(self, name, number_of_lines):
        if name in self.db:
            return parse_history_lines(scriptsExecutor.get_user_history(name, number_of_lines))
        return []

    def get_all_user_history(self, name):
        if name in self.db:
            return parse_history_lines(scriptsExecutor.get_all_user_history(name))
        return []

    def notify_user_exited(self, name):
        self.db[name] = decrease_number_of_connections(self.db[name])
        print self.db[name]

    def notify_user_entered(self, name):
        self.db[name] = increase_number_of_connections(self.db[name])
        print self.db[name]

    def get_list_of_connected_users(self):
        connected_users = []
        for user_name in self.db.keys():
            if self.db[user_name]["numberOfConnections"] > 0:
                connected_users.append(user_name)
        return connected_users

    def get_users(self):
        users = []
        for user_name in self.db.keys():
            user = {
                "name": user_name,
                "isConnected": False
            }
            if self.db[user_name]["numberOfConnections"] > 0:
                user["isConnected"] = True
            users.append(user)
        return users

    def get_last_modified_file(self, name):
        result = scriptsExecutor.get_user_last_modified_file(name, path_to_repos)
        splitted = result.splitlines()
        name = splitted[0]
        file = ""
        if len(splitted) > 1:
            file = "\n".join(result.splitlines()[1:])
        result_map = {
            "file_name": name,
            "file_content": file
        }
        return result_map

    def get_file_commits(self, user_name, file_name, time_from, time_to):
        if user_name in self.db:
            return parse_commits(scriptsExecutor.get_file_commits(user_name, file_name, time_from, time_to))
        return []

    def get_commits(self, user_name, time_from, time_to):
        if user_name in self.db:
            return parse_commits(scriptsExecutor.get_commits(user_name, time_from, time_to))
        return []

    def get_file_content(self, user_name, file_name, commit_id):
        if user_name in self.db:
            return scriptsExecutor.get_file_content(user_name, file_name, commit_id)
        return ""

    def get_user_history_from_to(self, user_name, time_from, time_to):
        if user_name in self.db:
            return parse_history_lines(scriptsExecutor.get_user_history_from_to(user_name, time_from, time_to))
        return []

    def get_changes_in_commit(self, user_name, commit_id):
        if user_name in self.db:
            return scriptsExecutor.get_changes_in_commit(user_name, commit_id)
        return ""

    def list_files(self, user_name, commit_id):
        if user_name in self.db:
            return scriptsExecutor.list_files(user_name, commit_id).splitlines()
        return []

    def list_files_prefixed_with(self, user_name, prefix, commit_id):
        if user_name in self.db:
            return scriptsExecutor.list_files_prefixed_with(user_name, prefix, commit_id).splitlines()
        return []

def parse_history_lines(history):
    print history
    parsed_history = []
    for line in history.splitlines():
        splitted = line.split(' ')
        history_line = {
            "time": splitted[0],
            "terminal": splitted[1],
            "line": " ".join(splitted[2:])
        }
        parsed_history.append(history_line)
    return parsed_history

def parse_commits(commits):
    print commits
    parsed_commits = []
    for line in commits.splitlines():
        splitted = line.split(' ')
        commit = {
            "id": splitted[0],
            "fileName": splitted[1],
            "date": splitted[2],
            "message": splitted[3]
        }
        parsed_commits.append(commit)
    return parsed_commits
