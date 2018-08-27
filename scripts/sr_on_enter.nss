void main()
{
    object oPC = GetEnteringObject();
    object oToken = GetItemPossessedBy(oPC, "StartGoldToken");

    if (!GetIsObjectValid(oToken) && GetIsPC(oPC))
    {
        object oCreated = CreateItemOnObject("startgoldtoken", oPC);
        AssignCommand(oPC, ActionEquipItem(oCreated, INVENTORY_SLOT_CWEAPON_B));

        int iClass = GetClassByPosition(1, oPC);
        switch (iClass)
        {
            case CLASS_TYPE_BARBARIAN:
                GiveGoldToCreature(oPC, 50);
        }
    }
}

