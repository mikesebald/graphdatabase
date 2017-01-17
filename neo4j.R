library(RNeo4j)

graph <- startGraph("http://localhost:7474/db/data/")

clear(graph, input = FALSE)

addConstraint(graph, "Person", "name")

nicole <- createNode(graph, "Person", name = "Nicole", male = F)
kenny <- createNode(graph, "Person", name = "Kenny", male = T)
greta <- createNode(graph, "Person", name = "Greta", male = F)
hank <- createNode(graph, "Person", name = "Hank", male = T)

addConstraint(graph, "BoardGame", "name")
addConstraint(graph, "ComputerGame", "name")

risk <- createNode(graph, "BoardGame", name = "RISK", max_players = c(5, 6))
settlers <- createNode(graph, "BoardGame", name = "Settlers of Cattan", max_players = 4)
lol <- createNode(graph, "ComputerGame", name = "League of Legends", max_players = 10)
sc <- createNode(graph, "ComputerGame", name = "Starcraft", max_players = 8)

risk$max_players

rel <- createRel(greta, "PLAYS", risk, color = "Red")

rels_h <- lapply(list(risk, lol), function(g) createRel(hank, "PLAYS", g))
rels_k <- lapply(list(risk, lol, sc), function(g) createRel(kenny, "PLAYS", g))

all_games <- getNodes(graph, 
                      "MATCH (n) WHERE (n:BoardGame) OR (n:ComputerGame) RETURN n")
rels_n <- lapply(all_games, function(g) createRel(nicole, "PLAYS", g))

all_games

browse(graph)

nicole <- updateProp(nicole, hair = "Blonde")

summary(graph)
getIndex(graph)
getConstraint(graph)

person <- getSingleNode(graph, "MATCH (p:Person) RETURN p LIMIT 1") 
person

nodes <- getNodes(graph, "MATCH (n) RETURN n")
lapply(nodes, function(x) x$name)

delete(greta)
delete(rel)
delete(greta)

