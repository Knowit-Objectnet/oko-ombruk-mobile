import 'package:flutter/material.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/forms/station/StationPatchForm.dart';
import 'package:ombruk/services/forms/station/StationPostForm.dart';

abstract class IStationService {

  Future<CustomResponse<List<Station>>> fetchStations(StationGetForm form);

  Future<CustomResponse<Station>> addStation(StationPostForm form);

  Future<CustomResponse<Station>> updateStation(StationPatchForm form);

  Future<CustomResponse> deleteStation({@required int id});
}