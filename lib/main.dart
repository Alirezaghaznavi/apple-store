import 'dart:ui';
import 'package:apple_store/bloc/basket/basket-bloc.dart';
import 'package:apple_store/bloc/category/category-bolc.dart';
import 'package:apple_store/bloc/home/home-bloc.dart';
import 'package:apple_store/constants/color.dart';
import 'package:apple_store/data/model/card-item.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/screens/card-screen.dart';
import 'package:apple_store/screens/category-screen.dart';
import 'package:apple_store/screens/home-screen.dart';
import 'package:apple_store/screens/login-screen.dart';
import 'package:apple_store/screens/profile-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('CardBox');
  await getItInit();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedBottomNavigationIndex = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad,
        },
      ),
      home: Scaffold(
        body: IndexedStack(
          index: selectedBottomNavigationIndex,
          children: getScreens(),
        ),
        bottomNavigationBar: getBottomNavigationBar(),
      ),
    );
  }

  Widget getBottomNavigationBar() {
    return Container(
      width: 428,
      height: 75,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
          child: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                selectedBottomNavigationIndex = index;
              });
            },
            currentIndex: selectedBottomNavigationIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            enableFeedback: false,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'SB',
              fontSize: 10,
              color: CustomColors.blue,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'SB',
              fontSize: 10,
              color: CustomColors.black,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child:
                      Image.asset('assets/images/icon_profile.png', height: 26),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child: Container(
                    child: Image.asset('assets/images/icon_profile_active.png',
                        height: 26),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                ),
                label: 'حساب کاربری',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child:
                      Image.asset('assets/images/icon_basket.png', height: 26),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child: Container(
                    child: Image.asset('assets/images/icon_basket_active.png',
                        height: 26),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                ),
                label: 'سبد خرید',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child: Image.asset('assets/images/icon_category.png',
                      height: 26),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child: Container(
                    child: Image.asset('assets/images/icon_category_active.png',
                        height: 26),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                ),
                label: 'دسته بندی',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child: Image.asset('assets/images/icon_home.png', height: 26),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child: Container(
                    child: Image.asset('assets/images/icon_home_active.png',
                        height: 26),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                ),
                label: 'خانه',
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      ProfileScreen(),
      BlocProvider(
        create: (context) =>
            locatore.get<BasketBloc>()..add(BasketFechedFromHiveEvent()),
        child: CardScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: CategoryScreen(),
      ),
      BlocProvider(
        create: (context) => HomeBloc()..add(HomeInitializeRequestEvent()),
        child: HomeScareen(),
      ),
    ];
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}
