#include "x2_inc_itemprop"
#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"

/********************************************************************************
 *
 * Global Variables
 * These may be set on the object (see below)
 *
 ********************************************************************************/
                                                           // special swords (d100 == 100)


int iScimitar=50;
int iKatana = 70;
int iRapier = 100;

int iShortSword    = 40;
int iLongSword     = 80;
int iGreatSword    = 90;
int iBastardSword  = 100;

int iClub         = 10;
int iLightFlail   = 20;
int iHeavyFlail   = 30;
int iMorningStar  = 40;
int iMace         = 80;
int iLightHammer  = 90;
int iWarHammer    = 100;

int iHandAxe     = 30;
int iBattleAxe   = 60;
int iDwarvenAxe  = 80;
int iGreatAxe    = 100;

int iScythe  = 10;
int iSpear   = 50;
int iHalberd = 80;
int iTrident = 100;

// set to false to use only default game items
int bUseAddons=1;

int bIdentified=TRUE;
// set to false if there is no bias towards items which hate Evil/Chaos
int bBiasGood=TRUE;

// if FALSE, it will not impose any order on combining bonuses vs something
// it could generate items with contradictory results :
//   ie a Long Sword +3 vs Evil with a +4 Attack Bonus vs Lawful Good and 1d4 Acid Damage vs Neutral
// if you want this chaos, set it to false.
int bCombineOrder=TRUE;

// if -1 chosen randomly
int iDamageBias = IP_CONST_DAMAGETYPE_DIVINE;

int iAlignBias = 39;
int iLawBias = 40;

// by default 5 or greater on a d10
int iEnhanceWeaponChance=5;

int iGoldMin    = 0;
int iGoldMax    = 100;

// If this is true Cleric and Magic user items are interchangeable between them
int bCrossCasting=FALSE;

// this is usually the level (in Hit Dice) at which the chest (or container) is valued
// it will generate items at around the level of the encounter, not the PC.
// setting this too high, results
int iChestLevel = -1;

// object item is placed on
object oObject = OBJECT_SELF;


// constants for stats
const int NONE=0;
const int STR=1;
const int INT=2;
const int DEX=3;
const int CON=4;
const int WIS=5;
const int CHA=6;

// if not NONE, set to one of the stats consts above
int iAbilityBias=NONE;

// Alignements AGAINST
const int ALL=0;
const int NEUTRAL=1;
const int LAW=2;
const int CHAOS=3;
const int GOOD=4;
const int EVIL=5;

// don't need this get rid of it
const int WEAPON_SLASH=1;
const int WEAPON_BLUNT=2;
const int WEAPON_DAGGER=3;
const int WEAPON_PIERCE=4;
const int WEAPON_OTHER=5;
const int WEAPON_ROD=6;
const int WEAPON_STAFF=7;
const int WEAPON_WAND=8;

// cleric only
const int T_HOLYMACE=1;

// only useable by Dwarf Fighter
const int T_GOBLINHAMMER=2;
const int T_ORCSLAYER=3;
const int T_GIANTSLAYER=4;

// only useable by elfens
const int T_ELFENSWORD=5;
const int T_ELFENBOW=6;

// only usable by sorcerors
const int T_SWORDOFSORCERY=7;

// useable by most
const int T_MANY_VIRTUES=8;

// Fighter
const int T_GREAT_DAMAGE=9;
const int T_REGENERATION=10;

// Evil, level drain + vampiric regeneration
const int T_VAMPIRIC=11;

// only useable by alignment group
const int T_LAWFUL=12;
const int T_CHAOTIC=13;
const int T_GOOD=14;
const int T_EVIL=15;
// only good vs race
const int T_RACE=16;
// No longer used
const int T_ENHANCED=17;
// Not used
const int T_DEADLYSLEEP=20;
// Rogues and Monks
const int T_STUNNING=21;
// Not Used
const int T_SLOWNESS=22;
// Fighter
const int T_VORPAL=23;
// Fighter or Barbarian
const int T_WOUNDING=24;
// Evil, ability drain + regeneration
const int T_NEGATIVETOUCH=25;
// Lawful Good Paladin
const int T_DIVINEMIGHT=26;
// Fighter
const int T_DRAGONSLAYER=27;
// Wizard
const int T_BANISHMENT=28;


// the odds the item will have specific purpose
int SPECIAL         = 5;
int ALIGNMENT_FOCUS = 10;
int RACE_FOCUS      = 5;

int iSkillPointInc   = 4;


