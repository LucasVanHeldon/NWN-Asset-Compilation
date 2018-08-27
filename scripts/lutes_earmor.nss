// Enchant Armor, Shields, Helmets

void EnchantArmor(struct sItemInfo ItemInfo)
{
    int    iTotalCost=0;
    int    iPoints=iChestLevel;
    struct sEnchantments Enchants;
    int    ticker = 0;
    int    tier=1;

    int level =  iChestLevel;
    if(d20() == 1) iPoints += d4();
    // don't generate magical items of obscene proportions
    if(level > 40) iChestLevel = 40;

    if(iChestLevel <= 3) tier=1;
    else if(iChestLevel > 3 && iChestLevel < 10)   tier=2;
    else if(iChestLevel > 10 && iChestLevel < 20)  tier=3;
    else if(iChestLevel > 20 && iChestLevel < 30)  tier=4;
    else if(iChestLevel > 30 && iChestLevel < 40) tier=5;
    else tier=6;


    Enchants.oItem      = ItemInfo.oItem;
    Enchants.sName      = ItemInfo.sName;


    Enchants.iAlign = ALL;
    Enchants.iRace = -1;
    Enchants.iOnHitDC=-1;
    Enchants.iSpellResistance=-1;

/*
    if(tier > 3 && d100() >= SPECIAL)
    {
        Enchants.iPoints = iPoints;
        Enchants         = EnchantSpecialWeapon(Enchants);
        iTotalCost       = Enchants.iValue;
    }
    else
*/
    {
        int bonus = 0;

        if(d100() > 95)
        {
            bonus = 1;
        }

        int base = (tier-1);

        if( base < 0 ) base = 0;




        Enchants.iACBonus = base+bonus;

        iTotalCost += base*3;
        iPoints    -= base*3;

        if(d100() > 95)
            iPoints += d4(tier);

        PrintString("Enchant Armor: Points="+IntToString(iPoints));



        int cost   = iTotalCost;
        int points = iPoints;
        Enchants.iPoints = iPoints;
        while(points > 0)
        {
            Enchants.iValue = 0;
            int iRoll = Die(12);
            //PrintString("Roll="+IntToString(iRoll));

            switch(iRoll)
            {
            case 1: Enchants = ImbueACBonus(Enchants); break;
            case 2: Enchants = ImbueArcaneSpellFailureDecrease(Enchants); break;
            case 3: Enchants = ImbueSaveBonus(Enchants);break;
            case 4: Enchants = ImbueSaveThrowBonus(Enchants);  break;
            case 5: Enchants = ImbueFreeAction(Enchants);  break;
            case 6: Enchants = ImbueBonusSpellSlot(Enchants); break;
            case 7: Enchants = ImbueSpellResistance(Enchants);break;
            case 8: Enchants = ImbueAbility(Enchants);break;
            case 9: Enchants = ImbueDamageImmunity(Enchants); break;
            case 10: Enchants = ImbueDamageReduction(Enchants); break;
            case 11: Enchants = ImbueDamageResistance(Enchants); break;
            case 12: Enchants = ImbueImprovedEvasion(Enchants); break;
            }
            //PrintString("Enchants.iValue="+IntToString(Enchants.iValue));
            // fix the watchdog to avoid infinite loops
            if(Enchants.iValue > 0) ticker = 0;
            else ticker = ticker +1;

            points -= Enchants.iValue;
            cost   += Enchants.iValue;

            if(ticker > 20) break;
        }
        iTotalCost = cost;
    }
    if(iTotalCost > 0)
    {
        Enchants.iTotalCost = iTotalCost;
        ApplyEnchantments(Enchants);
        //SetWeaponName(Enchants);
        SetName(Enchants.oItem, "Enchanted " + ItemInfo.sName);
    }
    iChestLevel = level;



}


void GenerateArmor()
{
    int iRoll = d12();
    struct sItemInfo ItemInfo;
    switch(iRoll)
    {
    case 1: ItemInfo = GenerateBandedMail(); break;
    case 2: ItemInfo = GenerateFullPlate(); break;
    case 3: ItemInfo = GenerateHalfPlate(); break;
    case 4: ItemInfo = GenerateSplintMail(); break;
    case 5: ItemInfo = GenerateLeather(); break;
    case 6: ItemInfo = GenerateStuddedLeather(); break;
    case 7: ItemInfo = GenerateScaleMail(); break;
    case 8: ItemInfo = GenerateBreastPlate(); break;
    case 9: ItemInfo = GenerateHideArmor(); break;
    case 10: ItemInfo = GenerateChainShirt(); break;
    case 11: ItemInfo = GenerateClothing(); break;
    case 12: ItemInfo = GenerateChainMail(); break;
    }

    ItemInfo.oItem = CreateObject(OBJECT_TYPE_ITEM,ItemInfo.sBluePrint,GetLocation(GetObjectByTag("DUMMYCHEST")));
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Armor " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return;
    }


    int color1=Random(64);
    int color2=Random(64);
    int color3=Random(64);
    ItemInfo.oItem=    IPDyeArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_COLOR_CLOTH1,color1);
    ItemInfo.oItem=    IPDyeArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_COLOR_CLOTH2,color2);
    ItemInfo.oItem=    IPDyeArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_COLOR_LEATHER1,color1);
    ItemInfo.oItem=    IPDyeArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_COLOR_LEATHER2,color2);
    ItemInfo.oItem=    IPDyeArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_COLOR_METAL1,color1);
    ItemInfo.oItem=    IPDyeArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_COLOR_METAL2,color2);


    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_LBICEP,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_LFOOT,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_LFOREARM,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_LHAND,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_LSHIN,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_LSHOULDER,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_LTHIGH,X2_IP_ARMORTYPE_RANDOM,TRUE);

    int nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LTHIGH);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RTHIGH,nPart);
    nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LBICEP);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RBICEP,nPart);
    nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LFOOT);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RFOOT,nPart);
    nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LFOREARM);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RFOREARM,nPart);
    nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LHAND);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RHAND,nPart);
    nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LSHIN);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RSHIN,nPart);
    nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LSHOULDER);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RSHOULDER,nPart);
    nPart = GetItemAppearance(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LTHIGH);
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RTHIGH,nPart);

    //ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_TORSO,X2_IP_ARMORTYPE_RANDOM,TRUE);
    //ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_ROBE,X2_IP_ARMORTYPE_RANDOM,TRUE);

    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_BELT,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_NECK,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedArmor(ItemInfo.oItem,ITEM_APPR_ARMOR_MODEL_PELVIS,X2_IP_ARMORTYPE_RANDOM,TRUE);


    object o = CopyItem(ItemInfo.oItem,oObject);
    DestroyObject(ItemInfo.oItem);
    ItemInfo.oItem = o;
    EnchantArmor(ItemInfo);

}

void GenerateShield()
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
        return;
    }

    object oldItem=ItemInfo.oItem;
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(ItemInfo.oItem)) DestroyObject(oldItem);

    EnchantArmor(ItemInfo);

}


void GenerateHelmet()
{
    struct sItemInfo ItemInfo;
    ItemInfo.sName = "Helmet";
    ItemInfo.sBluePrint = "lutes_helm00"+IntToString(Random(9)+1);

    ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint, oObject);
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Helmet " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return;
    }
    EnchantArmor(ItemInfo);

    object oldItem=ItemInfo.oItem;
    ItemInfo.oItem= CopyItemAndModify(ItemInfo.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(ItemInfo.oItem)) DestroyObject(oldItem);


}

