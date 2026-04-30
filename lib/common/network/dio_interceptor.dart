import 'package:dio/dio.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err); // just forward the original error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = "https://api.themoviedb.org/3";
    options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ODY2MmNlYTkzM2I1NWUwNDgwYTVkNGQ3NmVmN2ZiYiIsIm5iZiI6MTU2MjEwNTM3Ny44NzYsInN1YiI6IjVkMWJkNjIxNTMyYWNiNGFlMGNkM2FjNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.O7WIi7ZVYt8EUwOWwqgNwJMStAunz6ZQMloP6hi154I';

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
