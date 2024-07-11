class model {
  String? title;
  String? id;
  String? acc;
  String? amount;
  String? desc;
  String? date;
  bool? status;

  model(
      {this.id,
      this.title,
      this.acc,
      this.amount,
      this.desc,
      this.status,
      this.date});

  Map<String, dynamic> tojson() => {
        "id": id,
        "title": title,
        "acc": acc,
        "amount": amount,
        "desc": desc,
        "date": date,
        "status": status
      };
}
