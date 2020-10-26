import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/viewmodel/PartnerViewModel.dart';
import 'package:provider/provider.dart';

// DEPRECATED
class PartnerPicker extends StatelessWidget {
  final Partner selectedPartner;
  final ValueChanged<Partner> partnerChanged;
  final Color backgroundColor;

  PartnerPicker({
    @required this.selectedPartner,
    @required this.partnerChanged,
    this.backgroundColor = CustomColors.osloWhite,
  }) : assert(partnerChanged != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CustomIcons.image(CustomIcons.driver)),
          Container(
            child: DropdownButton<Partner>(
              value: selectedPartner,
              hint: Text('Velg partner'),
              onChanged: partnerChanged,
              underline: Container(),
              items: [],
              //   items: partnerViewModel.partners
              //       .map((partner) => DropdownMenuItem(
              //             value: partner,
              //             child: Text(partner.name ?? ''),
              //           ))
              //       .toList(),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:meta/meta.dart';
// import 'package:flutter/material.dart';
// import 'package:ombruk/models/Partner.dart';
// import 'package:ombruk/ui/shared/const/CustomColors.dart';
// import 'package:ombruk/ui/shared/const/CustomIcons.dart';
// import 'package:ombruk/viewmodel/PartnerViewModel.dart';
// import 'package:provider/provider.dart';

// class PartnerPicker extends StatelessWidget {
//   final Partner selectedPartner;
//   final ValueChanged<Partner> partnerChanged;
//   final Color backgroundColor;

//   PartnerPicker({
//     @required this.selectedPartner,
//     @required this.partnerChanged,
//     this.backgroundColor = CustomColors.osloWhite,
//   }) : assert(partnerChanged != null);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PartnerViewModel>(
//       builder: (context, PartnerViewModel partnerViewModel, child) {
//         return Container(
//           color: backgroundColor,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                   padding: EdgeInsets.only(right: 8.0),
//                   child: CustomIcons.image(CustomIcons.driver)),
//               Container(
//                 child: DropdownButton<Partner>(
//                   value: selectedPartner,
//                   hint: Text('Velg partner'),
//                   onChanged: partnerChanged,
//                   underline: Container(),
//                   items: partnerViewModel.partners
//                       .map((partner) => DropdownMenuItem(
//                             value: partner,
//                             child: Text(partner.name ?? ''),
//                           ))
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
