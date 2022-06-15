class OtpUri {
  String? _method;
  String? get method => _method;

  late String _secret;
  String get secret => _secret;

  String? _issuer;
  String? get issuer => _issuer;

  String? _algorithm;
  String? get algorithm => _algorithm;

  int? _digits;
  int? get digits => _digits;

  int? _period;
  int? get period => _period;


  OtpUri(String otpUri) {
    final uri = Uri.parse(otpUri);

    if (uri.scheme != 'otpauth') {
      throw OtpUriError('Incorrect URI scheme');
    }

    if (!uri.queryParameters.containsKey('secret')) {
      throw OtpUriError('Required parameter secret missing');
    }

    _method = uri.host;
    _secret = uri.queryParameters['secret']!;
    _issuer = uri.queryParameters['issuer'];
    _algorithm = uri.queryParameters['algorithm'];

    if (uri.queryParameters.containsKey('digits')) {
      _digits = int.tryParse(uri.queryParameters['digits']!);
    }

    if (uri.queryParameters.containsKey('period')) {
      _period = int.tryParse(uri.queryParameters['period']!);
    }

  }
}

class OtpUriError extends Error {
  final String message;

  OtpUriError(this.message);
}