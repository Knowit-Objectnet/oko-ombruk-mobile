import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/DataProvider/WeightReportClient.dart';
import 'package:ombruk/blocs/WeightReportBloc.dart';
import 'package:ombruk/repositories/WeightReportRepository.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportScreen.dart';

class WeightRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WeightReportRepository weightReportRepository =
        WeightReportRepository(apiClient: WeightReportClient());

    return BlocProvider(
      create: (context) =>
          WeightReportBloc(weightReportRepository: weightReportRepository)
            ..add(WeightReportLoadRequested()),
      child: BlocBuilder<WeightReportBloc, WeightReportState>(
        builder: (context, state) {
          if (state is WeightReportInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is WeightReportLoadSuccess) {
            return WeightReportScreen(weightEvents: state.weightEvents);
          }
          if (state is WeightReportLoadFailure) {
            return Center(child: Text('Kunne ikke laste inn vektuttakt'));
          }
          return Container();
        },
      ),
    );
  }
}
