//import 'package:http/http.dart' as http;

/*  Future<List<PiscumPhotoModel>> _fetchPost({
    required int pageNo,
  }) async {
    try {
      http.Response _response = await http.get(
          Uri.parse("https://picsum.photos/v2/list?page=$pageNo&limit=10"));
      if (_response.statusCode == 200) {
        List<dynamic> _data = json.decode(_response.body);
        List<PiscumPhotoModel> _result =
            _data.map((e) => PiscumPhotoModel.fromJson(e)).toList();
        return _result;
      } else {
        return [];
      }
    } catch (error) {
      logger.e(error);
      return [];
    }
  }*/