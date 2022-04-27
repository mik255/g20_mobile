class Credentials {
  Credentials({
    required this.cpfCnpj,
    required this.passWord,
  });

  String cpfCnpj;
  String passWord;

  String setCpfCnpj(String value) {
    return cpfCnpj = value;
  }

  String setPassWord(String value) {
    return passWord = value;
  }
  toJson(){
    return {
      'cpfCnpj':cpfCnpj,
      'passWord':passWord
    };
  }
}
