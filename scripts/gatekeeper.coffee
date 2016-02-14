# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
#

exec = require('child_process').exec;

module.exports = (robot) ->

  robot.enter (res) ->
    res.send res.random enterReplies

  # Display services status
  robot.hear /status/i, (res) ->
    exec 'git rev-parse HEAD', (err, stdout, stderr) ->
      res.send "Gatekeeper: Running at #{stdout.slice 0, 7}"

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

  # Display managed repositories
  robot.respond /managed repositories/, (res) ->
    managedRepositories = robot.brain.get('managedRepositories') or {}
    count = Object.keys(managedRepositories).length

    if count is 0
      res.send "Hey, I'm sorry, but you haven't given me any repositories to manage yet!"

  # Tell the bot to start managing a repository
  robot.respond /manage repository (\w+)\/(\w+) as (\w+)/, (res) ->
    account    = res.match[1]
    repository = res.match[2]
    name       = res.match[3]

    res.send "Okay, I will try to clone " + account + "/" + repository + " as " + name

    exec('ls -la managed_repositories', ((err, stdout, stderr) ->
      console.log(stdout)
    ))


  #
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
   robot.respond /have a soda/i, (res) ->
     # Get number of sodas had (coerced to a number).
     sodasHad = robot.brain.get('totalSodas') * 1 or 0

     if sodasHad > 4
       res.reply "I'm too fizzy.."

     else
       res.reply 'Sure!'

       robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
