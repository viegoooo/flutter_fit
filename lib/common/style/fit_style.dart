import 'package:flutter/material.dart';
///因项目规范问题,本类修改自GSYGithubAppFlutter项目中的gsy_style.dart

///颜色
class FitColor {

  static const MaterialColor themeColors = Colors.deepOrange;
  static const Color primaryColor = const Color(0xFF24292E);
  static const Color primaryLightColor = const Color(0xFF42464b);
  static const Color primaryDarkColor = const Color(0xFF121917);

  static const Color cardWhite = const Color(0xFFFFFFFF);
  static const Color textColorOrange = const Color(0xFFF5642A);
  static const Color textWhite = const Color(0xFFFFFFFF);
  static const Color miWhite = const Color(0xffececec);
  static const Color white = const Color(0xFFFFFFFF);
  static const Color actionBlue = const Color(0xff267aff);
  static const Color subTextColor = const Color(0xff959595);
  static const Color subLightTextColor = const Color(0xffc4c4c4);

  static const Color mainBackgroundColor = const Color(0xffececec);

  static const Color mainTextColor =  const Color(0xFF121917);
  static const Color mainLittleLightTextColor =  const Color(0xFFCDCDCD);
  static const Color textColorWhite = const Color(0xFFFFFFFF);


  static const Color circleProgressBackgroundColor = const Color(0xFFFFA049);
  static const Color exerciseRecordsBackgroundColor = const Color(0xFFF8F2F2);
  static const Color twoContentBackgroundColor = const Color(0x53FFA049);

  static const Color sleepBackgroundColor = const Color(0xFFF4EFF5);
  static const Color heartBackgroundColor = const Color(0xFFFCF1F5);
  static const Color weightBackgroundColor = const Color(0xFFEBF2FA);
  static const Color pressBackgroundColor = const Color(0xFFF2F3F7);
  static const Color bloodOxyBackgroundColor = const Color(0xFFFFF5F4);
  static const Color bloodPressBackgroundColor = const Color(0xFFFAEFF3);
  static const Color bloodSugarBackgroundColor = const Color(0xFFFBF2EB);

  static const Color loginGradientStart = const Color(0xFF42464b);
  static const Color loginGradientEnd = const Color(0xFF121917);

  static const loginLinearGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color todayCardGradientStart = const Color(0xFFFD9229);
  static const Color todayCardGradientEnd = Colors.deepOrange;

  static const todayCardLinearGradient = const LinearGradient(
    colors: const [todayCardGradientStart, todayCardGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

}

class FitIcons{

  static const String DEFAULT_USER_ICON = 'assets/images/user_icon.jpeg';
  static const String DEFAULT_BAND = 'assets/images/hua_wei_band3_pro.jpg';


}

class FitPadding{
  static const EdgeInsetsGeometry pagePadding = const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0);

}

///文本样式
class FitConstant {

  static const String app_default_share_url = "https://github.com/CarGuo/GSYGithubAppFlutter";

  static const lagerTextSize = 30.0;
  static const bigTextSize = 22.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minTextWhiteStyle = TextStyle(
    color:FitColor.subLightTextColor,
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: FitColor.textColorWhite,
    fontSize: smallTextSize,
  );
  static const smallTextOrange = TextStyle(
    color: FitColor.textColorOrange,
    fontSize: smallTextSize,
  );
  static const smallTextOrangeBold = TextStyle(
    color: FitColor.textColorOrange,
    fontSize: smallTextSize,
    fontWeight: FontWeight.w600,
  );

  static const smallText = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: smallTextSize,
  );

  static const smallLittleLightText = TextStyle(
    color: FitColor.mainLittleLightTextColor,
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: FitColor.subLightTextColor,
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: FitColor.actionBlue,
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: FitColor.miWhite,
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: FitColor.subTextColor,
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: FitColor.textColorWhite,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: FitColor.subTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: FitColor.subLightTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: FitColor.textColorWhite,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: FitColor.subTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalLightText = TextStyle(
      color: FitColor.subTextColor,
      fontSize: normalTextSize,
      decoration: TextDecoration.none
  );

  static const normalText = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: normalTextSize,
    decoration: TextDecoration.none
  );

  static const normalTextBold = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.w500,
  );
  static const normalTextDeepBold = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color:FitColor.subTextColor,
    fontSize: normalTextSize,
  );
  static const normalSubTextBold = TextStyle(
    color:FitColor.subTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.w600,
  );

  static const normalTextWhite = TextStyle(
    color: FitColor.textColorWhite,
    fontSize: normalTextSize,
  );

  static const normalTextOrange = TextStyle(
    color: FitColor.textColorOrange,
    fontSize: normalTextSize,
  );
  static const normalTextOrangeBold = TextStyle(
    color: FitColor.textColorOrange,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );
  static const normalTextMitWhiteBold = TextStyle(
    color: FitColor.miWhite,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: FitColor.actionBlue,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: FitColor.primaryLightColor,
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: FitColor.mainTextColor,
    fontSize: bigTextSize,
    fontWeight: FontWeight.w500,
  );

  static const largeTextWhite = TextStyle(
    color: FitColor.textColorWhite,
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: FitColor.textColorWhite,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: FitColor.textColorWhite,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
  static const largeLargeTextOrange = TextStyle(
    color: FitColor.textColorOrange,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: FitColor.primaryColor,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}