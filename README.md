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
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/5ce05a17-a722-4d62-930e-f52d90203311" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/da9a8de5-978c-4e88-9edf-8c4558e88a26" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/21ff4aec-f494-4c2a-be53-19d6f72b3f57" height="420" />
</div>
</br>
<div style="display: flex; justify-content: center;">
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/75bb0ead-1f08-412d-9f8f-aa0c81eb8f46" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/29412a2a-7169-412e-9b86-026dd708b007" height="420" />
  <img src="https://github.com/Gabriel-S-Souza/car_store/assets/94877176/2dbebdd4-ba35-4033-8bf5-1ae9b570009a" height="420" />
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
