import 'package:eyr/app/app_theme.dart';
import 'package:eyr/localised/localiser.g.dart';
import 'package:eyr/shared/observers/app_router_observer.dart';
import 'package:eyr/shared/widgets/app_alert/app_alert_view.dart';
import 'package:eyr/states/auth/auth_cubit.dart';
import 'package:eyr/states/env/env_cubit.dart';
import 'package:eyr/states/init/init_cubit.dart';
import 'package:eyr/states/locale/locale_cubit.dart';
import 'package:eyr/states/mask/mask_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'app_config.dart';

class App extends StatelessWidget with AppRouterObserver {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<MaskCubit>()),
        BlocProvider(create: (context) => GetIt.I<AppAlertCubit>()),
        BlocProvider(create: (context) => GetIt.I<InitCubit>()),
        BlocProvider(create: (context) => GetIt.I<EnvCubit>()),
        BlocProvider(create: (context) => GetIt.I<AuthCubit>()),
        BlocProvider(create: (context) => GetIt.I<LocaleCubit>()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) => Stack(
          alignment: Alignment.center,
          children: [
            // App
            MaterialApp.router(
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              locale: state.locale,
              localizationsDelegates: Localiser.localizationsDelegates,
              supportedLocales: Localiser.supportedLocales,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              debugShowCheckedModeBanner: false,
            ),
            // Alert
            // AppAlert(
            //   locale: state.locale,
            //   localizationsDelegates: Localiser.localizationsDelegates,
            //   supportedLocales: Localiser.supportedLocales,
            // ),
          ],
        ),
      ),
    );
  }
}
