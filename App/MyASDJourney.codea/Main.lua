-- My ASD Journey
supportedOrientations(LANDSCAPE_ANY)
displayMode(FULLSCREEN_NO_BUTTONS)
-- Use this function to perform your initial setup
function setup()
    math.randomseed(os.date("*t")["month"]*os.date("*t")["day"]*os.date("*t")["hour"]*os.date("*t")["min"]*os.date("*t")["sec"]*os.date("*t")["wday"])
    stage = 3
    stageMax = 2
    bool = true
    item = ""
    touching = false
    right_answer_position = -1
    itemList = {"apple","waffle","ball","box","table","sky","orange","glass"}
    points = 0
    face1 = vec3(0,0,0)
    face2 = vec3(0,0,0)
    face3=vec3(0,0,0)
    timer = os.time()
    decider = math.random(1,1000)
    speech.volume = 1
    paragraph1={"I","like","cats",".","I","have","over","100","pictures","of","my","cats","on","my","phone",".","I","am","definitely","not","a","crazy","cat","lady","."}
    paragraph2={}
    sarcasm1=3
    sarcasm2=1
    rand_word=0
    rand_paragraph=1
    loop_index=0
    period=false
    bodies = {}
    wall1 = physics.body(POLYGON, vec2(20,0), vec2(0,0), vec2(0,HEIGHT), vec2(20,HEIGHT))
    wall1.type = STATIC
    wall2 = physics.body(POLYGON, vec2(WIDTH-(20),0), vec2(WIDTH,0), vec2(WIDTH,HEIGHT), vec2(WIDTH-(20),HEIGHT))
    wall2.type = STATIC
    floor = physics.body(POLYGON, vec2(0,20), vec2(0,0), vec2(WIDTH,0), vec2(WIDTH,20))
    floor.type = STATIC
    floor = physics.body(POLYGON, vec2(0,HEIGHT-20), vec2(0,HEIGHT), vec2(WIDTH,HEIGHT), vec2(WIDTH,HEIGHT-20))
    locations = {}
    py1 = {}
    px1 = {}
    i = 0.125*WIDTH/4
    z = HEIGHT*3/4
    index = 1
    fontSize(45)
    col = vec3(0,0,0)
    while index <= #paragraph1 do
        py1[index] = z
        px1[index] = i
        i = i + textSize(" "..((paragraph1[index])).." ")
        if i >= WIDTH - 0.375*WIDTH/4 then
            i = 0.125*WIDTH/4
            z = z - HEIGHT/16
        end
        index = index + 1
        if paragraph1[index] == "." then
            py1[index] = z
            px1[index] = i
            table.insert(locations,index)
            index = index+1
        end
    end
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
temp = math.random(0,HEIGHT/2)
sprite("Project:Face"..math.floor((face1).x), WIDTH/4, HEIGHT/4+temp, WIDTH/6)
sprite("Project:Nose"..math.floor((face1).y), WIDTH/4, HEIGHT/4+temp, WIDTH/20,HEIGHT/17)
sprite("Project:eyes"..math.floor((face1).z), WIDTH/4, 1.15*HEIGHT/4+temp, WIDTH/7.5)
temp = math.random(0,HEIGHT/2)
sprite("Project:Face"..math.floor((face2).x), WIDTH/2, HEIGHT/4+temp, WIDTH/6)
sprite("Project:Nose"..math.floor((face2).y), WIDTH/2, HEIGHT/4+temp, WIDTH/20,HEIGHT/17)
sprite("Project:eyes"..math.floor((face2).z), WIDTH/2, 1.15*HEIGHT/4+temp, WIDTH/7.5)
temp = math.random(0,HEIGHT/2)
sprite("Project:Face"..math.floor((face3).x), 3*WIDTH/4, HEIGHT/4+temp, WIDTH/6)
sprite("Project:Nose"..math.floor((face3).y), 3*WIDTH/4,HEIGHT/4+temp, WIDTH/20,HEIGHT/17)
sprite("Project:eyes"..math.floor((face3).z), 3*WIDTH/4, 1.15*HEIGHT/4+temp, WIDTH/7.5)

--add tint
tint(255,255,255,145)

--draw noise
for i= 1,6 do
    sprite("Project:noise"..i, WIDTH/2, HEIGHT/2, math.random(WIDTH, 2*WIDTH), math.random(HEIGHT, 2*HEIGHT))
end

tint(255,255,255,255)

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
fill(255)
fontSize(50)
text(math.floor(30+os.difftime(timer,os.time())),WIDTH/2,HEIGHT*7/8)
if os.difftime(os.time(),timer) >= 30 then
    bool=true
    nextGame()
end

