import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'features/auth/domain/repositories/i_auth_repository.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/finance_tracker/domain/repositories/i_finance_repository.dart';
import 'features/finance_tracker/presentation/cubit/finance_cubit.dart';
import 'core/theme/theme_cubit.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

const _webClientId = '1022510105024-rt9sogsrgso2ribikdglfavtas0oglcf.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Google Sign-In.
  // Web uses clientId, Android requires serverClientId.
  await GoogleSignIn.instance.initialize(
    clientId: kIsWeb ? _webClientId : null,
    serverClientId: kIsWeb ? null : _webClientId,
  );

  // Setup Dependency Injection
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => AuthCubit(getIt<IAuthRepository>()),
        ),
        BlocProvider(
          create: (_) => FinanceCubit(getIt<IFinanceRepository>()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Budget App',
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: appRouter,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', 'RU'),
              Locale('en', 'US'),
            ],
            locale: const Locale('ru', 'RU'),
          );
        },
      ),
    );
  }
}
