mixin AppLocale {
  static const String mapNav = 'mapNav';
  static const String routeNav = 'routeNav';
  static const String settingNav = 'settingNav';
  static const String nearCharge = 'nearCharge';
  static const String chargeType = 'chargeType';
  static const String searchLocation = 'searchLocation';
  static const String filter = 'filter';
  static const String login = 'login';
  static const String log = 'log';
  static const String iin = 'in';

  static const Map<String, dynamic> EN = {
    mapNav: 'Map',
    routeNav:'Route',
    settingNav:'Setting',
    nearCharge:'Charging Point Nearby',
    chargeType:'Charge Free',
    searchLocation: 'Search a Location',
    login:'Login',
    log:'Log',
    iin:'in'
  };
  static const Map<String, dynamic> AR = {
    mapNav: 'خريطة',
    routeNav:'الطريق',
    settingNav:'الاعدادات',
    nearCharge:'اقرب نقطة شحن',
    chargeType:'شحن مجاني',
    searchLocation: 'بحث عن موقع',
    login:'تسجيل الدخول',
    log:'تسجيل',
    iin:'الدخول'
  };
}