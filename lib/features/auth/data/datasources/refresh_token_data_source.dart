import '../../../../shared/domain/entities/result.dart';

abstract class RefreshTokenDataSource {
  Future<Result<VoidSuccess>> get();
}
