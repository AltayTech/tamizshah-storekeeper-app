import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr_storekeeper/models/operator.dart';

import '../../provider/app_theme.dart';
import '../../provider/customer_info.dart';

class CustomerDetailInfoScreen extends StatefulWidget {
  final Operator operator;

  CustomerDetailInfoScreen({this.operator});

  @override
  _CustomerDetailInfoScreenState createState() =>
      _CustomerDetailInfoScreenState();
}

class _CustomerDetailInfoScreenState extends State<CustomerDetailInfoScreen> {
  Operator operator;
  var _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      cashOrder();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> cashOrder() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CustomerInfo>(context, listen: false).getCustomer();
    operator = Provider.of<CustomerInfo>(context, listen: false).operator;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: _isLoading
            ? Align(
                alignment: Alignment.center,
                child: SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index.isEven ? Colors.grey : Colors.grey,
                      ),
                    );
                  },
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/user_Icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'اطلاعات شخصی',
                              style: TextStyle(
                                color: AppTheme.h1,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 18.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'مشخصات',
                              style: TextStyle(
                                color: AppTheme.black,
                                fontFamily: 'Iransans',
                                fontSize: textScaleFactor * 14.0,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        Container(
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              InfoItem(
                                title: 'نام',
                                text: operator.operatorData.fname,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                              InfoItem(
                                title: 'نام خانوادگی',
                                text: operator.operatorData.lname,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                              InfoItem(
                                title: 'نوع کاربر',
                                text: operator.status.name,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Container(
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              InfoItem(
                                title: 'ایمیل',
                                text: operator.operatorData.email,
                                bgColor: Colors.white,
                                iconColor: Color(0xffA67FEC),
                              ),
                              InfoItem(
                                title: 'استان',
                                text: operator.operatorData.ostan != null
                                    ? operator.operatorData.ostan
                                    : '',
                                bgColor: Colors.white,
                                iconColor: Color(0xff4392F1),
                              ),
                              InfoItem(
                                title: 'شهر',
                                text: operator.operatorData.city != null
                                    ? operator.operatorData.city
                                    : '',
                                bgColor: Colors.white,
                                iconColor: Color(0xff4392F1),
                              ),
                              InfoItem(
                                title: 'کدپستی',
                                text: operator.operatorData.postcode != null
                                    ? operator.operatorData.postcode
                                    : '',
                                bgColor: Colors.white,
                                iconColor: Color(0xff4392F1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key key,
    @required this.title,
    @required this.text,
    @required this.bgColor,
    @required this.iconColor,
  }) : super(key: key);

  final String title;
  final String text;
  final Color bgColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$title : ',
            style: TextStyle(
              color: AppTheme.grey,
              fontFamily: 'Iransans',
              fontSize: textScaleFactor * 14.0,
            ),
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(
                    color: Colors.grey.withOpacity(
                  0.0,
                )),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: AppTheme.black,
                    fontFamily: 'Iransans',
                    fontSize: textScaleFactor * 14.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
