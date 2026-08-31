import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../domain/repositories/coin_repository.dart';
import '../../data/models/coin.dart';

enum CoinListStatus { initial, loading, success, failure }

class CoinListState extends Equatable {
  const CoinListState({
    this.status = CoinListStatus.initial,
    this.coins = const [],
    this.query = '',
    this.isLoadingMore = false,
    this.loadingMoreFailed = false,
    this.hasMore = true,
    this.isRefreshing = false,
  });

  final CoinListStatus status;
  final List<Coin> coins;
  final String query;
  final bool isLoadingMore;
  final bool loadingMoreFailed;
  final bool hasMore;
  final bool isRefreshing;

  bool get isSearching => query.isNotEmpty;

  CoinListState copyWith({
    CoinListStatus? status,
    List<Coin>? coins,
    String? query,
    bool? isLoadingMore,
    bool? loadingMoreFailed,
    bool? hasMore,
    bool? isRefreshing,
  }) {
    return CoinListState(
      status: status ?? this.status,
      coins: coins ?? this.coins,
      query: query ?? this.query,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadingMoreFailed: loadingMoreFailed ?? this.loadingMoreFailed,
      hasMore: hasMore ?? this.hasMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        status,
        coins,
        query,
        isLoadingMore,
        loadingMoreFailed,
        hasMore,
        isRefreshing,
      ];
}

class CoinListCubit extends Cubit<CoinListState> {
  CoinListCubit(this._repository) : super(const CoinListState());

  final CoinRepository _repository;

  Future<void> fetchFirstPage() async {
    emit(state.copyWith(status: CoinListStatus.loading));
    try {
      final coins = await _repository.getCoins(offset: 0);
      emit(CoinListState(
        status: CoinListStatus.success,
        coins: coins,
        hasMore: coins.length >= AppConstants.pageSize,
      ));
    } catch (_) {
      emit(state.copyWith(status: CoinListStatus.failure));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasMore == false) return;
    emit(state.copyWith(isLoadingMore: true, loadingMoreFailed: false));
    try {
      final coins = state.isSearching
          ? await _repository.searchCoins(
              keyword: state.query,
              offset: state.coins.length,
            )
          : await _repository.getCoins(offset: state.coins.length);
      final hasMore = coins.isNotEmpty && coins.length >= AppConstants.pageSize;
      emit(state.copyWith(
        coins: [...state.coins, ...coins],
        isLoadingMore: false,
        hasMore: hasMore,
      ));
    } catch (_) {
      emit(state.copyWith(isLoadingMore: false, loadingMoreFailed: true));
    }
  }

  Future<void> refresh() async {
    if (state.isSearching) return;
    emit(state.copyWith(isRefreshing: true));
    try {
      final coins = await _repository.getCoins(offset: 0);
      emit(CoinListState(
        status: CoinListStatus.success,
        coins: coins,
        hasMore: coins.length >= AppConstants.pageSize,
      ));
    } catch (_) {
      emit(state.copyWith(isRefreshing: false));
      rethrow;
    }
  }

  Future<void> search(String query) async {
    final keyword = query.trim();
    if (keyword.isEmpty) {
      await clearSearch();
      return;
    }
    emit(state.copyWith(
      query: keyword,
      status: CoinListStatus.loading,
      coins: [],
      hasMore: true,
    ));
    try {
      final coins = await _repository.searchCoins(keyword: keyword, offset: 0);
      emit(state.copyWith(
        status: CoinListStatus.success,
        coins: coins,
        hasMore: coins.length >= AppConstants.pageSize,
      ));
    } catch (_) {
      emit(state.copyWith(status: CoinListStatus.failure));
    }
  }

  Future<void> clearSearch() async {
    emit(state.copyWith(
      query: '',
      status: CoinListStatus.loading,
      coins: [],
      hasMore: true,
    ));
    await fetchFirstPage();
  }

  Future<void> retryLoadingMore() async {
    await loadMore();
  }
}
