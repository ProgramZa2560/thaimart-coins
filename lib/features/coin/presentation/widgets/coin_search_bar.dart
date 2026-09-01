import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../core/theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/coin_list_cubit.dart';

class CoinSearchBar extends StatefulWidget {
  const CoinSearchBar({super.key});

  @override
  State<CoinSearchBar> createState() => _CoinSearchBarState();
}

class _CoinSearchBarState extends State<CoinSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(AppConstants.searchDebounce, () {
      context.read<CoinListCubit>().search(value);
    });
  }

  void _clear() {
    _debounce?.cancel();
    _controller.clear();
    context.read<CoinListCubit>().clearSearch();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.searchField,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.fromLTRB(7, 0, 4, 0),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Color(0xFF5A585C),
              size: 20,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextField(
                  controller: _controller,
                  onChanged: _onChanged,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: l10n.searchHint,
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF5A585C),
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (_, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF5A585C),
                    size: 20,
                  ),
                  onPressed: _clear,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
