void main() {
    string strReagent = "Gold";
    int iGoldCost = 5000;
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nTotal;

    // Get the variable from the Alchem kit
    nTotal = (GetLocalInt(oSelf, strReagent)) + iGoldCost;
    SetLocalInt(oSelf, strReagent, nTotal);

    // Remove the gold from the PC
    TakeGoldFromCreature(iGoldCost, oPC, TRUE);
}
