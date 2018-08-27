
void EnchantPotion(struct sEnchantments Enchants)
{
    int iPoints=iChestLevel;
    int iTotalCost=0;
    int iTemp = iChestLevel;

    if(iChestLevel > 9) iChestLevel=9;


    int cost   = iTotalCost;
    int points = iChestLevel;
    if(d6() == 1) iPoints += d4();
    if(d20() == 1) iPoints += d4(2);

    Enchants.iPoints = iPoints;
    if(points > 0)
    {
        Enchants.iValue = 0;

        points -= Enchants.iValue;
        cost   += Enchants.iValue;
    }

    iTotalCost = cost;
    if(iTotalCost > 0)
    {
        Enchants.iTotalCost = iTotalCost;
        ApplyEnchantments(Enchants);
    }

    iChestLevel = iTemp;
}

void EnchantScroll(struct sEnchantments Enchants)
{
    int iPoints,iTotalCost=0;
    int ticker = 0;

    int cost   = iTotalCost;
    int points = iChestLevel;

    if(d6() == 1) iPoints += d4();
    if(d20() == 1) iPoints += d4(2);

    Enchants.iPoints = iPoints;
    if(points > 0)
    {
        Enchants.iValue = 0;
        Enchants = ImbueCastSpell(Enchants);
        points -= Enchants.iValue;
        cost   += Enchants.iValue;
    }

    iTotalCost = cost;
    if(iTotalCost > 0)
    {
        Enchants.iTotalCost = iTotalCost;
        ApplyEnchantments(Enchants);
    }

}

void EnchantMagic(struct sEnchantments Enchants)
{
    int iPoints=iChestLevel,iTotalCost=0;
    int    ticker = 0;


    int cost   = iTotalCost;

    if(d6() == 1) iPoints += d4();
    if(d20() == 1) iPoints += d4(2);
    int points = iPoints;
    Enchants.iPoints = iPoints;

    while(points > 0)
    {
        Enchants.iValue = 0;
        Enchants = ImbueCastSpell(Enchants);

        if(Enchants.iValue > 0) break;
        else ticker = ticker +1;

        points -= Enchants.iValue;
        cost   += Enchants.iValue;

        if(ticker > 20) break;
    }

    iTotalCost = cost;
    if(iTotalCost > 0)
    {
        Enchants.iTotalCost = iTotalCost;
        ApplyEnchantments(Enchants);
    }
}

void EnchantSpellBook(struct sItemInfo ItemInfo)
{
    int    iTotalCost=0;
    int    iPoints=iChestLevel;
    struct sEnchantments Enchants;
    int    ticker = 0;
    int    tier=1;

    int level =  iChestLevel;


    if(d6() == 1) iPoints += d4();
    if(d20() == 1) iPoints += d4(2);

    Enchants.iPoints = iPoints;

    if(level > 40) iChestLevel = 40;


    Enchants.oItem      = ItemInfo.oItem;
    Enchants.sName      = ItemInfo.sName;

    int cost   = iTotalCost;
    int points = iPoints;
    Enchants.iPoints = iPoints;
    while(points > 0)
    {
        Enchants.iValue = 0;
        Enchants = ImbueCastSpell(Enchants);

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

    iChestLevel = level;
}


void GeneratePotion()
{
    string item = "lutes_potions";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Potion";
    SetName(oitem,Enchants.sName);
    EnchantPotion(Enchants);
    SetIdentified(oitem,bIdentified);
}

void GenerateScroll()
{
    string item = "lutes_scrolls";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Scroll";
    SetName(oitem,Enchants.sName);
    EnchantScroll(Enchants);
    SetIdentified(oitem,bIdentified);
}

void PlaceScrolls(int max)
{
    int i;
    for(i = 0; i < max; i++) GenerateScroll();
}

void PlacePotions(int max)
{
    int i;
    for(i = 0; i < max; i++) GeneratePotion();
}



void GenerateWand()
{
    string item = "lutes_wand";
    object oitem = CreateObject(OBJECT_TYPE_ITEM,item,GetLocation(GetObjectByTag("DUMMYCHEST")));
    SetIdentified(oitem,bIdentified);
    struct sEnchantments Enchants;

    /*
    object oldItem=oitem;
    oitem= CopyItemAndModify(Enchants.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oitem)) DestroyObject(oldItem);
    */

    object oItem = oitem;
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_COLOR_BOTTOM,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_COLOR_TOP,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_BOTTOM,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_MIDDLE,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_TOP,X2_IP_WEAPONTYPE_RANDOM,TRUE);

    object o = CopyItem(oItem,oObject);
    DestroyObject(oItem);
    oitem = o;

    Enchants.oItem = oitem;

    Enchants.sName = "Enchanted Wand";
    SetName(oitem,Enchants.sName);
    EnchantMagic(Enchants);

}

