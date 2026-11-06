class Validadores {
  static String? textoObrigatorio(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Este campo é obrigatório.';
    }
    return null;
  }

  static String? quantidade(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe uma quantidade.';
    }
    final n = int.tryParse(valor.trim());
    if (n == null) {
      return 'Informe um número inteiro válido (sem letras ou decimais).';
    }
    if (n < 0) {
      return 'A quantidade não pode ser negativa.';
    }
    return null;
  }
}
