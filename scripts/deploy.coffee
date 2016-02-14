exec = require('child_process').exec

module.exports = (robot) ->
  robot.hear /deploy gatekeeper/, (res) ->
    res.send "Deploying myself..."
    exec 'git pull --rebase', (err, stdout, stderr) ->
      if trimNL(stdout) is "Current branch master is up to date."
        res.send "Oh! I'm up to date."
      else
        exec 'git rev-parse HEAD', (err, stdout, stderr) ->
          res.send "Updating to #{stdout.slice 0, 7}"
          process.exit(1)



trimNL = (str) ->
  str.replace(/[\n\r]/g, "")

