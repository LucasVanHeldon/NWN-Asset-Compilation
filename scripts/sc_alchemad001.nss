void main() {
    string strReagent = "Barkskin";
    object oSelf = OBJECT_SELF;
    int nTotal;

    // Get the variable from the Alchem kit
    nTotal = (GetLocalInt(oSelf, strReagent)) + 1;
    SetLocalInt(oSelf, strReagent, nTotal);
}
