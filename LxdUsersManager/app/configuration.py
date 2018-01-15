from optparse import OptionParser

parser = OptionParser()

parser.add_option("--scripts", dest="scripts_path", action="store")

parser.add_option("--repositories", dest="repositories_path", action="store")

parser.add_option("--users_db", dest="users_db_path", action="store")

parser.add_option("--offline", dest="is_offline", action="store_true", default=False)

(options, args) = parser.parse_args()