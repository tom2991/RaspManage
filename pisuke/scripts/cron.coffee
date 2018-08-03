CronJob = require('cron').CronJob
CronJob2 = require('cron').CronJob
isCron = 0
module.exports = (robot) ->
  auto_operation_job = new CronJob(
    cronTime: "0 30 6 * * *"
    onTick: ->
      @exec = require('child_process').exec
      command = "sh /home/pi/shell/auto_operation.sh"
      @exec command, (error, stdout, stderr) ->
        robot.send {room: "#general"}, error if error?
        robot.send {room: "#general"}, stdout if stdout?
        robot.send {room: "#general"}, stderr if stderr?
        return
        start: false
  )
  check_nasne_job = new CronJob2(
    cronTime: "0 30 18 * * *"
    onTick: ->
      @exec = require('child_process').exec
      command = "sh /home/pi/shell/checkNasneHDD.sh"
      @exec command, (error, stdout, stderr) ->
        robot.send {room: "#general"}, error if error?
        robot.send {room: "#general"}, stdout if stdout?
        robot.send {room: "#general"}, stderr if stderr?
        return
        start: true
  )

  robot.respond /くろん|クロン/i, (res) ->
    if isCron == 0
      isCron = 1
      auto_operation_job.start()
      res.send "cronおん"
    else
      isCron = 0
      auto_operation_job.stop()
      res.send "cronおふ"
