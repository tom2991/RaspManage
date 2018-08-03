isEcho = 0
module.exports = (robot) ->
  robot.hear /ぴすけ|ピスケ/i, (res) ->
    res.send "ぴよぴよ"
  robot.hear /あつい|さむい/i, (res) ->
    res.send "（・з・)つ[キモチ]"
  robot.hear /ねー/i, (res) ->
    res.send "ねー"
  robot.respond /えこー|エコー/i, (res) ->
    if isEcho == 0
      isEcho = 1
      res.send "エコーおん"
    else
      isEcho = 0
      res.send "エコーおふ"
  robot.hear /.*/i, (res) ->
    if isEcho == 1
      res.send "#{res.match[0]}"
      # strMatch = ""
      # for val in res.match then
      #   strMatch = strMatch + val
      # res.send "#{strMatch}"

  # 気温を返す
  robot.respond /気温|きおん/i, (res) ->
    @exec = require('child_process').exec
    command = "sh /home/pi/shell/getTemp.sh"
    @exec command, (error, stdout, stderr) ->
      res.send error if error?
      res.send stdout if stdout?
      res.send stderr if stderr?
  # 暖房を入れる（温度は22度）
  robot.respond /暖房オン/i, (res) ->
    @exec = require('child_process').exec
    command = "sh /home/pi/shell/danboh_ON.sh"
    @exec command, (error, stdout, stderr) ->
      res.send error if error?
      res.send "おん！" if stdout?
      res.send stderr if stderr?
  # 冷房を入れる（温度は25度）
  robot.respond /冷房オン/i, (res) ->
    @exec = require('child_process').exec
    command = "sh /home/pi/shell/reiboh_ON.sh"
    @exec command, (error, stdout, stderr) ->
      res.send error if error?
      res.send "おん！" if stdout?
      res.send stderr if stderr?
  # エアコンを切る
  robot.respond /冷房オフ|暖房オフ|オフ/i, (res) ->
    @exec = require('child_process').exec
    command = "sh /home/pi/shell/danboh_OFF.sh"
    @exec command, (error, stdout, stderr) ->
      res.send error if error?
      res.send "おふ！" if stdout?
      res.send stderr if stderr?
  # ナスネの容量を返す
  robot.respond /なすね|ナスネ/i, (msg) ->
    @exec = require('child_process').exec
    command = "sh /home/pi/shell/getNasneHDD.sh"
    @exec command, (error, stdout, stderr) ->
      msg.send error if error?
      msg.send stdout if stdout?
      msg.send stderr if stderr?
  robot.respond /ちぇっく|チェック/i, (msg) ->
    @exec = require('child_process').exec
    command = "sh /home/pi/shell/checkNasneHDD.sh"
    @exec command, (error, stdout, stderr) ->
      msg.send error if error?
      msg.send stdout if stdout?
      msg.send stderr if stderr?
  robot.respond /おやすみ/i, (res) ->
    @exec = require('child_process').exec
    command = "sh /home/pi/pisuke/stop.sh"
    @exec command, (error, stdout, stderr) ->
      res.send "おやすみ" if stdout?
