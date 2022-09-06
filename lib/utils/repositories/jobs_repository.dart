import 'package:arcopen_enquirer/http/exceptions/request_exception.dart';
import 'package:arcopen_enquirer/http/requests/add_dispute_request.dart';
import 'package:arcopen_enquirer/http/requests/create_job_request.dart';
import 'package:arcopen_enquirer/http/responses/active_job_details_response.dart';
import 'package:arcopen_enquirer/http/responses/active_jobs_response.dart';
import 'package:arcopen_enquirer/http/responses/create_job_response.dart';
import 'package:arcopen_enquirer/http/responses/dispute_response.dart';
import 'package:arcopen_enquirer/http/responses/fund_details_response.dart';
import 'package:arcopen_enquirer/http/responses/history_job_details_response.dart';
import 'package:arcopen_enquirer/http/responses/past_jobs_response.dart';
import 'package:arcopen_enquirer/http/responses/post_job_details.dart';
import 'package:arcopen_enquirer/http/responses/posted_jobs_response.dart';
import 'package:arcopen_enquirer/http/responses/remove_saved_member_response.dart';
import 'package:arcopen_enquirer/http/responses/saved_details_response.dart';
import 'package:arcopen_enquirer/utils/repositories/base_repository.dart';
import 'package:dio/dio.dart';

class JobsRepository extends BaseRepository {
  Future<PostedJobsResponse> getPostedJobs() async {
    try {
      Response response = await client.get(path: "/jobListings/");
      return PostedJobsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<bool> rejectApplication(int id) async {
    try {
      print(id);
      await client.post(path: "/jobs/api/rejectApplication/$id");
      return true;
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<PostedJobsResponse> confirmApplication(int id) async {
    try {
      Response response = await client.get(path: "/jobListings/");
      return PostedJobsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<FundDetailsResponse> fundDetailsApplication(id) async {
    try {
      Response response = await client.get(path: "/jobs/api/fundDetails/$id/");
      return FundDetailsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<ActiveJobDetailsResponse> getActiveJobDetails(int id) async {
    try {
      Response response = await client.get(path: "/activeJobDetails/$id/");
      return ActiveJobDetailsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<HistoryJobDetailsResponse> getPastJobDetails(int id) async {
    try {
      Response response = await client.get(path: "/pastProjectsDetails/$id");
      return HistoryJobDetailsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<PostedJobDetailsResponse> getPostedJobDetails(int id) async {
    try {
      Response response = await client.get(path: "/postedJobDetails/$id");
      return PostedJobDetailsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<PastJobsResponse> getPastJobs() async {
    try {
      Response response = await client.get(path: "/pastProjects/");
      return PastJobsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<ActiveJobsResponse> getActiveJobs() async {
    try {
      Response response = await client.get(path: "/activeProjects/");
      return ActiveJobsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<SavedDetailsResponse> getSavedDetails() async {
    try {
      Response response = await client.get(path: "/savedDetails/");
      return SavedDetailsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<RemoveSavedMemberResponse> removeSavedMember({required int id}) async {
    try {
      Response response = await client.delete(path: "/removeSavedMember/$id");
      return RemoveSavedMemberResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<String> saveMember({required int memberId}) async {
    try {
      Response response = await client.post(path: "/saveMember/", args: {
        "member_id": memberId,
      });
      return response.data["message"];
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<CreateJobResponse> createJob({required CreateJobRequest request}) async {
    try {
      Response response = await client.post(path: "/jobs/api/job/", args: request.toJson());
      return CreateJobResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<DisputeResponse> getDisputeJobs() async {
    try {
      Response response = await client.get(path: "/jobs/api/getDisputes");
      return DisputeResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<ActiveJobsResponse> loadMembers() async {
    try {
      Response response = await client.get(path: "/exploreMembers/");
      return ActiveJobsResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<bool> inviteFriends({params}) async {
    try {
      await client.post(path: "/jobs/api/inviteGuard", args: params);
      return true;
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }

  Future<bool> addDispute({required AddDisputeRequest request}) async {
    try {
      await client.post(path: "/jobs/api/addDispute/", args: request);
      return true;
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }
}
