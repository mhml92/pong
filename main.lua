function love.load()
   love.graphics.setDefaultFilter( "nearest", "nearest", 1)
   
   -- width and height of window
   WIDTH, HEIGHT = love.graphics.getDimensions()
   
   -- Tennis-ish pong
   --world = love.physics.newWorld( 0, 1000, false)
   
   -- Classic pong
   world = love.physics.newWorld( 0, 0, false)

   -- Placement of players (how fare away from the border of the screen)
   MARGIN = 50

   -- Player movement speed
   MOVESPEED = 400

   -- Thickness of the players
   PLAYERWIDTH = 5

   -- Length of the player
   PLAYERHEIGHT = 100

   -- How bouncy the ball should be. 
   -- 1 = no energi loss on impict 
   -- 0 100% energi loss, 
   -- > 1 gain energi on impact 
   RESTITUTION = 1
   
   -- Start speed of the ball
   BALLSPEED = 500 
   
   -- size of the ball e.i. its radius
   BALLSIZE = 10
   BALLFRICTION = 0
   
   --create players
   p1 = {}
   p1.size = PLAYERHEIGHT
   p1.points = 0
   p1.body = love.physics.newBody(world,MARGIN,HEIGHT/2,"kinematic") 
   p1.shape = love.physics.newRectangleShape(PLAYERWIDTH, p1.size)
   p1.fixture = love.physics.newFixture(p1.body,p1.shape)

   p2 = {}
   p2.size = PLAYERHEIGHT
   p2.points = 0
   p2.body = love.physics.newBody(world,WIDTH-MARGIN,HEIGHT/2,"kinematic") 
   p2.shape = love.physics.newRectangleShape(PLAYERWIDTH, p2.size)
   p2.fixture = love.physics.newFixture(p2.body,p2.shape)

   ball = {}
   ball.r = BALLSIZE
   ball.body = love.physics.newBody(world,WIDTH/2,HEIGHT/2,"dynamic")
   ball.shape = love.physics.newCircleShape(ball.r)
   ball.fixture = love.physics.newFixture(ball.body,ball.shape)
   ball.fixture:setRestitution(RESTITUTION)
   ball.body:setBullet(true)
   ball.fixture:setFriction(BALLFRICTION)

  
   -- Putting sides on the top and bottom of the screen fore the ball to bounce of
   side1 = {}
   side1.body = love.physics.newBody(world,WIDTH/2,0,"static")
   side1.shape = love.physics.newRectangleShape(WIDTH,1)
   side1.fixture = love.physics.newFixture(side1.body,side1.shape)
   
   side2 = {}
   side2.body = love.physics.newBody(world,WIDTH/2,HEIGHT,"static")
   side2.shape = love.physics.newRectangleShape(WIDTH,1)
   side2.fixture = love.physics.newFixture(side2.body,side2.shape)
   
   restart()
end


function love.update(dt)
   -- Update the physics world
   world:update(dt)
   
   ---------------------------------------------------
   -- Get keybord input
   ---------------------------------------------------
   
   if love.keyboard.isDown('w') then
      -- move player1 upwards by setting the Y coordinate of 
      -- the players body
      p1.body:setY(p1.body:getY() - MOVESPEED*dt)
      
      -- if the player is out of the screen put him back
      if p1.body:getY() < 0 then
         p1.body:setY(0)
      end
   end
   
   if love.keyboard.isDown('s') then
      p1.body:setY(p1.body:getY() + MOVESPEED*dt)
      if p1.body:getY() > HEIGHT then
         p1.body:setY(HEIGHT)
      end
   end

   
   if love.keyboard.isDown('up') then
      p2.body:setY(p2.body:getY() - MOVESPEED*dt)
      if p2.body:getY() < 0 then
         p2.body:setY(0)
      end
   end
   
   if love.keyboard.isDown('down') then
      p2.body:setY(p2.body:getY() + MOVESPEED*dt)
      if p2.body:getY() > HEIGHT then
         p2.body:setY(HEIGHT)
      end
   end

   -- if the ball is outside of the screen someone has scroed a point
   if ball.body:getX() > WIDTH  then
      p1.points = p1.points + 1
      restart()
   end
   if ball.body:getX() < 0 then 
      p2.points = p2.points + 1
      restart()
   end

   -- close the game with the escape key
   if love.keyboard.isDown('escape') then
      love.event.quit()
   end
end

function love.draw()
   -- put the score in the window decoration
   love.window.setTitle(p1.points .. ":" .. p2.points)
   
   -- Draw the ball
   love.graphics.circle("line",ball.body:getX(),ball.body:getY(),ball.r,8)

   -- Draw player1
   love.graphics.rectangle("fill",p1.body:getX()-PLAYERWIDTH/2,p1.body:getY()-p1.size/2,PLAYERWIDTH,p1.size)
   -- Draw player2
   love.graphics.rectangle("fill",p2.body:getX()-PLAYERWIDTH/2,p2.body:getY()-p2.size/2,PLAYERWIDTH,p2.size)

end

function restart()
   randomRad = love.math.random()*2*math.pi
   ball.body:setX(WIDTH/2)
   ball.body:setY(HEIGHT/2)
   ball.body:setLinearVelocity(BALLSPEED*math.cos(randomRad),BALLSPEED*math.sin(randomRad))
end

