import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:version_poc/features/posts/post.dart';
import 'package:version_poc/features/settings/version.dart';
import 'package:version_poc/features/settings/version_notifier.dart';
import 'package:version_poc/features/weather/weather.dart';

part 'api_client.g.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) {
    final selectedVersion = ref.watch(versionNotifierProvider);
    return ApiClient(
      ref.watch(
        dioProvider(selectedVersion.baseUrl),
      ),
    );
  },
);

final dioProvider = Provider.family<Dio, String>((ref, baseUrl) {
  final preferredVersion = ref.watch(versionNotifierProvider);
  final dio = Dio(
    BaseOptions(baseUrl: baseUrl),
  );
  dio.interceptors.addAll(switch (preferredVersion) {
    Version.version1 => [],
    _ => [TokenInterceptor()],
  });
  return dio;
});

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET('/posts')
  Future<List<Post>> getPosts();

  @GET('/weather')
  Future<Weather> getWeatherFor({
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
  });
}

class TokenInterceptor extends QueuedInterceptor {
  static const _apiKey = '02ad86b286e775fce7ec210cf3ecf65e';
  TokenInterceptor();

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.addEntries(
      [],
    );
    options.queryParameters.addEntries([
      const MapEntry<String, String>('appid', _apiKey),
    ]);
    super.onRequest(options, handler);
  }
}
