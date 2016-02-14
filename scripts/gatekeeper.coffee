exec = require('child_process').exec

module.exports = (robot) ->

  # Display services status
  robot.hear /status/i, (res) ->
    # Gatekeeper status
    exec 'git rev-parse HEAD && git rev-parse --abbrev-ref HEAD', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "gatekeeper: Running at #{output[1]}/#{output[0].slice(0, 7)}"

    exec 'ssh api "cd ~/api && git rev-parse HEAD && git rev-parse --abbrev-ref HEAD"', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "api: Running at #{output[1]}/#{output[0].slice(0, 7)}"

    exec 'ssh www "cd ~/www && git rev-parse HEAD && git rev-parse --abbrev-ref HEAD"', (err, stdout, stderr) ->
      output = stdout.split('\n')
      res.send "www: Running at #{output[1]}/#{output[0].slice(0, 7)}"

  # Start deploy proccess
  robot.hear /deploy (\w+)?(\/?(\w+)?)? to (\w+)/, (res) ->
    repository  = res.match[1]
    branch      = res.match[3]
    environment = res.match[4]

    # There's a slash but no branch was given. Eg: deploy www/ to
    if res.match[2] is "/"
      res.send "It looks a little weird. Maybe you forgot the branch?"
    # Branch was given correctly or not given at all. Eg: deploy www to, deploy www/branch to
    else
      if not branch?
        branch = "master"
      res.send "Looks like it's a task for the Gatekeeper! Deploying " + repository + "/" + branch + " to " + environment
