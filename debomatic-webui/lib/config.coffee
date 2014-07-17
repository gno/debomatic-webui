###
Please DO NOT edit this file.
Edit auto-generated 'user.config.coffee' file instead.
###

extend = require('extend')

#start config-auto-export
###
Init some values, do not touch these
###
config = {}
config.debomatic = {}
config.web = {}
config.web.debomatic = {}
config.web.debomatic.admin = {}
config.web.debomatic.dput = {}
config.web.file = {}
config.web.preferences = {}

###
Configure host and port
###
config.host = "localhost"
config.port = 3000

###
Deb-O-Matic settings
###
config.debomatic.path = "/srv/debomatic-amd64"
config.debomatic.jsonfile = "/var/log/debomatic-json.log"

###
Web template configuration
Title and description for the header
###
config.web.debomatic.architecture = "amd64"
config.web.title = "Deb-o-Matic web.ui"
config.web.description = "This is a web interface for debomatic over " +
                         config.web.debomatic.architecture

###
Admin email and name to show in the home page.
For the email address please use the SPAMFREE form "you AT host DOT org",
it will be converted client side by javascript
###
config.web.debomatic.admin.email = "you AT debian DOT org"
config.web.debomatic.admin.name = "Your Name"

###
Configuration of dput to show in the home page.
###
config.web.debomatic.dput.incoming = config.debomatic.path
config.web.debomatic.dput.host = config.host
config.web.debomatic.dput.login = "debomatic"
config.web.debomatic.dput.method = "scp"
config.web.debomatic.dput.unsigned_uploads = false

###
List of files to get a simple preview and number of lines
to show
###
config.web.file.preview = ["buildlog"]
config.web.file.num_lines = 25

###
The default user preferences.
See /preferences page for more info
###
config.web.preferences.autoscroll = true
config.web.preferences.header = true
config.web.preferences.sidebar = true
config.web.preferences.glossy_theme = true
config.web.preferences.file_background = true
config.web.preferences.file_fontsize = 13  # valid values are [13..16]
config.web.preferences.debug = 0  # debug level - 0 means disabled

#end config-auto-export

###
The version
###
config.version = "0.6.0"

###
List of files to not show in webui
###
config.debomatic.excluded_files = [
    "datestamp"
    "json"
]

###
The routes, that are the pages urls
###
config.routes = {}
config.routes.debomatic = "/debomatic"
config.routes.distribution = "/distribution"
config.routes.preferences = "/preferences"
config.routes.commands = "/commands"

###
The events
###
config.events = {}
config.events.error = "server-error"
config.events.broadcast = {}
config.events.broadcast.distributions = "b.distributions"
config.events.broadcast.status_update = "b.status_update"
config.events.broadcast.status_debomatic = "b.status_debomatic"
config.events.client = {}
config.events.client.distribution_packages = "c.distribution_packages"
config.events.client.distribution_packages_status = "c.distribution_packages_status"
config.events.client.package_files_list = "c.package_files_list"
config.events.client.package_info = "c.package_info"
config.events.client.file = "c.file"
config.events.client.file_newcontent = "c.file_newcontent"
config.events.client.status = "c.status"

###
The status according with JSONLogger.py module
###
config.status = {}
config.status.build = "build"
config.status.create = "create"
config.status.update = "update"
config.status.success = true
config.status.fail = false


# Merge the configuration
try
    Parser = require("./parser")
    parser = new Parser()
    user_config = parser.getUserConfig()
    if user_config
        console.log "Reading user configutation ..."
        config = extend(true, {}, config, require(user_config))
    else
        console.log "No user config specified. Using global settings."

    # export some variable to web
    config.web.paths = config.routes
    config.web.events = config.events
    config.web.status = config.status
    config.web.host = config.host

    # get the debomatic pidfile
    config.debomatic.pidfile = "/var/run/debomatic-" +
                               require("crypto")
                               .createHash("sha256")
                               .update(config.debomatic.path)
                               .digest("hex")
    module.exports = config

catch err
    if err.code is "MODULE_NOT_FOUND"
        console.log "File %s not found.", user_config
    else
        console.error "Error reading user configutation", err
    process.exit 1
