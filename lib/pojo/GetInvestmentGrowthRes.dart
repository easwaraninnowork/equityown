class GetInvestmentGrowthRes {
  List<Result>? result;

  GetInvestmentGrowthRes({this.result});

  GetInvestmentGrowthRes.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? year;
  int? amount;
  dynamic? interestAmount;
  int? projectsCount;

  Result({this.year, this.amount, this.interestAmount, this.projectsCount});

  Result.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    amount = json['amount'];
    interestAmount = json['interest_amount'];
    projectsCount = json['projects_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['amount'] = this.amount;
    data['interest_amount'] = this.interestAmount;
    data['projects_count'] = this.projectsCount;
    return data;
  }
}
