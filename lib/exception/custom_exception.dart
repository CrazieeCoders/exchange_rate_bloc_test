class AppException implements Exception {

  final _prefix;
  final _message;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException{
  FetchDataException([String message]):
        super(message,"Error during Communication:");
}


class BadRequestException extends AppException{
  BadRequestException([String message]):
        super(message,"Invalid request");
}

class UnAuthorisedException extends AppException{
  UnAuthorisedException([String message]):
        super(message,"UnAuthorised");
}

class InvalidInputException extends AppException{
  InvalidInputException([String message]):
        super(message,"Invalid Url");
}

class URLNotAvailable extends AppException{
  URLNotAvailable([String message]):
        super("Invalid Url");
}


class ExchangeRateNotFoundException extends AppException{
  ExchangeRateNotFoundException([String message]):
        super(message,"Currency code not Found");

}