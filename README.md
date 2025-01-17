# GitHub API Sample App

[![GitHub license](https://img.shields.io/github/license/victorpereiradepaula/github-api-sample-app)](https://github.com/victorpereiradepaula/github-api-sample-app/blob/master/LICENSE)
[![Xcode 16.2+](https://img.shields.io/badge/Xcode-16.2%2B-blue.svg)](https://developer.apple.com/download/all/?q=Xcode%2016.2)
[![Swift 5+](https://img.shields.io/badge/Swift-5%2B-orange.svg)](https://www.swift.org/blog/swift-5-released/)
[![iOS 17.6+](https://img.shields.io/badge/iOS-17.6%2B-purple)](https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-17_6-release-notes)

Um projeto exemplo feito utilizando APIs do GitHub, UIKit (ViewCode), com arquitetura MVVM e testes unitários feitos com Quick/Nimble.

## Índice

1. [Setup do projeto](#setup-do-projeto)
1. [Funcionalidades](#funcionalidades)
1. [Dependências](#dependências)
1. [Exemplos](#exemplos)
1. [Referências](#referências)

## Setup do projeto

Para rodar o projeto é necessário instalar o Xcode e Cocoapods instalados na máquina, então basta rodar o comando abaixo:

```bash
pod install;open GitHubAPISampleApp.xcworkspace
```


## Funcionalidades

- [ ] Lista de repositórios mais populares de Swift
    - [ ] Paginação (scroll infinito)
    - [x] Informações do repositorio por item: nome, descrição, autor (nome/foto), número de estrelas e número de forks
    - [ ] Navegação do item para uma página com a lista de pull requests
- [ ] Lista de pull requests
    - [x] Informações do pull request por item: título, autor (nome/foto), data e body
    - [ ] Navegação (modal) do item para uma o url da pull request em webView

## Dependências

O gerenciador de dependências do projeto é o [Cocoapods](https://cocoapods.org).

- [Alamofire](https://github.com/Alamofire/Alamofire/tree/master)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Quick/Nimble](https://github.com/Quick/Quick)

## Exemplos

<!-- ![SAMPLE_NAME](SAMPLE_URL) -->

## Referências

- [API REST do GitHub](https://docs.github.com/pt/rest?apiVersion=2022-11-28)
- [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview)
- [WKNavigationDelegate](https://developer.apple.com/documentation/webkit/wknavigationdelegate)