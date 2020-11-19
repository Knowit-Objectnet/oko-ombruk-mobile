import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Request.dart';
import 'package:ombruk/services/forms/request/RequestPostForm.dart';
import 'package:ombruk/services/forms/request/class%20RequestDeleteForm.dart';
import 'package:ombruk/services/forms/request/class%20RequestGetForm.dart';

abstract class IRequestService {
  Future<CustomResponse<List<Request>>> fetchRequests(RequestGetForm form);
  Future<CustomResponse> postRequest(RequestPostForm form);
  Future<CustomResponse> deleteRequest(RequestDeleteForm form);
}
