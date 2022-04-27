import 'package:g20newapp/core/http-client/http_client.dart';

import 'repository/repository.dart';

class Settings {
  bool period;

  Settings({required this.period});
}


class SettingsMainStances{
   Settings? settings;
   Future<Settings> fetchSettings()async{
    G20Response g20response = await Repository().getCategories();
    if (g20response is G20Sucess) {
      return settings = Settings(period: g20response.response.data['period']);
  }else if(g20response is G20Exception){
      throw G20Exception();
  }
  throw G20Exception();
}
}

