-- My ASD Journey
supportedOrientations(LANDSCAPE_ANY)
displayMode(FULLSCREEN_NO_BUTTONS)
-- Use this function to perform your initial setup
function setup()
     math.randomseed(os.date("*t")["month"]*os.date("*t")["day"]*os.date("*t")["hour"]*os.date("*t")["min"]*os.date("*t")["sec"]*os.date("*t")["wday"])
    stage = 2
    stageMax = 2
    bool = true
    item = ""
    touching = false
     right_answer_position = -1
    itemList = {"apple","waffle","ball","box","table"}
    points = 0
    face_list={"","",""}
    face2 = Vec3(0,0,0)
    face3=Vec3(0,0,0)
end

--Austin make your game here
function game1()
    --Generate random vec3
    face1 = Vec3(math.random(1,3), math.random(1,3), math.random(1,3))

    --Generate a unique second face
    repeat
        face2 = Vec3(math.random(1,3), math.random(1,3), math.random(1,3))
    until face2 ~= face1

    --Generate a unique third face
    repeat
        face3 = Vec3(math.random(1,3), math.random(1,3), math.random(1,3))
    until face3 ~= face1 and face3 ~= face2

end

function nextGame()
    stage = math.random(1,stageMax)
end

--In this game, the user must select the right answer to "what color is this apple?"
    --while there is a lot of background noise and everything is blurred
function game2()

    fontSize(20)
    
    --Make four rectangles  
    draw_game2_rectangles()

    if bool then
    item = itemList[math.random(1,5)]
        --Randomly select right answer
        --0|1
        --2|3
        right_answer_position  = math.random(0,3)
        if right_answer_position == 0 then
            speech.say("The "..item.." is green")
        elseif right_answer_position == 1 then
            speech.say("The "..item.." is yellow")
        elseif right_answer_position == 2 then
            speech.say("The "..item.." is red")
        elseif right_answer_position == 3 then
            speech.say("The "..item.." is blue")
        end
    fontSize(45*WIDTH/1024)
    text("What color is this "..item.."?", WIDTH/2, HEIGHT/2)
    end
    bool = false


    fill(255)


    text("The "..item.." is green",WIDTH/4,HEIGHT/6+HEIGHT/8)
    text("The "..item.." is yellow",WIDTH*2.85/4,HEIGHT/6+HEIGHT/8)
    text("The "..item.." is red",WIDTH/4,HEIGHT/8)
    text("The "..item.." is blue",WIDTH*2.85/4,HEIGHT/8)

    --read touches

    if CurrentTouch.state == BEGAN and touching then
        touching = false
        if CurrentTouch.x < WIDTH/2 then
           if CurrentTouch.y < HEIGHT/6 then
                
            elseif CurrentTouch.y < HEIGHT/6 + (HEIGHT/4)-(1.75*HEIGHT/15) then

            end
        else
            if CurrentTouch.y < HEIGHT/6 then

            elseif CurrentTouch.y < HEIGHT/6 + (HEIGHT/4)-(1.75*HEIGHT/15) then

            end
        end
    end

    if CurrentTouch.state == ENDED then
        touching=true
    end


end

--Draw the four rectangles for the answer choices
function draw_game2_rectangles()
    rectMode(CORNER)
    fill(30,30,30,160)
    --Bottom left rectangleS
    rect(WIDTH/30,HEIGHT/30, (WIDTH/2)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30))

    --Top left rectangle
    rect(WIDTH/30,(HEIGHT/6)+(HEIGHT/30), (WIDTH/2)-(WIDTH/15), (HEIGHT/4)-(1.75*HEIGHT/15))

    --Bottom Right
    rect(WIDTH/2,HEIGHT/30, (WIDTH/2)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30))

    --Top right
    rect(WIDTH/2,(HEIGHT/6)+(HEIGHT/30), (WIDTH/2)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30))
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color
    background(174, 174, 190, 255)
    
    if stage == 0 then
        
        
    elseif stage == 1 then
        game1()

    elseif stage == 2 then
        
        --Katie make a mini game here
        game2()
    end
    
end
