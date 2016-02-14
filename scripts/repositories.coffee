
module.export = (robot) ->
  robot.respond /repositories/, (res) ->
    res.send "hey"
