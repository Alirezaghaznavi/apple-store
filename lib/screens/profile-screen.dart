import 'package:flutter/material.dart';
import '../constants/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bachgroundScreenColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 44, left: 44),
          child: Column(
            children: [
              headerBox(context),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'علیرضا غزنوی',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '09944541002',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 10,
                        color: CustomColors.gery,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 270,
                child: Wrap(
                  runAlignment: WrapAlignment.end,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 20,
                  spacing: 30,
                  children: [
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                    // CategoriesItemChip(),
                  ],
                ),
              ),
              Spacer(),
              Text(
                'Apple Store',
                style: TextStyle(
                  fontFamily: '',
                  fontSize: 10,
                  color: CustomColors.gery,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'V-1.0.00',
                style: TextStyle(
                  fontFamily: '',
                  fontSize: 10,
                  color: CustomColors.gery,
                ),
              ),
              SizedBox(height: 5),
              Text(
                't.me/AlirezaTech',
                style: TextStyle(
                  fontFamily: '',
                  fontSize: 10,
                  color: CustomColors.gery,
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerBox(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 15),
              child: Image.asset(
                'assets/images/icon_apple_blue.png',
                height: 26,
              ),
            ),
            Expanded(
              child: Text(
                'حساب کاربری',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SB',
                  fontSize: 16,
                  color: CustomColors.blue,
                ),
              ),
            ),
            SizedBox(
              width: 37,
            ),
          ],
        ),
      ),
    );
  }
}
