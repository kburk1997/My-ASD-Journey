-- My ASD Journey

-- Use this function to perform your initial setup
function setup()
    stage = 0
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color
    background(174, 174, 190, 255)
    
    if stage == 0 then
        
        
    elseif stage == 1 then
        
    elseif stage == 2 then
        
        --Katie make a mini game here

        --User must pick correct answer in conversation
        	--Sensory overload - a lot of background noise 
    	fontSize(20)
    	text("What color is this apple?", WIDTH/2, HEIGHT/2)

    	--Make four rectangles  
    	rect(WIDTH/30,HEIGHT/30, (WIDTH/2)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30))

    	--Top left rectangle
    	rect(WIDTH/30,(HEIGHT/6)+(HEIGHT/30), (WIDTH/2)-(WIDTH/15), (HEIGHT/4)-(1.75*HEIGHT/15))

    	--Bottom Right
    	rect(WIDTH/2,HEIGHT/30, (WIDTH)-(WIDTH/15), (HEIGHT/6)-(HEIGHT/30))

    	--Top right
    	rect(WIDTH/2,(HEIGHT/6)+(HEIGHT/30), (WIDTH)-(WIDTH/15), (HEIGHT/4)-(1.75*HEIGHT/15))

        --Randomly select right answer
        --0|1
        --2|3

        right_answer_position = math.random(0,3)

        if right_answer_position == 0 then

        elseif right_answer_position == 1 then

        elseif right_answer_position == 2 then

        else

        end


    end
    
end
