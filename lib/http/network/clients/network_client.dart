abstract class NetworkClient {
  Future get({required String path, dynamic args});
  Future post({required String path, dynamic args});
  Future put({required String path, dynamic args});
  Future delete({required String path});
}
