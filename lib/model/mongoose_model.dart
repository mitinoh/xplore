class Mongoose {
  int? limit;
  int? skip;
  List<String>? select;
  Map<String, dynamic>? sort;
  List<Filter>? filter;
  Mongoose({this.limit, this.skip, this.select, this.sort, this.filter});

  String getUrl() {
    String url = "";
    filter?.asMap().forEach((index, f) {
      if(f.value != null) {
        if (index > 0) url += "&";
        url += f.key + f.operation + f.value!;
      }
    });
    if (select != null && select!.isNotEmpty) {
      url += "&select=";
      url += select!.join(',');
    }
    sort?.forEach((k, v) =>
        {if (k.toString().contains("=")) url += "$k&" else url += "$k=$v&"});
    if (url.endsWith('&')) url = url.substring(0, url.length - 1);
    if (limit != null) url += "&limit=$limit";
    if (skip != null) url += "&skip=$skip";
    if (url.trim() != "") url = '?' + url;
    return url;
  }
}

class Filter {
  String key;
  String operation;
  String? value;

  Filter({required this.key, required this.operation, required this.value});
}
