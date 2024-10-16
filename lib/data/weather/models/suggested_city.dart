class SuggestedCity {
  String? name;
  LocalNames? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  SuggestedCity(
      {this.name,
      this.localNames,
      this.lat,
      this.lon,
      this.country,
      this.state});

  SuggestedCity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = json['local_names'] != null
        ? LocalNames.fromJson(json['local_names'])
        : null;
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (localNames != null) {
      data['local_names'] = localNames!.toJson();
    }
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}

class LocalNames {
  String? de;
  String? en;
  String? pl;
  String? ar;
  String? fr;
  String? et;
  String? es;
  String? ru;
  String? eo;

  LocalNames(
      {this.de,
      this.en,
      this.pl,
      this.ar,
      this.fr,
      this.et,
      this.es,
      this.ru,
      this.eo});

  LocalNames.fromJson(Map<String, dynamic> json) {
    de = json['de'];
    en = json['en'];
    pl = json['pl'];
    ar = json['ar'];
    fr = json['fr'];
    et = json['et'];
    es = json['es'];
    ru = json['ru'];
    eo = json['eo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['de'] = de;
    data['en'] = en;
    data['pl'] = pl;
    data['ar'] = ar;
    data['fr'] = fr;
    data['et'] = et;
    data['es'] = es;
    data['ru'] = ru;
    data['eo'] = eo;
    return data;
  }
}