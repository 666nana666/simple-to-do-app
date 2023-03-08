typedef Parser<T> = T Function(dynamic json);

class ParserJson<T> {
  late String message;
  late T data;

  ParserJson.fromJson(Map<String, dynamic> json, Parser<T> parser) {
    message = json['message'];
    data = parser(json['data']);
  }

  ParserJson(this.message, this.data);
}
