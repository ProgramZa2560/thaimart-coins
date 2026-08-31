import 'package:get_it/get_it.dart';

import '../../features/coin/data/api/coin_api_client.dart';
import '../../features/coin/data/repositories/coin_repository_impl.dart';
import '../../features/coin/domain/repositories/coin_repository.dart';
import '../../features/coin/presentation/cubit/coin_detail_cubit.dart';
import '../../features/coin/presentation/cubit/coin_list_cubit.dart';

final sl = GetIt.instance;

void configureDependencies() {
  sl.registerLazySingleton<CoinApiClient>(() => CoinApiClient());
  sl.registerLazySingleton<CoinRepository>(
    () => CoinRepositoryImpl(sl<CoinApiClient>()),
  );
  sl.registerFactory<CoinListCubit>(() => CoinListCubit(sl<CoinRepository>()));
  sl.registerFactory<CoinDetailCubit>(
    () => CoinDetailCubit(sl<CoinRepository>()),
  );
}
