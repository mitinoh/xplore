class Mongoose {
  int? limit;
  int? skip;
  List<String>? select;
  List<String>? sort;
  List<Filter>? filter;
  Mongoose({this.limit, this.skip, this.select, this.sort, this.filter});

  String getUrl() {
    String url = "";
    filter?.asMap().forEach((index, f) {
      if (f.value != null) {
        if (index > 0) url += "&";
        url += f.key + f.operation + f.value!;
      }
    });
    if (select != null && select!.isNotEmpty) {
      url += "&select=";
      url += select!.join(',');
    }
    if (sort != null && sort!.isNotEmpty) {
      url += "&sort=";
      url += sort!.join(',');
    }

    if (url.endsWith('&')) url = url.substring(0, url.length - 1);
    if (limit != null) url += "&limit=$limit";
    if (skip != null) url += "&skip=$skip";
    if (url.trim() != "") url = '&' + url;
    return url;
  }

  Map<String, dynamic> getMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    if (limit != null) map["limit"] = limit;
    if (skip != null) map["skip"] = skip;
    if (select != null && select!.isNotEmpty) map["select"] = select?.join(",");
    if (sort != null && sort!.isNotEmpty) map["sort"] = sort?.join(",");
    if (filter != null && filter!.isNotEmpty) map["_"] = getFilter();
    return map;
  }

  String getFilter() {
    String url = "";
    filter?.asMap().forEach((index, f) {
      if (f.value != null) {
        url += "&" + f.key + f.operation + f.value!;
      }
    });
    return url;
  }
}

class Filter {
  String key;
  String operation;
  String? value;
  Filter({required this.key, required this.operation, required this.value});
}
