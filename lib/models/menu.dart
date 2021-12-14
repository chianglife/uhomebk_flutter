class Menu {
   String resName = "";
  late String resCode;
  late String icon;
  late String icon2;
  late String url;
  late List<Menu> child;

  Menu(this.resName);

  Menu.fromMap(Map<String, dynamic>json) {
    this.resName = json['resName'];
    this.resCode = json['resCode'];
    this.icon = json['icon'];
    this.icon2 = json['icon2'];
    this.url = json['url'];
    this.child = ((json['child'] ?? []) as List<dynamic>).map((e) => Menu.fromMap(e)).toList();
  }
}