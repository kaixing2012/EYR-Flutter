part of 'package:eyr/api/eyr_spring_boot/eyr_spring_boot_service.dart';

class EYRSpringBootReq extends ApiRequest {
  EYRSpringBootReq({
    required super.method,
    required super.uri,
  });

  final _env = GetIt.I<EnvCubit>();
  final _logger = GetIt.I<LoggingService>();
  final _cryptoService = GetIt.I<CryptoService>();
  final _api000Service = GetIt.I<Api000Service>();

  @override
  Future<IOClient> get client async {
    final sslCert = await rootBundle.load('ext/certs/client.p12');
    final remoteCert = await rootBundle.load('ext/certs/server.crt');
    final securityContext = SecurityContext()
      ..usePrivateKeyBytes(
        sslCert.buffer.asInt8List(),
        password: 'abab12',
      )
      ..useCertificateChainBytes(
        sslCert.buffer.asInt8List(),
        password: 'abab12',
      )
      ..setTrustedCertificatesBytes(
        remoteCert.buffer.asInt8List(),
      );

    final client = HttpClient(context: securityContext)
      ..badCertificateCallback = (
        cert,
        host,
        port,
      ) =>
          true;

    return IOClient(client);
  }

  @override
  Uri get reqURI {
    final url = 'https://${_env.state.apiEyrDomain}/api/v1/$uri';

    return switch (method) {
      ApiMethod.get => Uri.parse(url).replace(
          queryParameters: toJson(),
        ),
      ApiMethod.post => Uri.parse(url),
    };
  }

  @override
  Map<String, String> get reqHeader {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
  }

  @override
  String? get reqBody => jsonEncode(toJson());

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() => throw UnimplementedError();

  @override
  ApiResponse<T> handleResponse<T>(
    Response response,
    T Function(Map<String, dynamic> value) serialiser,
  ) {
    final resJson = jsonDecode(response.body) as Map<String, dynamic>;

    return EYRSpringBootRes<T>(
      uri: reqURI,
      status: '${response.statusCode}',
      data: serialiser(resJson['payload']),
    );
  }

  @override
  Future<ApiResponse<T>?> handleError<T>(
    Exception error,
    Future<ApiResponse<T>> Function() tryRequestAgain,
  ) async {
    if (error is! ApiException) return null;

    if (error is CryptoExpiredException) {
      _logger
        ..e('$error')
        ..d('Crypto refreshing pub key');

      final res000003 = await _api000Service.api000003();

      _cryptoService.currentRSAPublicKeyByte = base64.decode(
        res000003.data.pubKey,
      );

      return tryRequestAgain.call();
    }

    throw EYRSpringBootExc(
      status: error.status,
      from: error.from,
      response: error.response,
    );
  }
}
