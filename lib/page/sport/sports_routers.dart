import 'package:fluro/fluro.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
import 'package:flutter_fit/page/sport/sports_history_page.dart';
import 'package:flutter_fit/page/sport/sports_page.dart';

class SportsRouters implements IRouter{
  static String sports = "/sports";
  static String sportsHistoryPage = "/sports/sportsHistory";

  @override
  void define(Router router) {
    router.define(sports, handler: Handler(handlerFunc: (_, params) => SportsPage()));
    router.define(sportsHistoryPage, handler: Handler(handlerFunc: (_, params) => SportsHistoryPage()));
  }

}