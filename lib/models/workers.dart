class Worker {
  String name, image, address, introduce, jobName;
  int price, id, jobId, countRate, jobEmpId;
  double averageRate;

  Worker({
    required this.id,
    required this.jobEmpId,
    required this.jobId,
    required this.name,
    required this.image,
    required this.introduce,
    required this.countRate,
    required this.averageRate,
    required this.address,
    required this.jobName,
    required this.price,
  });
}
