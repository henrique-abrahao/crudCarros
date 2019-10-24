class Cars {
  int id;
  String nome;
  String cor;
  String imagem;
  String modelo;
  String ano;
  String combustivel;

  Cars();

  Cars.fromMap(Map map) {
    id = map['id'];
    nome= map['nome'];
    ano= map['ano'];
    combustivel= map['combustivel'];
    cor= map['cor'];
    imagem= map['imagem'];
    modelo= map['modelo'];
  }

  Map toMap(){
    Map<String, dynamic> map = {
        "nome": nome,
        "ano": ano ?? 'Não Informado',
        "combustivel": combustivel ?? 'Não Informado',
        'cor': cor ?? 'Não Informado',
        'imagem': imagem,
        'modelo': modelo ?? 'Não Informado'
    };
    if(id != null){
      map['id'] = id;
    }
      return map;
    }
  @override
  String toString() {
    return "Cars(id: $id, nome:$nome, ano: $ano, combustivel: $combustivel, cor: $cor, imagem: $imagem, modelo: $modelo)";
  }
}


