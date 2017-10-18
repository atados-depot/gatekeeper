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

deploy_dir = "/home/ubuntu"
www_deploy_dir = "#{deploy_dir}/client/deploy"
api_deploy_dir = "#{deploy_dir}/api/deploy"

module.exports = (robot) ->
  robot.hear /deploy beta www/, (res) ->
    res.send "Deploying beta atados www..."
    cmd = spawn "ssh", ["beta-atados", "'#{www_deploy_dir}/deploy.sh'"]

    cmd.stdout.on 'data', (data) ->
      res.send data.toString()
    cmd.stderr.on 'data', (data) ->
      res.send data.toString()
    cmd.on 'close', (code) ->
      if code is not 0
        res.send "Deploy script finished with code #{code}"


  robot.hear /deploy beta api/, (res) ->
    res.send "Deploying beta atados api..."
    cmd = spawn "ssh", ["beta-atados", "'#{api_deploy_dir}/deploy.sh'"]

    cmd.stdout.on 'data', (data) ->
      res.send data.toString()
    cmd.stderr.on 'data', (data) ->
      res.send data.toString()
    cmd.on 'close', (code) ->
      if code is not 0
        res.send "Deploy script finished with code #{code}"


trimNL = (str) ->
  str.replace(/[\n\r]/g, "")


