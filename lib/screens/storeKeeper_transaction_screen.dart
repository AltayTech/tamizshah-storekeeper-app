import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../models/search_detail.dart';
import '../models/transaction.dart';
import '../provider/app_theme.dart';
import '../provider/auth.dart';
import '../provider/customer_info.dart';
import '../widgets/en_to_ar_number_convertor.dart';
import '../widgets/transaction_item_transactions_screen.dart';
import 'customer_info/login_screen.dart';

class StoreKeeperTransactionScreen extends StatefulWidget {
  static const routeName = '/StoreKeeperTransactionScreen';

  @override
  _StoreKeeperTransactionScreenState createState() =>
      _StoreKeeperTransactionScreenState();
}

class _StoreKeeperTransactionScreenState
    extends State<StoreKeeperTransactionScreen>
    with SingleTickerProviderStateMixin {
  bool _isInit = true;
  ScrollController _scrollController = new ScrollController();
  var _isLoading;
  int page = 1;
  SearchDetail productsDetail;

  @override
  void initState() {
    Provider.of<CustomerInfo>(context, listen: false).sPage = 1;

    Provider.of<CustomerInfo>(context, listen: false).searchBuilder();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (page < productsDetail.max_page) {
          page = page + 1;
          Provider.of<CustomerInfo>(context, listen: false).sPage = page;

          searchItems();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      getCustomerInfo();
      searchItems();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> getCustomerInfo() async {
    bool isLogin = Provider.of<Auth>(context, listen: false).isAuth;
    if (isLogin) {
      await Provider.of<CustomerInfo>(context, listen: false).getCustomer();
    }
  }

  List<Transaction> loadedProducts = [];
  List<Transaction> loadedProductstolist = [];

  Future<void> searchItems() async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<CustomerInfo>(context, listen: false).searchBuilder();
    await Provider.of<CustomerInfo>(context, listen: false)
        .searchTransactionItems();
    productsDetail =
        Provider.of<CustomerInfo>(context, listen: false).searchDetails;

    loadedProducts.clear();
    loadedProducts = await Provider.of<CustomerInfo>(context, listen: false)
        .transactionItems;
    loadedProductstolist.addAll(loadedProducts);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    bool isLogin = Provider.of<Auth>(context).isAuth;

    var currencyFormat = intl.NumberFormat.decimalPattern();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.0, horizontal: deviceWidth * 0.02),
          child: !isLogin
              ? Container(
                  height: deviceHeight * 0.8,
                  child: Center(
                    child: Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('شما وارد نشده اید'),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'ورود به حساب کاربری',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      height: deviceHeight * 0.62,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppTheme.bg,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'لیست تراکنش ها',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppTheme.black
                                                  .withOpacity(0.5),
                                              fontFamily: 'Iransans',
                                              fontSize: textScaleFactor * 14.0,
                                            ),
                                          ),
                                          Spacer(),
                                          Consumer<CustomerInfo>(
                                              builder: (_, Wastes, ch) {
                                            return Container(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        deviceHeight * 0.0,
                                                    horizontal: 3),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  direction: Axis.horizontal,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 3,
                                                          vertical: 5),
                                                      child: Text(
                                                        'تعداد:',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Iransans',
                                                          fontSize:
                                                              textScaleFactor *
                                                                  12.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4.0,
                                                              left: 6),
                                                      child: Text(
                                                        productsDetail != null
                                                            ? EnArConvertor()
                                                                .replaceArNumber(
                                                                    loadedProductstolist
                                                                        .length
                                                                        .toString())
                                                            : EnArConvertor()
                                                                .replaceArNumber(
                                                                    '0'),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Iransans',
                                                          fontSize:
                                                              textScaleFactor *
                                                                  13.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 3,
                                                          vertical: 5),
                                                      child: Text(
                                                        'از',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Iransans',
                                                          fontSize:
                                                              textScaleFactor *
                                                                  12.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4.0,
                                                              left: 6),
                                                      child: Text(
                                                        productsDetail != null
                                                            ? EnArConvertor()
                                                                .replaceArNumber(
                                                                    productsDetail
                                                                        .total
                                                                        .toString())
                                                            : EnArConvertor()
                                                                .replaceArNumber(
                                                                    '0'),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Iransans',
                                                          fontSize:
                                                              textScaleFactor *
                                                                  13.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: deviceWidth * 0.10,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              'نوع',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 15.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'برای',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 15.0,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'مبلغ(تومان)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppTheme.grey,
                                                fontFamily: 'Iransans',
                                                fontSize:
                                                    textScaleFactor * 15.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: deviceHeight * 0.42,
                                      child: ListView.builder(
                                        controller: _scrollController,
                                        scrollDirection: Axis.vertical,
                                        itemCount: loadedProductstolist.length,
                                        itemBuilder: (ctx, i) =>
                                            ChangeNotifierProvider.value(
                                          value: loadedProductstolist[i],
                                          child:
                                              TransactionItemTransactionsScreen(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: _isLoading
                            ? SpinKitFadingCircle(
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index.isEven
                                          ? Colors.grey
                                          : Colors.grey,
                                    ),
                                  );
                                },
                              )
                            : Container(
                                child: loadedProductstolist.isEmpty
                                    ? Center(
                                        child: Text(
                                          'درخواستی وجود ندارد',
                                          style: TextStyle(
                                            fontFamily: 'Iransans',
                                            fontSize: textScaleFactor * 15.0,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
