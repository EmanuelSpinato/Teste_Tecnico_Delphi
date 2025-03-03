
# Descrição do Desafio

Este desafio consiste em criar uma aplicação Delphi para implementar um sistema simples de gestão de pedidos para uma loja. A aplicação permite o cadastro de produtos, clientes, a criação de pedidos e a geração de um relatório básico com o total de vendas por cliente. O sistema foi desenvolvido utilizando o Delphi 12, com banco de dados Firebird 5.0.

## Funcionalidades

### 1. Cadastro de Produtos:
- Cada produto pode ser cadastrado com nome, preço unitário e quantidade em estoque.
- Foi implementada uma interface intuitiva que permite a inserção, edição e exclusão de produtos.
- Validação para garantir que a quantidade em estoque seja suficiente ao adicionar itens ao pedido.

### 2. Cadastro de Clientes:
- Os clientes podem ser cadastrados com nome, CPF/CNPJ, endereço, e-mail, telefone e outros dados.
- A aplicação inclui uma validação básica do CPF/CNPJ, garantindo que os dados estejam no formato correto.

### 3. Cadastro de Pedidos:
- O sistema permite a criação de pedidos vinculados aos clientes cadastrados.
- Cada pedido contém a data, o cliente e a lista de produtos com a quantidade e o preço unitário.
- O total do pedido é calculado automaticamente a partir dos itens adicionados.

### 4. Relatório de Vendas:
- O sistema gera um relatório que mostra o total de vendas por cliente, incluindo:
  - Nome do cliente
  - Quantidade total de pedidos
  - Valor total gasto

## Requisitos Técnicos

### Banco de Dados:
- O banco de dados utilizado foi o Firebird 5.0.
- O login de acesso padrão do Firebird é:
  - **Usuário (Username): SYSDBA**
  - **Senha (Password): masterkey**
- O sistema usa as tabelas necessárias para armazenar os dados de produtos, clientes, pedidos e itens de pedidos.
- Um script SQL de criação do banco de dados está disponível na pasta 'BD'.

### Orientação a Objetos:
- O sistema foi desenvolvido utilizando conceitos de orientação a objetos, garantindo uma estrutura modular e de fácil manutenção.
- Foi implementado o padrão de projeto **Repository** para o gerenciamento de dados, centralizando as operações de acesso ao banco de dados e melhorando a escalabilidade.

## Interface do Usuário:
- A interface foi desenvolvida com o framework VCL do Delphi, garantindo uma experiência simples e eficiente para o usuário final.
- O sistema possui telas para cadastro de produtos, clientes, pedidos, e para geração do relatório de vendas.

## Outros Detalhes:
- O sistema inclui validações básicas nos campos obrigatórios e na formatação de CPF/CNPJ.
- Foram implementadas mensagens de erro amigáveis ao usuário, garantindo uma boa experiência ao lidar com dados inválidos ou incorretos.
- O projeto é funcional e livre de erros.

## Acesso ao Sistema:
- **Login no sistema:**
  - **Usuário: adm
  - **Senha: 123

## Instruções para Acessar o Banco de Dados:
- As instruções para configuração e acesso ao banco de dados Firebird estão disponíveis na pasta 'BD'.

