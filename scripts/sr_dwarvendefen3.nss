void main()
{
    object oPrestigeItem = CreateItemOnObject("dwarfdefendarmor", GetPCSpeaker());
    AssignCommand(GetPCSpeaker(), ActionEquipItem(oPrestigeItem, INVENTORY_SLOT_CARMOUR));

}
