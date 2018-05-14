local  donjon = {}
donjon.nombreColonne = 9
donjon.nombreLigne = 6
donjon.salleDepart = nil
donjon.map = {}

function CreerSalle(pLigne, pColonne)
  local newSalle = {}
  
  newSalle.ligne = pLigne
  newSalle.colonne = pColonne
  
  newSalle.estOuverte = false
  
  newSalle.porteHaut = false
  newSalle.porteDroite = false
  newSalle.porteBas = false
  newSalle.porteGauche = false
  
  return newSalle
end

function GenereDonjon()
  print("GenereDonjon")
  
  --reset le donjon
  donjon.map = {}
  for nLigne=1,donjon.nombreLigne do
    donjon.map[nLigne] = {}
    for nColonne=1,donjon.nombreColonne do
      donjon.map[nLigne][nColonne] = CreerSalle(nLigne, nColonne)
    end
  end
  
  --generer le donjon
  local listeSalles = {}
  local nbSalles = 20
  
  --creer la salle de depart
  local nLigneDepart, nColonneDepart
  nLigneDepart = math.random(1,donjon.nombreLigne)
  nColonneDepart = math.random(1,donjon.nombreColonne)
  local salleDepart = donjon.map[nLigneDepart][nColonneDepart]
  salleDepart.estOuverte = true
  table.insert(listeSalles,salleDepart)
  
  --memoriser la salle de depart
  donjon.salleDepart = salleDepart
  
  while #listeSalles < nbSalles do
    
    --Sélectionne une salle dans la liste
    local nSalle = math.random(1, #listeSalles)
    local nLigne = listeSalles[nSalle].ligne
    local nColonne = listeSalles[nSalle].colonne
    local salle = listeSalles[nSalle]
    local nouvelleSalle = nil
    
    local direction = math.random(1,4)
    
    local bAjouteSalle = false
    
    if direction == 1 and nLigne > 1 then
      nouvelleSalle = donjon.map[nLigne-1][nColonne]
      if nouvelleSalle.estOuverte == false then
        salle.porteHaut = true
        nouvelleSalle.porteBas = true
        bAjouteSalle = true
      end
    end
    if direction == 2 and nColonne < donjon.nombreColonne then
      nouvelleSalle = donjon.map[nLigne][nColonne+1]
      if nouvelleSalle.estOuverte == false then
        salle.porteDroite = true
        nouvelleSalle.porteGauche = true
        bAjouteSalle = true
      end
    end
    if direction == 3 and nLigne < donjon.nombreLigne then
      nouvelleSalle = donjon.map[nLigne+1][nColonne]
      if nouvelleSalle.estOuverte == false then
        salle.porteBas = true
        nouvelleSalle.porteHaut = true
        bAjouteSalle = true
      end
    end
    if direction == 4 and nColonne > 1 then
      nouvelleSalle = donjon.map[nLigne][nColonne-1]
      if nouvelleSalle.estOuverte == false then
        salle.porteGauche = true
        nouvelleSalle.porteDroite = true
        bAjouteSalle = true
      end
    end
    
    --ajoute la salle
    if bAjouteSalle == true then
      nouvelleSalle.estOuverte = true
      table.insert(listeSalles, nouvelleSalle)
    end
    
  end
  
end

function love.load()
  GenereDonjon()
end

function love.update(dt)
  
end

function love.draw()
  
  local x = 5
  local y = 5
  local largeurCase = 34
  local hauteurCase = 13
  local espaceCase = 5
  
   for nLigne=1,donjon.nombreLigne do
     
     x = 5
    
    for nColonne=1,donjon.nombreColonne do
      local salle = donjon.map[nLigne][nColonne]
      --dessine la cellule
      if salle.estOuverte == false then
        love.graphics.setColor(60, 60, 60)
      elseif donjon.salleDepart == salle then
        love.graphics.setColor(25, 255, 25)
      else
        love.graphics.setColor(255, 255, 255)
      end
      
      love.graphics.rectangle("fill", x, y, largeurCase, hauteurCase)
      
      love.graphics.setColor(255, 25, 25)
      if salle.porteHaut == true then
        love.graphics.rectangle("fill", (x+largeurCase/2)-2, (y-2),4 ,6)
      end
      if salle.porteDroite == true then
        love.graphics.rectangle("fill", (x+largeurCase)-2, (y+hauteurCase/2)-2, 6, 4)
      end
      if salle.porteBas == true then
        love.graphics.rectangle("fill", (x+largeurCase/2)-2, (y+hauteurCase)-2 ,4 ,6)
      end
      if salle.porteGauche == true then
        love.graphics.rectangle("fill", (x-2), (y+hauteurCase/2)-2,6 ,4)
      end
      
      
      
      x = x + largeurCase + espaceCase
      
    end
    
    y = y + hauteurCase + espaceCase
    
  end
  
  love.graphics.setColor(255, 255, 255)
  
end

function love.keypressed(key)
  print(key)
  if key == "escape" then
    love.event.quit(0)
  end
  if key == "space" or key == " " then
    GenereDonjon()
  end
end