local function word_to_letter_table(word)
	local t = {}
	for i = 1, #word do
		local c = word:sub(i,i)
		t[#t+1] = c
	end
	return t 
end
  
local function splitString(str, sep)
	if sep == nil then sep = "%s" end
  
	local t={}
	local i=1
  
	for str in string.gmatch(str, "([^"..sep.."]+)") do
	  t[i] = str
	  i = i + 1
	end
  
	return t
end

function drawTxt(text, x, y, scale, r, g, b,useFont,f)
	SetTextFont(f)

	SetTextCentre(1)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextDropShadow(30, 5, 5, 5, 255)
	SetTextEntry("STRING")
	SetTextColour(r, g, b, 255)
	AddTextComponentString(text)
	DrawText(x, y)
end

local function drawTxtSubtitle(x,y,z, text, scl, f) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(f)
        SetTextProportional(1)
        SetTextColour(255, 0, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

exports('subtitleText', function(dimension, font, posVector, offsetTime, prefix, scale)
	prefix = prefix or ''
	local timer = GetGameTimer() + 60
	text = splitString(text, ' ')
	local wordLetters = {  }
	for i = 1, #text do 
		wordLetters[#wordLetters+1] = word_to_letter_table(text[i])
	end

	local currentLetter =  ''
	local letterCount = 0
	Citizen.CreateThread(function()
		timer = timer + 60
		for i = 1, #wordLetters do 
			for j = 1, #wordLetters[i] do 
				letterCount = letterCount + 1
				if letterCount == 3 then 
					letterCount = 0 
					PlaySoundFrontend(-1, '10_SEC_WARNING', 'HUD_MINI_GAME_SOUNDSET', 1)
				end
				currentLetter = currentLetter .. wordLetters[i][j]
				timer = timer + 60
				Citizen.Wait(50)
			end
				currentLetter = currentLetter .. ' '
		end 
			timer = timer + offsetTime
	end)

	while timer > GetGameTimer()  do 
		Citizen.Wait(0)
		if dimension == '3d' then 
			drawTxtSubtitle(posVector.x,posVector.y,posVector.z, prefix .. currentLetter, scale, font)
		end
		if dimension == '2d' then 
			drawTxt(prefix .. currentLetter, posVector.x, posVector.y, scale, 255, 255, 255, true , font)
		end
	end
end)
  
