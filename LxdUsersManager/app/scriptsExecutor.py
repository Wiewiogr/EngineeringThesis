import subprocess
import os
import sys
import configuration

scripts_path = configuration.options.scripts_path
repositories_path = configuration.options.repositories_path


def run_script_with_args(script_name, params):
    path = os.path.join(os.getcwd(), scripts_path, script_name)
    return subprocess.check_output(["bash", path, repositories_path] + params)


def get_user_history(name, number_of_elements):
    return run_script_with_args("getHistory.sh", [name, number_of_elements])


def get_all_user_history(name):
    return run_script_with_args("getHistory.sh", [name])


def create_user(name, password):
    run_script_with_args("createUser.sh", [name, password])


def remove_user(name):
    run_script_with_args("removeUser.sh", [name])


def run_container(name, status):
    run_script_with_args("startOrStopContainer.sh", [name, status])


def get_container_status(name):
    return run_script_with_args("getContainerStatus.sh", [name])


def get_file_commits(user_name, file_name, time_from, time_to):
    if time_from == "":
        return run_script_with_args("getFileCommitsFromTo.sh", [user_name, file_name])
    elif time_to == "":
        return run_script_with_args("getFileCommitsFromTo.sh", [user_name, file_name, time_from])
    else:
        return run_script_with_args("getFileCommitsFromTo.sh", [user_name, file_name, time_from, time_to])


def get_commits(user_name, time_from, time_to):
    if time_from == "":
        return run_script_with_args("getCommitsFromTo.sh", [user_name, ])
    elif time_to == "":
        return run_script_with_args("getCommitsFromTo.sh", [user_name, time_from])
    else:
        return run_script_with_args("getCommitsFromTo.sh", [user_name, time_from, time_to])


def get_file_content(user_name, file_name, commit_id):
    if commit_id == "":
        return run_script_with_args("getFileContent.sh", [user_name, file_name])
    else:
        return run_script_with_args("getFileContent.sh", [user_name, file_name, commit_id])


def get_user_history_from_to(user_name, time_from, time_to):
    if time_to == "":
        return run_script_with_args("getHistoryFromTo.sh", [user_name, time_from])
    else:
        return run_script_with_args("getHistoryFromTo.sh", [user_name, time_from, time_to])

def get_changes_in_commit(user_name, commit_id):
    return run_script_with_args("getChangesFromCommit.sh", [user_name, commit_id])


def list_files(user_name, commit_id):
    if commit_id == "":
        return run_script_with_args("listFiles.sh", [user_name])
    else:
        return run_script_with_args("listFiles.sh", [user_name, commit_id])


def list_files_prefixed_with(user_name, prefix, commit_id):
    if commit_id == "":
        return run_script_with_args("listFilesPrefixedWith.sh", [user_name, prefix])
    else:
        return run_script_with_args("listFilesPrefixedWith.sh", [user_name, prefix, commit_id])

def save_snapshot(db_path, save_path):
    run_script_with_args("saveContainersSnapshot.sh", [db_path, save_path])
