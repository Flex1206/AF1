class Passageiro {
  String? nome;
  String? cpf;
  String? rg;
  String? email;
  String? celular;

  Passageiro({this.nome, this.cpf, this.rg, this.email, this.celular});
}

class PlataformaVenda {
  int? codigoCanal;
  String? nomeCanal;

  PlataformaVenda({this.codigoCanal, this.nomeCanal});
}

class Atendente {
  String? nome;
  String? matricula;
  String? cargo;
  String? email;
  String? celular;
  double? salario;

  Atendente({
    this.nome,
    this.matricula,
    this.cargo,
    this.email,
    this.celular,
    this.salario,
  });
}

mixin Logger {
  void log(String mensagem) {
    print("[LOG]: $mensagem");
  }
}

mixin Auditoria {
  void auditar(String mensagem) {
    print("[Auditoria]: $mensagem");
  }
}


class Passagem {
  String? _codigoLocalizador = "";
  Passageiro? passageiro;
  PlataformaVenda? plataforma;
  Atendente? atendente;
  String? observacoes;

  Passagem();

  Passagem.somenteCodigo(String codigoLocalizador) {
    this._codigoLocalizador = codigoLocalizador;
  }

  Passagem.completa(
    String codigoLocalizador,
    this.passageiro,
    this.plataforma,
    this.atendente,
    this.observacoes,
  ) {
    this._codigoLocalizador = codigoLocalizador;
  }

  Passagem.codigoEPassageiro({String? codigoLocalizador, this.passageiro}) {
    this._codigoLocalizador = codigoLocalizador ?? "";
  }

  Passagem.all(
    String codigoLocalizador, {
    required this.passageiro,
    required this.plataforma,
    required this.atendente,
    this.observacoes,
  }) {
    this._codigoLocalizador = codigoLocalizador;
  }

  String? getCodigoLocalizador() {
    return _codigoLocalizador;
  }

  void setCodigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print("Código localizador de passagem inválido!");
      return;
    }
    this._codigoLocalizador = codigoLocalizador;
  }

  String? get codigoLocalizador => _codigoLocalizador;

  set codigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print("Código localizador de passagem inválido!");
      return;
    }
    this._codigoLocalizador = codigoLocalizador;
  }

  void EmitirPassagem() {
    print("Passagem emitida com sucesso!");
  }

  bool CancelarPassagem() {
    print("Passagem cancelada com sucesso!");
    return true;
  }

  void AtualizarPassagem() {
    print("Passagem atualizada com sucesso!");
  }

  Passagem ConsultarPassagem(String codigo) {
    print("Passagem consultada com sucesso!");
    return Passagem();
  }
}

class PassagemPrimeiraClasse extends Passagem with Logger, Auditoria {
  String? loungeAcesso;

  PassagemPrimeiraClasse(
    String codigoLocalizador, {
    required Passageiro? passageiro,
    required PlataformaVenda? plataforma,
    required Atendente? atendente,
    String? observacoes,
    required this.loungeAcesso,
  }) : super.all(
          codigoLocalizador,
          passageiro: passageiro,
          plataforma: plataforma,
          atendente: atendente,
          observacoes: observacoes,
        );

  @override
  void AtualizarPassagem() {
    print("Passagem de Primeira Classe atualizada com sucesso!");
    log("Atendente responsável: ${this.atendente?.nome ?? 'Não informado'}");
    auditar("Verificação de segurança realizada para a Primeira Classe.");
  }
}

void main() {
  print("=== SISTEMA DE EMISSÃO DE PASSAGENS SKYHORIZON ===\n");

  var passageiro1 = Passageiro(
    nome: "Vitor Medina",
    cpf: "123.456.789-00",
    email: "vitor@email.com",
  );

  var plataforma1 = PlataformaVenda(
    codigoCanal: 101,
    nomeCanal: "Site Oficial SkyHorizon",
  );

  var atendente1 = Atendente(
    nome: "Raphael Lopes",
    matricula: "AT889",
    cargo: "Agente de Aeroporto",
  );

  print("--- 1. PASSAGEM PADRÃO (Construtor Vazio e Setter) ---");
  var passagemPadrao = Passagem();
  passagemPadrao.codigoLocalizador = "SH-1001"; 
  passagemPadrao.passageiro = passageiro1;
  print("Localizador: ${passagemPadrao.codigoLocalizador}"); 
  passagemPadrao.EmitirPassagem();
  
  print("Teste de Validação de Código:");
  passagemPadrao.codigoLocalizador = ""; 
  print("");

  print("--- 2. PASSAGEM COM CONSTRUTOR .all() ---");
  var passagemAll = Passagem.all(
    "SH-2002",
    passageiro: passageiro1,
    plataforma: plataforma1,
    atendente: atendente1,
    observacoes: "Bagagem extra incluída",
  );
  print("Localizador: ${passagemAll.codigoLocalizador}");
  print("Passageiro: ${passagemAll.passageiro?.nome}");
  passagemAll.AtualizarPassagem();
  print("");

  print("--- 3. PASSAGEM PRIMEIRA CLASSE (VIP, Mixins & Polimorfismo) ---");
  var passagemVIP = PassagemPrimeiraClasse(
    "VIP-9999",
    passageiro: passageiro1,
    plataforma: plataforma1,
    atendente: atendente1,
    observacoes: "Atendimento prioritário",
    loungeAcesso: "Sala VIP Lounge Star Alliance - Terminal 3",
  );

  print("Localizador: ${passagemVIP.codigoLocalizador}");
  print("Lounge Acesso: ${passagemVIP.loungeAcesso}");
  

  passagemVIP.AtualizarPassagem();
  passagemVIP.CancelarPassagem();
  print("");

  print("=== OPERAÇÕES FINALIZADAS COM SUCESSO ===");
}