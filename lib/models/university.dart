class University {
  final String name;
  final String country;
  final String alphaTwoCode;
  final List<String> domains;
  final String? stateProvince;
  final List<String> webPages;

University({
  required this.name,
  required this.country,
  required this.alphaTwoCode,
  required this.domains,
  required this.stateProvince,
  required this.webPages,
});

factory University.fromJson(Map<String, dynamic> json){
  return University(
    name: json['name'],
    country: json['country'],
    alphaTwoCode: json['alpha_two_code'],
    domains: List<String>.from(json['domains']),
    stateProvince: json['state-province'],
    webPages: List<String>.from(json['web_pages']),
  );
}
}