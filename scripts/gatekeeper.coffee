# Description:
#   Basic implementation of gatekeeper
#
# Commands:
#   hubot status - chef: Show server current status
#
# Author:
#   leonardoarroyo
#

exec = require('child_process').exec

module.exports = (robot) ->

  # Display services status
  robot.hear /status/i, (res) ->
    # Gatekeeper status
    exec 'git rev-parse HEAD && git rev-parse --abbrev-ref HEAD', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "gatekeeper: Running at #{output[1]}/#{output[0].slice(0, 7)}"

    exec 'ssh nv "cd ~/api && git rev-parse HEAD && git rev-parse --abbrev-ref HEAD"', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "api: Running at #{output[1]}/#{output[0].slice(0, 7)}"

    exec 'ssh nv "cd ~/www && git rev-parse HEAD && git rev-parse --abbrev-ref HEAD"', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "www: Running at #{output[1]}/#{output[0].slice(0, 7)}"


  # Display services status
  robot.hear /status homolog/i, (res) ->
    # Gatekeeper status
    res.send "Homolog status"

    exec 'git rev-parse HEAD && git rev-parse --abbrev-ref HEAD', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "gatekeeper: Running at #{output[1]}/#{output[0].slice(0, 7)}"

    exec 'ssh nv "cd ~/api && git rev-parse HEAD && git rev-parse --abbrev-ref HEAD"', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "api: Running at #{output[1]}/#{output[0].slice(0, 7)}"

    exec 'ssh nv "cd ~/www && git rev-parse HEAD && git rev-parse --abbrev-ref HEAD"', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "www: Running at #{output[1]}/#{output[0].slice(0, 7)}"

