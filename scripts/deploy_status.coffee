# Description:
#   Allows hubot to deploy atados
#
# Commands:
#   hubot deploy gatekeeper - chef: Deploy gatekeeper
#   hubot deploy api - chef: Deploy api
#
# Author:
#   leonardoarroyo
#

child_process = require('child_process')
exec = child_process.exec
spawn = child_process.spawn

deploy_dir = "/home/cachet/deploy"

module.exports = (robot) ->
  robot.hear /deploy gpa-status/, (res) ->
    res.send "Deploying gpa-status..."
    cmd = spawn "ssh", ["gpa-status", "'#{deploy_dir}/gpa-status/deploy.sh'"]

    cmd.stdout.on 'data', (data) ->
      res.send data.toString()
    cmd.stderr.on 'data', (data) ->
      res.send data.toString()
    cmd.on 'close', (code) ->
      if code is not 0
        res.send "Deploy script finished with code #{code}"



trimNL = (str) ->
  str.replace(/[\n\r]/g, "")


