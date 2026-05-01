import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_dicoding_app/common/network/dio_client.dart';

import 'dio_client_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late DioClient dioClient;

  setUp(() {
    mockDio = MockDio();
    // isUnittest=true skips adding interceptors, allowing clean unit testing
    dioClient = DioClient(dio: mockDio, isUnittest: true);
  });

  group('DioClient', () {
    test('constructor with isUnittest=false should add DioInterceptor', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Using a real Dio so interceptors.add works correctly
      final realDio = Dio();
      final client = DioClient(dio: realDio, isUnittest: false);
      expect(client, isA<DioClient>());
      expect(realDio.interceptors.length, greaterThan(0));
    });

    test('get should call dio.get with path and queryParameters', () async {
      final tResponse = Response(
        requestOptions: RequestOptions(path: '/test'),
        statusCode: 200,
        data: {'result': 'success'},
      );
      when(mockDio.get('/test', queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => tResponse);

      final result = await dioClient.get('/test', queryParameters: {'key': 'value'});

      expect(result.statusCode, 200);
      verify(mockDio.get('/test', queryParameters: {'key': 'value'})).called(1);
    });

    test('get should call dio.get without queryParameters when null', () async {
      final tResponse = Response(
        requestOptions: RequestOptions(path: '/test'),
        statusCode: 200,
        data: {},
      );
      when(mockDio.get('/test', queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => tResponse);

      final result = await dioClient.get('/test');

      expect(result.statusCode, 200);
    });

    test('post should call dio.post with path and data', () async {
      final tResponse = Response(
        requestOptions: RequestOptions(path: '/test'),
        statusCode: 201,
        data: {'id': 1},
      );
      when(mockDio.post('/test', data: anyNamed('data')))
          .thenAnswer((_) async => tResponse);

      final result = await dioClient.post('/test', data: {'name': 'test'});

      expect(result.statusCode, 201);
      verify(mockDio.post('/test', data: {'name': 'test'})).called(1);
    });

    test('put should call dio.put with path and data', () async {
      final tResponse = Response(
        requestOptions: RequestOptions(path: '/test/1'),
        statusCode: 200,
        data: {'updated': true},
      );
      when(mockDio.put('/test/1', data: anyNamed('data')))
          .thenAnswer((_) async => tResponse);

      final result = await dioClient.put('/test/1', data: {'name': 'updated'});

      expect(result.statusCode, 200);
      verify(mockDio.put('/test/1', data: {'name': 'updated'})).called(1);
    });

    test('delete should call dio.delete with path and data', () async {
      final tResponse = Response(
        requestOptions: RequestOptions(path: '/test/1'),
        statusCode: 204,
        data: null,
      );
      when(mockDio.delete('/test/1', data: anyNamed('data')))
          .thenAnswer((_) async => tResponse);

      final result = await dioClient.delete('/test/1');

      expect(result.statusCode, 204);
      verify(mockDio.delete('/test/1', data: null)).called(1);
    });
  });
}
