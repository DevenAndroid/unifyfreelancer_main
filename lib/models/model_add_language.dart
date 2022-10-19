class ModelAddLanguage {
  Languages? languages;

  ModelAddLanguage({this.languages});

  ModelAddLanguage.fromJson(Map<String, dynamic> json) {
    languages = json['languages'] != null
        ? new Languages.fromJson(json['languages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.languages != null) {
      data['languages'] = this.languages!.toJson();
    }
    return data;
  }
}

class Languages {
  String? english;
  String? french;
  String? hindi;
  String? spanish;

  Languages({this.english, this.french, this.hindi, this.spanish});

  Languages.fromJson(Map<String, dynamic> json) {
    english = json['english'];
    french = json['french'];
    hindi = json['hindi'];
    spanish = json['Spanish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english'] = this.english;
    data['french'] = this.french;
    data['hindi'] = this.hindi;
    data['Spanish'] = this.spanish;
    return data;
  }
}
