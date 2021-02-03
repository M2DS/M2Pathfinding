
#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]

void bellman_ford(NumericMatrix edges,int vertex_source)
{
  int n;
  n=edges.ncol();
  NumericVector dis(n);
  
  for (int i=0; i<n; i++){
    dis[i]= INT_MAX;
  }
  
  
  /* Initialisation des distances Ã  l'infini */
  for(int k=0;k<n;k++)
  {
    dis[k]=INT_MAX;
    
  }
  dis[vertex_source]=0;
  
  /* relaxation de l'algorithme en rÃ©pÃ©tant l'actualisation des distances n-1 fois */
  for(int k=0;k<n-1;k++){
    
    for(int i=0;i<n;i++)
    {
      for(int j=0;j<n;j++)
      {
        if(edges(i,j) !=0 && dis[i] != INT_MAX && dis[i]+edges(i,j) < dis[j] )
        {
          dis[j]=dis[i]+edges(i,j);
        }  
      }
    }
  }
  
  
  
  /* vÃ©rification de l'existance d'un cycle nÃ©gatif */
  for(int i=0;i<n;i++)
  {
    for(int j=0;j<n;j++)
    {
      if(edges(i,j) !=0 && dis[i]+edges(i,j) < dis[j])
      {
        Rcout<<"\n\nle graphe contient un cycle de poids nÃ©gatif, l'algo de Bellman n'est pas adaptÃ© Ã  votre problÃ¨me!!\n";
        return;
      }
    }
  }
  //Rcout<<"\nVertex"<<"  Distance from source";
  //for(int i=0;i<n;i++)
  //{
    //Rcout<<"\n"<<i<<"\t"<<dis[i];
  //}
  
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
library(Rcpp)
  timesTwo(42)
  edges <- matrix(data = c(0,4,0,5,0,0,0,0,0,-10,0,0,0,0,3,0),4,4,byrow = TRUE)
  edges2 <- matrix(data = c(0,4,0,5,0,0,0,5,0,-10,0,0,0,0,3,0),4,4,byrow = TRUE)
  
#print(edges)
bellman_ford(edges, 0)
#to_edges(edges)
  */
