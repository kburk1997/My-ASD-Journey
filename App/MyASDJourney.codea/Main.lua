-- My ASD Journey
supportedOrientations(LANDSCAPE_ANY)
--displayMode(FULLSCREEN_NO_BUTTONS)
-- Use this function to perform your initial setup
function setup()
    math.randomseed(os.date("*t")["month"]*os.date("*t")["day"]*os.date("*t")["hour"]*os.date("*t")["min"]*os.date("*t")["sec"]*os.date("*t")["wday"])
    stage = 1
    stageMax = 2
    bool = true
    item = ""
    touching = false
    right_answer_position = -1
    itemList = {"apple","waffle","ball","box","table"}
    points = 0
    face1 = vec3(0,0,0)
    face2 = vec3(0,0,0)
    face3=vec3(0,0,0)
    speech.volume = 1
bodies = {}
    wall1 = physics.body(POLYGON, vec2(20,0), vec2(0,0), vec2(0,HEIGHT), vec2(20,HEIGHT))
    wall1.type = STATIC
    wall2 = physics.body(POLYGON, vec2(WIDTH-(20),0), vec2(WIDTH,0), vec2(WIDTH,HEIGHT), vec2(WIDTH-(20),HEIGHT))
    wall2.type = STATIC
    floor = physics.body(POLYGON, vec2(0,20), vec2(0,0), vec2(WIDTH,0), vec2(WIDTH,20))
    floor.type = STATIC
    floor = physics.body(POLYGON, vec2(0,HEIGHT-20), vec2(0,HEIGHT), vec2(WIDTH,HEIGHT), vec2(WIDTH,HEIGHT-20))
end

--Austin make your game here
function game1()
    background(math.random(0,255),math.random(0,255),math.random(0,255),255)
    if bool then
    --Generate random vec3
        face1 = vec3(math.random(1,3), math.random(1,3), math.random(1,3))
        
        --Generate a unique second face
        repeat
        face2 = vec3(math.random(1,3), math.random(1,3), math.random(1,3))
        until face2 ~= face1
        
        --Generate a unique third face
        repeat
        face3 = vec3(math.random(1,3), math.random(1,3), math.random(1,3))
        until face3 ~= face1 and face3 ~= face2
        
        right_answer_position = math.random(1,3)

        bool=false
    end


    --Draw faces

--draw other faces
sprite("Project:Face"..math.floor((face1).x), WIDTH/4, HEIGHT/4, WIDTH/6)
sprite("Project:Nose"..math.floor((face1).y), WIDTH/4, HEIGHT/4, WIDTH/24)
sprite("Project:eyes"..math.floor((face1).z), WIDTH/4, 1.15*HEIGHT/4, WIDTH/7.5)
sprite("Project:Face"..math.floor((face2).x), WIDTH/2, HEIGHT/4, WIDTH/6)
sprite("Project:Nose"..math.floor((face2).y), WIDTH/2, HEIGHT/4, WIDTH/24)
sprite("Project:eyes"..math.floor((face2).z), WIDTH/2, 1.15*HEIGHT/4, WIDTH/7.5)
sprite("Project:Face"..math.floor((face3).x), 3*WIDTH/4, HEIGHT/4, WIDTH/6)
sprite("Project:Nose"..math.floor((face3).y), 3*WIDTH/4,HEIGHT/4, WIDTH/24)
sprite("Project:eyes"..math.floor((face3).z), 3*WIDTH/4, 1.15*HEIGHT/4, WIDTH/7.5)

--add tint
tint(255,255,255,82)

--draw noise
for i= 1,4 do
    sprite("Project:noise"..i, WIDTH/2, HEIGHT/2, math.random(WIDTH, 2*WIDTH), math.random(HEIGHT, 2*HEIGHT))
end

--Draw correct face in corner
    if right_answer_position == 1 then
    spriteMode(CENTER)
    sprite("Project:Face"..math.floor((face1).x), WIDTH/4, 7.1*HEIGHT/8, WIDTH/14)
    sprite("Project:Nose"..math.floor(face1.y), WIDTH/4, 7.1*HEIGHT/8, WIDTH/38,HEIGHT/32)
    sprite("Project:eyes"..math.floor(face1.z), WIDTH/4, 7.24*HEIGHT/8, WIDTH/17)
    elseif right_answer_position == 2 then
