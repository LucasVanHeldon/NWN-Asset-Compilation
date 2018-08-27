

struct sItemInfo GenerateClothing() {
    struct sItemInfo item;
    item.sName = "Clothing";
    item.sBluePrint = "NW_CLOTH027";
    return item;
}

struct sItemInfo GenerateBandedMail() {
    struct sItemInfo item;
    item.sName = "Banded Mail";
    item.sBluePrint = "NW_AARCL011";
    return item;
}

struct sItemInfo GenerateFullPlate() {
    struct sItemInfo item;
    item.sName = "Full Plate";
    item.sBluePrint = "NW_AARCL007";
    return item;
}

struct sItemInfo GenerateHalfPlate() {
    struct sItemInfo item;
    item.sName = "Half Plate";
    item.sBluePrint = "NW_AARCL006";
    return item;
}

struct sItemInfo GenerateSplintMail() {
    struct sItemInfo item;
    item.sName = "Splint Mail";
    item.sBluePrint = "NW_AARCL005";
    return item;
}

struct sItemInfo GenerateLeather() {
    struct sItemInfo item;
    item.sName = "Leather Armor";
    item.sBluePrint = "NW_AARCL001";
    return item;
}

struct sItemInfo GenerateStuddedLeather() {
    struct sItemInfo item;
    item.sName = "Studded Leather Armor";
    item.sBluePrint = "NW_AARCL002";
    return item;
}


struct sItemInfo GenerateScaleMail() {
    struct sItemInfo item;
    item.sName = "Scale Mail";
    item.sBluePrint = "NW_AARCL003";
    return item;
}


struct sItemInfo GenerateBreastPlate() {
    struct sItemInfo item;
    item.sName = "Breast Plate";
    item.sBluePrint = "NW_AARCL010";
    return item;
}

struct sItemInfo GenerateHideArmor() {
    struct sItemInfo item;
    item.sName = "Hide Armor";
    item.sBluePrint = "NW_AARCL008";
    return item;
}


struct sItemInfo GenerateChainShirt() {
    struct sItemInfo item;
    item.sName = "Chain Shirt";
    item.sBluePrint = "NW_AARCL012";
    return item;
}

struct sItemInfo GenerateChainMail() {
    struct sItemInfo item;
    item.sName = "Chain Mail";
    item.sBluePrint = "NW_AARCL004";
    return item;
}



struct sItemInfo GenerateSmallShield() {
    struct sItemInfo item;
    item.sName = "Small Shield";
    item.sBluePrint = "NW_ASHSW001";
    return item;
}

struct sItemInfo GenerateLargeShield() {
    struct sItemInfo item;
    item.sName = "Large Shield";
    item.sBluePrint = "NW_ASHLW001";
    return item;
}

struct sItemInfo GenerateTowerShield()
{
    struct sItemInfo item;
    item.sName = "Tower Shield";
    item.sBluePrint = "NW_ASHTO001";
    return item;
}

void GenerateArmor();
void GenerateShield();
void GenerateHelmet();




void PlaceArmor(int num)
{
    int i;
    for(i = 0; i < num; i++)
        GenerateArmor();
}

void PlaceShield(int num)
{
    int i;
    for(i = 0; i < num; i++)
        GenerateShield();
}

void PlaceHelmet(int num)
{
    int i;
    for(i = 0; i < num; i++)
        GenerateHelmet();
}

void CreateArmor(int num, int type=-1)
{
    int i = 0;
    for(i = 0; i < num; i++)
    {
        GenerateArmor();
    }
}

void CreateShield(int num, int type=-1)
{
    int i = 0;
    for(i = 0; i < num; i++)
    {
        GenerateShield();
    }
}

void CreateHelmet(int num, int type=-1)
{
    int i = 0;
    for(i = 0; i < num; i++)
    {
        GenerateHelmet();
    }
}



