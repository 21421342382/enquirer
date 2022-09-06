import 'dart:io';

import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/http/network/clients/network_client.dart';
import 'package:arcopen_enquirer/utils/helpers/k_storage.dart';
import 'package:arcopen_enquirer/utils/mixins/logging_mixin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient with LoggingMixin implements NetworkClient {
  static final DioClient _singleton = DioClient._internal(dotenv.env["ENDPOINT"]!);
  final String baseUrl;

  factory DioClient() {
    return _singleton;
  }

  late Dio _dio;
  DioClient._internal(this.baseUrl) : super() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );

    this.addCookieInterceptor();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final String? accessToken = KStorage.read(key: AppConstants.accessTokenKey);
          if (accessToken != null) {
            options.headers.addAll({"Authorization": "Bearer $accessToken"});
          }
          options.headers.addAll({
            "Accept-Encoding": "gzip, deflate, br",
            "Accept": "application/json",
            "User-Agent": "EnquirerApp",
            "Connection": "keep-alive",
          });

          return handler.next(options);
        },
        onError: (e, handler) {
          logger.e({
            "type": "Error",
            "message": e.message,
            "data": e.response?.data,
          });
          return handler.next(e);
        },
      ),
    );

    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<void> addCookieInterceptor() async {
    var cookieJar = PersistCookieJar(
      persistSession: true,
      storage: FileStorage("${await _localPath}/${await _localCoookieDirectory}"),
    );
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Directory> get _localCoookieDirectory async {
    final path = await _localPath;
    final Directory dir = new Directory('$path/cookies');
    await dir.create();
    return dir;
  }

  @override
  Future<Response> delete({required String path}) {
    return _dio.delete(path);
  }

  @override
  Future get({required String path, args}) {
    return _dio.get(path);
  }

  @override
  Future post({required String path, args}) {
    return _dio.post(path, data: args);
  }

  @override
  Future put({required String path, args}) {
    return _dio.put(path, data: args);
  }
}
