calcular_muestra_finita <- function(N,z=1.96,p=0.5,q=0.5,e=0.05){
  resultado <- (
                N/(
                  1+(
                      ((e^2)*(N-1))
                      /((z^2)*(p*q))
                    )
                  )
                )
  
  return(resultado)
} 

calcular_muestra_infinita <- function(z=1.96,p=0.5,q=0.5,e=0.05) {
  resultado <- (
    (z^2*p*q)/e^2
  )
  
  return(resultado)
}


