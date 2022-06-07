class KNN:
    '''A classe KNN cria um objeto do tipo classificador KNN.
    Entradas
    Lista de dados categorizados: [[dado1],[dado2], [dado3], ..., [dadon]]
    Lista de dados a categorizar: [[dado1],[dado2], [dado3], ..., [dadon]]
    Métodos disponíveis:
    .info_categorizados(pc): (pc=posição das categorias) retorna um dicionário dos dados categorizados : categoria:frequência
    .distancia(a, b): retorna a distância entre dois pontos de qualquer dimensão (entrada: duas tuplas ou listas 'a' e 'b')
    .kvizinhos(lista_distancias, k): ordena uma lista de distâncias [categoria, distancia] e retorna os 'k' primeiros itens 
    .classifica(pid, kvizinhos): classifica um item 'acategorizar' (pid=posição do identificador) com base em seus k-vizinhos 
    '''
    def __init__(self, categorizados, acategorizar):
        self.categorizados = categorizados  # Conjunto de dados categorizados
        self.acategorizar = acategorizar    # Conjunto de dados a categorizar
        self.classificados = {}             # Dicionário para armazenar o resultado da classificação KNN
    
    def info_categorizados(self, pc):
        '''O método 'info_categorizados' retorna um resumos dos dados categorizados
        Entrada: pc: a posição das categorias na lista
        Saída: dicionário 'categorias' contendo 'nome da categoria':valor (quantidade de dados dessa categoria)
        '''
        self.pc = pc
        self.categorias = {} # Cria um dicionário para armezar as categorias
        for item in self.categorizados:
            if item[self.pc] not in self.categorias: # Para uma categoria ainda não listada
                self.categorias[item[self.pc]] = 1   # Adiciona o primeiro item no dicionário com valor 1
            else:                                    # Para uma categoria já adicionada, incremente seu valor
                self.categorias[item[self.pc]] += 1
        return print('Resumo dos dados já categorizados:', self.categorias)
    
    def distancia(self, a, b):
        '''O método 'distância' retorna a distância euclidiana entre dois pontos 'a' e 'b' de dimensão n
        Entradas: duas tuplas ou lista de valores 'a' e 'b'
        Saída: distância euclidiana entre os pontos 'a' e 'b'
        '''       
        return sum([(a[i] - b[i])**2 for i in range(len(a))])**0.5
    
    def kvizinhos(self, lista_distancias, k):
        '''O método 'kvizinhos' ordena uma lista de distâncias e retorna os k vizinhos
        Entradas: 
        lista_distancias: contendo 'categoria, distância' de cada ponto do conjunto 'categorizado' ao item 'acategorizar'
        k: valor de kvizinhos desejado
        Saída: lista de k vizinhos
        '''
        self.k = k
        distancias_ordenadas = sorted(lista_distancias, key=lambda lista_distancias:lista_distancias[1]) # Ordena a lista do menor ao maior
        kvizinhos = distancias_ordenadas[0:self.k:1] # Seleciona os k primeiros itens 
        return kvizinhos
    
    def classifica(self, pid, kvizinhos):
        '''O método 'classifica' classifica um item 'acategorizar' com base em seus k vizinhos
        Entradas
        pid: posição do identificador do dado a 'acategorizar'
        kvizinhos: lista de kvizinhos
        Saída (interna): dicionário self.classificados é atualizado (chave: id do item, valor: categoria do item) 
        '''
        self.pid = pid
        rotulos = {} # Dicionário para armazenar o rótulo das categorizas vizinhas e suas frequencias
        for item in kvizinhos:
            if item[0] not in rotulos:  # Para cada rótulo de categoria em 'kvizinhos' ainda não listado
                rotulos[item[0]] = 1    # Adicionar ao dicionário e atribuir o valor 1
            else:                       # Para cada rótulo de categoria em 'kvizinhos' já adicionado ao dicionário
                rotulos[item[0]] += 1   # Incrementar seu valor em 1
        
        rotulo = max(rotulos, key=lambda key: rotulos[key])    # Retorna a chave com maior valor (categoria mais frequente)
        self.classificados[self.pid] = rotulo # dicionário self.classificado é atualizado com id do item e sua categoria