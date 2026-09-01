import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/coin.dart';
import '../cubit/coin_detail_cubit.dart';
import '../cubit/coin_list_cubit.dart';
import '../widgets/coin_list_item.dart';
import '../widgets/coin_search_bar.dart';
import '../widgets/error_view.dart';
import '../widgets/invite_friends_tile.dart';
import '../widgets/top_coins_section.dart';
import 'coin_detail_pane.dart';
import 'coin_detail_sheet.dart';

sealed class _Row {
  const _Row();
}

class _Top3Row extends _Row {
  const _Top3Row(this.coins);
  final List<Coin> coins;
}

class _CoinRow extends _Row {
  const _CoinRow(this.coin);
  final Coin coin;
}

class _InviteRow extends _Row {
  const _InviteRow();
}

class _FooterRow extends _Row {
  const _FooterRow();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double wideBreakpoint = 800;

  String? _selectedUuid;

  @override
  void initState() {
    super.initState();
    context.read<CoinListCubit>().fetchFirstPage();
  }

  void _openDetail(BuildContext context, Coin coin) {
    final isWide = MediaQuery.of(context).size.width >= wideBreakpoint;
    if (isWide) {
      setState(() => _selectedUuid = coin.uuid);
    } else {
      CoinDetailSheet.show(context, coin.uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= wideBreakpoint;
            final list = BlocBuilder<CoinListCubit, CoinListState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const CoinSearchBar(),
                    Expanded(child: _buildBody(context, state)),
                  ],
                );
              },
            );
            if (!isWide) return list;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 420, child: list),
                const VerticalDivider(width: 1),
                Expanded(
                  child: BlocProvider(
                    create: (_) => sl<CoinDetailCubit>(),
                    child: _DetailPaneHost(uuid: _selectedUuid),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CoinListState state) {
    switch (state.status) {
      case CoinListStatus.initial:
      case CoinListStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case CoinListStatus.failure:
        return ErrorView(
          onRetry: () => state.isSearching
              ? context.read<CoinListCubit>().search(state.query)
              : context.read<CoinListCubit>().fetchFirstPage(),
        );
      case CoinListStatus.success:
        return _buildList(context, state);
    }
  }

  Widget _buildList(BuildContext context, CoinListState state) {
    final cubit = context.read<CoinListCubit>();
    final l10n = AppLocalizations.of(context)!;
    if (state.coins.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => cubit.refresh(),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: Text(
                  l10n.noCoinsFound,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200) {
          cubit.loadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () => cubit.refresh(),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _rows(state).length,
          itemBuilder: (context, index) =>
              _buildRow(context, state, _rows(state)[index]),
        ),
      ),
    );
  }

  List<_Row> _rows(CoinListState state) {
    final rows = <_Row>[];
    if (!state.isSearching && state.coins.length > 3) {
      rows.add(_Top3Row(state.coins.take(3).toList()));
    }
    final mainCoins = state.isSearching ? state.coins : state.coins.sublist(3);
    var displayPosition = 1;
    for (final coin in mainCoins) {
      if (_isInvitePosition(displayPosition)) {
        rows.add(const _InviteRow());
        displayPosition++;
      }
      rows.add(_CoinRow(coin));
      displayPosition++;
    }
    rows.add(const _FooterRow());
    return rows;
  }

  bool _isInvitePosition(int position) {
    if (position < 5) return false;
    var p = 5;
    while (p < position) {
      p *= 2;
    }
    return p == position;
  }

  Widget _buildRow(BuildContext context, CoinListState state, _Row row) {
    switch (row) {
      case _Top3Row(:final coins):
        return TopCoinsSection(
          coins: coins,
          onCoinTap: (coin) => _openDetail(context, coin),
        );
      case _InviteRow():
        return const InviteFriendsTile();
      case _CoinRow(:final coin):
        return CoinListItem(
          coin: coin,
          onTap: () => _openDetail(context, coin),
        );
      case _FooterRow():
        if (state.isLoadingMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
            ),
          );
        }
        if (state.loadingMoreFailed) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ErrorView(
              onRetry: () => context.read<CoinListCubit>().retryLoadingMore(),
            ),
          );
        }
        return const SizedBox.shrink();
    }
  }
}

class _DetailPaneHost extends StatefulWidget {
  const _DetailPaneHost({required this.uuid});

  final String? uuid;

  @override
  State<_DetailPaneHost> createState() => _DetailPaneHostState();
}

class _DetailPaneHostState extends State<_DetailPaneHost> {
  Coin? _coin;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CoinDetailCubit>();
    if (widget.uuid != null && widget.uuid != _coin?.uuid) {
      cubit.load(widget.uuid!).whenComplete(() {
        if (mounted) {
          setState(() => _coin = cubit.state.coin);
        }
      });
    }
    return BlocBuilder<CoinDetailCubit, CoinDetailState>(
      builder: (context, state) {
        return CoinDetailPane(
          coin: state.coin,
          isLoading: state.status == CoinDetailStatus.loading,
          isFailure: state.status == CoinDetailStatus.failure,
          onRetry: () => cubit.load(widget.uuid!),
        );
      },
    );
  }
}
