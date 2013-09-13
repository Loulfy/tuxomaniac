-------------------------------
------ Follow ME v 0.1.1 ------
-------------------------------

function LOAD_Map(map)
	carte = love.filesystem.newFile(map)
	carte:open('r')
	for i=1, HAUTEUR_TERRAIN do
		table.insert(MAP, {})
		data = carte:read(LARGEUR_TERRAIN + 1)
		for I=1, LARGEUR_TERRAIN do
			table.insert(MAP[i], data:sub(I,I))
		end
	end
end

function DISPLAY_Map()
	for y=1, HAUTEUR_TERRAIN do
		yy = (y-1) * TAILLE_SPRITE
		for x=1, LARGEUR_TERRAIN do
			xx = (x-1) * TAILLE_SPRITE
			if MAP[y][x] == '1' then
				love.graphics.draw(mur, xx, yy)
			elseif MAP[y][x] == '0' then
				love.graphics.draw(dalle, xx, yy)
			end
		end
	end
end

function love.load()
	TAILLE_SPRITE   = 32
	LARGEUR_TERRAIN = math.floor(love.graphics.getWidth()/TAILLE_SPRITE)
	HAUTEUR_TERRAIN = math.floor(love.graphics.getHeight()/TAILLE_SPRITE)
	MAP = {}
	
	mur = love.graphics.newImage("mur_test.png")
	dalle = love.graphics.newImage("dalle_test.png")

	t = 1
	sprite = love.graphics.newImage("sprite_test.png")
	widthimage = sprite:getWidth()/2
	heightimage = sprite:getHeight()/2
    vitesse = 4

	cible_x = 400
	cible_y = 250
	sprite_x = 400
	sprite_y = 249
	angle = math.atan2(cible_x  - sprite_x, cible_y - sprite_y)
	depart_x = sprite_x
	depart_y = sprite_y
	v = vitesse / (math.sqrt((cible_x - sprite_x)^2 + (cible_y - sprite_y)^2))

	LOAD_Map("carte")
end

function love.draw()
	DISPLAY_Map()
	love.graphics.setColor(255, 255, 255) -- Couleur  : Blanc
	love.graphics.circle("line", cible_x, cible_y, 10, 10)
    --love.graphics.translate(sprite_x,sprite_y)
	--love.graphics.rotate(-angle+3.141592653)
    --love.graphics.translate(-sprite_x, -sprite_y)
	love.graphics.draw(sprite, sprite_x - widthimage*math.cos(angle), sprite_y - heightimage*math.sin(angle), angle)
end

function love.mousepressed(mouse_x, mouse_y, button)
   if button == "l" then
		cible_x = math.floor(mouse_x/TAILLE_SPRITE)*TAILLE_SPRITE+TAILLE_SPRITE/2
		cible_y = math.floor(mouse_y/TAILLE_SPRITE)*TAILLE_SPRITE+TAILLE_SPRITE/2
		depart_x = sprite_x
		depart_y = sprite_y
    	t = 1
		v = vitesse / (math.sqrt((cible_x - sprite_x)^2 + (cible_y - sprite_y)^2))
		angle = -math.atan2(cible_x-sprite_x,cible_y-sprite_y)+math.pi
   end
end

function love.keypressed(key)
   if key == "escape" then
      screenshot = love.graphics.newScreenshot()
   end
end

function love.update()
	if t > 0 then
      t = t - v
	  sprite_x = cible_x + (depart_x - cible_x) * t
	  sprite_y = cible_y + (depart_y - cible_y) * t
    end
end


