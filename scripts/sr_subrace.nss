void GiveSubRaceCWeaponL(string sSubRaceWeapon, object oPC)
{
    object oRacialWeapon = CreateItemOnObject(sSubRaceWeapon, oPC);
    AssignCommand(oPC, ActionEquipItem(oRacialWeapon, INVENTORY_SLOT_CWEAPON_L));
}

string SR_SubRace(object oPC)
{
    if (GetIsPC(oPC)) {
        object oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC);
        if (GetIsObjectValid(oItem))
            DestroyObject(oItem);
        string sSubRace = GetSubRace(oPC);
        string sSRItem = "None";
        int iRace = GetRacialType(oPC);
        if (iRace == RACIAL_TYPE_DWARF) {
            if (sSubRace == "Gold Dwarf") {
                sSRItem = "golddwarfsubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Gray Dwarf") {
                sSRItem = "graydwarfsubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Shield Dwarf")
                return sSRItem;
        } // Dwarf
        if (iRace == RACIAL_TYPE_ELF) {
            if (sSubRace == "Moon Elf")
                return sSRItem;
            if (sSubRace == "Sun Elf") {
                sSRItem = "sunelfsubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Wild Elf") {
                sSRItem = "wildelfsubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Wood Elf") {
                sSRItem = "woodelfsubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Drow Elf") {
                sSRItem = "drowelfsubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
        } // Elf
        if (iRace == RACIAL_TYPE_HALFLING) {
            if (sSubRace == "Strongheart Halfling") {
                sSRItem = "strongheartsubra";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Ghostwise Halfling") {
                sSRItem = "ghostwisesubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Lightfoot Halfling")
                return sSRItem;
        } // Halfling
        if (iRace == RACIAL_TYPE_GNOME) {
            if (sSubRace == "Deep Gnome") {
                sSRItem = "deepgnomesubrace";
                GiveSubRaceCWeaponL(sSRItem, oPC);
                return sSRItem;
            }
            if (sSubRace == "Rock Gnome")
                return sSRItem;
        } // Halfling
    } // isPC
    return "None";
}
