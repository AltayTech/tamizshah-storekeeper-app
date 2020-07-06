import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

import '../models/shop.dart';
import '../provider/app_theme.dart';
import '../provider/customer_info.dart';
import '../widgets/main_drawer.dart';

class GuideScreen extends StatefulWidget {
  static const routeName = '/guideScreen';

  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  bool _isInit = true;

  Shop shopData;

  List<String> aboutInfotitle = [];

  List<String> aboutInfoContent = [];

  bool _isLoading = false;


  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await searchItems();

      aboutInfoContent = [
        shopData.return_policy,
        shopData.privacy,
        shopData.how_to_order,
        shopData.faq,
        shopData.pay_methods_desc
      ];
      aboutInfotitle = [
        'قوانین بازگردانی',
        'حریم خصوصی',
        'نحوه سفارش',
        'سوالات متداول',
        'شیوه پرداخت',
      ];
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CustomerInfo>(context, listen: false).fetchShopData();
    shopData = Provider.of<CustomerInfo>(context, listen: false).shop;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    shopData = Provider.of<CustomerInfo>(context).shop;

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: Text(
          'راهنما',
          style: TextStyle(
            color: AppTheme.bg,
            fontFamily: 'Iransans',
            fontSize: textScaleFactor * 18.0,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: AppTheme.appBarColor,
        iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
      ),
      body: _isLoading
          ? SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index.isEven ? Colors.grey : Colors.grey,
                  ),
                );
              },
            )
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: deviceWidth * 0.3,
                            height: deviceWidth * 0.3,
                            color: AppTheme.bg,
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('assets/images/circle.gif'),
                              image: NetworkImage(shopData.logo.sizes.medium),
                              fit: BoxFit.contain,
                              height: deviceWidth * 0.5,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            shopData.name,
                            style: TextStyle(
                              color: AppTheme.h1,
                              fontFamily: 'BFarnaz',
                              fontSize: textScaleFactor * 24.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            shopData.subject,
                            style: TextStyle(
                              color: AppTheme.grey,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 15.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: deviceHeight * 0.7,
                          width: deviceWidth,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: aboutInfotitle.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Card(
                                  child: ExpansionTile(

                                    title: Text(
                                      aboutInfotitle[index],
                                      style: TextStyle(
                                        color: AppTheme.black,
                                        fontFamily: 'Iransans',
                                        fontSize: textScaleFactor * 15.0,
                                      ),
                                    ),
                                    children: <Widget>[
                                      HtmlWidget(
                                        aboutInfoContent[index],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: MainDrawer(),
      ),
    );
  }
}
