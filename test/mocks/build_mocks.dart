import 'package:car_store/features/auth/domain/repositories/login_repository.dart';
import 'package:car_store/features/vehicle_store/domain/repositories/vehicle_reader_repository.dart';
import 'package:car_store/features/vehicle_store/domain/repositories/vehicle_writer_repositoty.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AuthRepository,
  VehicleReaderRepository,
  VehicleWriterRepository,
])
void main() {}