void GenerateStaff()
{
    string item = "lutes_staff";
    object oitem = CreateObject(OBJECT_TYPE_ITEM,item,GetLocation(GetObjectByTag("DUMMYCHEST")));
    SetIdentified(oitem,bIdentified);
    struct sEnchantments Enchants;

    object oItem = oitem;
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_COLOR_BOTTOM,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_COLOR_TOP,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_BOTTOM,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_MIDDLE,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_TOP,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oitem = oItem;

    object o = CopyItem(oItem,oObject);
    DestroyObject(oItem);
    oitem = o;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Staff";
    SetName(oitem,Enchants.sName);
    EnchantMagic(Enchants);
}

void GenerateRod()
{
    string item = "lutes_rod";
    object oitem = CreateObject(OBJECT_TYPE_ITEM,item,GetLocation(GetObjectByTag("DUMMYCHEST")));
    struct sEnchantments Enchants;

    object oItem = oitem;
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_COLOR_BOTTOM,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_COLOR_TOP,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_BOTTOM,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_MIDDLE,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedWeapon(oItem,ITEM_APPR_WEAPON_MODEL_TOP,X2_IP_WEAPONTYPE_RANDOM,TRUE);
    oitem = oItem;

    object o = CopyItem(oItem,oObject);
    DestroyObject(oItem);
    oitem = o;

    Enchants.oItem = oitem;

    Enchants.sName = "Enchanted Rod";
    SetName(oitem,Enchants.sName);

    EnchantMagic(Enchants);
    SetIdentified(oitem,bIdentified);
}

void GenerateGem()
{
    string tag = "NW_IT_GEM0";
    int x = Random(15)+1;
    if(x < 10) tag = tag + "0";
    tag = tag + IntToString(x);
    string item = tag;
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Gem";
    SetName(oitem,Enchants.sName);
    SetIdentified(oitem, TRUE);

    EnchantMagic(Enchants);
}



void GenerateSpellBook()
{
    struct sItemInfo info;
    info.sBluePrint = "grimoire";
    info.oItem = CreateItemOnObject("grimoire",oObject);
    object oldItem=info.oItem;
    info.oItem= CopyItemAndModify(info.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(info.oItem)) DestroyObject(oldItem);

    SetIdentified(info.oItem,bIdentified);
    EnchantSpellBook(info);
    SetName(info.oItem,"Spell Book");
    SetItemCharges(info.oItem,1);

}

void PlaceSpellBooks(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateSpellBook();
}


void PlaceWand(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateWand();
}

void PlaceRod(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateRod();
}

void PlaceStaff(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateStaff();
}

void PlaceArcaneScrolls(int n)
{
    int i;
    for(i = 0; i < n; i++) CreateArcaneScroll(oObject,oObject);
}

void PlaceDivineScrolls(int n)
{
    int i;
    for(i = 0; i < n; i++) CreateDivineScroll(oObject,oObject);
}

void GenerateRing();
void GenerateAmulet();

void PlaceGem()
{
    GenerateGem();
}

void PlaceRings(int n)
{
    int i;
    for(i = 0; i < n; i++)
    GenerateRing();
}

void PlaceAmulets(int n)
{
    int i;
    for(i = 0; i < n; i++)
    GenerateAmulet();
}

