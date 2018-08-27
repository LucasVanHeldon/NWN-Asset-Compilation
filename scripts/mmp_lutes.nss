#include "lutes"


void MMP_DoEquip()
{
    AssignCommand(OBJECT_SELF,ActionEquipMostEffectiveArmor());
}

object MMP_GenerateRing()
{
    string sRing = "lutes_ring0";
    int n = Random(10)+1;
    if( n < 10) sRing = sRing + "0" + IntToString(n);
    else sRing = sRing + IntToString(n);
    object oRing = CreateItemOnObject(sRing,oObject,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oRing;
    Enchants.sName = "Enchanted Ring";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
    return oRing;
}

object MMP_GenerateAmulet()
{
    string sAmulet = "lutes_amulet0";
    int n = Random(10)+1;
    if( n < 10) sAmulet = sAmulet + "0" + IntToString(n);
    else sAmulet = sAmulet + IntToString(n);
    object oAmulet = CreateItemOnObject(sAmulet,oObject,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oAmulet;
    Enchants.sName = "Enchanted Amulet";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
    return oAmulet;
}

object MMP_GenerateWand()
{
    string item = "lutes_wand";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Wand";
    SetName(oitem,Enchants.sName);
    SetIdentified(oitem, TRUE);
    EnchantMagic(Enchants);
    return oitem;
}

object MMP_GenerateStaff()
{
    string item = "lutes_staff";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Staff";
    SetName(oitem,Enchants.sName);
    struct sItemInfo info;

    struct sItemInfo wi;
    wi.sBluePrint=item;
    wi.sName     ="Enchanted Staff";
    wi.wType     = WEAPON_STAFF;
    EnchantWeapon(wi);
    EnchantMagic(Enchants);
    return oitem;
}

object MMP_GenerateRod()
{
    string item = "lutes_rod";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Rod";
    SetName(oitem,Enchants.sName);
    SetIdentified(oitem, TRUE);
    EnchantMagic(Enchants);
    return oitem;
}


object MMP_GenerateClericWeapon(int type = -1)
{
    struct sItemInfo ItemInfo;

    int iRoll = Random(5)+1;
    ItemInfo=GenerateBluntWeapon();

    ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint,oObject);
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Weapon " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return OBJECT_INVALID;
    }
    EnchantWeapon(ItemInfo);
    return ItemInfo.oItem;
}

object MMP_GenerateHeavyArmor()
{
    int iRoll = d6();
    struct sItemInfo ItemInfo;
    switch(iRoll)
    {
    case 1: ItemInfo = GenerateBandedMail(); break;
    case 2: ItemInfo = GenerateFullPlate(); break;
    case 3: ItemInfo = GenerateHalfPlate(); break;
    case 4: ItemInfo = GenerateSplintMail(); break;
    case 5: ItemInfo = GenerateScaleMail(); break;
    case 6: ItemInfo = GenerateBreastPlate(); break;
    case 7:
    default:
        ItemInfo = GenerateChainMail(); break;
    }

    ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint,oObject);
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Armor " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return OBJECT_INVALID;
    }
    EnchantArmor(ItemInfo);
    return ItemInfo.oItem;

}


object MMP_GenerateShield()
{
    int iRoll = d3();
    struct sItemInfo ItemInfo;

    switch(iRoll)
    {
    case 1: ItemInfo = GenerateSmallShield(); break;
    case 2: ItemInfo = GenerateLargeShield(); break;
    case 3: ItemInfo = GenerateTowerShield(); break;
    }

    ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint,oObject);
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Shield " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return OBJECT_INVALID;
    }

    EnchantArmor(ItemInfo);
    return ItemInfo.oItem;

}

