class ForgotPasswordRes {
  String? message;
  List<String>? error;

  ForgotPasswordRes({this.message});

  ForgotPasswordRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    //error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
   // data['error'] = this.error;
    return data;
  }
}
