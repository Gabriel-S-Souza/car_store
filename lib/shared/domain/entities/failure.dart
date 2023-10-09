class Failure implements Exception {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([String? message]) : super(message ?? 'Erro na comunicação com o servidor');
}

class BadRequestFailure extends Failure {
  const BadRequestFailure([String? message]) : super(message ?? 'Requisição inválida');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([String? message]) : super(message ?? 'Não encontrado');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([String? message]) : super(message ?? 'Não autorizado');
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure([String? message])
      : super(message ?? 'Você não tem permissão para acessar este recurso');
}

class OfflineFailure extends Failure {
  const OfflineFailure([String? message]) : super(message ?? 'Sem conexão com a internet');
}

class UnmappedFailure extends Failure {
  const UnmappedFailure([String? message]) : super(message ?? 'Ops, algo deu errado');
}
