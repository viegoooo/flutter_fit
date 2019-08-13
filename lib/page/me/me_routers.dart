import 'package:fluro/fluro.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
import 'package:flutter_fit/page/me/me_page.dart';
import 'package:flutter_fit/page/me/personal_information.dart';

class SportsRouters implements IRouter{
  static String me = "/me";
  static String personalInformation = "/me/personal_info";

  @override
  void define(Router router) {
    router.define(me, handler: Handler(handlerFunc: (_, params) => MePage()));
    router.define(personalInformation, handler: Handler(handlerFunc: (_, params) => PersonalInfoPage()));
  }

}