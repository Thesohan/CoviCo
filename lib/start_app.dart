import 'package:covico/blocs/state_data_bloc/state_data_bloc.dart';
import 'package:covico/data/di/injector.dart';
import 'package:covico/routes/routes.dart';
import 'package:covico/ui/pages/my_home_page.dart';
import 'package:covico/ui/widgets/theme_inherited_widget.dart';
import 'package:covico/util/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
//import 'package:sailor/sailor.dart';

void startApp() async {
//  Routes.initRoutes();
  WidgetsFlutterBinding.ensureInitialized();
  Injector.setup();
  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);
  runApp(ThemeSwitcherWidget(
      initialDarkModeOn:false,child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeSwitcher.of(context).isDarkModeOn
          ? darkTheme(context)
          : lightTheme(context),
      home: Provider(
          create: (context)=>StateDataBloc(),
          dispose: (context,bloc)=>bloc.dispose(),
          child: MyHomePage()),
//      onGenerateRoute: Routes.sailor.generator(),
//      navigatorObservers: [SailorLoggingObserver()],
//      navigatorKey: Routes.sailor.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
