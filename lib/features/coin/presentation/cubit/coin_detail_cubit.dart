import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/coin_repository.dart';
import '../../data/models/coin.dart';

class CoinDetailState extends Equatable {
  const CoinDetailState({
    this.status = CoinDetailStatus.initial,
    this.coin,
  });

  final CoinDetailStatus status;
  final Coin? coin;

  CoinDetailState copyWith({CoinDetailStatus? status, Coin? coin}) {
    return CoinDetailState(
      status: status ?? this.status,
      coin: coin ?? this.coin,
    );
  }

  @override
  List<Object?> get props => [status, coin];
}

enum CoinDetailStatus { initial, loading, success, failure }

class CoinDetailCubit extends Cubit<CoinDetailState> {
  CoinDetailCubit(this._repository) : super(const CoinDetailState());

  final CoinRepository _repository;

  Future<void> load(String uuid) async {
    emit(state.copyWith(status: CoinDetailStatus.loading));
    try {
      final coin = await _repository.getCoin(uuid);
      emit(CoinDetailState(status: CoinDetailStatus.success, coin: coin));
    } catch (_) {
      emit(state.copyWith(status: CoinDetailStatus.failure));
    }
  }
}
