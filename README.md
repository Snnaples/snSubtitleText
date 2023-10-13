# snSubtitleText
# DEV



dev-tool for subtitle text
letters are shown one by one with a soundeffect

USAGE: <br>
@dimension = '2d' / '3d' <br>
@font = 0-7<br>
@posVector = vec2(x,y) for 2d dimension / vec3(x,y,z) world coords for 3d dimension <br>
@offsetTime = offsets the timer that makes the text disappear in ms <br>
@prefix = prefix for everyletter ( ex: a color like ~r~ ) <br>
@scale = text scale  <br>

exports['resource']:subtitleText(dimension, font, posVector, offsetTime, prefix, scale)
