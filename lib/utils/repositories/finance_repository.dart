import 'package:arcopen_enquirer/http/exceptions/request_exception.dart';
import 'package:arcopen_enquirer/http/responses/download_invoice_response.dart';
import 'package:arcopen_enquirer/http/responses/finance_response.dart';
import 'package:arcopen_enquirer/utils/repositories/base_repository.dart';
import 'package:dio/dio.dart';

class FinanceRepository extends BaseRepository {
  Future<FinanceResponse> loadFinances() async {
    try {
      Response response = await client.get(path: "/finances/");
      return FinanceResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<DownloadInvoiceResponse> downloadInvoice(int transactionId) async {
    try {
      Response response = await client.get(path: "/jobs/api/downloadInvoice/$transactionId/");
      return DownloadInvoiceResponse.fromJson(response.data);
    } on DioError catch(e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }
}
