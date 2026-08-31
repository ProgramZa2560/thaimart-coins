import '../../../../core/constants.dart';
import '../../domain/repositories/coin_repository.dart';
import '../api/coin_api_client.dart';
import '../models/coin.dart';

class CoinRepositoryImpl implements CoinRepository {
  CoinRepositoryImpl(this._client);

  final CoinApiClient _client;

  @override
  Future<List<Coin>> getCoins({required int offset, int limit = AppConstants.pageSize}) {
    return _client.getCoins(limit: limit, offset: offset);
  }

  @override
  Future<List<Coin>> searchCoins({
    required String keyword,
    required int offset,
    int limit = AppConstants.pageSize,
  }) {
    return _client.searchCoins(keyword: keyword, limit: limit, offset: offset);
  }

  @override
  Future<Coin> getCoin(String uuid) {
    return _client.getCoin(uuid);
  }
}
