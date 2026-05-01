import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dio_interceptor.dart';

class DioClient {
  final Dio _dio;
  final bool _isUnittest;
  Future<void>? _sslInitialization;

  DioClient({required Dio dio, bool isUnittest = false}) : _dio = dio, _isUnittest = isUnittest {
    if (!isUnittest) _dio.interceptors.add(DioInterceptor());
    if (!isUnittest && kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => log(obj.toString(), name: 'API'),
        ),
      );
    }

    if (!isUnittest) {
      _sslInitialization = _configureSslPinning();
    }
  }

  Future<void> _configureSslPinning() async {
    final sslCert = await rootBundle.load('assets/cert/themoviedb.org.pem');

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final context = SecurityContext(withTrustedRoots: false)
          ..setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

        return HttpClient(context: context);
      },
    );
  }

  Future<void> _ensureInitialized() async {
    if (_isUnittest) return;
    _sslInitialization ??= _configureSslPinning();
    await _sslInitialization;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    await _ensureInitialized();
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    await _ensureInitialized();
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    await _ensureInitialized();
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    await _ensureInitialized();
    return _dio.delete(path, data: data);
  }
}
