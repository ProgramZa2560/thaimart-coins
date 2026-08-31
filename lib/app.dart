import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di.dart';
import 'core/theme.dart';
import 'features/coin/presentation/cubit/coin_list_cubit.dart';
import 'features/coin/presentation/pages/home_page.dart';
import 'l10n/app_localizations.dart';

class CoinMarketApp extends StatelessWidget {
  const CoinMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Market',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider(
        create: (_) => sl<CoinListCubit>(),
        child: const HomePage(),
      ),
    );
  }
}
