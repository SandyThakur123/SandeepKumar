class userFullDetails {
  user_fullData? userfull_data;
  Support? support;

  userFullDetails({this.userfull_data, this.support});

  userFullDetails.fromJson(Map<String, dynamic> json) {
    userfull_data =
        json['data'] != null ? new user_fullData.fromJson(json['data']) : null;
    support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userfull_data != null) {
      data['data'] = this.userfull_data!.toJson();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class user_fullData {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  user_fullData(
      {this.id, this.email, this.firstName, this.lastName, this.avatar});

  user_fullData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}
