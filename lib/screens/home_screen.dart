import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:tamizshahr_storekeeper/screens/statistics_screen.dart';

import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../screens/collect_list_screen.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import 'storeKeeper_transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;

  int _selectedItem = 1;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isInit = false;

      Provider.of<Auth>(context, listen: false).getToken();

      bool _isFirstLogin =
          Provider.of<Auth>(context, listen: false).isFirstLogin;
      if (_isFirstLogin) {
        _showLoginDialog(context);
      }
      bool _isFirstLogout =
          Provider.of<Auth>(context, listen: false).isFirstLogout;
      if (_isFirstLogout) {
        _showLoginDialogExit(context);
      }

      Provider.of<Auth>(context, listen: false).isFirstLogin = false;
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  void _showLoginDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (ctx) => CustomDialog(
          title: 'خوش آمدید',
          buttonText: 'تایید',
          description:
              'برای دریافت اطلاعات کاربری به قسمت پروفایل مراجعه فرمایید',
        ),
      );
    });
  }

  void _showLoginDialogExit(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (ctx) => CustomDialog(
          title: 'کاربر گرامی',
          buttonText: 'تایید',
          description: 'شما با موفقیت از اکانت کاربری خارج شدید',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    double itemPaddingF = 0.019;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 4),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.08),
                        blurRadius: 10.10,
                        spreadRadius: 10.510,
                        offset: Offset(
                          0,
                          0,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 5),
                        child: Icon(
                          Icons.calendar_today,
                          color: AppTheme.iconColor1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          EnArConvertor().replaceArNumber(
                            '${Jalali.fromDateTime(
                              DateTime.now(),
                            ).year}/${Jalali.fromDateTime(
                              DateTime.now(),
                            ).month}/${Jalali.fromDateTime(
                              DateTime.now(),
                            ).day}',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.h1,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 16.0,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 5),
                        child: Icon(
                          Icons.access_time,
                          color: AppTheme.iconColor1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          EnArConvertor().replaceArNumber(
                              '${DateTime.now().hour}:${DateTime.now().minute}'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.h1,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: deviceWidth,
              height: deviceHeight * 0.17,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectedItem = 0;
                        setState(() {});
                      },
                      child: LayoutBuilder(
                        builder: (_, constraint) => Padding(
                          padding: EdgeInsets.all(deviceWidth * itemPaddingF),
                          child: Container(
                            decoration: BoxDecoration(
                                color: _selectedItem == 0
                                    ? AppTheme.primary
                                    : AppTheme.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),
                                    blurRadius: 10.10,
                                    spreadRadius: 10,
                                    offset: Offset(
                                      0, // horizontal, move right 10

                                      0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        bottom: 10,
                                        top: 16),
                                    child: Container(
                                      height: constraint.maxHeight * 0.250,
                                      child: Icon(
                                        Icons.monetization_on,
                                        size: constraint.maxWidth * 0.35,
                                        color: _selectedItem == 0
                                            ? AppTheme.white
                                            : AppTheme.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'تراکنشها',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _selectedItem == 0
                                            ? AppTheme.white
                                            : Colors.black45,
                                        fontFamily: 'Iransans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _selectedItem = 1;
                        setState(() {});
                      },
                      child: LayoutBuilder(
                        builder: (_, constraint) => Padding(
                          padding: EdgeInsets.all(deviceWidth * itemPaddingF),
                          child: Container(
                            decoration: BoxDecoration(
                                color: _selectedItem == 1
                                    ? AppTheme.primary
                                    : AppTheme.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),
                                    blurRadius: 10.10,
                                    spreadRadius: 10.510,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        bottom: 5,
                                        top: 16),
                                    child: Container(
                                      height: constraint.maxHeight * 0.7,
                                      child: Icon(
                                        Icons.store,
                                        size: constraint.maxWidth * 0.35,
                                        color: _selectedItem == 1
                                            ? AppTheme.white
                                            : AppTheme.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'دریافت \n از انبار',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _selectedItem == 1
                                            ? AppTheme.white
                                            : Colors.black45,
                                        fontFamily: 'Iransans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(StatisticsScreen.routeName);
                      },
                      child: LayoutBuilder(
                        builder: (_, constraint) => Padding(
                          padding: EdgeInsets.all(deviceWidth * itemPaddingF),
                          child: Container(
                            decoration: BoxDecoration(
                                color: _selectedItem == 2
                                    ? AppTheme.primary.withOpacity(0.2)
                                    : AppTheme.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),
                                    blurRadius: 10.10,
                                    spreadRadius: 10.510,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        right: 30,
                                        bottom: 5,
                                        top: 15),
                                    child: Container(
                                      height: constraint.maxHeight * 0.25,
                                      child: Icon(
                                        Icons.insert_chart,
                                        size: constraint.maxWidth * 0.35,
                                        color: _selectedItem == 2
                                            ? AppTheme.white
                                            : AppTheme.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'آمار',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: 'Iransans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: textScaleFactor * 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: deviceHeight * 0.6,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_selectedItem == 0) {
                      return StoreKeeperTransactionScreen();
                    } else {
                      return CollectListScreen();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
