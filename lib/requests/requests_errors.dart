class RequestsErrors {
  static List<RequestsErrors> _responses = [];
  
  final int _code;
  final String _message;

  int get code => _code;
  String get message => _message;
  
  static void init() {
    _responses = [
      RequestsErrors._(2000, "Success"),
      RequestsErrors._(2100, "Vous n'avez pas fourni un élément"),
      RequestsErrors._(2101, "Un des paramètres fournis est invalide"),
      RequestsErrors._(2111, "Impossible de s'authentifier auprès du serveur"),

      RequestsErrors._(3001, "Le code de vérification fourni est incorrect"),
      RequestsErrors._(3002, "Cet utilisateur a déjà un compte publicateur associé"),
      RequestsErrors._(3003, "Le mot de passe fourni est invalide"),
      RequestsErrors._(3004, "Ce nom d'utilisateur est déjà pris. Veuillez renseigner un autre"),
      RequestsErrors._(3005, "Ce numéro de téléphone est déjà utilisé. Veuillez renseigner un autre"),

      RequestsErrors._(4001, "Le publicateur fourni pour cette opération est invalide"),

      RequestsErrors._(0000, "An unknown error happened. Please contact the support or try again later"),
    ];
  }

  static RequestsErrors find(int? code) {
    return _responses.firstWhere((r) => r._code == code, orElse: () => _responses.last);
  }

  RequestsErrors._(this._code, this._message);
}

class ResponseException implements Exception {
  final RequestsErrors message;

  ResponseException(this.message);
}