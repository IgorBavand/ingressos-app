class UsuarioResponseDto {
  int? id;
  String? nome;
  String? login;
  String? password;
  String? telefone;
  String? cpf;
  String? cidade;
  String? userRole;

  UsuarioResponseDto({
    this.id,
    this.nome,
    this.login,
    this.password,
    this.telefone,
    this.cpf,
    this.cidade,
    this.userRole,
  });

  factory UsuarioResponseDto.fromJson(Map<String, dynamic> json) {
    return UsuarioResponseDto(
      id: json['id'],
      nome: json['nome'],
      login: json['login'],
      password: json['password'],
      telefone: json['telefone'],
      cpf: json['cpf'],
      cidade: json['cidade'],
      userRole: json['userRole'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (nome != null) data['nome'] = nome;
    if (login != null) data['login'] = login;
    if (password != null) data['password'] = password;
    if (telefone != null) data['telefone'] = telefone;
    if (cpf != null) data['cpf'] = cpf;
    if (cidade != null) data['cidade'] = cidade;
    if (userRole != null) data['userRole'] = userRole;
    return data;
  }
}
