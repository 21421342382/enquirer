import 'package:arcopen_enquirer/http/exceptions/request_exception.dart';
import 'package:arcopen_enquirer/http/requests/billing_request.dart';
import 'package:arcopen_enquirer/http/responses/stripe_response.dart';
import 'package:arcopen_enquirer/utils/repositories/base_repository.dart';
import 'package:dio/dio.dart';

class BillingRepository extends BaseRepository {
  Future<StripeResponse> stripePayment(int id) async {
    try {
      final Response response = await client.get(path: "/jobs/api/fundDetailsSession/$id/");
      return StripeResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<void> cardPayment({required BillingRequest request}) async {
    try {
      await client.post(path: "/jobs/api/cardJobFunding/", args: request.toJson());
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }
}
