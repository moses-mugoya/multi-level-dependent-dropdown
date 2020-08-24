class Localization {
  final List<County> counties;
  final List<SubCounty> subCounties;
  final List<Wards> wards;

  Localization({this.counties, this.subCounties, this.wards});

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
        counties: parseCounty(json),
        subCounties: parseSubCounty(json),
        wards: parseWards(json));
  }

  static List<County> parseCounty(countyJson) {
    var clist = countyJson['counties'] as List;
    List<County> countiesList =
        clist.map((data) => County.fromJson(data)).toList();
    return countiesList;
  }

  static List<SubCounty> parseSubCounty(subCountyJson) {
    var slist = subCountyJson['subCounties'] as List;
    List<SubCounty> subCountiesList =
        slist.map((data) => SubCounty.fromJson(data)).toList();
    return subCountiesList;
  }

  static List<Wards> parseWards(wardsJson) {
    var wlist = wardsJson['wards'] as List;
    List<Wards> wardsList = wlist.map((data) => Wards.fromJson(data)).toList();
    return wardsList;
  }
}

class County {
  final int countyId;
  final String name;

  County({this.countyId, this.name});

  factory County.fromJson(Map<String, dynamic> parsedJson) {
    return County(countyId: parsedJson['county_id'], name: parsedJson['name']);
  }
}

class SubCounty {
  final String name;
  final int countyId;
  final int subCountyId;

  SubCounty({this.name, this.countyId, this.subCountyId});

  factory SubCounty.fromJson(Map<String, dynamic> parsedJson) {
    return SubCounty(
        name: parsedJson['name'],
        countyId: parsedJson['county_id'],
        subCountyId: parsedJson['sub_county_id']);
  }
}

class Wards {
  final String name;
  final int subCountyId;

  Wards({this.name, this.subCountyId});

  factory Wards.fromJson(Map<String, dynamic> parsedJson) {
    return Wards(
        name: parsedJson['name'], subCountyId: parsedJson['sub_county_id']);
  }
}
