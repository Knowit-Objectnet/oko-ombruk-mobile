abstract class UttaksType {
  static const String ENGANGSTILFELLE = "Engangstilfelle";
  static const String UKENTLIG = "Ukentlig";
  static const String BI_UKENTLIG = "Annenhver uke";

  static Set<String> get values => const {
        ENGANGSTILFELLE,
        UKENTLIG,
        BI_UKENTLIG,
      };

  static int getInterval(String type) {
    switch (type) {
      case UttaksType.UKENTLIG:
        return 1;
        break;
      case UttaksType.BI_UKENTLIG:
        return 2;
        break;
      default:
        return 1;
        break;
    }
  }
}
