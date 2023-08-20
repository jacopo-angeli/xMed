import '../../data/models/clinic_details/clinic_details_request_dto.dart';
import '../entitites/clinic_entity.dart';

abstract class ClinicRepository {
  /// Recupero delle informazioni grafiche della clinica
  Future<ClinicEntity> getDetails(ClinicDetailsRequestDto requestBody);
}
