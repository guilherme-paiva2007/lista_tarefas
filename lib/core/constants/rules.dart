abstract final class AppRules {
  static final AppRule<String> password = AppRule._([
    AppRuleVerifier._((v) => v.isNotEmpty, "A senha não pode estar vazia."),
    AppRuleVerifier._((v) => v.length >= 8 && v.length <= 64, "A senha precisa ter entre 8 e 64 caracteres.")
  ]);

  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  static final AppRule<String> email = AppRule._([
    AppRuleVerifier._((v) => v.isNotEmpty, "O e-mail não pode estar vazio."),
    AppRuleVerifier._((v) => _emailRegExp.hasMatch(v), "Estrutura de e-mail inválida.")
  ]);

  static final AppRule<DateTime> birthDate = AppRule._([
    AppRuleVerifier._((d) => d.isBefore(DateTime.now()), "A data de nascimento não pode ser antes de agora."),
  ]);

  static final RegExp nameRegExp = RegExp(r"^[a-zA-ZÀ-ÿ\s]+$");
  static final AppRule<String> name = AppRule._([
    AppRuleVerifier._((v) => v.isNotEmpty, "O nome não pode estar vazio."),
    AppRuleVerifier._((v) => v.length > 2, "O nome precisa ter mais de 2 caracteres."),
    AppRuleVerifier._((v) => nameRegExp.hasMatch(v), "O nome só pode conter letras e espaços.")
  ]);
}

final class AppRuleVerifier<T> {
  final bool Function(T v) function;
  final String errorMessage;

  const AppRuleVerifier._(this.function, this.errorMessage);
}

final class AppRule<T> {
  final List<AppRuleVerifier<T>> verifiers;

  const AppRule._(this.verifiers);

  bool isValid(T value) {
    for (var verifier in verifiers) {
      if (!verifier.function(value)) return false;
    }
    return true;
  }

  String? firstError(T value) {
    for (var verifier in verifiers) {
      if (!verifier.function(value)) return verifier.errorMessage;
    }
    return null;
  }

  List<String> errors(T value) {
    final List<String> errors = [];
    for (var verifier in verifiers) {
      if (!verifier.function(value)) errors.add(verifier.errorMessage);
    }
    return errors;
  }
}