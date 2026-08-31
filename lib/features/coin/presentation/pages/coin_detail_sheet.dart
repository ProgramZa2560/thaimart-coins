import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di.dart';
import '../cubit/coin_detail_cubit.dart';
import '../widgets/coin_detail_content.dart';
import '../widgets/error_view.dart';

class CoinDetailSheet extends StatelessWidget {
  const CoinDetailSheet({super.key, required this.uuid});

  final String uuid;

  static void show(BuildContext context, String uuid) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider(
        create: (_) => sl<CoinDetailCubit>()..load(uuid),
        child: CoinDetailSheet(uuid: uuid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinDetailCubit, CoinDetailState>(
      builder: (context, state) {
        final bottom = MediaQuery.of(context).padding.bottom;
        if (state.status == CoinDetailStatus.failure) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, bottom + 48),
            child: SizedBox(
              height: 200,
              child: ErrorView(
                onRetry: () => context.read<CoinDetailCubit>().load(uuid),
              ),
            ),
          );
        }
        if (state.status != CoinDetailStatus.success || state.coin == null) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 48, 0, bottom + 48),
            child: const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottom + 24),
            child: CoinDetailContent(coin: state.coin!),
          ),
        );
      },
    );
  }
}
