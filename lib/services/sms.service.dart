import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gdg_flutter/shared/sms.retorno.dart';

class SmsService {
  Dio _dio;
  SmsService() {
    _dio = new Dio();
  }

  send(String telefone) async {
    _dio = new Dio();
    var response = await _dio.post(
      "https://sms.comtele.com.br/api/v2/tokenmanager",
      data: {"PhoneNumber": telefone, "Prefix": "GDG"},
      options: Options(
        headers: {"auth-key": "e6e85810-046d-4afd-9b3d-e34e883e6c63"},
      ),
    );
    var sms = SmsEnvioRetorno.fromJson(response.data);
    print(sms.message);
  }

  Future<SmsEnvioRetorno> validate(String token) async {
    _dio = new Dio();
    Response response;
    try {
      response = await _dio.put(
        "https://sms.comtele.com.br/api/v2/tokenmanager",
        data: {"TokenCode": token},
        options: Options(
          headers: {
            "auth-key": "e6e85810-046d-4afd-9b3d-e34e883e6c63",
            "content-type": "application/json"
          },
        ),
      );
      var sms = SmsEnvioRetorno.fromJson(response.data);
      print(sms.message);
      return sms;
    } catch (e) {
      return null;
    }
  }
}
