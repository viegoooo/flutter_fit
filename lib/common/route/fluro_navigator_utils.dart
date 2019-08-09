import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


/// 界面跳转工具类
class NavigatorUtils {

  static String home = "/home";
  static String webViewPage = "/webview";
  static Router mRouter = Router.appRouter;

  static push(BuildContext context, String path,
      {bool replace : false, bool clearStack : false,TransitionType transition : TransitionType.native}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    mRouter.navigateTo(context, path, replace: replace, clearStack: clearStack, transition:transition);
  }

  static pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace : false, bool clearStack : false,TransitionType transition:TransitionType.native}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    mRouter.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: transition).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context, result);
  }

//  /// 跳到WebView页
//  static goWebViewPage(BuildContext context, String title, String url){
//    //fluro 不支持传中文,需转换
//    push(context, '${webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
//  }


  static void configureRoutes( List<IRouter> _listRouter) {

    /// 初始化路由
    _listRouter?.forEach((iRouter){
      iRouter.define(mRouter);
    });

    /// 指定路由跳转错误返回页
//    Router.appRouter.notFoundHandler = Handler(
//        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//          debugPrint("未找到目标页");
//         // return WidgetNotFound();
//        });

//    Router.appRouter.define(Routes.home, handler: Handler(
//        handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));

//    Router.appRouter.define(Routes.webViewPage, handler: Handler(handlerFunc: (_, params){
//      String title = params['title']?.first;
//      String url = params['url']?.first;
////      return WebViewPage(title: title, url: url);
//
//    }));
  }
}


abstract class IRouter{
  void define(Router router);
}





