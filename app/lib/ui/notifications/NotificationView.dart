import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/ui/app/widgets/AppDrawer.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';
import 'package:ombruk/ui/notifications/NotificationViewModel.dart';
import 'package:ombruk/ui/notifications/widget/admin/AdminPickupContainer.dart';
import 'package:ombruk/ui/notifications/widget/partner/PartnerContainer.dart';
import 'package:ombruk/ui/notifications/widget/partner/PartnerPickupContainer.dart';
import 'package:ombruk/ui/notifications/widget/station/StationPickupContainer.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:provider/provider.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: NotificationViewModel(
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      builder: (context, NotificationViewModel model, child) => Scaffold(
          appBar: OkoAppBar(
            title: "Varsler",
            showBackButton: false,
          ),
          drawer: AppDrawer(),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : _buildBody(model)),
    );
  }

  Widget _buildBody(NotificationViewModel model) {
    Widget _pickupContainer(Pickup pickup) {
      switch (model.role) {
        case KeycloakRoles.partner:
          return PartnerPickupContainer(
            pickup: pickup,
            button: _partnerButton(pickup, model),
          );
          break;
        case KeycloakRoles.reg_employee:
          return AdminPickupContainer(pickup: pickup);
          break;
        case KeycloakRoles.reuse_station:
          return StationPickupContainer(
              pickup: pickup, onApproveRequest: model.approveRequest);
          break;
        default:
          return Container();
      }
    }

    return RefreshIndicator(
      onRefresh: () async => await model.getPickups(notify: true),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: [
                Subtitle(text: "Aktive forespørsler"),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CustomColors.osloRed,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      model.pickups.length.toString(),
                      style: TextStyle(
                          color: CustomColors.osloWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (model.pickups.isEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("Ingen aktive forespørsler"),
              ),
            ),
          ...model.pickups.map((pickup) => _pickupContainer(pickup)).toList(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Subtitle(text: "Logg"),
          ),
          if (model.finishedPickups.isEmpty)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Du har ingen tidligere forespørsler de siste 7 dagene.",
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16.0,
                ),
              ),
            ),
          ...model.finishedPickups
              .map((pickup) => _pickupContainer(pickup))
              .toList(),
        ],
      ),
    );
  }

  Widget _partnerButton(Pickup pickup, NotificationViewModel model) {
    if (model.belongsToPartner(pickup)) {
      return PartnerContainer(
        label: "Forespørsel godkjent",
        borderColor: CustomColors.osloGreen,
      );
    }
    if (model.isRejected(pickup)) {
      return PartnerContainer(
        label: "Forespørsel avvist",
        borderColor: CustomColors.osloRed,
      );
    }
    if (model.hasApplied(pickup)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          FlatButton(
            onPressed: () => model.deleteRequest(pickup),
            child: Row(
              children: [
                CustomIcons.image(CustomIcons.close),
                Text(
                  "Meld av",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: PartnerContainer(
              label: "Avventer \n svar",
              borderColor: CustomColors.osloBlue,
              fractionalWidth: 0.45,
            ),
          ),
        ],
      );
    }
    if (pickup.chosenPartner == null) {
      return GestureDetector(
        onTap: () => model.addRequest(pickup),
        child: PartnerContainer(
          label: "Meld deg på ekstrauttak",
          backgroundColor: CustomColors.osloGreen,
          borderColor: CustomColors.osloGreen,
        ),
      );
    }
  }
}
