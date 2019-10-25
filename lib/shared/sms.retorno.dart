class SmsEnvioRetorno {
  bool success;
  Object object;
  String message;

  SmsEnvioRetorno({this.success, this.object, this.message});

  SmsEnvioRetorno.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    object =
        json['Object'] != null ? new Object.fromJson(json['Object']) : null;
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    if (this.object != null) {
      data['Object'] = this.object.toJson();
    }
    data['Message'] = this.message;
    return data;
  }
}

class Object {
  String prefix;
  String phoneNumber;

  Object({this.prefix, this.phoneNumber});

  Object.fromJson(Map<String, dynamic> json) {
    prefix = json['Prefix'];
    phoneNumber = json['PhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Prefix'] = this.prefix;
    data['PhoneNumber'] = this.phoneNumber;
    return data;
  }
}
