function love.load()
   love.graphics.setDefaultFilter( "nearest", "nearest", 1)
   
   WIDTH, HEIGHT = love.graphics.getDimensions()
   print(HEIGHT,WIDTH)
   MARGIN = 50
   MOVESPEED = 400
   BALLSPEED = 400
   PLAYERWIDTH = 5
   --create players
   p1 = {}
   p1.x = MARGIN
   p1.y = HEIGHT/2
   p1.size = 100
   p1.points = 0
   
   p2 = {}
   p2.x = WIDTH-MARGIN
   p2.y = HEIGHT/2
   p2.size = 100
   p2.points = 0

   ball = {}
   ball.r = 10
   ball.dir = {}
   restart()
end


function love.update(dt)
   --Get keybord input
   if love.keyboard.isDown('w') then
      p1.y = p1.y - MOVESPEED*dt
      if p1.y < 0 then
         p1.y = 0
      end
   end
   
   if love.keyboard.isDown('s') then
      p1.y = p1.y + MOVESPEED*dt
      if p1.y > HEIGHT then
         p1.y = HEIGHT
      end
   end

   if love.keyboard.isDown('up') then
      p2.y = p2.y - MOVESPEED*dt
      if p2.y < 0 then
         p2.y = 0
      end
   end
   
   if love.keyboard.isDown('down') then
      p2.y = p2.y + MOVESPEED*dt
      if p2.y > HEIGHT then
         p2.y = HEIGHT
      end 
   end

   

   ball.x = ball.x + (ball.dir.x*BALLSPEED*dt)
   ball.y = ball.y + (ball.dir.y*BALLSPEED*dt)
  
   if ball.x - ball.r < p1.x + PLAYERWIDTH/2 and ball.x + ball.r > p1.x - PLAYERWIDTH/2 then
      if ball.y - ball.r > p1.y-p1.size/2 and ball.y + ball.r < p1.y+p1.size/2 then
         ball.x = p1.x +PLAYERWIDTH/2 + ball.r
         ball.dir.x = ball.dir.x * -1
      end
   end
   
   if ball.x + ball.r > p2.x - PLAYERWIDTH/2 and ball.x - ball.r < p2.x + PLAYERWIDTH/2 then
      if ball.y - ball.r > p2.y-p2.size/2 and ball.y + ball.r < p2.y+p1.size/2 then
         ball.x = p2.x -(PLAYERWIDTH/2 + ball.r)
         ball.dir.x = ball.dir.x * -1
      end
   end

   if ball.x > WIDTH  then
      p1.points = p1.points + 1
      restart()
   end
   if ball.x < 0 then 
      p2.points = p2.points + 1
      restart()
   end
   if ball.y+ball.r > HEIGHT or ball.y-ball.r < 0 then
      ball.dir.y = ball.dir.y * -1 
      if ball.y > HEIGHT then
         ball.y = HEIGHT
      elseif ball.y < 0 then
         ball.y = 0
      end
   end

   if love.keyboard.isDown('escape') then
      love.event.quit()
   end
end

function love.draw()
   love.window.setTitle(p1.points .. ":" .. p2.points)
   love.graphics.circle("fill",ball.x,ball.y,ball.r,8)

   love.graphics.rectangle("fill",p1.x-PLAYERWIDTH/2,p1.y-p1.size/2,PLAYERWIDTH,p1.size)
   love.graphics.rectangle("fill",p2.x-PLAYERWIDTH/2,p2.y-p2.size/2,PLAYERWIDTH,p2.size)

end

function restart()
   randomNumber = love.math.random()
   ball.dir.x = math.cos(randomNumber)
   ball.dir.y = math.sin(randomNumber)
   if love.math.random() > 0.5 then
      ball.dir.x = ball.dir.x * -1
   end
   ball.x = WIDTH/2
   ball.y = HEIGHT/2
end

