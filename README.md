# Car Store App

O Car Store é um aplicativo Flutter para listar e gerenciar veículos em uma loja.

## Funcionalidades

- Login e cadastro de usuários
- Listagem de veículos
- Detalhes do veículo
- Adição de novo veículo
- Edição de veículo existente
- Exclusão de veículo

## Capturas de Tela

</br>
<div style="display: flex; justify-content: center;">
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/8f53f52a-f5a1-4a2b-96e7-4e7e11167a22" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/083f43ea-f7c1-4fd4-8d4e-bef409bb50fa" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/0a7c38cd-328b-4558-ac64-cc5e6b3e4456" height="420" />
</div>
</br>
<div style="display: flex; justify-content: center;">
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/6d720ebd-faf6-465c-bc96-8ed63306ff83" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/4bed6606-ad02-4797-922f-36d1c6e42d11" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/7bee1bd1-3a22-4f46-9c62-e0f0b46c6e8f" height="420" />
</div>
</br>

## Algumas Tecnologias Utilizadas

- Flutter
- Dart
- flutter_bloc
- Dio
- Go router

### Técnicas
- Arquitetura:
   - O projeto segue **Clean Architecture** (baseado na proposta da [**Resocoder**](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/)) que enfatiza a separação de responsabilidades em camadas.
   - Adota também o padrão de organização [**Feature First**](https://codewithandrea.com/articles/flutter-project-structure/), que prioriza a estruturação do projeto em torno das funcionalidades, facilitando a manutenção e melhorando a organização.
- Testes unitários:
  - Os testes seguem o pattern **Arrange, Act, Assert**
  - Para mocks foi utilizado [**Mockito**](https://pub.dev/packages/mockito)
  - **OBS**: devido ao tempo foi implementado o teste apenas do caso de uso de login
- Autenticação com JWT
- Caching com Decorator Pattern para listagem das imagens
- Princípios SOLID
- Injeção de Dependência
- Service Locator
- Factory Methods
- Singleton
- State Management

### Como Executar
O projeto requer que a Car Store Api esteja executando na sua rede. Siga os passos para executar a api em https://github.com/Gabriel-S-Souza/car_store_api.

A versão do Flutter utilizada no projeto foi a 3.13.5.
Clone este repositório para o seu ambiente de desenvolvimento:
```
git clone https://github.com/Gabriel-S-Souza/clock_in_it.git
```

Abra o projeto em um editor de código e baixe as dependências:

```
flutter pub get
```

Caso esteja executando a api co o docker compose up, substitua o argumento "API_URL" do arquivo ```env.json``` com o ip correto em que a api está executando na sua rede.

```
{
    "API_URL": "http://192.168.1.3:3000"
}
```

Selecione um dispositivo android ou ios ou selecione o chrome para a versão web. E então execute o app passando a seguinte flag.

```
flutter run --dart-define-from-file=env.json
```
