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

exec = require('child_process').exec

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
    cmd = spawn "ssh homolog \"cd #{api_deploy_dir} && bash #{api_deploy_dir}/api.sh\""

    ls.stdout.on 'data', (data) ->
      res.send data
    ls.stderr.on 'data', (data) ->
      res.send data
    ls.on 'close', (code) ->
      res.send "Deploy finished with code #{code}"


trimNL = (str) ->
  str.replace(/[\n\r]/g, "")


