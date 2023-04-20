--script made by legole0, based on Forever Engine tracking by note system
--please dont steal :)

--customize variables
local camOffset = 15; -- how much will it move
local moveOnHit = true; -- basically a switch that enables or disables the script
local onlyBF = false; -- camera moves only when bf hits a note
local onlyOpp = false; -- camera moves only when the opponent hits a note
--

-- dont touch all this if you dont know what you're doing!!
local oppCamX = 915;
local oppCamY = 370;
local bfCamX = 915;
local bfCamY = 370;
local finalOffsetX=0;
local finalOffsetY=0;
local pissed = false

function goodNoteHit() --this fixes a bug that makes it go always to the opponent cam in the first section ignoring the mustHitSection value
    if pissed == false then
        startScript()
        mustHitSection = true
    end
end
function opponentNoteHit()
    if pissed == false then
        startScript()
        mustHitSection = false
    end
end
function startScript()
    oppCamX = oppCamX - 100;
    oppCamY = oppCamY - 50;
    bfCamX = bfCamX + 100;
    bfCamY = bfCamY + 50;
    pissed = true
    setProperty('defaultCamZoom', 0.8)
end
function onUpdatePost()
    if moveOnHit then
        finalOffsetX = 0;
        finalOffsetY = 0;

        --long ass conditionals but less spaghetti code
        if mustHitSection and onlyOpp == false and getProperty('playerStrums.members[0].animation.curAnim.name') == 'confirm' or mustHitSection == false and onlyBF == false and getProperty('opponentStrums.members[0].animation.curAnim.name') == 'confirm' then
            finalOffsetX = 0
            finalOffsetX = -camOffset;
        elseif mustHitSection and onlyOpp == false and getProperty('playerStrums.members[3].animation.curAnim.name') == 'confirm' or mustHitSection == false and onlyBF == false and getProperty('opponentStrums.members[3].animation.curAnim.name') == 'confirm'  then
            finalOffsetX = 0
            finalOffsetX = camOffset;
        end
        if mustHitSection and onlyOpp == false and getProperty('playerStrums.members[1].animation.curAnim.name') == 'confirm' or mustHitSection == false and onlyBF == false and getProperty('opponentStrums.members[1].animation.curAnim.name') == 'confirm'  then
            finalOffsetY = 0
            finalOffsetY = camOffset;
        elseif mustHitSection and onlyOpp == false and getProperty('playerStrums.members[2].animation.curAnim.name') == 'confirm' or mustHitSection == false and onlyBF == false and getProperty('opponentStrums.members[2].animation.curAnim.name') == 'confirm'  then
            finalOffsetY = 0
            finalOffsetY = -camOffset;
        end
          
        if curStep >= 1 and pissed then
            if mustHitSection then
                setProperty('camFollow.x', bfCamX + finalOffsetX)
                setProperty('camFollow.y', bfCamY + finalOffsetY)
            else
                setProperty('camFollow.x', oppCamX + finalOffsetX)
                setProperty('camFollow.y', oppCamY + finalOffsetY)
            end
        else
            setProperty('camFollow.x', bfCamX + finalOffsetX)
            setProperty('camFollow.y', bfCamY + finalOffsetY)
        end
    end
end