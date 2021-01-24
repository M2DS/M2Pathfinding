# pathfinding
# Recherche du plus court chemin dans un graphe - Algorithme de Dijkstra & Bellman

## Description
Ce programme permet de déterminer le chemin le plus court entre deux noeuds grâce à l'algorithme de Dijkstra et Bellman . Il commence d'abord par calculer la distance de point de départ aux autres , puis affiche le plus court chemin.

Le package M2pathfinding contient deux algorithmes (path_function(qui contient l'algo de dijkstra),Bellmann) implementé en R et Rcpp.
Ces algorithmes prennent en parametres un graphe et retourne le plus court chemin. On sait que un graphe peut être representé à partir de sa matrice d'adjacence.


# Algorithme de Bellman Ford

L'algorithme de Bellman-Ford résout le problème des plus courts chemins avec origine unique
dans le cas le plus général où les poids des arcs peuvent avoir des valeurs négatives

# Algorithme de Dijkstra
Cet algorithme résout le problème du chemin le plus court d'un graphe orienté  dans lequel les poids des arcs sont positives.

Animation ci-dessous illustre le fonctionemenet de cet algorithme :

![Dijkstra_Animation](https://user-images.githubusercontent.com/75957755/104924965-76eed300-599e-11eb-9ab8-c849a5fa9b7e.gif)


## Complexités des deux Algorithmes:

L'algorithme de Bellmann est plus lent que l'algorithme de Dijkstra pour le même problème, mais plus polyvalent, car il est capable de gérer des graphiques dans lesquels certains des poids d'arête sont des nombres négatifs.
La compléxité de l'algorithme de Bellmann Ford est de O(|V|.|E|) où |V| et |E| sont respectivement le nombre de sommets et d'arêtes.

Pour l'algorithme de Dijkstra : Les limites du temps d'exécution de l'algorithme de Dijkstra sur un graphe avec des arêtes E et des sommets V peuvent être exprimées en fonction du nombre d'arêtes, noté{\ displaystyle | E |}| E |, et le nombre de sommets, noté {\ displaystyle | V |}| V |, en utilisant la notation big-O . La complexité liée dépend principalement de la structure de données utilisée pour représenter l'ensemble Q (ensemble de sommets) . Dans ce qui suit, les limites supérieures peuvent être simplifiées car{\ displaystyle | E |}| E | est {\ displaystyle \ Theta ($| V | ^ {2}$)}\ Thêta ($$| V | ^ {2}$$) pour n'importe quel graphe, mais cette simplification ne tient pas compte du fait que dans certains problèmes, d'autres limites supérieures sur {\ displaystyle | E |}| E | peut tenir.

Si le graphe est stocké sous forme de liste de contiguïté, le temps d'exécution d'un graphe dense (c'est-à-dire où $${\ displaystyle | E | \ in \ Theta (| V | ^ {2})}{\ displaystyle | E | \ in \ Theta (| V | ^ {2})})$$ est

{\ displaystyle \ Theta ((| V | ^ {2}) \ log | V |)}{\ displaystyle \ Theta ((| V | ^ {2}) \ log | V |)}.