sprite("Project:Face"..math.floor((face2).x), WIDTH/4, 7.1*HEIGHT/8, WIDTH/14)
sprite("Project:Nose"..math.floor(face2.y), WIDTH/4, 7.1*HEIGHT/8, WIDTH/38,HEIGHT/32)
sprite("Project:eyes"..math.floor(face2.z), WIDTH/4, 7.24*HEIGHT/8, WIDTH/17)
    elseif right_answer_position == 3 then
sprite("Project:Face"..math.floor((face3).x), WIDTH/4, 7.1*HEIGHT/8, WIDTH/14)
sprite("Project:Nose"..math.floor(face3.y), WIDTH/4, 7.1*HEIGHT/8, WIDTH/38,HEIGHT/32)
sprite("Project:eyes"..math.floor(face3.z), WIDTH/4, 7.24*HEIGHT/8, WIDTH/17)
end

--touch functionality
    if CurrentTouch.state == BEGAN and touching then
        touching = false
        --Check if position is below a certain threshold
        if CurrentTouch.y < HEIGHT/2 then
            if CurrentTouch.x >= ((right_answer_position*WIDTH)/4)-(WIDTH/7.5) and 
                CurrentTouch.x < ((right_answer_position*WIDTH)/4)+(WIDTH/7.5) then
                stage = 0
            else
                bool=true
            end
        end
    end

    if CurrentTouch.state == ENDED then
        touching=true
    end

end

function nextGame()
    stage = math.random(1,stageMax)
end

--In this game, the user must select the right answer to "what color is this apple?"
--while there is a lot of background noise and everything is blurred
function game2()
    sound(SOUND_EXPLODE, 45885)
    sound(SOUND_EXPLODE, 24166)
    fontSize(20)
    physics.gravity(Gravity)
    
    
    if bool then
        bodies = {}
        table.insert(bodies,makeBox(WIDTH/30,HEIGHT/30, (WIDTH/2)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30)))
        table.insert(bodies,makeBox(WIDTH/30,(HEIGHT/6)+(HEIGHT/30),(WIDTH/2)-(WIDTH/15), (HEIGHT/4)-(1.75*HEIGHT/15)))
        table.insert(bodies,makeBox(WIDTH/2,HEIGHT/30, (WIDTH/2)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30)))
        table.insert(bodies,makeBox(WIDTH/2,(HEIGHT/6)+(HEIGHT/30), (WIDTH/2)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30)))
    
    
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
        
    end
    bool = false
    
    --Make four rectangles
    draw_game2_rectangles()
    fill(255)
    text("What color is this "..item.."?", WIDTH/2, HEIGHT/2)
    
    text("The "..item.." is green",WIDTH/4,HEIGHT/6+HEIGHT/8)
    text("The "..item.." is yellow",WIDTH*2.85/4,HEIGHT/6+HEIGHT/8)
    text("The "..item.." is red",WIDTH/4,HEIGHT/8)
    text("The "..item.." is blue",WIDTH*2.85/4,HEIGHT/8)
    
    --read touches
    
    if CurrentTouch.state == BEGAN and touching then
        touching = false
        if CurrentTouch.x < WIDTH/2 then
            if CurrentTouch.y < HEIGHT/6 then
                if right_answer_position == 2 then
                    stage = 0
                else
                    bool = true
                end
            elseif CurrentTouch.y < HEIGHT/6 + (HEIGHT/4)-(1.75*HEIGHT/15) then
                if right_answer_position == 0 then
                    stage = 0
                else
                    bool = true
                end
            end
        else
            if CurrentTouch.y < HEIGHT/6 then
                if right_answer_position == 3 then
                    stage = 0
                else
                    bool = true
                end
            elseif CurrentTouch.y < HEIGHT/6 + (HEIGHT/4)-(1.75*HEIGHT/15) then
                if right_answer_position == 1 then
                    stage = 0
                else
                    bool = true
                end
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

-- Helper function to create a box using a polygon body
function makeBox(x,y,w,h)
    -- Points are defined in counter-clockwise order
    local body = physics.body(POLYGON,vec2(-w/2, h/2),
    vec2(-w/2, -h/2), vec2(w/2, -h/2), vec2(w/2, h/2))
    
    -- Set the body's transform (position, angle)
    body.x = x
    body.y = y
    -- Make movement smoother regardless of framerate
    body.interpolate = true
    
    return body
end