// these are set by nw_ch_default7 or manually
int bMagic=FALSE;
int bWeapon=FALSE;
int bArmor=FALSE;
int bWizard=FALSE;
int bCleric=FALSE;
int bRogue=FALSE;
int bFighter=FALSE;
int bPaladin=FALSE;
int bMonk=FALSE;
int bRanger=FALSE;
int bAbberation=FALSE;
int bDragon=FALSE;
int bUndead=FALSE;
int bGiant=FALSE;
int bBard = FALSE;
int bAssassin = FALSE;
int bMagicalBeast=FALSE;
int bDruid=FALSE;
int bOutsider=FALSE;



#include "lutes_inc"
#include "lutes_alignrace"
#include "lutes_utils"
#include "lutes_imbue"
#include "lutes_armor"
#include "lutes_earmor"
#include "lutes_weapons"
#include "lutes_encweapon"
#include "lutes_scrpotions"
#include "lutes_magic"
#include "lutes_ringamulet"
#include "lutes_items"
#include "lutes_ranged"

void CreateWeapon(int num, int type=-1);
void CreateArmor(int num, int type=-1);
void CreateShield(int num, int type=-1);
void CreateHelmet(int num, int type=-1);
void CreateMoney(int max, int min=0);
void CreateScrolls(int max);
void CreatePotions(int max);
void CreateGems(int num);
void CreateJewelry(int num);
void CreateBelt();
void CreateBoots();
void CreateBracers();
void CreateGauntlets();
// generates non-magical misc items
void CreateMisc(int num);
void CreateCloak();
void CreateMagicRingAmulet();
// rings, wands, staffs, rods,amulets
void CreateMagic(int num);
// bracers, cloaks, belts, etc
void CreateMiscMagic(int num);
void CreateStdPotion();
void CreateStdScroll();


// Generate a unique weapon with possible enchantments
void GenerateMeleeWeapon(int type = -1);
// Generate unique armor items with possible enchantments
void GenerateArmor();
void GenerateShield();
void GenerateHelmet();

// these functions decide how to generate items

// If true, it will only generate standard game items
// If false, it will generate unique as well as standard items
int bStandard=FALSE;
// Internal chance it will generate items rather than select stock items
int bGenChance=95;


void GenerateBelt()
{
    string sBelt = "lutes_belt";
    object oBelt = CreateItemOnObject(sBelt,oObject,1);
    SetIdentified(oBelt,bIdentified);
    struct sEnchantments Enchants;
    Enchants.oItem = oBelt;

    object oldItem=Enchants.oItem;
    oBelt = CopyItemAndModify(Enchants.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oBelt)) DestroyObject(oldItem);

    Enchants.sName = "Enchanted Belt";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
}

void GenerateBoots()
{
    string sItem = "lutes_boots";
    object oItem = CreateItemOnObject(sItem,oObject,1);
    SetIdentified(oItem,bIdentified);

    struct sEnchantments Enchants;

    object oldItem=oItem;

    oItem= CopyItemAndModify(Enchants.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oItem)) DestroyObject(oldItem);
    Enchants.oItem = oItem;
    Enchants.oItem = oItem;
    Enchants.sName = "Enchanted Boots";
    SetName(Enchants.oItem,Enchants.sName);
    EnchantItem(Enchants);

}

void GenerateBracer()
{
    string sItem = "lutes_bracer";
    object oItem = CreateItemOnObject(sItem,oObject,1);
    SetIdentified(oItem,bIdentified);
    struct sEnchantments Enchants;
    Enchants.oItem = oItem;

    object oldItem=oItem;
    oItem= CopyItemAndModify(Enchants.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oItem)) DestroyObject(oldItem);

    Enchants.sName = "Enchanted Bracer";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
}

void GenerateGauntlet()
{
    string sItem = "lutes_gauntlet";
    object oItem = CreateItemOnObject(sItem,oObject,1);
    SetIdentified(oItem,bIdentified);
    struct sEnchantments Enchants;
    Enchants.oItem = oItem;

    object oldItem=oItem;
    oItem= CopyItemAndModify(Enchants.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oItem)) DestroyObject(oldItem);

    Enchants.sName = "Enchanted Gauntlet";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
}

void GenerateCloak()
{
    string sItem = "lutes_cloak";
    object oItem = CreateItemOnObject(sItem,oObject,1);
    SetIdentified(oItem,bIdentified);
    struct sEnchantments Enchants;
    Enchants.oItem = oItem;

    object oldItem=oItem;
    oItem= CopyItemAndModify(Enchants.oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(255));
    if(GetIsObjectValid(oItem)) DestroyObject(oldItem);

    Enchants.sName = "Enchanted Cloak";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);


}



