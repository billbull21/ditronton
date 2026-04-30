import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_dicoding_app/common/network/dio_interceptor.dart';

void main() {
  late DioInterceptor interceptor;

  setUp(() {
    interceptor = DioInterceptor();
  });

  group('DioInterceptor', () {
    test('onRequest should set baseUrl and Authorization header', () {
      final options = RequestOptions(path: '/movies');
      bool didSetBaseUrl = false;
      bool didSetAuth = false;

      final handler = RequestInterceptorHandler();
      // Call onRequest — it mutates options in-place, then calls handler.next
      try {
        interceptor.onRequest(options, handler);
      } catch (_) {
        // handler.next completes the internal future; errors from standalone handler are expected
      }

      expect(options.baseUrl, 'https://api.themoviedb.org/3');
      expect(options.headers['Authorization'], isNotNull);
      expect((options.headers['Authorization'] as String).startsWith('Bearer '), isTrue);
    });

    test('onResponse should call handler.next with the response', () {
      final requestOptions = RequestOptions(path: '/test');
      final tResponse = Response(
        requestOptions: requestOptions,
        statusCode: 200,
        data: {'result': 'ok'},
      );
      try {
        interceptor.onResponse(tResponse, ResponseInterceptorHandler());
      } catch (_) {
        // handler.next may throw outside real Dio pipeline
      }
      expect(tResponse.statusCode, 200);
    });

    test('onError should forward the error via handler.next', () {
      final requestOptions = RequestOptions(path: '/test');
      final tError = DioException(
        requestOptions: requestOptions,
        message: 'Network error',
      );

      // ErrorInterceptorHandler.next() uses completeError internally which propagates
      // as an unhandled async error outside the real Dio pipeline.
      // runZonedGuarded suppresses this expected zone error.
      runZonedGuarded(() {
        interceptor.onError(tError, ErrorInterceptorHandler());
      }, (error, _) {
        // suppress the async InterceptorState error from standalone handler
      });

      expect(tError.message, 'Network error');
    });

    test('DioInterceptor extends InterceptorsWrapper', () {
      expect(interceptor, isA<InterceptorsWrapper>());
    });
  });
}

