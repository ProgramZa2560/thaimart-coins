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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          hintStyle: const TextStyle(color: AppColors.textSecondary),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 13, right: 13),
            child: Icon(Icons.search, color: AppColors.textSecondary, size: 22),
          ),
          prefixIconColor: AppColors.textSecondary,
          prefixIconConstraints: const BoxConstraints(minWidth: 48),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (_, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
                onPressed: _clear,
              );
            },
          ),
          filled: true,
          fillColor: AppColors.searchField,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
