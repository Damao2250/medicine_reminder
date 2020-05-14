class Conflits {
  String medicineA;
  String medicineB;

  Conflits(this.medicineA, this.medicineB);
}

List<Conflits> conflits = [
  Conflits('NSAIDS', '糖皮质激素'),
  Conflits('ACEI', '氨苯蝶啶'),
  Conflits('华法林', '胺碘酮'),
  Conflits('华法林', 'NASID'),
  Conflits('西咪替丁', '茶碱')
];

bool isConfilts(String nameA,String nameB) {
  for (var c in conflits) {
    if ((nameA==c.medicineA&&nameB==c.medicineB)||(nameB==c.medicineA&&nameA==c.medicineB)){
      //  var s = nameA+"与"+nameB+"不能联用";
      return true;
    }
  }
  return false;
}