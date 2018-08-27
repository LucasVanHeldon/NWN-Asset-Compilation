void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC) || GetHitDice(oPC)>1) {
        FloatingTextStringOnCreature("A guard tells you that the sewers are better left to the more inexperienced.", oPC);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(GetObjectByTag("WP_SewersExit")));
    }
}
