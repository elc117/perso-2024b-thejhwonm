# Identificação

- João Pedro Campos Perançoni.
- Ciência da Computação.

# Tema/Objetivo

- Comparativos de códigos.
- Exercícios que foram vistos em Haskell sendo vistos em Elixir.

# Processo de desenvolvimento

O tema abordado dos exercícios em Elixir foram testados em um ambiente online chamado [Replit](https://replit.com/~), sendo possível utilizar o interpretador IEX através do terminal.  
O iex será usado para verificar os resultados dos exercícios em Elixir, similar ao GHCI visto em Haskell.

### Alguns exercícios que foram simples de resolver usando o interpretador, apenas a sintáxe da linguagem é diferente
``` Haskell
Haskell
sqrt 4
# 2.0

Elixir
:math.sqrt(4)
# 2.0
```

``` Haskell
Haskell
min 16 8
# 8

Elixir
min(16, 8)
# 8
```

# Funções

Uma função não tipada em Haskell:
``` Haskell
f x = x + 4
f 3 
# 7
```
No Elixir, todas as funções precisam estar em módulos ou serem funções anônimas.  
Já conhecemos as funções anônimas, conhecidas em Haskell como funções Lambda mas o que são os módulos ?  

Módulos são estruturas que agrupam funções relacionadas, o que torna o código mais limpo e organizado. Módulos em Elixir seriam similares as classes em outras linguagens, porém sem estado e herança.  
No Elixir, os módulos criam namespace o que significa que é possível ter o mesmo nome em funções que são de módulos diferentes.

O código visto em Haskell acima, em Elixir funcionaria dessa forma no interpretador:
``` Elixir
defmodule Calc do
def f(x), do: x + 4
end
Calc.f(3) 
# 7
```
Para ser possível usar uma função definida em um módulo, devemos referenciar o módulo seguido pelo nome da função:  
**NomeMódulo.NomeFunção(argumentos)** é o mesmo que **Calc.f(3)** visto no código acima.  

Módulos são importantes em Elixir ao utilizar funções, já que a linguagem Elixir é uma linguagem com tipagem dinâmica diferente de Haskell, portanto ao escrever uma função não é possível declarar quais os tipos dos dados que a função vai receber e retornar conforme foi visto em Haskell.

# Funções anônimas
Funções anônimas em Elixir embora tenha a sintaxe diferente de Haskell, a finalidade é a mesma.
Segue um exemplo de função anônima vista no interpretador do Elixir, que soma + 4 ao argumento recebido:
``` Elixir
func = fn x -> x + 4 end

func.(3)

# 7
```

# Listas

Em Haskell as listas são homogênenas, isto é, tem um conjunto de dados do mesmo tipo e uma vez criadas não podem serem alteradas.  
As listas em Elixir também são imutáveis, mas o seu conjunto de dados pode ser diferente já que a linguagem é dinamicamente tipada.  

Exemplo de uma lista em Haskell:
``` Haskell
lista de inteiro [1, 2, 3]
lista de char    ['a', 'b', 'c']
lista de string  "abc"
```
Exemplo de uma lista em Elixir:
``` Elixir
lista [1 , ?a,  ?b, ?c, "abc"]
```
um caractere em elixir é representado como um átomo, o **?* é usado para obter o código Unicode do caractere.  
Nesse caso, ?a representa o caractere 'a'.

Ao utilizar a lista Lista1 [1, 2, 3, ?a] no interpretador iex do Elixr e usar o código List.last(Lista1) para retornar o último valor, podemos perceber que o valor retornado não é o 'a' e sim o valor unicode de 'a' que é 97.  
Portanto nesse caso precisa converter novamente para caractere.  
Outra forma seria utilizar o caractere como uma string "a" que é basicamente uma lista de caracteres contendo os unicodes.  

Quando queremos descobrir o primeiro elemento da lista podemos usar o método cabeça/cauda que também foi visto em Haskell durante as aulas.  
O código ficaria dessa forma:
``` Elixir
[h | tail] = [1 , 2, 3, "abc", 4]
# h 1
# tail 4
```
Basta apenas digitar h ou tail no interpretador que retornará o resultado.

# Funções de alta ordem map/filter

### Map
Funções de alta ordem em Elixir são um pouquinho diferente de Haskell.      
As funções de alta ordem em Elixir ficam dentro do módulo Enum que possui mais de 70 funções disponíveis para uso.  
A forma para aplicar as funções de Enum lembram um pouco a forma de acessar uma struct em C.  
Um exemplo seria Enum.map([x], y) onde y é aplicado em cada valor de x.  

O exemplo onde se é utilizado a função de alta ordem **map** em Haskell:
``` Haskell
funq x = x + 4
func 3
# 7
map func [1, 2, 3]
# [5,6,7]
```

Em Elixir você só tem acesso a função **map** de alta ordem se acessar o módulo Enum:
``` Elixir
funq = fn x -> x + 4 end
func.(3)
# 7
Enum.map([1, 2, 3], func))
# [5,6,7]
```

Outra forma é ter uma função dentro de um módulo e passar essa função como argumento para a função de alta ordem **map**.  
O exemplo ficaria:  
``` Elixir
defmodule func_map do
  def func(x), do: x + 4
end


Enum.map([1,2,3], &func_map.func/1)
# [5, 6, 7]
```

- **&** serve para  referenciar a função do módulo **func_map** em vez de chamar a função, serve para garantir que a função não será executada imediatamente.  
- **func** é o nome da função dentro do módulo func_map.  
- /1 significa que possui um argumento.

### Filter
Antes de usarmos filter, precisamos entender o que é o operador de pipeline |>.  
Em Elixir, o operador de pipeline permite encadear funções de maneira limpa e intuitiva. Ele pega o valor da expressão anterior e passa como primeiro argumento para a próxima função.   

Aqui está um código visto em Haskell durante as aulas:
``` Haskell
nospace c =   c /= ' '
filter nospace "ha ha"
# "haha"
```

O código em Elixir não é tão simples quando o visto em Haskell, pois o filter em Elixir não aceita uma lista de strings como argumento, listas de string são representadas internamente como listas de códigosde caracters Unicode.  
Nesse caso é necessário converter a lista de string para uma lista de caracteres e após aplicar o filter, precisa converter o resultado parta uma lista de string.  

Podemos usar String.to_charlist() para converter lista de string para lista de char.  
E podemos usar List.to_string() para converter lista de char para lista de string.

``` Elixir
nome = "Jo a o" |>
String.to_charlist() |>
Enum.filter(&RemoveSpace.nospace/1) |>
List.to_string()

# "Joao"
```

- A String "Jo a o" é passada como resultado para String.to_charlist() que converte a string em uma lista de caracteres.  
- Essa lista de caracteres é passada como argumento para Enum.filter() que aplica a função nospace que está dentro do módulo RemoveSpace para cada caractere da lista.
- O que retorna uma lista de caracteres após o uso do filter, e List.to_string() converte para uma string.

# Let, For, Where

### Let
Em Haskell, **let** é usado para definir varáveis locais em uma expressão. Já em Elixir, as variáveis são definidas diretamente com a sintaxe variável = valor, e o escopo depende de onde são declaradas.
Haskell:
``` Haskell
let x = 10 in x + 5
# 15
```
Elixir:
``` Elixir
x = 10
x + 5
# 15
```
Portanto em Elixir, basta declarar a variável.

### For
O For do Elixir nos permite iterar sobre coleções, gerar listas e até filtrar elementos, embora seja diferente do For conhecido como na linguagem C.  
Em Haskell não existe o For loop iterário como existe em C, mas existe as list comprehension, onde você descreve o que quer e não como fazer, onde uma lista resulta em outra.

For em Elixir:
``` Elixir
for x <- [1,2,3,4,5], x > 2, do: x * 2

# [6,8,10]
```
- o For está aplicando a operação x * 2 para cada elemento que atendeu à condição x > 2.
- Esses elementos se encontram dentro da lista [1,2,3,4,5]

### Where

Em Haskell, **where** permite definir funções auxiliares ou váriaveis locais que podem serem usadas dentro de uma função.  
Em Elixir, isso geralmente é feito através de fumções auxiliares privadas ou funções anônimas.  

Funções auxiliares privadas são funções acessíveis apenas dentro do módulo, onde foram definidas, e servem em auxiliação para outras funções dentro do módulo.  

Exemplo de código em Haskell:
``` Haskell
calcArea r = pi * quadrado r
  where quadrado x = x * x

square 3

# 28.274333882308138
```

Exemplo de código em Elixir:
``` Elixir
defmodule Circulo do
  def calc_area(r) do
    :math.pi() * potencia(r)
  end

  # função auxiliar privada
  defp potencia(x), do: x * x

end

Circulo.calc_area(3)

# 28.274333882308138
```
- Circulo.calc_area(3) -> Chamamos a função calc_area que está dentro do módulo Circulo com o valor 3 como argumento.
- O valor 3 é representado por r.
- Dentro da função calc_area,o valor de PI está vindo de :math.pi() que será multiplicado * com o valor de potencia(r).
- potencia(r) é uma função auxiliar privada, que está enviando o valor 3 representado por r para a função potencia.
- A função potencia(x), do: x * x está multiplicando o valor do argumento recebido por ele mesmo.
- Com isso a função calc_area é resolvida, valor de PI * (x * x)

# Resultado final

[Vídeo curto do código](https://www.youtube.com/watch?v=2DEo8-CuzGk)

# Referências e cŕeditos
[Por que Elixir ?](https://elixirbridge.org/02_Intro_to_Elixir/01-why-program-why-elixir.html)  
[Aprendendo Elixir](https://elixirbridge.org/02_Intro_to_Elixir/03-learning-elixir.html)                        
[Tipos de dados em Elixir](https://elixirbridge.org/02_Intro_to_Elixir/04-elixir-types.html)  
[Operadores e Variáveis](https://elixirbridge.org/02_Intro_to_Elixir/05-operators-and-variables.html)      
[Listas e Tuplas](https://elixirbridge.org/02_Intro_to_Elixir/05.5-anonymous-functions-lists-and-tuples.html)  
[Operador Pipeline/Tubulação 1](https://elixirbridge.org/02_Intro_to_Elixir/05.8-Pipe-Operator.html)  
[Operador Pipeline/Tubulação 2](https://elixirbridge.org/02_Intro_to_Elixir/07.5-Pipe-Operator.html)  
[Enumeráveis](https://elixirbridge.org/02_Intro_to_Elixir/05.9-enumerables.html)  
[Módulos](https://elixirbridge.org/02_Intro_to_Elixir/06.4-modules.html)  
[Funções](https://elixirbridge.org/02_Intro_to_Elixir/06.5_Functions.html)  
[Outros sites 1](https://elixirschool.com/en/lessons/misc/debugging)  
[Outros sites 2](https://inquisitivedeveloper.com/lwm-elixir-12/)  

