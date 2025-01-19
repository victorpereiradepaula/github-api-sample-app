# GitHub API Sample App

[![GitHub license](https://img.shields.io/github/license/victorpereiradepaula/github-api-sample-app)](https://github.com/victorpereiradepaula/github-api-sample-app/blob/master/LICENSE)
[![Xcode 16.2+](https://img.shields.io/badge/Xcode-16.2%2B-blue.svg)](https://developer.apple.com/download/all/?q=Xcode%2016.2)
[![Swift 5+](https://img.shields.io/badge/Swift-5%2B-orange.svg)](https://www.swift.org/blog/swift-5-released/)
[![iOS 17.6+](https://img.shields.io/badge/iOS-17.6%2B-purple)](https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-17_6-release-notes)

Um projeto exemplo feito utilizando APIs do GitHub, UIKit (ViewCode), com arquitetura MVVM e testes unitários feitos com Quick/Nimble.

## Índice

1. [Setup do projeto](#setup-do-projeto)
1. [Funcionalidades](#funcionalidades)
1. [Arquitetura](#arquitetura)
    - [Organização das pastas projeto](#organização-das-pastas-projeto)
1. [Dependências](#dependências)
1. [Exemplos](#exemplos)
1. [Referências](#referências)

## Setup do projeto

Para rodar o projeto é necessário ter o Xcode e Cocoapods instalados na máquina, então basta rodar o comando abaixo:

```bash
pod install
open GitHubAPISampleApp.xcworkspace
```

## Funcionalidades

- [x] Lista de repositórios mais populares de Swift
    - [x] Paginação (scroll infinito)
    - [x] Informações do repositorio por item: nome, descrição, autor (nome/foto), número de estrelas e número de forks
    - [x] Navegação do item para uma página com a lista de pull requests
- [x] Lista de pull requests
    - [x] Informações do pull request por item: título, autor (nome/foto), data e body
    - [x] Navegação (modal) do item para uma o url da pull request em WebView
- [x] Controle de estados das features
- [ ] Testes unitários ViewModels
- [ ] Testes de snapshot dos componentes
- [ ] Acessibilidade dos componentes (VoiceOver)

## Arquitetura

O projeto é implementado em **MVVM** (Model-View-ViewModel),arquitetura que permite a divisão das responsabilidades da seguinte forma:

**Model** é a camada responsável pelos objetos de dados que serão utilizados nas demais camadas, nesta implementação, devido à simplicidade do projeto, os modelos utilizados pela ViewModel e View são os mesmos.

**View** é a camada responsável pela interface do usuário, como neste projeto não foi definido um padrão mais robusto de gerenciamento de navegação então a camada de View tem esta responsabilidade adicional.

**ViewModel** é a camada responsável pelas regras de negócio da aplicação, os dados que serão exibidos na camada de View são tratados nessa camada, ela também recebe as ações da View e executa as ações necessárias, gerencia estados de erro e loading da View, e é a camada que recebe maior atenção quanto aos testes unitários.

### Organização das pastas projeto

**Features** - pasta possui subpasta para cada feature com sua respectiva ViewController, ViewModel e componentes visuais referentes apenas à essa feature.

**Model** - pasta que contém os modelos de dados utilizados no projeto, estes não ficam dentro das pastas das features por algumas vezes serem reutilizados por outros modelos ou funcionalidades.

**View** - pasta que possui as subpastas **Components** que possui componentes visuais da aplicação e **Utils** que possui extensions e outros blocos de código reaproveitáveis dentro do escopo de view.

## Dependências

O gerenciador de dependências do projeto é o [Cocoapods](https://cocoapods.org).

As dependências utilizadas foram escolhidas por atenderem os requisitos: familiarida por usos em projetos anteriores, repositório ativo, ampla utilzação pela comunidade (estrelas, forks, citações em canais sobre desenvolvimento iOS consolidados), boa documentação e simplicidade de utilizar.

- [Alamofire](https://github.com/Alamofire/Alamofire/tree/master)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Quick/Nimble](https://github.com/Quick/Quick)

## Exemplos

<!-- ![SAMPLE_NAME](SAMPLE_URL) -->

## Referências

- [API REST do GitHub](https://docs.github.com/pt/rest?apiVersion=2022-11-28)
- [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview)
- [WKNavigationDelegate](https://developer.apple.com/documentation/webkit/wknavigationdelegate)