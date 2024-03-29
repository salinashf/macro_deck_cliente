const String validateIP = r'((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}';
const String validateSeqnoIP =
    r'^[0-9]*[.]?[0-9]*[0-9]*[.]?[0-9]*[0-9]*[.]?[0-9]*';

const String validatePort =
    r'^((6553[0-5])|(655[0-2][0-9])|(65[0-4][0-9]{2})|(6[0-4][0-9]{3})|([1-5][0-9]{4})|([0-5]{0,5})|([0-9]{1,4}))$';
const String validateSeqnoPort = r'^[0-9]*';
const String charClientID = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
