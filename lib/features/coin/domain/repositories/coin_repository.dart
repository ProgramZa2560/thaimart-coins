import '../../data/models/coin.dart';

abstract class CoinRepository {
  Future<List<Coin>> getCoins({required int offset, int limit});
  Future<List<Coin>> searchCoins({
    required String keyword,
    required int offset,
    int limit,
  });
  Future<Coin> getCoin(String uuid);
}