void CreateDivineScrolls(int n)
{
    int i;
    for(i = 0; i < n; i++) CreateDivineScroll(oObject,oObject);
}

void CreateArcaneScrolls(int n)
{
    int i;
    for(i = 0; i < n; i++) CreateArcaneScroll(oObject,oObject);
}

void CreatePotions(int n)
{
    int i;
    for(i = 0; i < n; i++) CreateStdPotion();
}

void PlaceBoots(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateBoots();
}

void PlaceBracers(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateBracer();
}

void PlaceGauntlets(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateGauntlet();
}

void PlaceCloaks(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateCloak();
}

void PlaceBelt(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateBelt();
}

#include "lutes_addons"



void Lutes(object oTarget)
{
    int i,n;
    oObject = oTarget;
    if(iChestLevel == -1)
        iChestLevel = GetHitDice(oObject);

    int nGold = d20(iChestLevel);
    int chance = iChestLevel/4*10;
    int iNum = iChestLevel;

    int nGems=Random(2);
    int nJewls=0;
    int nMagic=0;
    int nMisc2 = d20() < 5? d3():0;
    int nWeapon=d20()<=5?1:0;
    int nArmor=d20()<=5?1:0;
    int nAScrolls=d20()<=5?d2():0;
    int nDScrolls=d20()<=5?d2():0;
    int nPotions=d20()<=5?d2():0;
    int nShield=d20()==1?1:0;
    int nHelmet=d20()==1?1:0;
    int nMisc=d20()==1?1:0;
    int nPoison=0;
    int nMiscMagic=0;
    int nRanged =d20()==1?1:0;
    int nAmmo=d20()<=5?d3():0;
    int nGrenades= d20()<=5?d2():0;
    int nBooks = 0;
    int nWands = 0;
    int nRods = 0;
    int nStaff=0;
    int nRings = 0;
    int nAmulets = 0;
    int nBoots = d20()==1?1:0;
    int nBracer = d20()==1?1:0;
    int nBelt = d20()==1?1:0;
    int nGauntlet =d20()==1?1:0;
    int nCloak = d20()==1?1:0;
    int nTrash = d20() < 5? 1:0;

    if( bFighter == TRUE || bGiant == TRUE || bPaladin == TRUE || bRanger == TRUE)
    {
        nWeapon   = d20() < 10? 1:0;
        nRanged   = d20() < 5? 1 : 0;
        nAmmo     = d20() < 5? 1 : 0;
        nShield   = d20() < 10? 1:0;
        nHelmet   = d20() < 10? 1:0;
        nRings    = d20() < 5? d2():0;
        nAmulets  = d20() < 5? 1:0;
        nBelt     = d20() < 5? 1:0;
        nBracer   = d20() < 5? 1:0;
        nGauntlet = d20() < 5? 1:0;
        nBoots    = d20() < 5? 1:0;
        nCloak    = d20() < 5? 1:0;

        nPotions  = Random(iChestLevel/3);
        nGems     = Random(iChestLevel/3);
        nJewls    = Random(iChestLevel/3);
        nGold     = Random(d10()*100*iChestLevel);
        nGrenades = Random(2);

    }
    else if( bWizard == TRUE)
    {
        nPotions   = Random(iChestLevel/3);
        nAScrolls  = d20() < 15? d4():0;
        nMagic     = d20() < 10? 1:0;
        nMiscMagic = d20() < 10? 1:0;
        nRings     = d20() < 10? d2():0;
        nAmulets   = d20() < 10? d2():0;
        nBelt     = d20() < 5? 1:0;
        nBracer   = d20() < 5? 1:0;
        nGauntlet = d20() < 5? 1:0;
        nBoots    = d20() < 5? 1:0;
        nCloak    = d20() < 5? 1:0;

        nGems      = Random(iChestLevel/5);
        nJewls     = Random(iChestLevel/5);
        nGold      = Random(d10()*100*iChestLevel);
        nBooks     = d20() < 10? d3():0;
        nWands     = d20() < 10? d3():0;
        nStaff     = d20() < 10? 1:0;

    }
    else if( bCleric == TRUE || bDruid == TRUE)
    {
        nWeapon    = d20() < 10?1:0;
        nArmor     = d20() < 10?1:0;
        nShield    = d20() < 10?1:0;
        nRings     = d20() < 10?d2():0;
        nAmulets   = d20() < 10?1:0;
        nBooks     = d20() < 5? 1:0;
        nRods      = d20() < 10? 1:0;
        nBelt     = d20() < 5? 1:0;
        nBracer   = d20() < 5? 1:0;
        nGauntlet = d20() < 5? 1:0;
        nBoots    = d20() < 5? 1:0;
        nCloak    = d20() < 5? 1:0;

        nPotions   = Random(iChestLevel/3);
        nDScrolls  = Random(iChestLevel/4);
        nMagic     = Random(iChestLevel/5);
        nGems      = Random(iChestLevel/3);
        nJewls     = Random(iChestLevel/3);
        nGold      = Random(d10()*100*iChestLevel);


    }
    else if( bRogue == TRUE || bAssassin == TRUE)
    {
        nPoison  = d4();
        nRanged  = Random(2);
        nAmmo    = Random(3);
        nWeapon  = d20() < 10? 1:0;
        nPotions = Random(iChestLevel/5);
        nGems    = Random(iChestLevel/5);
        nJewls   = Random(iChestLevel/5);
        nGold    = Random(d10()*100*iChestLevel);
        nGrenades = Random(d4());
        nBooks    = d20() < 3? 1:0;
        nWands    = d20() < 4? 1:0;
        nRings    = d20() < 10? d2():0;
        nAmulets  = d20() < 10? 1:0;

        nAScrolls = d4();
        nDScrolls = d4();
        nBelt     = d20() < 5? 1:0;
        nBracer   = d20() < 5? 1:0;
        nGauntlet = d20() < 5? 1:0;
        nBoots    = d20() < 5? 1:0;
        nCloak    = d20() < 5? 1:0;

    }
    else if( bUndead == TRUE && iChestLevel > 4)
    {
        nGems  = Random(iChestLevel/4);
        nJewls = Random(iChestLevel/4);
        nMisc   =0;
        PrintString("Undead Drop");
    }
    else if( bDragon == TRUE)
    {
        nGems  = Random(Die(100)+iChestLevel);
        nGold  = d4(iChestLevel)*1000;
        nJewls = iChestLevel;
        nRings    = Random(6);
        nAmulets  = Random(4);

        PrintString("Dragon Drop");
     }
    else if( bAbberation == TRUE)
    {
        nGems  = Random(Die(10)+iChestLevel/4);
        nGold  = Random(d4()*100*iChestLevel/4);
        nJewls = Random(iChestLevel/4);

        nMisc = 0;
        PrintString("Abberation Drop");
    }
    else if( bMagicalBeast == TRUE)
    {
        nGems  = Random(Die(10)+iChestLevel/4);
        nJewls = Random(iChestLevel/4);
        nMisc=0;
        PrintString("Magical Beast Drop");
    }

    nGold = nGold + Random(20)*nGold;

    if(nGems > 0)      CreateGems(nGems);
    if(nGold > 0 )     CreateMoney(nGold);
    if(nJewls > 0)     CreateJewelry(nJewls);
    if(nWeapon > 0)    PlaceWeapon(nWeapon);
    if(nArmor > 0)     PlaceArmor(nArmor);
    if(nShield > 0)    PlaceShield(nShield);
    if(nHelmet > 0)    PlaceHelmet(nHelmet);
    if(nRanged > 0)    PlaceRangedWeapon(nRanged);
    if(nAmmo > 0)      PlaceAmmo(nAmmo);

    if(nPotions > 0)    CreatePotions(nPotions);
    if(nAScrolls > 0)   CreateArcaneScrolls(nAScrolls);
    if(nDScrolls > 0)   CreateDivineScrolls(nDScrolls);

    if(nBooks > 0)      PlaceSpellBooks(nBooks);
    if(nWands > 0)      PlaceWand(nWands);
    if(nRods > 0)       PlaceRod(nRods);
    if(nStaff > 0)      PlaceStaff(nStaff);
    if(nRings > 0)      PlaceRings(nRings);
    if(nAmulets > 0)    PlaceAmulets(nAmulets);

    if(nBoots > 0) GenerateBoots();
    if(nGauntlet > 0) GenerateGauntlet();
    if(nBracer > 0) GenerateBracer();
    if(nBelt > 0) GenerateBelt();
    if(nCloak > 0) GenerateCloak();
    if(bUseAddons == TRUE)
    {
        // need to sort only useful properties for these
        //if(nGrenades > 0)   PlaceGrenades(nGrenades);
        if(nTrash > 0) GenerateTrash();
        if(nMisc > 0)      CreateMisc(nMisc);
        if(nMisc2 > 0)     PlaceMiscItems(nMisc);
    }
}




