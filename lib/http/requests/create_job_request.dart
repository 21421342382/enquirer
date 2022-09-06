import 'package:arcopen_enquirer/http/requests/base_request.dart';

class CreateJobRequest extends BaseRequest {
  CreateJobRequest({
    this.businessName,
    this.jobCategory,
    this.jobType,
    this.shiftType,
    this.vacancies,
    this.budget,
    this.jobDescription,
    this.shiftStartDate,
    this.shiftEndDate,
    this.shiftStartTime,
    this.shiftEndTime,
    this.address,
    this.city,
    this.isDraft,
    this.emergencyRate,
    this.fileName,
    this.contract,
  });

  String? businessName;
  String? jobCategory;
  String? jobType;
  String? shiftType;
  String? vacancies;
  String? budget;
  String? jobDescription;
  String? shiftStartDate;
  String? shiftEndDate;
  String? shiftStartTime;
  String? shiftEndTime;
  String? address;
  String? city;
  String? isDraft;
  String? emergencyRate;
  String? fileName;
  String? contract;

  Map<String, dynamic> toJson() => {
        "business_name": businessName,
        "job_category": jobCategory,
        "job_type": jobType,
        "shift_type": shiftType,
        "vacancies": vacancies,
        "budget": budget,
        "job_description": jobDescription,
        "shift_start_date": shiftStartDate,
        "shift_end_date": shiftEndDate,
        "shift_start_time": shiftStartTime,
        "shift_end_time": shiftEndTime,
        "address": address,
        "city": city,
        "is_draft": isDraft,
        "emergency_rate": emergencyRate,
        "file_name": fileName,
        "contract": contract,
      };
}
