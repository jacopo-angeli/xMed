import 'package:dio/dio.dart';
import 'package:xmed/constants/constants.dart';
import 'package:xmed/data/dtos/clinic_details/request/clinic_details_request.dart';
import 'package:xmed/data/dtos/clinic_details/response/clinic_details_response.dart';
import 'package:xmed/data/http_client.dart';

class ClinicRepository {
  void getClinicaDetails({required clinicID}) async {
    final requestBody =
        ClinicDetailsRequest(clinicID: clinicID, institute: "2272").toJson();

    print(requestBody);
    final httpClient =
        await XMedTabletHttpClient.builder().setRequestBody(requestBody);

    final Response<dynamic> response =
        await httpClient.post(Endpoints.clinicDetailsEndPoint);

    print(response.statusCode);

    late ClinicDetailsResponse data;
    try {
      data = ClinicDetailsResponse.fromJson(response.data);
      print("data : ");
      print(data);
    } on Exception catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
      return;
    }
  }
}
