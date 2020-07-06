import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/auth.dart';
import './provider/wastes.dart';
import './screens/about_us_screen.dart';
import './screens/contact_with_us_screen.dart';
import './screens/customer_info/customer_user_info_screen.dart';
import './screens/delivery_detail_screen.dart';
import './screens/home_screen.dart';
import './screens/navigation_bottom_screen.dart';
import 'classes/strings.dart';
import 'provider/customer_info.dart';
import 'provider/deliveries.dart';
import 'screens/collect_list_screen.dart';
import 'screens/customer_info/login_screen.dart';
import 'screens/customer_info/profile_screen.dart';
import 'screens/guide_screen.dart';
import 'screens/splash_Screen.dart';
import 'screens/statistics_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerInfo(),
        ),
        ChangeNotifierProvider(
          create: (context) => Wastes(),
        ),
        ChangeNotifierProvider(
          create: (context) => Deliveries(),
        ),
      ],
      child: MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  fontFamily: 'Iransans',
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  fontFamily: 'Iransans',
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline1: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Iransans',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        supportedLocales: const <Locale>[
          Locale('en', ''),
          Locale('ar', ''),
        ],
        home: Directionality(
          child: SplashScreens(),
          textDirection: TextDirection.rtl, // setting rtl
        ),
        routes: {
          NavigationBottomScreen.routeName: (ctx) => NavigationBottomScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          AboutUsScreen.routeName: (ctx) => AboutUsScreen(),
          ContactWithUs.routeName: (ctx) => ContactWithUs(),
          CustomerUserInfoScreen.routeName: (ctx) => CustomerUserInfoScreen(),
          GuideScreen.routeName: (ctx) => GuideScreen(),
          CollectListScreen.routeName: (ctx) => CollectListScreen(),
          CollectDetailScreen.routeName: (ctx) => CollectDetailScreen(),
          StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
        },
      ),
    );
  }
}
