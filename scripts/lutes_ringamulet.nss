// Rings, Amulets, all items must be included after
// will imbue any item but weapons and armor have their own functions.
void EnchantItem(struct sEnchantments Enchants)
{
    int iPoints=iChestLevel,iTotalCost=0;
    int    ticker = 0;
    int    tier = 0;
    int level =  iChestLevel;

    if(d6() == 1) iPoints += d4();
    if(d20() == 1) iPoints += d4(2);

    int cost   = iTotalCost;
    int points = iPoints;

    Enchants.iPoints = iPoints;

    while(points > 0)
    {
        Enchants.iValue = 0;
        int iRoll = Die(15);
        //PrintString("Roll="+IntToString(iRoll));

        // todo: cast spell, skills, feats
        switch(iRoll)
        {
        case 1: Enchants  = ImbueSaveThrowBonus(Enchants);  break;
        case 2: Enchants  = ImbueFreeAction(Enchants);  break;
        case 3: Enchants  = ImbueRegeneration(Enchants); break;
        case 4: Enchants = ImbueBonusSpellSlot(Enchants); break;
        case 5: Enchants = ImbueSpellResistance(Enchants);break;
        case 6: Enchants = ImbueSaveBonus(Enchants);break;
        case 7: Enchants = ImbueAbility(Enchants);break;
        case 8: Enchants = ImbueACBonus(Enchants); break;
        case 9: Enchants = ImbueDamageImmunity(Enchants); break;
        case 10: Enchants = ImbueDamageReduction(Enchants); break;
        case 11: Enchants = ImbueDamageResistance(Enchants); break;
        case 12: Enchants = ImbueImprovedEvasion(Enchants); break;

        case 13: Enchants = ImbueCastSpell(Enchants); break;
        case 14: Enchants = ImbueSkill(Enchants); break;
        case 15: Enchants = ImbueFeat(Enchants); break;


        }

        //PrintString("Enchants.iValue="+IntToString(Enchants.iValue));
        // fix the watchdog to avoid infinite loops
        if(Enchants.iValue > 0) ticker = 0;
        else ticker = ticker +1;

        points -= Enchants.iValue;
        cost   += Enchants.iValue;

        if(ticker > 50) break;
    }
    iTotalCost = cost;
    if(iTotalCost > 0)
    {
        Enchants.iTotalCost = iTotalCost;
        ApplyEnchantments(Enchants);
    }

}

void GenerateRing()
{
    string sRing = "lutes_ring0";
    int n = Random(10)+1;
    if( n < 10) sRing = sRing + "0" + IntToString(n);
    else sRing = sRing + IntToString(n);
    object oRing = CreateItemOnObject(sRing,oObject,1);
    SetIdentified(oRing,bIdentified);
    struct sEnchantments Enchants;

    object oldItem=oRing;
    oRing= CopyItemAndModify(oRing, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oRing)) DestroyObject(oldItem);

    Enchants.oItem = oRing;
    Enchants.sName = "Enchanted Ring";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
}

void GenerateAmulet()
{
    string sAmulet = "lutes_amulet0";
    int n = Random(10)+1;
    if( n < 10) sAmulet = sAmulet + "0" + IntToString(n);
    else sAmulet = sAmulet + IntToString(n);
    object oAmulet = CreateItemOnObject(sAmulet,oObject,1);
    SetIdentified(oAmulet,bIdentified);
    struct sEnchantments Enchants;
    object oldItem=oAmulet;
    oAmulet= CopyItemAndModify(oAmulet, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oAmulet)) DestroyObject(oldItem);

    Enchants.oItem = oAmulet;
    Enchants.sName = "Enchanted Amulet";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
}

