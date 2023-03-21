class Booking {
  int id, userId, empId, jobId, workTime, price;
  String usename, empName, status, location, jobName, description, jobImage;
  DateTime timestamp;
  Booking({
    required this.id,
    required this.userId,
    required this.usename,
    required this.empId,
    required this.empName,
    required this.status,
    required this.workTime,
    required this.timestamp,
    required this.price,
    required this.location,
    required this.jobId,
    required this.jobName,
    required this.description,
    required this.jobImage,
  });
}
