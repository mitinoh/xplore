
// TODO trovare nome migliore
enum ReportUserType { SPAM, NUDE, SCAM, HATE, BULLYING, OTHER }

extension ReportUserExtension on ReportUserType {
  String get description {
    switch (this) {
      case ReportUserType.SPAM:
        return "Spam";

      case ReportUserType.NUDE:
        return "Nudo o atti sessuali";

      case ReportUserType.SCAM:
        return "Truffa o frode";

      case ReportUserType.HATE:
        return "Discorsi o simboli che incitano all'odio";

      case ReportUserType.BULLYING:
        return "Bullismo o intimidazioni";

      case ReportUserType.OTHER:
        return "Altro";

      default:
        return "Altro";
    }
  }
}
