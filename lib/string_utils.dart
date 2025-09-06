String removerAcentos(String texto) {
  const withAccents = 'ãáàâäéèêëíìîïõóòôöúùûüçñ';
  const withoutAccents = 'aaaaeeeeiiiioooouuuucn';

  for (int i = 0; i < withAccents.length; i++) {
    texto = texto.replaceAll(withAccents[i], withoutAccents[i]);
  }
  return texto;
}

bool fuzzyMatch(String text, String query) {
  text = removerAcentos(text.toLowerCase());
  query = removerAcentos(query.toLowerCase());

  if (text.contains(query)) return true;

  int errors = 0;
  int minLength = query.length < text.length ? query.length : text.length;

  for (int i = 0; i < minLength; i++) {
    if (query[i] != text[i]) errors++;
    if (errors > 2) return false;
  }

  return true;
}