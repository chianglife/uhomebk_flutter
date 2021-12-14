class UserInfo {
  static late int userId, jobCommunity;
  static late String organId, organName, jobCommunityName, name, tel;
  static void save(Map<String, dynamic> json) {
    UserInfo.userId = json["userId"];
    UserInfo.organId = json["organId"];
    UserInfo.organName = json["organName"];
    UserInfo.jobCommunity = json["jobCommunity"];
    UserInfo.jobCommunityName = json["jobCommunityName"];
    UserInfo.name = json["name"];
    UserInfo.tel = json["tel"];
  }
}