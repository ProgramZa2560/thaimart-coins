import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:coinmarket/core/constants.dart';
import 'package:coinmarket/features/coin/data/models/coin.dart';
import 'package:coinmarket/features/coin/domain/repositories/coin_repository.dart';
import 'package:coinmarket/features/coin/presentation/cubit/coin_list_cubit.dart';

class _MockCoinRepository extends Mock implements CoinRepository {}

Coin _coin(String uuid, {num change = 1}) {
  return Coin(
    uuid: uuid,
    symbol: uuid,
    name: 'Coin $uuid',
    iconUrl: 'https://example.com/$uuid.png',
    price: 100,
    change: change,
    marketCap: 1000000000,
  );
}

List<Coin> _page(int page, {int size = AppConstants.pageSize}) {
  return List.generate(size, (i) => _coin('coin-${page * size + i}'));
}

void main() {
  late _MockCoinRepository repository;

  setUp(() {
    repository = _MockCoinRepository();
  });

  group('CoinListCubit', () {
    blocTest<CoinListCubit, CoinListState>(
      'emits loading then success on fetchFirstPage',
      build: () {
        when(() => repository.getCoins(offset: 0))
            .thenAnswer((_) async => _page(0));
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.fetchFirstPage(),
      expect: () => [
        const CoinListState(status: CoinListStatus.loading),
        CoinListState(
          status: CoinListStatus.success,
          coins: _page(0),
          hasMore: true,
        ),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'emits failure when fetchFirstPage throws',
      build: () {
        when(() => repository.getCoins(offset: 0)).thenThrow(Exception());
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.fetchFirstPage(),
      expect: () => [
        const CoinListState(status: CoinListStatus.loading),
        const CoinListState(status: CoinListStatus.failure),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'loadMore appends next page and keeps hasMore',
      seed: () => CoinListState(
        status: CoinListStatus.success,
        coins: _page(0),
      ),
      build: () {
        when(() => repository.getCoins(offset: AppConstants.pageSize))
            .thenAnswer((_) async => _page(1));
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        predicate<CoinListState>((s) => s.isLoadingMore),
        predicate<CoinListState>((s) =>
            !s.isLoadingMore &&
            s.coins.length == AppConstants.pageSize * 2 &&
            s.hasMore),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'loadMore sets hasMore false on short page',
      seed: () => CoinListState(
        status: CoinListStatus.success,
        coins: _page(0),
      ),
      build: () {
        when(() => repository.getCoins(offset: AppConstants.pageSize))
            .thenAnswer((_) async => _page(1, size: 3));
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        predicate<CoinListState>((s) => s.isLoadingMore),
        predicate<CoinListState>((s) =>
            !s.hasMore &&
            s.coins.length == AppConstants.pageSize + 3),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'loadMore failure sets loadingMoreFailed',
      seed: () => CoinListState(
        status: CoinListStatus.success,
        coins: _page(0),
      ),
      build: () {
        when(() => repository.getCoins(offset: AppConstants.pageSize))
            .thenThrow(Exception());
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        predicate<CoinListState>((s) => s.isLoadingMore),
        predicate<CoinListState>((s) => s.loadingMoreFailed),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'loadMore does nothing while a page is already loading',
      seed: () => CoinListState(
        status: CoinListStatus.success,
        coins: _page(0),
        isLoadingMore: true,
      ),
      build: () => CoinListCubit(repository),
      act: (cubit) => cubit.loadMore(),
      expect: () => <CoinListState>[],
    );

    blocTest<CoinListCubit, CoinListState>(
      'search emits loading then results with query set',
      build: () {
        when(() => repository.searchCoins(keyword: 'btc', offset: 0))
            .thenAnswer((_) async => [_coin('BTC')]);
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.search('btc'),
      expect: () => [
        const CoinListState(
          status: CoinListStatus.loading,
          query: 'btc',
        ),
        predicate<CoinListState>((s) =>
            s.status == CoinListStatus.success &&
            s.isSearching &&
            s.coins.length == 1),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'search with empty query delegates to clearSearch',
      seed: () => CoinListState(
        status: CoinListStatus.success,
        coins: _page(0),
        query: 'btc',
      ),
      build: () {
        when(() => repository.getCoins(offset: 0))
            .thenAnswer((_) async => _page(0));
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.search(''),
      expect: () => [
        predicate<CoinListState>((s) =>
            s.status == CoinListStatus.loading && s.query.isEmpty),
        predicate<CoinListState>((s) =>
            s.status == CoinListStatus.success &&
            !s.isSearching &&
            s.coins.length == AppConstants.pageSize),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'refresh reloads first page',
      seed: () => CoinListState(
        status: CoinListStatus.success,
        coins: _page(0),
      ),
      build: () {
        when(() => repository.getCoins(offset: 0))
            .thenAnswer((_) async => _page(9));
        return CoinListCubit(repository);
      },
      act: (cubit) => cubit.refresh(),
      expect: () => [
        predicate<CoinListState>((s) => s.isRefreshing),
        predicate<CoinListState>((s) =>
            !s.isRefreshing &&
            s.coins.first.uuid == _page(9).first.uuid),
      ],
    );

    blocTest<CoinListCubit, CoinListState>(
      'refresh is a no-op while searching',
      seed: () => CoinListState(
        status: CoinListStatus.success,
        coins: [_coin('BTC')],
        query: 'btc',
      ),
      build: () => CoinListCubit(repository),
      act: (cubit) => cubit.refresh(),
      expect: () => <CoinListState>[],
    );
  });
}
