import 'package:fluro/fluro.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
import 'package:flutter_fit/page/me/interest_attention_page.dart';
import 'package:flutter_fit/page/me/me_page.dart';
import 'package:flutter_fit/page/me/personal_information.dart';

class MeRouters implements IRouter{
  static String me = "/me";
  static String personalInformation = "/me/personal_info";
  static String interestAndAttention = "/me/personal_info/interest";
  static String groupInfo = "/me/group";
  static String messageInfoPage = "/me/message";
  static String goal = "/me/goal";

  @override
  void define(Router router) {
    router.define(me, handler: Handler(handlerFunc: (_, params) => MePage()));
    router.define(personalInformation, handler: Handler(handlerFunc: (_, params) => PersonalInfoPage()));
    router.define(interestAndAttention, handler: Handler(handlerFunc: (_, params) => InterestPage()));
  }

}