devtools::install_github("M2DS/M2Pathfinding")
library(M2Pathfinding)
library(igraph)

## fonction pour l'affichage des graph

creat_graph<-function(graph){
  d=t(as.data.frame(graph))
  d=as.data.frame(d)
  g <- graph.data.frame(d, directed=TRUE)

  plot(g)
}


##################################################################
########   ** Exemple pour l'algorithme de Bellman Ford **########


################################################
############# Algorithme en R ##################
################################################

# exemple 1 :  avec un graphe ne contenant pas de cycle Ã  poids nÃ©gatifs

vertices1 <-list('1','2', '3','4')
edges1 <- list(c(1,2,4),c(1,4,5), c(3,2,-10), c(4,3,3))

# on trace le graphe pour l'illustrer
creat_graph(edges1)

# lancement de l'algorithme
BellmanFord(vertices1,edges1,4)

########## RÃ©sultats

# $dist1
# [1] 0
#
# $dist2
# [1] -2
#
# $dist3
# [1] 8
#
# $dist4
# [1] 5
#
# $pred1
# NULL
#
# $pred2
# [1] 3
#
# $pred3
# [1] 4
#
# $pred4
# [1] 1
#
# $k
# [1] 4

# l'lagorithme de Bellman permet de donner les distance finale pour chaque sommet
#du graphe en partnat du sommet '1'
# ainsi les distances/couts des sommets '1','2', '3','4' du graphe sont
#donnÃ©es respectivement : 0 -2 8 5
# l'algorithme donne aussi le prÃ©dÃ©cesseur optimal de chaque sommet,
#ils ont donnÃ©es respectivement  :
# les sommets : '1','2', '3','4' et les prÃ©dÃ©cesseurs : NULL, '3' , '4', '"1'





# exemple 2 :  avec un graphe contenant un cycle Ã  poids nÃ©gatifs

vertices2 <-list('1','2', '3','4','5')
edges2 <- list(c(1,2,4),c(1,4,5), c(3,2,-10), c(4,3,3), c(2,5,2), c(5,4,2))

# on trace le graphe pour l'illustrer
creat_graph(edges2)

# lancement de l'algorithme

BellmanFord(vertices2,edges2,1)

# RÃ©sultats

# l'lactualisation des distances s'arrete a n-1 itÃ©rations 4 Ã©tant le nombre de sommets.
# La cherche du cycle Ã  poids nÃ©gatif prouve l'existance ce de dernier
# Un messag est affichÃ© dÃ©clarant l'incompatiblitÃ© de
#l'algorithme avec la problÃ©matique en question.
#algorithme de Dijkstra peut prÃ©senter une alternative

###########################################################
############# Algorithme de Bellman en CPP ################
##########################################################

# pour cette implÃ©mntation on a choisi le format suivant

#edgescpp <- matrix(data = c(0,4,0,5,0,0,0,0,0,-10,0,0,0,0,3,0),4,4,byrow = TRUE)


edgescpp0 <- as.matrix(read.table(text=
   "A B C D
 A  0 8 0 2
 B  0 0 0 0
 C  0 2 0 0
 D  0 0 3 0", header=T))

g0 <- graph.adjacency(edgescpp0,mode="directed", weighted=TRUE,diag = FALSE)


plot.igraph(g0,vertex.size=20 ,edge.label=E(g0)$weight, edge.color= "red")


# lancement de l'algorithme

bellman_ford(edgescpp0, 0)


# RÃ©sultats

# Vertex  Distance from source
# 0     	0
# 1	      7
# 2	      5
# 3	      2

# la meme interprÃ©tation s'applique, ontrouve les distances
#minimales pour aller a partir du sommet A vers les autres sommets B C D respectivement
# 7 5 2




##################################################################
########   ** Exemple pour l'algorithme de Djikstra**#############



###########################################################
############# Algorithme de DjIkstra en R ################
##########################################################

#un graphe peut Ãªtre representÃ© par sa matrice d'adjacence

#exemple graphe a partir de la librairie igraph
g <- as.matrix(read.table(text=
                            "C T1 V1 T2 V2 WS1 WS2 TC1 TC2 RRC
 C    0  8 10 12  0   0   0   0   0   0
 T1   8  0  2  0  0   0   0   0  12   0
 V1  10  2  0  0  2   0   0   0   0   0
 T2  12  0  0  0  0   5   0  10   0   0
 V2   0  0  2  0  0   1   7   0   0   0
 WS1  0  0  0  5  1   0   0   2   0   0
 WS2  0  0  0  0  7   0   0   2   2   0
 TC1  0  0  0 10  0   2   2   0   5   8
 TC2  0 12  0  0  0   0   2   5   0   3
 RRC  0  0  0  0  0   0   0   8   3   0", header=T))


g <- graph.adjacency(g, mode="undirected", weighted=TRUE,diag = FALSE)

plot(g,edge.label=E(g)$weight)

#results nous donne la distance du sommet d'origine C par rapport Ã  tous les autres sommets

results <- dijkstra(g, start = "C")

#par exemple la dstance entre 0->T1 est 8, 0->V1 est 10 etc....
#C  T1  V1  T2  V2 WS1 WS2 TC1 TC2 RRC
#0   8  10  12  12  13  17  15  19  22


#seq nous donne le chemin optimal partant de "C" pour aller a "RRC":
Seq <- shortDPath(results)
Seq

#exemple de sortie: "C"   "V1"  "V2"  "WS1" "TC1" "WS2" "TC2" "RRC"
#mais aussi on a les predecesseurs optimal de chaque sommet qui est donnÃ©e par:

#C    T1    V1    T2    V2   WS1   WS2   TC1   TC2   RRC
#NA   "C"   "C"   "C"  "V1"  "V2" "TC1" "WS1" "WS2" "TC2"

#par exemple le predecesseur optimal du sommet T1 est C, celui de V2 est V1 etc..


###########################################################
############# Algorithme de DjIkstra en CPP ################
##########################################################

library(Rcpp)


##### la matrice d'adjacence representant le poid de chaque arete

edges_dik <- matrix(data = c(0,4,8,0,0,4,0,2,5,0,8,2,0,5,9,0,5,5,0,4,0,0,9,4,0),5,5)
dijkstra_cpp(edges_dik)

####l'algorithme de dijkstra en c++ nous donne la sortie suivante avec la matrice d'adiacence
#ci-dessus:
#les chemins les plus courts partant du sommet d'origine
#V  | Dist | Path
#0->1| 4 | 01
#0->2| 6 | 012
#0->3| 9 | 013
#0->4| 13 | 0134

#Explication de la sortie ci dessus:

#par exemple pour 0->4 on obtient que la distance min est Dist=13 et le chemin optimal est
#donnÃ© par path=0134 c'est Ã  dire le chemin le plus court de quitter 0 pour aller Ã  4 est
#0134.


