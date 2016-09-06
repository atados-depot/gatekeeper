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

deploy_dir = "/home/ubuntu/deploy"
api_deploy_dir = "#{deploy_dir}/api"

module.exports = (robot) ->
  robot.hear /deploy gatekeeper/, (res) ->
    res.send "Deploying myself..."
    exec "git pull --rebase", (err, stdout, stderr) ->
      if trimNL(stdout) is "Current branch master is up to date."
        res.send "Oh! I'm up to date. Are you calling me old?"
      else
        exec "git rev-parse HEAD", (err, stdout, stderr) ->
          res.send "Updating to #{stdout.slice 0, 7}"
          process.exit(1)

  robot.hear /deploy homolog api/, (res) ->
    res.send "Deploying api..."
    cmd = spawn "ssh", ["homolog", "'#{api_deploy_dir}/api.sh'"]

    cmd.stdout.on 'data', (data) ->
      res.send data.toString()
    cmd.stderr.on 'data', (data) ->
      res.send data.toString()
    cmd.on 'close', (code) ->
      res.send "Deploy finished with code #{code}"


trimNL = (str) ->
  str.replace(/[\n\r]/g, "")


