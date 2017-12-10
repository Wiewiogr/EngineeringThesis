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
        self.users = []
        self.db_name = "users"
        self.db = shelve.open("users")

    def create_user(self, name, password):
        scriptsExecutor.create_user(name, password)
        self.db[name] = create_user_object(name)

    def remove_user(self, name):
        scriptsExecutor.remove_user(name)
        del self.db[name]

    def get_user_history(self, name):
        if name in self.db:
            return scriptsExecutor.get_user_history(name).splitlines()
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
