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

deploy_dir = "/home/gdd/deploy"
www_deploy_dir = "#{deploy_dir}/www"
api_deploy_dir = "#{deploy_dir}/api"

module.exports = (robot) ->
  robot.hear /deploy gdd www/, (res) ->
    res.send "Deploying gdd homolog www..."
    cmd = spawn "ssh", ["gdd", "'#{www_deploy_dir}/www.sh'"]

    cmd.stdout.on 'data', (data) ->
      res.send data.toString()
    cmd.stderr.on 'data', (data) ->
      res.send data.toString()
    cmd.on 'close', (code) ->
      if code is not 0
        res.send "Deploy script finished with code #{code}"


  robot.hear /deploy gdd api/, (res) ->
    res.send "Deploying gdd homolog api..."
    cmd = spawn "ssh", ["gdd", "'#{api_deploy_dir}/api.sh'"]

    cmd.stdout.on 'data', (data) ->
      res.send data.toString()
    cmd.stderr.on 'data', (data) ->
      res.send data.toString()
    cmd.on 'close', (code) ->
      if code is not 0
        res.send "Deploy script finished with code #{code}"


trimNL = (str) ->
  str.replace(/[\n\r]/g, "")


