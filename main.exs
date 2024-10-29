defmodule Calc do
  # função que soma um valor por ele mesmo
  def funq1(x), do: x + x

  # função que calcula a raiz quadrade de um valor
  def funq2(x), do: :math.sqrt(x)

  # função que adiciona + 4 no argumento recebido
  def funq3(x), do: x + 4
end

# função que remove espaços de um
defmodule RemoveSpace do

  def nospace(x) do
    x != ?\s
  end
  
end

# função que calcula a área do círculo
defmodule Circulo do
  def calc_area(r) do
    :math.pi() * potencia(r)
  end

  # função auxiliar privada
  defp potencia(x), do: x * x

end
