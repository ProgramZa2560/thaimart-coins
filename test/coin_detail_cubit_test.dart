import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:coinmarket/features/coin/data/models/coin.dart';
import 'package:coinmarket/features/coin/domain/repositories/coin_repository.dart';
import 'package:coinmarket/features/coin/presentation/cubit/coin_detail_cubit.dart';

class _MockCoinRepository extends Mock implements CoinRepository {}

Coin _coin(String uuid) {
  return Coin(
    uuid: uuid,
    symbol: uuid,
    name: 'Coin $uuid',
    iconUrl: 'https://example.com/$uuid.png',
    price: 100,
    change: 1,
    marketCap: 1000000000,
    description: 'desc',
    websiteUrl: 'https://example.com',
  );
}

void main() {
  late _MockCoinRepository repository;

  setUp(() {
    repository = _MockCoinRepository();
  });

  blocTest<CoinDetailCubit, CoinDetailState>(
    'emits loading then success when coin is fetched',
    build: () {
      when(() => repository.getCoin('BTC'))
          .thenAnswer((_) async => _coin('BTC'));
      return CoinDetailCubit(repository);
    },
    act: (cubit) => cubit.load('BTC'),
    expect: () => [
      const CoinDetailState(status: CoinDetailStatus.loading),
      CoinDetailState(status: CoinDetailStatus.success, coin: _coin('BTC')),
    ],
  );

  blocTest<CoinDetailCubit, CoinDetailState>(
    'emits failure when repository throws',
    build: () {
      when(() => repository.getCoin('BTC')).thenThrow(Exception());
      return CoinDetailCubit(repository);
    },
    act: (cubit) => cubit.load('BTC'),
    expect: () => [
      const CoinDetailState(status: CoinDetailStatus.loading),
      const CoinDetailState(status: CoinDetailStatus.failure),
    ],
  );
}
