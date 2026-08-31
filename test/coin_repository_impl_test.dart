import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:coinmarket/features/coin/data/api/coin_api_client.dart';
import 'package:coinmarket/features/coin/data/models/coin.dart';
import 'package:coinmarket/features/coin/data/repositories/coin_repository_impl.dart';
import 'package:coinmarket/features/coin/domain/repositories/coin_repository.dart';

class _MockCoinApiClient extends Mock implements CoinApiClient {}

Coin _coin(String uuid, {int rank = 1}) {
  return Coin(
    uuid: uuid,
    symbol: uuid,
    name: 'Coin $uuid',
    iconUrl: 'https://example.com/$uuid.png',
    price: rank * 100,
    change: rank * 1.0,
    marketCap: rank * 1000000000,
    description: 'Description $uuid',
    websiteUrl: 'https://example.com',
  );
}

void main() {
  late _MockCoinApiClient client;
  late CoinRepository repository;

  setUp(() {
    client = _MockCoinApiClient();
    repository = CoinRepositoryImpl(client);
  });

  group('CoinRepositoryImpl', () {
    test('getCoins passes limit and offset to client', () async {
      final coins = [_coin('BTC'), _coin('ETH')];
      when(() => client.getCoins(limit: 10, offset: 20))
          .thenAnswer((_) async => coins);

      final result = await repository.getCoins(offset: 20);

      expect(result, coins);
      verify(() => client.getCoins(limit: 10, offset: 20)).called(1);
    });

    test('searchCoins passes keyword, limit and offset to client', () async {
      final coins = [_coin('BTC')];
      when(() => client.searchCoins(
            keyword: 'bitcoin',
            limit: 10,
            offset: 10,
          )).thenAnswer((_) async => coins);

      final result = await repository.searchCoins(
        keyword: 'bitcoin',
        offset: 10,
      );

      expect(result, coins);
      verify(() => client.searchCoins(
            keyword: 'bitcoin',
            limit: 10,
            offset: 10,
          )).called(1);
    });

    test('getCoin delegates to client', () async {
      final coin = _coin('BTC');
      when(() => client.getCoin('BTC')).thenAnswer((_) async => coin);

      final result = await repository.getCoin('BTC');

      expect(result, coin);
      verify(() => client.getCoin('BTC')).called(1);
    });

    test('propagates client errors', () async {
      when(() => client.getCoins(limit: any(named: 'limit'),
              offset: any(named: 'offset')))
          .thenThrow(Exception('network'));

      expect(() => repository.getCoins(offset: 0), throwsException);
    });
  });
}
