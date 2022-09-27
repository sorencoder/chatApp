class MesaageModel {
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;
  MesaageModel({this.sender, this.text, this.seen, this.createdon});

  MesaageModel.fromMap(Map<String, dynamic> map) {
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    createdon = map["createdon"];
  }
  Map<String, dynamic> toMap() {
    return {
      "sender": sender,
      "text": text,
      "seen": seen,
      "createdon": createdon
    };
  }
}
