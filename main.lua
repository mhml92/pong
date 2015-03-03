function love.load()
   love.graphics.setDefaultFilter( "nearest", "nearest", 1)
   
   WIDTH, HEIGHT = love.graphics.getDimensions()
   world = love.physics.newWorld( 0, 0, false)

   print(HEIGHT,WIDTH)
   MARGIN = 50
   MOVESPEED = 400
   --BALLSPEED = 400
   PLAYERWIDTH = 5
   RESTITUTION = 1
   --create players
   p1 = {}
   p1.size = 100
   p1.points = 0
   p1.body = love.physics.newBody(world,MARGIN,HEIGHT/2,"kinematic") 
   p1.shape = love.physics.newRectangleShape(PLAYERWIDTH, p1.size)
   p1.fixture = love.physics.newFixture(p1.body,p1.shape)
   p1.fixture:setRestitution(RESTITUTION)

   p2 = {}
   p2.size = 100
   p2.points = 0
   p2.body = love.physics.newBody(world,WIDTH-MARGIN,HEIGHT/2,"kinematic") 
   p2.shape = love.physics.newRectangleShape(PLAYERWIDTH, p2.size)
   p2.fixture = love.physics.newFixture(p2.body,p2.shape)
   p2.fixture:setRestitution(RESTITUTION)

   ball = {}
   ball.r = 10
   ball.body = love.physics.newBody(world,WIDTH/2,HEIGHT/2,"dynamic")
   ball.shape = love.physics.newCircleShape(ball.r)
   ball.fixture = love.physics.newFixture(ball.body,ball.shape)
   ball.fixture:setRestitution(RESTITUTION)
   ball.body:setBullet(true)
   ball.fixture:setFriction( 0 )

   
   side1 = {}
   side1.body = love.physics.newBody(world,WIDTH/2,0,"static")
   side1.shape = love.physics.newRectangleShape(WIDTH,1)
   side1.fixture = love.physics.newFixture(side1.body,side1.shape)
   side1.fixture:setRestitution(RESTITUTION)
   
   side2 = {}
   side2.body = love.physics.newBody(world,WIDTH/2,HEIGHT,"static")
   side2.shape = love.physics.newRectangleShape(WIDTH,1)
   side2.fixture = love.physics.newFixture(side2.body,side2.shape)
   side2.fixture:setRestitution(RESTITUTION)
   
   
   restart()
end


function love.update(dt)
   world:update(dt)
   --Get keybord input
   if love.keyboard.isDown('w') then
      p1.body:setY(p1.body:getY() - MOVESPEED*dt)
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

   
   if ball.body:getX() > WIDTH  then
      p1.points = p1.points + 1
      restart()
   end
   if ball.body:getX() < 0 then 
      p2.points = p2.points + 1
      restart()
   end
   if love.keyboard.isDown('escape') then
      love.event.quit()
   end
end

function love.draw()
   love.window.setTitle(p1.points .. ":" .. p2.points)
   love.graphics.circle("line",ball.body:getX(),ball.body:getY(),ball.r,8)

   love.graphics.rectangle("fill",p1.body:getX()-PLAYERWIDTH/2,p1.body:getY()-p1.size/2,PLAYERWIDTH,p1.size)
   love.graphics.rectangle("fill",p2.body:getX()-PLAYERWIDTH/2,p2.body:getY()-p2.size/2,PLAYERWIDTH,p2.size)

end

function restart()
   randomRad = love.math.random()*2*math.pi
   ball.body:setX(WIDTH/2)
   ball.body:setY(HEIGHT/2)
   print(randomRad)
   print(math.cos(randomRad))
   print(math.sin(randomRad))
   print()
   ball.body:setLinearVelocity(500*math.cos(randomRad),500*math.sin(randomRad))
end

