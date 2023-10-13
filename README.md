# snSubtitleText
# DEV



dev-tool for subtitle text
letters are shown one by one with a soundeffect

usage:

@dimension = '2d' / '3d' 
@font = 0-7
@posVector = vec2(x,y) for 2d dimension / vec3(x,y,z) world coords for 3d dimension
@offsetTime = offsets the timer that makes the text disappear in ms
@prefix = prefix for everyletter ( ex: a color like ~r~ )
@scale = text scale 
exports['resource']:subtitleText(dimension, font, posVector, offsetTime, prefix, scale)
