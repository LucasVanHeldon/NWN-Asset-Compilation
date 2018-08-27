void SubRaceDark(object oPC)
{
    if (GetSubRace(oPC) == "Gray Dwarf") {
        if (GetIsDay() && !GetLocalInt(GetArea(oPC), "InDark") && !GetLocalInt(oPC, "InDay")) {
            SetLocalInt(oPC, "InDay", TRUE);
            object oRacialWeapon = CreateItemOnObject("graydwarfdark", oPC);
            AssignCommand(oPC, ActionEquipItem(oRacialWeapon, INVENTORY_SLOT_CWEAPON_R));
            SendMessageToPC(oPC, "Gray Dwarf: Not InDark");
        }
        if ((!GetIsDay() || GetLocalInt(GetArea(oPC), "InDark")) && GetLocalInt(oPC, "InDay")) {
            SetLocalInt(oPC, "InDay", FALSE);
            object oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
            if (GetIsObjectValid(oItem))
                DestroyObject(oItem);
            SendMessageToPC(oPC, "Gray Dwarf: InDark");
        }
    } //Gray Dwarf

    if (GetSubRace(oPC) == "Drow Elf") {
        if (GetIsDay() && !GetLocalInt(GetArea(oPC), "InDark") && !GetLocalInt(oPC, "InDay")) {
            SetLocalInt(oPC, "InDay", TRUE);
            object oRacialWeapon = CreateItemOnObject("drowdark", oPC);
            AssignCommand(oPC, ActionEquipItem(oRacialWeapon, INVENTORY_SLOT_CWEAPON_R));
            SendMessageToPC(oPC, "Drow ELF: Not InDark");
        }
        if ((!GetIsDay() || GetLocalInt(GetArea(oPC), "InDark")) && GetLocalInt(oPC, "InDay")) {
            SetLocalInt(oPC, "InDay", FALSE);
            object oItem = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC);
            if (GetIsObjectValid(oItem))
                DestroyObject(oItem);
            SendMessageToPC(oPC, "Drow Elf: InDark");
        }
    } //Drow Elf
}
