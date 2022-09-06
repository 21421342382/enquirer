import 'package:arcopen_enquirer/http/exceptions/request_exception.dart';
import 'package:arcopen_enquirer/http/responses/explore_members_response.dart';
import 'package:arcopen_enquirer/utils/repositories/base_repository.dart';
import 'package:dio/dio.dart';

class MembersRepository extends BaseRepository {
  Future<ExploreMembersResponse> exploreMembers() async {
    try {
      Response response = await client.get(path: "/exploreMembers/");
      return ExploreMembersResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw new RequestException(this.extractErrorMessageFromDioError(e));
    }
  }
}
