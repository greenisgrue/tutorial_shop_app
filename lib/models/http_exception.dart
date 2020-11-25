
// Med Implements ingår vi ett kontrakt att overrida. Modifierar toString till eget meddelande. 
class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}

