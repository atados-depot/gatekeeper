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
www_deploy_dir = "#{deploy_dir}/www"

module.exports = (robot) ->
  robot.hear /deploy www/, (res) ->
    res.send "I don't deploy to production yet."

  robot.hear /deploy homolog www/, (res) ->
    res.send "Deploying www..."
    cmd = spawn "ssh", ["homolog", "'#{www_deploy_dir}/www.sh'"]

    cmd.stdout.on 'data', (data) ->
      res.send data.toString()
    cmd.stderr.on 'data', (data) ->
      res.send data.toString()
    cmd.on 'close', (code) ->
      if code is not 0
        res.send "Deploy script finished with code #{code}"


trimNL = (str) ->
  str.replace(/[\n\r]/g, "")


