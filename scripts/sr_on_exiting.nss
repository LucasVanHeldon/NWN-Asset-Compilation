void main()
{
    object oPC = GetExitingObject();
    string sPCHP = "HP_" + GetName(oPC);
    SetLocalInt(GetModule(), sPCHP, GetCurrentHitPoints(oPC));
    if (GetCurrentHitPoints(oPC) == 0)
        SetLocalInt(oPC, sPCHP, 1000);

}