--touch functionality
    if CurrentTouch.state == BEGAN and touching then
        touching = false
        --Check if position is below a certain threshold
            if CurrentTouch.x >= ((right_answer_position*WIDTH)/4)-(WIDTH/7.5) and 
                CurrentTouch.x < ((right_answer_position*WIDTH)/4)+(WIDTH/7.5) then
                stage = 0
            else
                bool=true
                nextGame()
            end
    end

    if CurrentTouch.state == ENDED then
        touching=true
    end

end

function nextGame()
    stage = math.random(1,stageMax)
    timer = os.time()
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
    
    
        item = itemList[math.random(1,#itemList)]
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
    fill(255,0,0,255)
    text("The "..item.." is green",WIDTH/4,HEIGHT/6+HEIGHT/8)
    fill(0,0,255,255)
    text("The "..item.." is yellow",WIDTH*2.85/4,HEIGHT/6+HEIGHT/8)
    fill(0,255,0,255)
    text("The "..item.." is red",WIDTH/4,HEIGHT/8)
    fill(255,255,0,255)
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
                    nextGame()
                end
            elseif CurrentTouch.y < HEIGHT/6 + (HEIGHT/4)-(1.75*HEIGHT/15) then
                if right_answer_position == 0 then
                    stage = 0
                else
                    bool = true
                    nextGame()
                end
            end
        else
            if CurrentTouch.y < HEIGHT/6 then
                if right_answer_position == 3 then
                    stage = 0
                else
                    bool = true
                    nextGame()
                end
            elseif CurrentTouch.y < HEIGHT/6 + (HEIGHT/4)-(1.75*HEIGHT/15) then
                if right_answer_position == 1 then
                    stage = 0
                else
                    bool = true
                    nextGame()
                end
            end
        end
    end
    
    if CurrentTouch.state == ENDED then
        touching=true
    end

    fill(255)
    fontSize(50)
    text(math.floor(30+os.difftime(timer,os.time())),WIDTH/2,HEIGHT*7/8)
    if os.difftime(os.time(),timer) >= 30 then
        bool=true
        nextGame()
    end

end

--Draw the four rectangles for the answer choices
function draw_game2_rectangles()
    rectMode(CORNER)
    maintainbodies()
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

--Word game - identify which sentence is sarcasm
function game3()
    textMode(CORNER)
    --define random nth word to disappear
    math.randomseed(decider)
    if bool then
        rand_word=math.random(3,7)
       -- rand_paragraph=math.random(1,2)
        loop_index=1
        col = vec3(math.random(0,1),math.random(0,1),math.random(0,1))
        fill(col.x*255,col.y*255,col.z*255,255)
        rect(WIDTH/4,HEIGHT/15, WIDTH/8, WIDTH/8)
    end
    index = 1
    fontSize(45)
    while index <= #paragraph1 do
        fill(col.x*255,col.y*255,col.z*255,255)
        if index == locations[1] or index == locations[2] then
            col = vec3(math.random(0,1),math.random(0,1),math.random(0,1))
            fill(col.x*255,col.y*255,col.z*255,255)
            if index == locations[1] then
                rect(WIDTH/2,HEIGHT/15, WIDTH/8, WIDTH/8)
            else
                rect(3*WIDTH/4,HEIGHT/15, WIDTH/8, WIDTH/8)
            end
        end
        text(" "..paragraph1[index].." ",px1[index],py1[index])
        index = index + 1
        if index%rand_word == 0 then
            index = index + 1
        end
    end
    fill(255)
    fontSize(50)
    text(math.floor(30+os.difftime(timer,os.time())),WIDTH/2,HEIGHT*7/8)
    if os.difftime(os.time(),timer) >= 30 then
        bool=true
        nextGame()
        decider = math.random(1,1000)
    end
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color
    background(174, 174, 190, 255)
    
    if stage == 0 then
        fill(0)
        fontSize(80)
        text("Sensory Overload Simulator",WIDTH/2,HEIGHT/2)
        fontSize(45)
        text("tap to begin",WIDTH/2,HEIGHT/2.4)
        text("SEIZURE RISK WARNING",WIDTH/2,HEIGHT/3)
        if CurrentTouch.state == BEGAN then
            nextGame()
        end
    elseif stage == 1 then
        game1()
        
    elseif stage == 2 then
        
        --Katie make a mini game here
        game2()
    elseif stage == 3 then
        game3()
    end
    
end

function maintainbodies()
    for i,body in ipairs(bodies) do
        if body.position.x < 0 then
            body.position.x = 0
        elseif body.position.x > WIDTH then
            body.position.x = WIDTH
        end

        if body.position.y < 0 then
            body.position.y = 0
        elseif body.position.y > HEIGHT then
            body.position.y = HEIGHT
        end

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
