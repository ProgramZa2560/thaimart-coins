import 'package:dio/dio.dart';

import '../../../../core/constants.dart';
import '../models/coin.dart';

class CoinApiClient {
  CoinApiClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
          ),
        );

  final Dio _dio;

  Future<List<Coin>> getCoins({required int limit, required int offset}) async {
    final data = await _get('/coins', query: {
      'limit': limit,
      'offset': offset,
    });
    return _parseCoins(data);
  }

  Future<List<Coin>> searchCoins({
    required String keyword,
    required int limit,
    required int offset,
  }) async {
    final data = await _get('/coins', query: {
      'search': keyword,
      'limit': limit,
      'offset': offset,
    });
    return _parseCoins(data);
  }

  Future<Coin> getCoin(String uuid) async {
    final data = await _get('/coin/$uuid');
    return Coin.fromJson(data['coin'] as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: query,
      options: Options(headers: _headers),
    );
    final body = response.data;
    if (body == null || body['status'] != 'success') {
      throw DioException(
        requestOptions: response.requestOptions,
        message: body?['status']?.toString() ?? 'Request failed',
      );
    }
    return (body['data'] as Map).cast<String, dynamic>();
  }

  Map<String, String> get _headers {
    const apiKey = String.fromEnvironment('COINRANKING_API_KEY');
    if (apiKey.isEmpty) return const {};
    return {'x-access-token': apiKey};
  }

  List<Coin> _parseCoins(Map<String, dynamic> data) {
    final coins = (data['coins'] as List?) ?? const [];
    return coins
        .whereType<Map>()
        .map((e) => Coin.fromJson(e.cast<String, dynamic>()))
        .toList();
  }
}
