////////////////////////////////////////////////////////////////////////////////
// Common Functions Library
//      -TheEngine      Jan 12th, 2003
//       www.zeromassengine.com
////////////////////////////////////////////////////////////////////////////////

// NOTES for future revisions
//

////////////////////////////////////////////////////////////////////////////////
// Cursed Items v1.00
// By TheEngine
// Jan 12th, 2003
//
//  NOTE* To Remove a curse, you -must- possess the cursed item upon removal!!!!
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  Food System v1.00
//      -TheEngine      Nov  9/2002
//       www.zeromassengine.com
//
//  NOTES
//  Standard usage is 120 units for 1 day of rations (5 units per game-hour)
//  Therefore, 6 units of supplies is deducted every 24 seconds under the STANDARD conditions
//
//  *** DEC 19 - Cut the food consumption rate by 40% - it was just eating resources too fast.
//               Default Heartbeat for system is now 60 seconds instead of 24 seconds.
//             - Added code to FoodSys_HeartBeat() so if a PC is dead (0 HP), he will not
//               use food.
//  *** JAN 5, 2003 - Integrated Foodsystem scripts into Common scripts library file
//
//  STANDARD CONDITIONS
//      o 120 Supply units = 1 day of rations
//      o 6 food units for every 4 rounds (24 seconds), totalling 120 units for 1 game day
//        Since there are 480 rounds in 1 game day, there are 20 x 24-second periods in a game day.
//        20 x 6 = 120 supply units.
//      o SEASON = Fall; Time of Day = Day; CON-mod = 0; STR-mod = 0; Terrain = GRASSLAND; Modifier = NORMAL;
//        Ambient Temp = 25 C; No Clothing.
//
//  TIME Notes
//  1 round = 6 seconds, 1 turn = 60 seconds
//  2 real minutes = 1 game hour
//  48 rm's = 1 game day
//
//  CONSIDERATIONS
//      - Season
//      - Time of Day
//      - PC Constitution
//      - PC Strength
//      - Terrain Type
//      - Ambient Temperature
//      - PC Clothing/Equipment/
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
int SEASON_SUMMER                       = 1;        int SEASON_FALL                         = 2;    // JUN - AUG then SEP - NOV
int SEASON_WINTER                       = 3;        int SEASON_SPRING                       = 4;    // DEC - FEB then MAR - MAY
// Time of Day Constants
int TOD_DUSK                            = 1;        int TOD_DAWN                            = 2;
int TOD_DAY                             = 3;        int TOD_NIGHT                           = 4;
// Healing
int HEAL_EFFECTS_NONE                   = 0;        // Healing Function Constants
int HEAL_EFFECTS_BASIC                  = 1;        // Effects to be removed will be AC, Attack, and Damage Decrease
int HEAL_EFFECTS_SENSORY                = 2;        // Saving throws, Curse, Blindness and Deafness
int HEAL_EFFECTS_CONSTITUTION           = 4;        // Constitution impairments. Damage Immunity Decrease, Disease, Poison and Paralysis
int HEAL_EFFECTS_ENERGY_DRAIN           = 8;        // Negative Levels are lifted.
int HEAL_EFFECTS_ADVANCED               = 16;       // Ability decrease, Skill decrease and Spell Resistance Decrease
int HEAL_EFFECTS_ALL                    = 31;       // Remove ALL effects
// Blessing
int HEAL_BLESS_DURATION_LOW             = 16;       // 1 minutes blessing duration
int HEAL_BLESS_DURATION_MEDIUM          = 32;       // 3 minutes
int HEAL_BLESS_DURATION_HIGH            = 64;       // 6 minutes
int HEAL_BLESS_NONE                     = 0;        // Blessing 'packages'
int HEAL_BLESS_BASIC                    = 1;        // +1 AC/Attack/Saves
int HEAL_BLESS_AVERAGE                  = 2;        // +2 AC/Attack/Saves
int HEAL_BLESS_HIGH                     = 4;        // +3 AC/Attack/Saves
int HEAL_BLESS_EXTRA_DAMAGE             = 128;      // Optional Blessing Effects
int HEAL_BLESS_DAMAGE_REDUCTION         = 256;      int HEAL_BLESS_DAMAGE_RESIST_ACID       = 512;
int HEAL_BLESS_DAMAGE_RESIST_COLD       = 1024;     int HEAL_BLESS_DAMAGE_RESIST_FIRE       = 2048;
int HEAL_BLESS_HASTE                    = 4096;     int HEAL_BLESS_HIT_POINTS               = 8192;
int HEAL_BLESS_REGENERATE               = 16384;    int HEAL_BLESS_SPELL_ABSORPTION_ONE     = 32768;
int HEAL_BLESS_SPELL_ABSORPTION_TWO     = 65536;    int HEAL_BLESS_SPELL_ABSORPTION_THREE   = 131072;
// Experience Values
int XP_ATTO                             = 1;        int XP_FEMTO                            = 2;
int XP_PICO                             = 3;        int XP_NANO                             = 4;
int XP_MICRO                            = 5;        int XP_MILLI                            = 6;
int XP_CENTI                            = 7;        int XP_DECI                             = 9;
int XP_DECA                             = 10;       int XP_HECTO                            = 12;
int XP_KILO                             = 13;       int XP_MEGA                             = 15;
int XP_GIGA                             = 17;       int XP_TERA                             = 20;
int XP_PETA                             = 25;       int XP_EXA                              = 30;
int XP_ULTRA                            = 40;
// Item Category Values
int MAX_AMMO_LOW                        = 12;       int MAX_AMMO_MEDIUM                     = 16;
int MAX_AMMO_HIGH                       = 22;       int MAX_ARMOR_LOW                       = 100;
int MAX_ARMOR_MEDIUM                    = 39;       int MAX_ARMOR_HIGH                      = 9;
int MAX_BOOKS_LOW                       = 7;        int MAX_BOOKS_MEDIUM                    = 6;
int MAX_BOOKS_HIGH                      = 1;        int MAX_CLOTHING_LOW                    = 4;
int MAX_CLOTHING_MEDIUM                 = 5;        int MAX_CLOTHING_HIGH                   = 9;
int MAX_JEWELRY_LOW                     = 24;       int MAX_JEWELRY_MEDIUM                  = 81;
int MAX_JEWELRY_HIGH                    = 71;       int MAX_MISCELLANEOUS                   = 73;
int MAX_ALCHEM_NOTES                    = 14;       int MAX_POISONS                         = 53;
int MAX_POTIONS_LOW                     = 29;       int MAX_POTIONS_MEDIUM                  = 15;
int MAX_POTIONS_HIGH                    = 18;       int MAX_NWN_POTIONS                     = 23;
int MAX_REAGENTS_LOW                    = 30;       int MAX_REAGENTS_MEDIUM                 = 12;
int MAX_REAGENTS_HIGH                   = 28;       int MAX_RECIPES_LOW                     = 30;
int MAX_RECIPES_MEDIUM                  = 12;       int MAX_RECIPES_HIGH                    = 28;
int MAX_SCROLLS_LOW                     = 11;       int MAX_SCROLLS_MEDIUM                  = 2;
int MAX_SCROLLS_HIGH                    = 1;        int MAX_WEAPONS_LOW                     = 100;
int MAX_WEAPONS_MEDIUM                  = 100;      int MAX_WEAPONS_HIGH                    = 32;
// Object Quality Identifiers
float QUALITY_HIGH                        = 37.0;       float QUALITY_LOW                         = 19.0;
float QUALITY_MEDIUM                      = 26.0;
// Object Types
int OBJECT_TYPE_BARREL                  = 1;        int OBJECT_TYPE_BOOKS                   = 2;
int OBJECT_TYPE_CHEST                   = 3;        int OBJECT_TYPE_CRATE                   = 4;
int OBJECT_TYPE_GOLD_PILE               = 5;        int OBJECT_TYPE_LOOTBAG                 = 6;
int OBJECT_TYPE_MISCELLANEOUS           = 7;        int OBJECT_TYPE_WIZARD_CABINET          = 8;
// Exchange Rates
float EXCHANGE_RATE_COPPER    = 100.0;
float EXCHANGE_RATE_SILVER    = 10.0;
float EXCHANGE_RATE_ELECTRUM  = 2.0;
float EXCHANGE_RATE_GOLD      = 1.0;
float EXCHANGE_RATE_PLATINUM  = 0.2;
// Food System
int DEBUG_STATE     = FALSE;     // Switch to FALSE if Debug information is not wanted
int TERRAIN_MODIFIER_INFRA   = 0;
int TERRAIN_MODIFIER_EASY    = 1;
int TERRAIN_MODIFIER_NORMAL  = 2;
int TERRAIN_MODIFIER_HARD    = 3;
int TERRAIN_MODIFIER_ULTRA   = 4;
int TERRAIN_TYPE_FOREST     = 1;
int TERRAIN_TYPE_GRASSLAND  = 2;
int TERRAIN_TYPE_CITY       = 3;
int TERRAIN_TYPE_CAVERN     = 4;
int TERRAIN_TYPE_HILLS      = 5;
int TERRAIN_TYPE_DUNGEON    = 6;
// Effect durations
float nDurShrt = 15.0;     // Short duration 15 seconds
float nDurMedm = 30.0;     // Medium duration 30 seconds
float nDurLong = 90.0;     // Long duration 90 seconds (1.5 minutes)
float nDurUltr = 180.0;    // Ultra-Long duration 180 seconds (3 minutes)
float nDurSupr = 360.0;    // Super-Long duration 360 seconds (6 minutes)
float nDurMega = 720.0;    // Mega-Long duration 720 seconds (12 minutes)
float nDurGiga = 1440.0;   // Giga-Long duration 1440 seconds (24 minutes)
float nDurExxa = 2880.0;   // Exa-Long duration 2880 seconds (48 minutes)(1 game day)
// Constants for the Cursed-Item System
int     MAX_CURSED_ITEMS    = 6;
float   CURSE_CHECKPERIOD   = 12.0;
int     CURSE_TYPE_MUSTKEEP = 1;    // Must keep in inventory or negative effect applies
int     CURSE_TYPE_MUSTUSE  = 2;    // Must keep equipped or negative effect applies
int     CURSE_ABILITY       = 1;
int     CURSE_SKILL         = 2;
int     CURSE_DAMAGE        = 4;
int     CURSE_TOHIT         = 8;
int     CURSE_BLIND         = 16;
int     CURSE_DEAF          = 32;
int     CURSE_POLYMORPH     = 64;
int     CURSE_AC            = 128;
int     CURSE_POLY_RANDOM   = 1;    // For iParam of Curse_Info, if Polymorph will be random, select this - otherwise,
                                    // iParam should be a POLYMORPH_TYPE_* constant.


////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
struct Curse_Info {
    int iCurseType;
    int iCurse;
    int iParamA;
    int iParamB;
    int iParamC;
    string strSpecial;
};

////////////////////////////////////////////////////////////////////////////////
// Functions List //////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void        ActionForceMoveToRandomLocation(object oSubject, float fXDist, float fYDist, int iRun=TRUE);
void        AI_Movement_FlockTypeA(int iFlockRoll, float fDist=1.0, object oObject=OBJECT_SELF);
void        AI_Movement_FlockTypeB(float fMinDist=1.5, float fMaxDist=2.2, int iMoveToGroup=TRUE, object oObject=OBJECT_SELF);
void        Area_CheckForPlayers(object oArea, float fFrequency=18.0);
string      Array_AddElement(string strElement, string strArray);
string      Array_GetElement(int iElement, string strArray);
int         Array_GetTotalElements(string strArray);
void        Array_ObjectAddElement(object oObject, string strArrayName, string strElement);
string      Array_RemoveElement(int iElement, string strArray);
int         BlockCodeExecution(object oTarget, string strBlockFlag, int iReset=FALSE);
int         BlockMultiActivation(string strBlockFlag, object oTarget, float fBlockPeriod, string strMessage="Nothing happened!");
void        CreateItem(object oPC, string strItemTag, int iGiveBack);
object      CreateObjectAtDistance(int nObjectType, object oTarget, string strResRef, float fDist);
void        Curse_ApplyCurse(object oOwner, struct Curse_Info CI);
void        Curse_CheckForCurses(object oOwner);
int         Curse_IsEffectActive(object oOwner, string strItemTag, struct Curse_Info CI);
int         Curse_IsItemPlaced(object oOwner, string strItemTag, struct Curse_Info CI);
int         Curse_GetState(object oOwner, string strCurseTag);
struct      Curse_Info Curse_LookupCurse(string strCurseTag);
void        Curse_SetState(object oOwner, string strCurseTag, int iState=TRUE);
void        Debug_Report(string strMessage, object oSelf=OBJECT_SELF);
void        Doors_ActionCloseDoor(object oDoor);
void        Doors_ActionSealDoor(object oDoor, int iNoPC=TRUE);
void        Doors_BashOpenCheck(object oObject=OBJECT_SELF);
void        Doors_DelayClose(object oDoor, float fDelay);
void        Doors_DelaySeal(object oDoor, float fDelay);
int         Doors_DoBashDamage(object oDoor);
void        Doors_FakeDoorSpeak(object oDoor=OBJECT_SELF);
string      Effect_AbsorbAbility(object oAbsorber, object oVictim, int iAbility);
string      Effect_AbsorbHitPoints(object oAbsorber, object oVictim);
string      Effect_AbsorbRandomAbility(object oAbsorber, object oVictim);
string      Effect_AbsorbRandomSkill(object oAbsorber, object oVictim);
string      Effect_AbsorbSpellMemory(object oAbsorber, object oVictim);
void        Effect_AbsorptionVFX(object oAbsorber, object oVictim);
void        Effect_DischargeAbsorbedSpell(object oCaster, int iAbortOnUnknown=FALSE);
void        Effect_DischargeMemorizedSpell(object oCaster, int iSpellID);
effect      Effect_SetAbilityScore(int iValue, object oTarget, int iAbility);
void        Encounter_NightEncounterOnEnter(object oEncounter=OBJECT_SELF);
void        Encounter_NightEncounterOnExit(object oEncounter=OBJECT_SELF);
int         Experience_GetXPForDC(int iDC);
int         Experience_RewardByLevel(int iLvls, int iBaseXP);
void        Experience_RewardNearestByDC(int iDC);
void        Fire_BurnCreature(object oVictim, int iDamage, int iDamageType=DAMAGE_TYPE_FIRE, int iDC=21);
void        Fire_DoBurnCheck(int iDamage, int iDamageType=DAMAGE_TYPE_FIRE, int iDC=21, object oFire=OBJECT_SELF, float fDelay=1.0);
void        Fire_DoRandomMotion(int iHungry=FALSE, object oFire=OBJECT_SELF, float fMaxXRange=4.0, float fMaxYRange=4.0, float fXRange=0.15, float fYRange=0.15);
void        Fire_Explosion(location lCenter, int iMaxDamage=30, int iMinDamage=6, float fRadius=10.0);
void        FoodSys_ClearMessages(object oPC);
void        FoodSys_CommentOnWeather(object oPC, float fApparentTemp);
void        FoodSys_Drunk_CheckVomit(object oPC, int iMOD, int iBloodAlcohol);
void        FoodSys_Drunk_EffectDrunk(object oTarget);
void        FoodSys_Drunk_LowerBloodAlcohol(object oTarget);
void        FoodSys_Drunk_PlaySoundFemale(object oPC);
void        FoodSys_Drunk_PlaySoundMale(object oPC);
void        FoodSys_Drunk_SpeakWarning(object oPC);
void        FoodSys_Drunk_VomitEffect(object oPC, int iMOD);
int         FoodSys_GetActiveState(object oArea);
int         FoodSys_GetAmbientTemperature(object oArea);
int         FoodSys_GetConAdjPCClothing(object oPC);
int         FoodSys_GetConAdjSeason();   // Consumption Adjustment for Season
int         FoodSys_GetConAdjTerrainModifier(object oArea);
int         FoodSys_GetConAdjTerrainType(object oArea);
int         FoodSys_GetConAdjTOD();
int         FoodSys_GetFoodUse();
int         FoodSys_GetHeatRetension(object oPC);
int         FoodSys_GetMinimumFoodRate(object oArea);
int         FoodSys_GetStarvationLimit(object oPC);
int         FoodSys_GetStarveCounter(object oPC);
int         FoodSys_GetTemperatureFlux(object oArea);
int         FoodSys_GetTerrainModifier(object oArea);
int         FoodSys_GetTerrainType(object oArea);
void        FoodSys_HeartBeat(object oPC, float fHeartBeat);
void        FoodSys_Initialize(object oTarget, float fHeartBeat=60.0, int iBaseFoodUse=6);
void        FoodSys_SendMessage(object oPC, string strMessageID, string strMessage);
void        FoodSys_SetFoodUse(int iBaseFoodUse);
void        FoodSys_SetStarveCounter(object oPC, int iValue=0);
void        FoodSys_SetTerrainType(int iTerrainType=3, int iAmbientTemperature=25, int iTerrainModifier=2, int iTemperatureFlux=10, int iMinFoodRate=1, int iActive=TRUE);
void        FoodSys_ShowTerrainVars(object oPC);
int         FoodSys_TakeSupplies(object oPC, int iQuantity);
int         GetHighestLevel(object oSubject);
int         GetLevel(object oSubject);
int         GetLowestLevel(object oSubject);
int         GetMiddleLevel(object oSubject);
int         GetNumberOfNegativeEffects(object oTarget);
int         GetSeason();
string      GetSeasonString();
int         GetTOD();
string      GetTODString();
void        Heal_BeginHealing(object oPC, int iRemoveEffects = 31, int iAddBlessings = 0, int iGiveHenchPotions = TRUE, string strPotionTag = "NW_IT_MPOTION003", int iHealHench = TRUE, int iHealFamil = TRUE, int iHealOthers = TRUE, int iMinHP = 0, int iMaxHP = 0);
void        Heal_BlessingEffect(object oPC, int iAddBlessings);
void        Heal_RestoreEffect(object oTarget, int iRemoveEffects, int iMinHP, int iMaxHP, int iDoHeal=TRUE);
int         Inventory_CountItem(object oTarget, string strItemTag);
void        Inventory_DestroyAllItems(object oTarget=OBJECT_SELF);
int         Inventory_IsEquipped(object oOwner, string strItemTag);
int         Inventory_ItemCount(object oTarget);
void        Inventory_RemoveItem(object oTarget, string strItemTag);
int         Inventory_RemoveItemNumber(object oTarget, string strItemTag, int iTake=1);
void        Inventory_RemoveStackedItemQuantity(object oTarget, string strItemTag, int iRemoveNum);
void        Lightning_DamageCreatures(location lStrike, int iDifficulty=15, float fRange=10.0, int iMaxDamage=26, int iMinDamage=6);
void        Lightning_DivineFury(object oObject, float fRadius, int iTotalStrikes, int iDoesDamage=FALSE, float fDelayWindow=14.0);
void        Lightning_DoStrike(int iLightning, object oSelf);
void        Lightning_Initialize(object oSelf, int iXSize, int iYSize, int iLightningDC=15, float fLightningRange=6.0, int iLightningRandFreq=20, int iLightningConstFreq=9);
location    Location_AddVectors(vector vCurrentPosition, float fVectorX, float fVectorY, float fVectorZ, object oObject=OBJECT_SELF);
location    Location_GetLocationNearObject(object oObject, float fXRange=1.0, float fYRange=1.0);
location    Location_GetLocationNearWaypoint(string strObjectTag, float fXRange=1.0, float fYRange=1.0);
location    Location_GetRandomLocation(object oArea, int iXSize, int iYSize, int iXMargin=0, int iYMargin=0, int iHeight=0);
float       Math_FitFloatToBoundaries(float fValue, float fPoint, float fRange);
float       Math_RandomFloat(float fMaxValue);
float       Math_RandomFloatSign();
int         Math_RandomIntSign();
void        Object_AddProperty(int iEffect, int iParamA=1, int iParamB=4, int iParamC=1, object oObject=OBJECT_SELF);
void        Object_CheckDamageVsResistances(int iDown, int iSpecDam, int iDReduction, float fDur, int iResistances, object oSelf=OBJECT_SELF);
int         Object_CheckInventoryForItem(string strResource, object oObject);
int         Object_CountSameAtLocation(object oObject, location lCenter, float fSize=5.0, int iShape=SHAPE_SPHERE);
void        Object_CreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE);
void        Object_EnableRegenerators(object oObject=OBJECT_SELF);
void        Object_ForceEndCombat(object oAttacker);
void        Object_InitializeInventory(string strItemTag, int iStack=4, object oObject=OBJECT_SELF);
int         Object_IsClassAndRace(int iClassType, object oObject=OBJECT_SELF, int iExclusive=FALSE, string strName="");
int         Object_IsPCNear(object oObject=OBJECT_SELF, float fDist=15.0);
int         Object_IsPrey(object oObject=OBJECT_SELF);
object      Object_GetClosestSameInLocationShape(location lCenter, object oObject=OBJECT_SELF, float fSize=5.0, int iShape=SHAPE_SPHERE);
vector      Object_GetDensityCenter(location lCenter, object oObject=OBJECT_SELF, float fSize=5.0, int iShape=SHAPE_SPHERE);
int         Object_GetDifficulty(object oObject, int iReturnRaw=FALSE);
object      Object_GetNearestSame(object oObject=OBJECT_SELF, float fDistance=15.0);
int         Object_GetType(object oObject);
void        Object_GiveUniqueAbilities(object oObject=OBJECT_SELF);
void        Object_MakeAnimalsCommon(object oObject=OBJECT_SELF);
void        Object_RespawnContents(string strResource, int iStack=1, object oObject=OBJECT_SELF);
void        Object_RespawnSpecialInventory(object oObject, string strInventoryArray);
int         Object_SelectMemorizedSpell(object oCaster);
void        Object_SpawnMonsterFromPC(object oPlayer);
string      Object_StoreSpecialInventory(object oObject=OBJECT_SELF);
void        OnActivate_Jewelry_RingOfBlinking(object oItem, object Activator, object oTarget);
void        OnActivate_Misc_MaskOfTalquin(object oItem, object oActivator, object oTarget);
void        OnActivate_Potion_DraughtOfLife(object oItem, object oPC, object oTarget);
void        OnActivate_Potion_ElixirOfHealth(object oItem, object oActivator, object oTarget);
void        OnActivate_Potion_OilOfResistance(object oItem, object oActivator, object oTarget, int iDamageType);
void        Placeable_Altar_ShrineOfPtah(object oCloser, object oObject=OBJECT_SELF);
int         Placeable_Lever_GetState(object oLever);
int         Placeable_Lever_SwitchState(object oLever);
void        Player_HeartBeat_Raise(object oPC, float fHeartBeat=6.0, int iReviveDC = 25);
void        Player_HeartBeat_Revive(object oPC, float fHeartBeat=6.0, int iReviveDC = 25);
void        Player_RestoreToLife(object oPC);
string      Recall_GetDefaultPortalTag();
string      Recall_GetPortalTag(object oArea=OBJECT_SELF);
void        Recall_InitializeArea(string strRecallPortal, string strDefaultPortal="NULL", object oArea=OBJECT_SELF);
int         Recall_IsDefaultPortalActive();
int         Recall_IsDefaultPortalBlocked(object oArea=OBJECT_SELF);
int         Recall_IsAreaActive(object oArea=OBJECT_SELF);
int         Recall_IsRecall();
void        Recall_SetAreaBlocked(int iBlockValue=TRUE, object oArea=OBJECT_SELF);
void        Recall_SetDefaultPortal(string strDefaultPortal);
void        Respawn_ByResrefWithDelay(object oObject, float fDelay, string strInventoryArray="");
void        Respawn_DoRespawn(int iType, string strResRef, location lLoc, string strInventoryArray="");
int         RollChance(int iPercent);
int         Spell_IsOffensive(int iSpellID);
string      String_AddDigits(string strItemTag, int iValue, int iDigits=2);
string      String_GetAbilityText(int iAbility);
int         String_IsSubString(string strOriginal, string strFindThis);
void        Sunlight_CheckForSunriseInArea(object oArea, float fHeartBeat=18.0);
void        Sunlight_CheckForSunlightOnUndead(object oUndead);
void        Sunlight_DamageUndead(object oUndead, int iMaxDamage=12, int iMinDamage=6, float fFrequency=2.0, int iRepeats=20);
void        Sunlight_DestroyUndead(object oUndead);
void        Sunlight_DestroyUndeadInArea(object oArea);
void        TorchLight_Heartbeat(object oPC, float fHeartBeat, float fBurnLimit, float fBurnRate);
void        TorchLight_Initialize(object oPC, float fHeartBeat=6.0, float fBurnLimit=2880.0, float fBurnRate=6.0);
int         TorchLight_IsHoldingTorch(object oPC);
int         Treasure_Death_CreateMeat(int iProb=45, int iMax=3);
int         Treasure_Death_DecideOnBodyParts(int nPercentChance, int nQuant, string strTemplate, object oMonster);
void        Treasure_Death_DecideOnMeat(object oMonster);
void        Treasure_Death_PlaceBodyParts(object oMonster=OBJECT_SELF);
int         Treasure_ExchangeFundsForGold(object oPC, object oItem, float fExchangeRate);
void        Treasure_GenerateBook(object oContainer, object oLastOpener, int iQuality);
void        Treasure_GenerateCursedItem(object oContainer);
void        Treasure_GenerateCustomTreasure(object oContainer, int iWealth=0);
object      Treasure_GenerateMiscItem(object oContainer);
void        Treasure_GenerateNWNBook(object oContainer, object oLastOpener);
object      Treasure_GeneratePoisonPotion(object oContainer);
void        Treasure_GeneratePotion(object oContainer, object oAdventurer, int iQuality);
void        Treasure_GenerateReagent(object oContainer, int iQuality);
void        Treasure_GenerateTreasure(object oObject, object oLastOpener, int iQuality, int iType);
void        Treasure_GenerateValuable(object oContainer, object oAdventurer, int iQuality);
void        Treasure_GenerateWizardSupplies(object oContainer, object oAdventurer, int iQuality);
void        Treasure_GoldForClassAdjust(object oTarget);
int         Treasure_RollCoins(object oPC, object oItem, float fExchangeRate);
void        Treasure_StockContainerByDCAndRespawn(object oObject);
void        Weapon_FireBallista(object oWeapon, object oPC, int iPower=6);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Forces the the action subject to run to a random location, the distance of which is
// specified by the fXDist and fYDist parameters. The object will not move if the location
// generated is invalid or can't be reached.
void ActionForceMoveToRandomLocation(object oSubject, float fXDist, float fYDist, int iRun=TRUE) {
    vector vCurrentPosition = GetPosition(oSubject);
    int iDMOD = GetAbilityModifier(ABILITY_DEXTERITY, oSubject);
    int iCMOD = GetAbilityModifier(ABILITY_CONSTITUTION, oSubject);
    float fRunDistanceX = fXDist + IntToFloat(Random(iDMOD)) + IntToFloat(Random(iCMOD));
    float fRunDistanceY = fYDist + IntToFloat(Random(iDMOD)) + IntToFloat(Random(iCMOD));
    float fDirectionX = 1.0;
    float fDirectionY = 1.0;
    if (Random(100) < 50) fDirectionX = -1.0;
    if (Random(100) < 50) fDirectionY = -1.0;
    float fVX = vCurrentPosition.x + (fDirectionX * fRunDistanceX);
    float fVY = vCurrentPosition.y + (fDirectionY * fRunDistanceY);
    vector vNewPosition = Vector(fVX, fVY, vCurrentPosition.z);
    location lNewLocation = Location(GetArea(oSubject), vNewPosition, IntToFloat(Random(180)));
    AssignCommand(oSubject, ClearAllActions());
    AssignCommand(oSubject, ActionForceMoveToLocation(lNewLocation, iRun));
}

// Flocking algorithm that clusters creatures of the same species. Cohesion of the cluster is
// determined by the Charisma and Wisdom of the animals involved.
void AI_Movement_FlockTypeA(int iFlockRoll, float fDist=1.0, object oObject=OBJECT_SELF) {
    // see if we flock to others
    object oSame = Object_GetNearestSame();
    if (GetIsObjectValid(oSame)) {
        float fDist = GetDistanceToObject(oSame);
        int iABILS = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA) + GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM);
        if (iFlockRoll <= iABILS) {
            ActionForceMoveToObject(oSame, FALSE, fDist);
        }
    }
}

// Keeps creatures a minimum of fMinDist apart while moving them to the highest concentration of nearby
// similair creatures
void AI_Movement_FlockTypeB(float fMinDist=1.5, float fMaxDist=2.2, int iMoveToGroup=TRUE, object oObject=OBJECT_SELF) {
    // Keep a minimum distance from similair objects
    object oNearest = Object_GetNearestSame();
    if (GetDistanceBetween(oNearest, oObject) < fMinDist) {
        ActionMoveAwayFromObject(oNearest, FALSE, fMaxDist);
        return;
    }

    // Move toward the highest concentration of similair objects
    vector vPosition = Object_GetDensityCenter(GetLocation(oObject), oObject, 15.0);
    location lNewLocation = Location(GetArea(oObject), vPosition, IntToFloat(Random(180)));
    ActionForceMoveToLocation(lNewLocation, Random(2));
    return;
}

// This function is called from the Master OnEnter file for a given area. It schedules itself
// to run every 18 seconds (by default) and examines the area for PC's who are NOT DM's - and
// sets a variable ("iPlayerPresent") on the area to TRUE if PC's were found. Once a PC is found,
// the function aborts searching through objects to save some effort.
void Area_CheckForPlayers(object oArea, float fFrequency=18.0) {
    int iPlayerPresent = FALSE;
    object oObject = GetFirstObjectInArea(oArea);

    // Search for a PC, exclude the DM
    while(GetIsObjectValid(oObject)) {
        if (GetIsPC(oObject) && !GetIsDM(oObject)) {
            iPlayerPresent = TRUE;
            break;
        }
        oObject = GetNextObjectInArea(oArea);
    }

    // Set a variable on the area indicating if a Player was found
    SetLocalInt(oArea, "iPlayerPresent", iPlayerPresent);

    // Continue checking
    AssignCommand(oArea, DelayCommand(fFrequency, Area_CheckForPlayers(oArea, fFrequency)));
}

// Add an element!
string Array_AddElement(string strElement, string strArray) {
    string strWork = strArray + strElement + "|";
    return strWork;
}

// Access the element number passed
string Array_GetElement(int iElement, string strArray) {
    int iDelimeter;
    int iLength;
    string strWork;
    int iIndex;

    // Locate element
    for (iIndex=0; iIndex<iElement; iIndex++) {
        iDelimeter = FindSubString(strArray, "|");
        iLength = GetStringLength(strArray);
        strWork = GetSubString(strArray, iDelimeter+1, iLength-iDelimeter+1);
        strArray = strWork;
    }

    // Shave off data passed data we want
    iDelimeter = FindSubString(strArray, "|");
    return(GetStringLeft(strArray, iDelimeter));
}

// Counts the number of individual strings in the array by their delimiters '|'
int Array_GetTotalElements(string strArray) {
    int iDelimeter;
    int iLength;
    string strWork;
    int iCount=0;

    while (GetStringLength(strArray) > 0) {
        iCount++;
        iDelimeter = FindSubString(strArray, "|");
        iLength = GetStringLength(strArray);
        strWork = GetSubString(strArray, iDelimeter+1, iLength-iDelimeter+1);
        strArray = strWork;
    }
    return iCount;
}

void Array_ObjectAddElement(object oObject, string strArrayName, string strElement) {
    string strArray = GetLocalString(oObject, strArrayName);
    strArray = Array_AddElement(strElement, strArray);
    SetLocalString(oObject, strArrayName, strArray);
}

string Array_RemoveElement(int iElement, string strArray) {
    int iIndex;
    string strFinished;
    int iTotalElements = Array_GetTotalElements(strArray);

    // Copy all elements up to the element we want
    for (iIndex=0; iIndex<iElement; iIndex++) strFinished += Array_GetElement(iIndex, strArray) + "|";

    // Copy all remaining elements, skipping the one we're removing
    for (iIndex=iElement+1; iIndex<iTotalElements; iIndex++) strFinished += Array_GetElement(iIndex, strArray) + "|";

    // Return the result
    return strFinished;
}

// This function is used to ensure that some piece of code is executed only once by testing
// a flag. If the code has been run, the return value is TRUE.
// The block condition can later be reset by calling the function again with the last
// parameter as TRUE.
int BlockCodeExecution(object oTarget, string strBlockFlag, int iReset=FALSE) {
    // Check too see if we're clearing the blocking flag on the target object
    if (iReset == TRUE) {
        SetLocalInt(oTarget, strBlockFlag, FALSE);
        return FALSE;
    }
    // Check too see if the block flag has already been set. Return TRUE if it has been.
    if (GetLocalInt(oTarget, strBlockFlag)) return TRUE;

    // If the block flag was not set, then set it and return FALSE.
    SetLocalInt(oTarget, strBlockFlag, TRUE);
    return FALSE;
}

// Used to Block a section of code from running if it's already been activated and is still active.  Good
// for potions who's abilities you don't want a PC to be able to accumulate. After fBlockPeriod expires,
// the code can run again.
int BlockMultiActivation(string strBlockFlag, object oTarget, float fBlockPeriod, string strMessage="Nothing happened!") {
    if (GetLocalInt(oTarget, strBlockFlag)) { FloatingTextStringOnCreature(strMessage, oTarget); return TRUE; }
    SetLocalInt(oTarget, strBlockFlag, TRUE);
    AssignCommand(oTarget, DelayCommand(fBlockPeriod, SetLocalInt(oTarget, strBlockFlag, FALSE)));
    return FALSE;
}

// Used in combination with a DelayCommand() call to create an item on an object
// after a brief wait.
void CreateItem(object oPC, string strItemTag, int iGiveBack) {
    CreateItemOnObject(strItemTag, oPC, iGiveBack);
}

// Creates an object relative to the location of another object (such as a PC)
object CreateObjectAtDistance(int nObjectType, object oTarget, string strResRef, float fDist) {
        float fFacing = GetFacing(oTarget);                                     // Get the angle the PC is facing
        if (fFacing >= 360.0) fFacing = 720.0 - fFacing;                    // Correct for the GetFacing bug
        if (fFacing < 0.0) fFacing += (360.0);
        vector vCreate = AngleToVector(fFacing);                            // Create a vector from the angle the PC is facing
        vCreate = VectorNormalize(vCreate);                                 // Normalize the vector to a unit vector
        vector vPCPos = GetPosition(oTarget);                                   // Get the vector position of the PC
        vCreate.x = (vCreate.x * fDist) + vPCPos.x;                         // Create the vector position for the new object
        vCreate.y = (vCreate.y * fDist) + vPCPos.y;
        vCreate.z = vPCPos.z;
        location lCreate = Location(GetArea(oTarget), vCreate, fFacing);        // Create a location for the new object
        object oReturn = CreateObject(nObjectType, strResRef, lCreate);     // Create the object
        return oReturn;
}

// Applies the details of the curse to a PC
void Curse_ApplyCurse(object oOwner, struct Curse_Info CI) {
    if ((CI.iCurse & CURSE_ABILITY)   == 1)  ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAbilityDecrease(CI.iParamA, CI.iParamB), oOwner);
    if ((CI.iCurse & CURSE_SKILL)     == 2)  ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillDecrease(CI.iParamA, CI.iParamB), oOwner);
    if ((CI.iCurse & CURSE_DAMAGE)    == 4)  ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageDecrease(CI.iParamA), oOwner);
    if ((CI.iCurse & CURSE_TOHIT)     == 8)  ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackDecrease(CI.iParamA), oOwner);
    if ((CI.iCurse & CURSE_BLIND)     == 16) ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectBlindness(), oOwner);
    if ((CI.iCurse & CURSE_DEAF)      == 32) ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDeaf(), oOwner);

    int iPolyType;
    if ((CI.iCurse & CURSE_POLYMORPH) == 64) {
        if (CI.iParamA == CURSE_POLY_RANDOM) {
            int iRand = d8();
            if (iRand == 1) iPolyType = POLYMORPH_TYPE_BADGER;
            if (iRand == 2) iPolyType = POLYMORPH_TYPE_BOAR;
            if (iRand == 3) iPolyType = POLYMORPH_TYPE_COW;
            if (iRand == 4) iPolyType = POLYMORPH_TYPE_IMP;
            if (iRand == 5) iPolyType = POLYMORPH_TYPE_PENGUIN;
            if (iRand == 6) iPolyType = POLYMORPH_TYPE_PIXIE;
            if (iRand == 7) iPolyType = POLYMORPH_TYPE_WOLF;
            if (iRand == 8) iPolyType = POLYMORPH_TYPE_ZOMBIE;
        }
        else iPolyType = CI.iParamB;
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPolymorph(iPolyType), oOwner);
    }
    if ((CI.iCurse & CURSE_AC)        == 128) ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACDecrease(CI.iParamA, CI.iParamB), oOwner);
}

// Scans the object passed for instances of curses - if found, applies the curse effects if they are not
// found. Searches up to MAX_CURSED_ITEMS - 1. Run this on PC's entering the game world to re-instantiate
// old curses from previous game sessions!
void Curse_CheckForCurses(object oOwner) {
    int iCurseActive = FALSE;
    string strBase = "cu_cursed";
    string strWork;
    int iIndex;
    struct Curse_Info CI;

    // Search through the name space of Curses too see if one is active
    for (iIndex = 0; iIndex < MAX_CURSED_ITEMS; iIndex++) {
        strWork = String_AddDigits(strBase, iIndex, 3);
        if (GetLocalInt(oOwner, strWork)) {
            iCurseActive = TRUE;
            CI = Curse_LookupCurse(strWork);    // Get the details of this curse

            // If the Curse's Effects are not active, activate them
            if (!Curse_IsEffectActive(oOwner, strWork, CI)) {
                Curse_ApplyCurse(oOwner, CI);

                // If the item should be equipped, and isn't, then the curse worsens!
                if (!Curse_IsItemPlaced(oOwner, strWork, CI))   {
                    Curse_ApplyCurse(oOwner, CI);
                    FloatingTextStringOnCreature("The curse has worsened since I've defied it!", oOwner);
                }
            }
        }
    }

    // Check for curses again after CURSE_CHECKPERIOD. Shut down checking when
    // no curses remain.
    if (iCurseActive) AssignCommand(oOwner, DelayCommand(CURSE_CHECKPERIOD, Curse_CheckForCurses(oOwner)));
}

// Checks to make sure the PC has the effects that his curse specifies
int Curse_IsEffectActive(object oOwner, string strItemTag, struct Curse_Info CI) {
    int iEffectActive = TRUE;

    // Check for effects
    if (CI.iCurse == CURSE_ABILITY)     iEffectActive = GetHasEffect(EFFECT_TYPE_ABILITY_DECREASE, oOwner);
    if (CI.iCurse == CURSE_SKILL)       iEffectActive = GetHasEffect(EFFECT_TYPE_SKILL_DECREASE, oOwner);
    if (CI.iCurse == CURSE_DAMAGE)      iEffectActive = GetHasEffect(EFFECT_TYPE_DAMAGE_DECREASE, oOwner);
    if (CI.iCurse == CURSE_TOHIT)       iEffectActive = GetHasEffect(EFFECT_TYPE_ATTACK_DECREASE, oOwner);
    if (CI.iCurse == CURSE_BLIND)       iEffectActive = GetHasEffect(EFFECT_TYPE_BLINDNESS, oOwner);
    if (CI.iCurse == CURSE_DEAF)        iEffectActive = GetHasEffect(EFFECT_TYPE_DEAF, oOwner);
    if (CI.iCurse == CURSE_POLYMORPH)   iEffectActive = GetHasEffect(EFFECT_TYPE_POLYMORPH, oOwner);
    return iEffectActive;
}

// Checks to ensure the cursed item is where it's suppossed to be according to the curse specifics
int Curse_IsItemPlaced(object oOwner, string strItemTag, struct Curse_Info CI) {
    int iItemPresent = TRUE;

    // Is item where it's suppossed to be?
    if (CI.iCurseType == CURSE_TYPE_MUSTKEEP) {
        // Must be somewhere in inventory or equipped
        if (!Inventory_CountItem(oOwner, strItemTag) && !Inventory_IsEquipped(oOwner, strItemTag)) {
            FloatingTextStringOnCreature("The cursed item!!!?? Where is it?! I want it!!!", oOwner);
            iItemPresent = FALSE;
        }
    }
    else if (!Inventory_IsEquipped(oOwner, strItemTag)) {
        FloatingTextStringOnCreature("I feel compelled to use a cursed item in my possession!!!", oOwner);
        iItemPresent = FALSE; // Must be equipped
    }
    return iItemPresent;
}

// Retrieves the current state (TRUE/FALSE == ON/OFF) of a particular curse
int Curse_GetState(object oOwner, string strCurseTag) {
    return(GetLocalInt(oOwner, strCurseTag));
}

// Returns information on the curse tag that was passed in
struct Curse_Info Curse_LookupCurse(string strCurseTag) {
    struct Curse_Info CI;

    // Set Default Values
    CI.iCurseType   = -1;
    CI.iCurse       = 0;
    CI.iParamA      = 0;
    CI.iParamB      = 0;
    CI.iParamC      = 0;
    CI.strSpecial   = "";

    // Ring of Withered Hate
    if (strCurseTag == "cu_cursed000") {
        CI.iCurseType   = CURSE_TYPE_MUSTUSE;
        CI.iCurse       = CURSE_ABILITY;
        CI.iParamA      = ABILITY_STRENGTH;
        CI.iParamB      = 3;
    }

    // Skull Scorn Amulet
    if (strCurseTag == "cu_cursed001") {
        CI.iCurseType   = CURSE_TYPE_MUSTUSE;
        CI.iCurse       = CURSE_ABILITY;
        CI.iParamA      = ABILITY_INTELLIGENCE;
        CI.iParamB      = 5;
    }

    // Book of Curses
    if (strCurseTag == "cu_cursed002") {
        CI.iCurseType   = CURSE_TYPE_MUSTUSE;
        CI.iCurse       = CURSE_ABILITY;
        CI.iParamA      = ABILITY_INTELLIGENCE;
        CI.iParamB      = 5;
    }

    // Scythe of Vile Hatred
    if (strCurseTag == "cu_cursed003") {
        CI.iCurseType   = CURSE_TYPE_MUSTUSE;
        CI.iCurse       = CURSE_BLIND;
    }

    // Jacket of Many Skins
    if (strCurseTag == "cu_cursed004") {
        CI.iCurseType   = CURSE_TYPE_MUSTUSE;
        CI.iCurse       = CURSE_POLYMORPH;
        CI.iParamA      = CURSE_POLY_RANDOM;
    }

    // Rat Hide
    if (strCurseTag == "cu_cursed005") {
        CI.iCurseType   = CURSE_TYPE_MUSTUSE;
        CI.iCurse       = CURSE_POLYMORPH;
        CI.iParamA      = -1;
        CI.iParamB      = POLYMORPH_TYPE_WERERAT;
    }

    // Return the lookup result
    return CI;
}

// Used to turn the state of a particular curse on or off
void Curse_SetState(object oOwner, string strCurseTag, int iState=TRUE) {
    SetLocalInt(oOwner, strCurseTag, iState);
    if (iState == TRUE) Curse_CheckForCurses(oOwner);
}

// Output a string to the nearest PC of the object executing the function
void Debug_Report(string strMessage, object oSelf=OBJECT_SELF) {
//  NOT sure if it works!!!
/*    string strReport = GetTag(oSelf);
    strReport += ": " + strMessage;
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    SendMessageToPC(oPC, strReport);
*/
}

// Performs the close door action, but only if no PC is nearby.
void Doors_ActionCloseDoor(object oDoor) {
    if (!Object_IsPCNear(oDoor)) ActionCloseDoor(oDoor);
    else AssignCommand(oDoor, DelayCommand(20.0, Doors_ActionCloseDoor(oDoor)));
}

// Performs the seal door action, but only if no PC is nearby (when iNoPC is TRUE).  If iNoPC is
// FALSE, then the door will close automatically.
void Doors_ActionSealDoor(object oDoor, int iNoPC=TRUE) {
    if (iNoPC) {
        if (!Object_IsPCNear(oDoor)) {
            ActionCloseDoor(oDoor);
            SetLocked(oDoor, TRUE);
        }
        else AssignCommand(oDoor, DelayCommand(30.0, Doors_ActionCloseDoor(oDoor)));
    }
    else {
        ActionCloseDoor(oDoor);
        SetLocked(oDoor, TRUE);
    }
}

// Checks too see if damage done to the door causes it too open. Uses the objects
// will save to determine the number of 'Hitpoints' of damage that can be taken before
// opening.
void Doors_BashOpenCheck(object oDoor=OBJECT_SELF) {
    int iFortitude  = GetFortitudeSavingThrow(oDoor); // It gets a save for half damage
    int iHardness   = GetReflexSavingThrow(oDoor);  // Use the Reflex Save as the 'Hardness' of the door!
    int iOpenDamage = GetWillSavingThrow(oDoor);    // Max damage door can take before opening
    int iDoorDamage = GetLocalInt(oDoor, "iDoorDamage");
    int iBash = Doors_DoBashDamage(oDoor) - iHardness;
    if (iBash < 0) iBash = 0;
    object oAttacker = GetLastAttacker(oDoor);

    // Check if the door only takes half damage
    int iDC = GetHighestLevel(oAttacker) + GetAbilityScore(oAttacker, ABILITY_STRENGTH) + GetAbilityModifier(ABILITY_STRENGTH, oAttacker);
    int iRoll = d20() + iFortitude;
    if (iRoll >= iDC) iBash /= 2;  // Success
    int iTotalDamage = iDoorDamage + iBash;

    // Float the damage on the PC
    string strBashText = "I did " + IntToString(iBash) + " damage!";
    FloatingTextStringOnCreature(strBashText, oAttacker);

    // Check if the door actually opens
    if (iTotalDamage >= iOpenDamage) {
        // Effects
        effect eFX2 = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
        effect eFX3 = EffectVisualEffect(VFX_COM_SPARKS_PARRY);
        int iSound = Random(3) + 1;
        string strSound = "as_cv_woodbreak" + IntToString(iSound);
        PlaySound(strSound);
        DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX3, oDoor));
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX2, oDoor));

        // Stop the PC from attacking
        Object_ForceEndCombat(oAttacker);

        // Open the door
        ActionUnlockObject(oDoor);
        ActionOpenDoor(oDoor);
        iTotalDamage = 0;    // Reset damage counter

        // Set the door to close and lock again after a delay
        Doors_DelaySeal(oDoor, 600.0 + IntToFloat(Random(300))); //   10.0
    }
    SetLocalInt(oDoor, "iDoorDamage", iTotalDamage);
}

// Closes a door object on a delay
void Doors_DelayClose(object oDoor, float fDelay) {
    DelayCommand(fDelay, Doors_ActionCloseDoor(oDoor));
}

// Closes and Locks a door object on a delay
void Doors_DelaySeal(object oDoor, float fDelay) {
    DelayCommand(fDelay, Doors_ActionSealDoor(oDoor));
}

// Calculate an amount of damage that the Attack of the Door is likely to do
int Doors_DoBashDamage(object oDoor){
    object oAttacker = GetLastAttacker();
    object oWeapon   = GetLastWeaponUsed(oAttacker);
    int iLVL         = GetLevel(oAttacker);
    int iSTR         = GetAbilityScore(oAttacker, ABILITY_STRENGTH);
    int iSTRMod      = GetAbilityModifier(ABILITY_STRENGTH, oAttacker);
    int iBaseItem    = GetBaseItemType(oWeapon);
    int iDamage;
    int iDamageModifier;
    if (iLVL < 9) iDamageModifier = 1;
    else if (iLVL < 16) iDamageModifier = 2;
    else if (iLVL < 21) iDamageModifier = 3;
    if      (iBaseItem == BASE_ITEM_BASTARDSWORD)   iDamage = d12(iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_BATTLEAXE)      iDamage = d10(iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_DOUBLEAXE)      iDamage = d6(2+iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_GREATAXE)       iDamage = d6(2+iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_GREATSWORD)     iDamage = d6(2+iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_HALBERD)        iDamage = d12(iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_HEAVYFLAIL)     iDamage = d10(iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_WARHAMMER)      iDamage = d10(iDamageModifier) + Random(iSTR);
    else if (iBaseItem == BASE_ITEM_LONGBOW)        iDamage = d6(iDamageModifier);
    else if (iBaseItem == BASE_ITEM_LIGHTCROSSBOW)  iDamage = d4(iDamageModifier);
    else if (iBaseItem == BASE_ITEM_SHORTBOW)       iDamage = d4(iDamageModifier);
    else if (iBaseItem == BASE_ITEM_HEAVYCROSSBOW)  iDamage = d6(iDamageModifier);
    else if (iBaseItem == BASE_ITEM_SHURIKEN)       iDamage = d3(iDamageModifier);
    else if (iBaseItem == BASE_ITEM_INVALID || iBaseItem == BASE_ITEM_GLOVES || iBaseItem == BASE_ITEM_BRACER) iDamage = d4();
    else iDamage = d4(iDamageModifier) + Random(iSTR);

    // Calculate final damage
    iDamage += iSTRMod;
    return(iDamage);
}

// This function
void Doors_FakeDoorSpeak(object oDoor=OBJECT_SELF){
    int iRand = Random(7);
    string strFakeSpeak;
    if (iRand == 0) strFakeSpeak = "The door appears jammed - perhaps there's another way in.";
    if (iRand == 1) strFakeSpeak = "The door is stuck.";
    if (iRand == 2) strFakeSpeak = "The door seems blocked from the other side.";
    if (iRand == 3) strFakeSpeak = "It just will not budge!";
    if (iRand == 4) strFakeSpeak = "Something tightly blocks the doorway from the other side.";
    if (iRand == 5) strFakeSpeak = "The door appears barred from within.";
    if (iRand == 6) strFakeSpeak = "The door is heavily damaged and will not open.";
    if (iRand == 7) strFakeSpeak = "A baracade has been constructed on the inside. There doesn't appear to be anyway in...";
    AssignCommand(oDoor, SpeakString(strFakeSpeak));
}

string Effect_AbsorbAbility(object oAbsorber, object oVictim, int iAbility) {
    string strAbility = String_GetAbilityText(iAbility);
    string strReturn;

    // How much?
    int iDrain = d3();

    // Only do the drain if the ability selected can support it...
    int iScore = GetAbilityScore(oVictim, iAbility);
    int iDiff = iScore - 3;
    if (iDiff == 0) return "";
    if (iDrain > iDiff) iDrain = iDiff;

    // Absorb the Ability
    effect eDrain = SupernaturalEffect(EffectAbilityDecrease(iAbility, iDrain));
    effect eGain  = SupernaturalEffect(EffectAbilityIncrease(iAbility, iDrain));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oVictim);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGain, oAbsorber);
    Effect_AbsorptionVFX(oAbsorber, oVictim);

    // Return string indicating result
    strReturn = "absorbed " + IntToString(iDrain) + " points of " + strAbility + " from " + GetName(oVictim);
    return strReturn;
}

string Effect_AbsorbHitPoints(object oAbsorber, object oVictim) {
    // How many hitpoints?
    int iCHP = GetCurrentHitPoints(oVictim);
    int iHP = d3(GetHitDice(oVictim));
    if (iHP >= iCHP) iHP = iCHP / 2;    // Only take MAX 50% of the PC's HP!!!
    if (iHP < 1) return "";

    // Absorb the Hitpoints
    effect eDrain = EffectDamage(iHP, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
    effect eGain  = EffectTemporaryHitpoints(iHP);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oVictim);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGain, oAbsorber);
    Effect_AbsorptionVFX(oAbsorber, oVictim);

    // Return string indicating result
    string strReturn = "absorbed " + IntToString(iHP) + " points of life from " + GetName(oVictim);
    return strReturn;
}

string Effect_AbsorbRandomAbility(object oAbsorber, object oVictim) {
    // What ability?
    int iAbility;
    int iRand = Random(6);
    string strAbility;
    string strReturn;
    if (iRand == 0) strReturn = Effect_AbsorbAbility(oAbsorber, oVictim, ABILITY_CHARISMA);
    if (iRand == 1) strReturn = Effect_AbsorbAbility(oAbsorber, oVictim, ABILITY_CONSTITUTION);
    if (iRand == 2) strReturn = Effect_AbsorbAbility(oAbsorber, oVictim, ABILITY_DEXTERITY);
    if (iRand == 3) strReturn = Effect_AbsorbAbility(oAbsorber, oVictim, ABILITY_INTELLIGENCE);
    if (iRand == 4) strReturn = Effect_AbsorbAbility(oAbsorber, oVictim, ABILITY_STRENGTH);
    if (iRand == 5) strReturn = Effect_AbsorbAbility(oAbsorber, oVictim, ABILITY_WISDOM);
    return strReturn;
}

string Effect_AbsorbRandomSavingThrow(object oAbsorber, object oVictim) {
    // What saving throw?
    int iRand = Random(19);
    int iSaveType;
    string strSaveType;
    if (iRand ==  0) { strSaveType = "save vs acids"; iSaveType = SAVING_THROW_TYPE_ACID; }
    if (iRand ==  1) { strSaveType = "save vs chaos"; iSaveType = SAVING_THROW_TYPE_CHAOS; }
    if (iRand ==  2) { strSaveType = "save vs cold"; iSaveType = SAVING_THROW_TYPE_COLD; }
    if (iRand ==  3) { strSaveType = "save vs death"; iSaveType = SAVING_THROW_TYPE_DEATH; }
    if (iRand ==  4) { strSaveType = "save vs diseases"; iSaveType = SAVING_THROW_TYPE_DISEASE; }
    if (iRand ==  5) { strSaveType = "save vs divine"; iSaveType = SAVING_THROW_TYPE_DIVINE; }
    if (iRand ==  6) { strSaveType = "save vs electricity"; iSaveType = SAVING_THROW_TYPE_ELECTRICITY; }
    if (iRand ==  7) { strSaveType = "save vs evils"; iSaveType = SAVING_THROW_TYPE_EVIL; }
    if (iRand ==  8) { strSaveType = "save vs fear"; iSaveType = SAVING_THROW_TYPE_FEAR; }
    if (iRand ==  9) { strSaveType = "save vs fire"; iSaveType = SAVING_THROW_TYPE_FIRE; }
    if (iRand == 10) { strSaveType = "save vs good"; iSaveType = SAVING_THROW_TYPE_GOOD; }
    if (iRand == 11) { strSaveType = "save vs law"; iSaveType = SAVING_THROW_TYPE_LAW; }
    if (iRand == 12) { strSaveType = "save vs mind spells"; iSaveType = SAVING_THROW_TYPE_MIND_SPELLS; }
    if (iRand == 13) { strSaveType = "save vs negative"; iSaveType = SAVING_THROW_TYPE_NEGATIVE; }
    if (iRand == 14) { strSaveType = "save vs poisons"; iSaveType = SAVING_THROW_TYPE_POISON; }
    if (iRand == 15) { strSaveType = "save vs positive"; iSaveType = SAVING_THROW_TYPE_POSITIVE; }
    if (iRand == 16) { strSaveType = "save vs sonics"; iSaveType = SAVING_THROW_TYPE_SONIC; }
    if (iRand == 17) { strSaveType = "save vs spells"; iSaveType = SAVING_THROW_TYPE_SPELL; }
    if (iRand == 18) { strSaveType = "save vs traps"; iSaveType = SAVING_THROW_TYPE_TRAP; }

    // Absorb the save
    int iDrain = d3();
    effect eDrain = SupernaturalEffect(EffectSavingThrowDecrease(SAVING_THROW_ALL, iDrain, iSaveType));
    effect eGain  = SupernaturalEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, iDrain, iSaveType));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oVictim);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGain, oAbsorber);
    Effect_AbsorptionVFX(oAbsorber, oVictim);

    // Return string indicating result
    string strReturn = "absorbed " + IntToString(iDrain) + " points of " + strSaveType + " from " + GetName(oVictim);
    return strReturn;
}

string Effect_AbsorbRandomSkill(object oAbsorber, object oVictim) {
    // What Skill? (Attempt the drain whether the PC has the skill or not)
    int iSkill;
    int iRand = Random(20);
    string strSkill;
    if (iRand ==  0) { iSkill = SKILL_ANIMAL_EMPATHY; strSkill = "Animal Empathy"; }
    if (iRand ==  1) { iSkill = SKILL_CONCENTRATION; strSkill = "Concentration"; }
    if (iRand ==  2) { iSkill = SKILL_DISABLE_TRAP; strSkill = "Disabling Traps"; }
    if (iRand ==  3) { iSkill = SKILL_DISCIPLINE; strSkill = "Discipline"; }
    if (iRand ==  4) { iSkill = SKILL_HEAL; strSkill = "Healing"; }
    if (iRand ==  5) { iSkill = SKILL_HIDE; strSkill = "Hiding"; }
    if (iRand ==  6) { iSkill = SKILL_LISTEN; strSkill = "Listening"; }
    if (iRand ==  7) { iSkill = SKILL_LORE; strSkill = "Lore"; }
    if (iRand ==  8) { iSkill = SKILL_MOVE_SILENTLY; strSkill = "Moving Silently"; }
    if (iRand ==  9) { iSkill = SKILL_OPEN_LOCK; strSkill = "Opening Locks"; }
    if (iRand == 10) { iSkill = SKILL_PARRY; strSkill = "Parry"; }
    if (iRand == 11) { iSkill = SKILL_PERFORM; strSkill = "Performing"; }
    if (iRand == 12) { iSkill = SKILL_PERSUADE; strSkill = "Persuading"; }
    if (iRand == 13) { iSkill = SKILL_PICK_POCKET; strSkill = "Picking Pockets"; }
    if (iRand == 14) { iSkill = SKILL_SEARCH; strSkill = "Searching"; }
    if (iRand == 15) { iSkill = SKILL_SET_TRAP; strSkill = "Setting Traps"; }
    if (iRand == 16) { iSkill = SKILL_SPELLCRAFT; strSkill = "Spellcrafting"; }
    if (iRand == 17) { iSkill = SKILL_SPOT; strSkill = "Spotting"; }
    if (iRand == 18) { iSkill = SKILL_TAUNT; strSkill = "Taunting"; }
    if (iRand == 19) { iSkill = SKILL_USE_MAGIC_DEVICE; strSkill = "Using Magical Devices"; }

    // Abort if the PC doesn't have the selected skill
    if (GetSkillRank(iSkill, oVictim) < 1) return "";

    // How much?
    int iDrain = d2(3);

    // Proceed with the absorption!!!!!
    effect eDrain = SupernaturalEffect(EffectSkillDecrease(iSkill, iDrain));
    effect eGain  = SupernaturalEffect(EffectSkillIncrease(iSkill, iDrain));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oVictim);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGain, oAbsorber);
    Effect_AbsorptionVFX(oAbsorber, oVictim);

    // Return string indicating result
    string strReturn = "absorbed " + IntToString(iDrain) + " points of " + strSkill + " from " + GetName(oVictim);
    return strReturn;
}

// Allows the creature to 'take' memorized spells from PC's.  Places the IDs for stolen spells
// into an array for later access.
string Effect_AbsorbSpellMemory(object oAbsorber, object oVictim) {
    // Select a spell that the PC has
    int iSpellID = Object_SelectMemorizedSpell(oVictim);

    // Cause the PC to discharge it
    Effect_DischargeMemorizedSpell(oVictim, iSpellID);

    // Add the Spell ID to memory array for later access
    Array_ObjectAddElement(oAbsorber, "strAbsorbedSpells", IntToString(iSpellID));

    // Do the FX
    Effect_AbsorptionVFX(oAbsorber, oVictim);

    // Return string indicating result
    string strReturn = "absorbed spell memories from " + GetName(oVictim);
    return strReturn;
}

void Effect_AbsorptionVFX(object oAbsorber, object oVictim) {
    effect eVFX1 = EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY);
    effect eVFX2 = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX1, oAbsorber);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX2, oVictim);
}

// Causes the target object to randomly select and cast a spell that they've absorbed.
void Effect_DischargeAbsorbedSpell(object oCaster, int iAbortOnUnknown=FALSE) {
    // Select a spell to cast
    string strAbsorbedSpells = GetLocalString(oCaster, "strAbsorbedSpells");
    int iTotalAbsorbed = Array_GetTotalElements(strAbsorbedSpells);
    int iElement = Random(iTotalAbsorbed);
    int iSpellID = StringToInt(Array_GetElement(iElement, strAbsorbedSpells));

    strAbsorbedSpells = Array_RemoveElement(iElement, strAbsorbedSpells);    // Remove the element
    SetLocalString(oCaster, "strAbsorbedSpells", strAbsorbedSpells);

    // Determine if the spell is defensive or offensive
    int iSpellType = Spell_IsOffensive(iSpellID);    // Returns TRUE if the spell is used to attack with
    if ((iSpellType == -1) && iAbortOnUnknown) {
        return; // Could not identify the spell, just skip it and return.
    }

    // If spell was offensive then get last attack target and FIRE! Otherwise, cast at self.
    if (iSpellType) {   // Offensive
        object oLastAttacker = GetLastAttacker(oCaster);
        AssignCommand(oCaster, ClearAllActions(TRUE));
        AssignCommand(oCaster, ActionCastSpellAtLocation(iSpellID, GetLocation(oLastAttacker), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    }
    else {              // Defensive
        AssignCommand(oCaster, ClearAllActions(TRUE));
        AssignCommand(oCaster, ActionCastSpellAtLocation(iSpellID, GetLocation(oCaster), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    }
}

// Causes the target of the function to cast the spell specified, effectively discharging it.
void Effect_DischargeMemorizedSpell(object oCaster, int iSpellID) {
    // Get a location away from the caster...
    location lLoc = GetLocation(oCaster);
    vector vPos = GetPositionFromLocation(lLoc);
    float fX = vPos.x;
    float fY = vPos.y;
    fX += Math_RandomFloatSign() * (5.0 + Math_RandomFloat(8.0));
    fY += Math_RandomFloatSign() * (5.0 + Math_RandomFloat(8.0));
    vPos.x = fX;
    vPos.y = fY;
    lLoc = Location(GetArea(oCaster), vPos, 0.0);

    // Cast the spell off
    AssignCommand(oCaster, ActionCastSpellAtLocation(iSpellID, lLoc, METAMAGIC_ANY, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
}

// Used to set an ability score to a particular value, rather than boosting it up X points.
effect Effect_SetAbilityScore(int iValue, object oTarget, int iAbility) {
    int iMOD = iValue - GetAbilityScore(oTarget, iAbility);
    if (iMOD < 0) { iMOD = 0; FloatingTextStringOnCreature("Nothing happened!!!", oTarget); }
    effect eReal = EffectAbilityIncrease(iAbility, iMOD);
    return(eReal);
}

// Placed in the master encounters OnEnter script for an encounter if that encounter
// is meant to be active only at night. Be sure the encounter tag is UNIQUE and that
// the counter is initially set to inactive (advanced tab) and Continuous.
void Encounter_NightEncounterOnEnter(object oEncounter=OBJECT_SELF) {
    object oPC = GetEnteringObject();
    int nEntries = GetLocalInt(oEncounter, "nEntries");
    int nResetValue = GetLocalInt(oEncounter, "nResetValue");

    if (GetIsPC(oPC) && GetIsNight()) {
        if (nEntries == 0) {
            SetEncounterActive(TRUE);
            nResetValue = 2 + Random(2);
            SetLocalInt(oEncounter, "nResetValue", nResetValue);
        }
        if (nEntries == nResetValue) nEntries = -1;
        SetLocalInt(oEncounter, "nEntries", nEntries);
    }
}

// Placed in the master encounters OnExit script for an encounter if that encounter
// is meant to be active only at night. Be sure the encounter tag is UNIQUE and that
// the counter is initially set to inactive (advanced tab) and Continuous.
void Encounter_NightEncounterOnExit(object oEncounter=OBJECT_SELF) {
    object oPC = GetExitingObject();
    int nEntries = GetLocalInt(oEncounter, "nEntries");

    if (GetIsPC(oPC)) {
        nEntries++;
        SetLocalInt(oEncounter, "nEntries", nEntries);
        SetEncounterActive(FALSE);
    }
}

// Returns an XP_* constant based on the magnitude of the DC value that was passed in
int Experience_GetXPForDC(int iDC) {
    if (iDC >= 0  && iDC < 4)  return (XP_ATTO);
    if (iDC >= 4  && iDC < 6)  return (XP_FEMTO);
    if (iDC >= 6  && iDC < 8)  return (XP_PICO);
    if (iDC >= 8  && iDC < 11) return (XP_NANO);
    if (iDC >= 11 && iDC < 13) return (XP_MICRO);
    if (iDC >= 13 && iDC < 15) return (XP_MILLI);
    if (iDC >= 15 && iDC < 16) return (XP_CENTI);
    if (iDC >= 16 && iDC < 17) return (XP_DECI);
    if (iDC >= 18 && iDC < 20) return (XP_DECA);
    if (iDC >= 20 && iDC < 22) return (XP_HECTO);
    if (iDC >= 22 && iDC < 25) return (XP_KILO);
    if (iDC >= 25 && iDC < 28) return (XP_MEGA);
    if (iDC >= 28 && iDC < 32) return (XP_GIGA);
    if (iDC >= 32)             return (XP_TERA);
    return 1;
}

// Lower level characters get more XP; returns the XP value for a PC of a certain
// level trying to disarm a trap of a certain difficulty
int Experience_RewardByLevel(int iLvls, int iBaseXP) {
    int iReward = 15 - iLvls;
    if (iReward <= 0) return iBaseXP;
    else iReward *= iBaseXP;
    if (iReward >= (iBaseXP * 3)) iReward = iBaseXP * 3;
    return (iReward);
}

// Calls Experience_RewardByLevel to determine the amount of XP (from the iXPValue) to award
void Experience_RewardNearestByDC(int iDC) {
    object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    int iDCXPValue = Experience_GetXPForDC(iDC);
    int iLevels = GetLevel(oTarget);
    GiveXPToCreature(oTarget, Experience_RewardByLevel(iLevels, iDC));
}

// Burns the creature specified with the damage & damage type passed.  Applies a saving throw for half damage.
void Fire_BurnCreature(object oVictim, int iDamage, int iDamageType=DAMAGE_TYPE_FIRE, int iDC=21) {
    // Do a saving throw
    int iFortSave = GetFortitudeSavingThrow(oVictim) + d20();
    if (iFortSave > iDC) {
        SendMessageToPC(oVictim, "Save (roll: " + IntToString(iFortSave) + ") vs. Flame (" + IntToString(iDC) + ") *success*");
        iDamage /= 2; // Half Damage
    }
    else SendMessageToPC(oVictim, "Save (roll: " + IntToString(iFortSave) + ") vs. Flame (" + IntToString(iDC) + ") *failure*");

    // Play audio
    if (GetIsPC(oVictim)) {
        if (!BlockMultiActivation("iBurnScream", oVictim, 7.0, "")) {
            if (GENDER_FEMALE == GetGender(oVictim)) AssignCommand(oVictim, PlaySound("as_pl_screamf1"));
            if (GENDER_MALE   == GetGender(oVictim)) AssignCommand(oVictim, PlaySound("as_pl_screamm1"));
        }
    }

    // Apply Damage
    effect eFX = EffectDamage(iDamage, iDamageType, DAMAGE_POWER_ENERGY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oVictim);

    // Output text
    FloatingTextStringOnCreature("Ouch!!", oVictim);
}

// Checks too see if any creatures are too close and applies fire damage if so. Recurses into itself
// to continue checking.
void Fire_DoBurnCheck(int iDamage, int iDamageType=DAMAGE_TYPE_FIRE, int iDC=21, object oFire=OBJECT_SELF, float fDelay=1.0) {
    // Check for nearby creatures
    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, 0.50, GetLocation(oFire));
    while (GetIsObjectValid(oCreature)) {
        // Burn the creature
        Fire_BurnCreature(oCreature, iDamage, iDamageType, iDC);

        // Get next creature
        oCreature = GetNextObjectInShape(SHAPE_SPHERE, 0.50, GetLocation(oFire));
    }

    // Recurse
    AssignCommand(oFire, DelayCommand(fDelay, Fire_DoBurnCheck(iDamage, iDamageType, iDC, oFire)));
}

// Moves the flame. Don't move too far from the closest "FireBowl" audio object. If iHungry is
// true, the flame will chase after nearby creatures.
void Fire_DoRandomMotion(int iHungry=FALSE, object oFire=OBJECT_SELF, float fMaxXRange=4.0, float fMaxYRange=4.0, float fXRange=0.20, float fYRange=0.20) {
    float fXPos;
    float fYPos;
    object oAudio = GetNearestObjectByTag("FireBowl");
    vector vLimit = GetPosition(oAudio);
    vector vPosition = GetPosition(oFire);
    if (!GetIsObjectValid(oAudio)) vLimit = vPosition;

    // Is the flame hungry?
    if (iHungry) {
        // Calculate new fire position that's closer to creature
        float fSiteRange = sqrt(pow(fMaxXRange, 2.0) + pow(fMaxYRange, 2.0));
        object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fSiteRange, GetLocation(oFire));
        vector vCreature = GetPosition(oCreature);
        if      (vCreature.x >= vPosition.x) fXPos = vPosition.x + Math_RandomFloat(fXRange);
        else if (vCreature.x <= vPosition.x) fXPos = vPosition.x - Math_RandomFloat(fXRange);
        if      (vCreature.y >= vPosition.y) fYPos = vPosition.y + Math_RandomFloat(fYRange);
        else if (vCreature.y <= vPosition.y) fYPos = vPosition.y - Math_RandomFloat(fYRange);
    }
    else {
        // Calculate new fire position
        fXPos = vPosition.x + (Math_RandomFloatSign() * Math_RandomFloat(fXRange));
        fYPos = vPosition.y + (Math_RandomFloatSign() * Math_RandomFloat(fYRange));
    }

    // Make sure fXPos is within bounds
    fXPos = Math_FitFloatToBoundaries(fXPos, vLimit.x, fMaxXRange);
    fYPos = Math_FitFloatToBoundaries(fYPos, vLimit.y, fMaxYRange);

    // Create another flame
    string strResRef = GetResRef(oFire);
    vector vNewPosition = Vector(fXPos, fYPos, vPosition.z);
    location lNewLocation = Location(GetArea(oFire), vNewPosition, Math_RandomFloat(180.0));
    CreateObject(OBJECT_TYPE_PLACEABLE, strResRef, lNewLocation);
    DestroyObject(oFire, Math_RandomFloat(3.0));
}

// Creates an area with explosive damage in it - all objects inside the sphere of effect take fire damage,
// prorated from the center.
void Fire_Explosion(location lCenter, int iMaxDamage=30, int iMinDamage=6, float fRadius=10.0) {
    if (fRadius <= 0.0) fRadius = 1.0;
    iMaxDamage -= iMinDamage;
    if (iMaxDamage <= 1) iMaxDamage=1;
    object oObject = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lCenter);
    effect eFX1 = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eFX2 = EffectVisualEffect(VFX_FNF_FIREBALL);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX2, lCenter);

    while (GetIsObjectValid(oObject)) {
        location lLoc = GetLocation(oObject);
        float fDistance = GetDistanceBetweenLocations(lCenter, lLoc);
        int iTotalDamage = iMinDamage + FloatToInt((IntToFloat(Random(iMaxDamage)) * (fRadius - fDistance)/fRadius));
        effect eDamage = EffectDamage(iTotalDamage, DAMAGE_TYPE_FIRE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oObject);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX1, oObject);
        oObject = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lCenter);
    }
}

// Clears off the state of all messages that have been sent (PC has eaten some food)
void FoodSys_ClearMessages(object oPC) {
    SetLocalInt(oPC, "iStarveMsg01", FALSE);
    SetLocalInt(oPC, "iStarveMsg02", FALSE);
    SetLocalInt(oPC, "iStarveMsg03", FALSE);
    SetLocalInt(oPC, "iStarveMsg04", FALSE);
}

// Outputs some floating text above the PC that indicates what the PC thinks of the current weather.
// If PC has been standing in the same spot for a while, output the info then block until he's standing at a new spot.
// If PC has been moving about, have a small chance for output.
void FoodSys_CommentOnWeather(object oPC, float fApparentTemp) {

}

// Called from FoodSys_Drunk_EffectDrunk() to determine if the booze-hound can hold
// their liqour...
void FoodSys_Drunk_CheckVomit(object oActivator, int iMOD, int iBloodAlcohol) {
    // Calculate whether oActivator's Blood Alcohol is too high
    int bVomit = FALSE;
    int iVomit;
    int iAdj;
    if (iMOD >= 0) { // For + CON
        iAdj = iMOD * iMOD;
        iVomit = Random(iBloodAlcohol) - (iMOD * Random(iMOD));
        if (iVomit > (20 + (iMOD * (iMOD-1)) + (FloatToInt(IntToFloat(iMOD) * 3.35)))) bVomit = TRUE;
    }
    else {          // For - CON
        iAdj = -1 * iMOD * iMOD;
        iVomit = Random(iBloodAlcohol) + (iMOD * Random(iMOD));
        if (iVomit > (20 - (iMOD * (iMOD)) + (FloatToInt(IntToFloat(iMOD) * 3.35)))) bVomit = TRUE;
    }

    // oActivator can't hold their booze!
    if (bVomit) {
        // Say something pre-event?
        if (Random(100) > 49) FoodSys_Drunk_SpeakWarning(oActivator);
        // Vomit effects
        AssignCommand(oActivator, ClearAllActions());
        AssignCommand(oActivator, FoodSys_Drunk_VomitEffect(oActivator, iMOD));
        // Remove some supplies (they barfed them up, afterall!)
        Inventory_RemoveStackedItemQuantity(oActivator, "supplies", Random(40 - iAdj) + d2(10));
    }
}

// Entry function for the FoodSys_Drunk_* functions.  Called from the activator function(s)
// for alcohol (such as Ale, Wine, etc.)
void FoodSys_Drunk_EffectDrunk(object oTarget) {
    // Check for immunity
    if (GetLocalInt(oTarget, "iAlcohol_Immune")) return;

    // Proceed normally
    int iMOD = GetAbilityModifier(ABILITY_CONSTITUTION, oTarget);
    int iAdj = iMOD * iMOD;
    if (iMOD < 0) iAdj *= -1;
    int iBloodAlcohol = GetLocalInt(oTarget, "iBloodAlcohol");
    if (iBloodAlcohol <= 0) AssignCommand(oTarget, DelayCommand(12.0, FoodSys_Drunk_LowerBloodAlcohol(oTarget)));
    int iInc = d12() + 5 - iAdj;
    if (iInc < 4) iInc = 4;
    iBloodAlcohol += iInc;
    SetLocalInt(oTarget, "iBloodAlcohol", iBloodAlcohol);

    // Do effects
    effect eFXA;
    effect eFXB;
    effect eFXC;
    if (iBloodAlcohol > (40 + iAdj)) {     // CON/WIS/INT -1
        eFXA = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);
        eFXB = EffectAbilityDecrease(ABILITY_WISDOM, 1);
        eFXC = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXA, oTarget, IntToFloat(d20(2)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXB, oTarget, IntToFloat(d20(2)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXC, oTarget, IntToFloat(d20(2)-iMOD));
    }
    if (iBloodAlcohol > (45 + iAdj)) {     // WIS-1 / CHA-2 / CONC - 1
        eFXA = EffectSkillDecrease(SKILL_CONCENTRATION, 1);
        eFXB = EffectAbilityDecrease(ABILITY_WISDOM, 1);
        eFXC = EffectAbilityDecrease(ABILITY_CHARISMA, 2);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXA, oTarget, IntToFloat(d20(3)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXB, oTarget, IntToFloat(d20(3)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXC, oTarget, IntToFloat(d20(3)-iMOD));
    }
    if (iBloodAlcohol > (55 + iAdj)) {    // DEX -1 / WIS -2/ CHA -2
        eFXA = EffectAbilityDecrease(ABILITY_DEXTERITY, 1);
        eFXB = EffectAbilityDecrease(ABILITY_WISDOM, 2);
        eFXC = EffectAbilityDecrease(ABILITY_CHARISMA, 2);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXA, oTarget, IntToFloat(d20(3)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXB, oTarget, IntToFloat(d20(3)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXC, oTarget, IntToFloat(d20(3)-iMOD));
    }
    if (iBloodAlcohol > (60 + iAdj)) {     // Blindness
        eFXB = EffectSkillDecrease(SKILL_CONCENTRATION, 2);
        eFXC = EffectSkillDecrease(SKILL_DISCIPLINE, 2);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXB, oTarget, IntToFloat(d20(4)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXC, oTarget, IntToFloat(d20(4)-iMOD));
    }
    if (iBloodAlcohol > (67 + iAdj)) {
        eFXB = EffectSkillDecrease(SKILL_CONCENTRATION, 4);
        eFXC = EffectSkillDecrease(SKILL_DISCIPLINE, 4);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXB, oTarget, IntToFloat(d20(4)-iMOD));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFXC, oTarget, IntToFloat(d20(4)-iMOD));
    }

    // Check to see if PC is gonna POP
    FoodSys_Drunk_CheckVomit(oTarget, iMOD, iBloodAlcohol);
}

// Once the target object begins drinking alcohol, his Blood Alcohol level is raised. This function
// is called and then recurses back into itself on a delay (determined by the CON of the target object)
// until the Blood Alcohol level is 0 or less.
void FoodSys_Drunk_LowerBloodAlcohol(object oTarget) {
    int iBloodAlcohol = GetLocalInt(oTarget, "iBloodAlcohol");
    int iMOD = GetAbilityModifier(ABILITY_CONSTITUTION, oTarget);
    if (iMOD <=  0) iMOD = 1;
    if (iMOD >  14) iMOD = 14;
    iBloodAlcohol -= iMOD;
    SetLocalInt(oTarget, "iBloodAlcohol", iBloodAlcohol);
    if (iBloodAlcohol > 0) AssignCommand(oTarget, DelayCommand(14.0 - IntToFloat(iMOD), FoodSys_Drunk_LowerBloodAlcohol(oTarget)));
}

// Randomly plays back one of the basic vomit sounds for females.
void FoodSys_Drunk_PlaySoundFemale(object oPC) {
    int iRandom = Random(3);
    string strSFX;
    if (iRandom == 0) strSFX = "f_vomit000";
    if (iRandom == 1) strSFX = "f_vomit001";
    if (iRandom == 2) strSFX = "f_vomit002";
    AssignCommand(oPC, PlaySound(strSFX));
}

// Randomly plays back one of the basic vomit sounds for males.
void FoodSys_Drunk_PlaySoundMale(object oPC) {
    int iRandom = Random(3);
    string strSFX;
    if (iRandom == 0) strSFX = "m_vomit000";
    if (iRandom == 1) strSFX = "m_vomit001";
    if (iRandom == 2) strSFX = "m_vomit002";
    AssignCommand(oPC, PlaySound(strSFX));
}

// If the FoodSystem determines that the target object is going to vomit, it can call this function
// to have the target say something prior to vomitting.
void FoodSys_Drunk_SpeakWarning(object oTarget) {
    int iRandom = Random(4);
    string strSay;
    if (iRandom == 0) strSay = "Don't feel so good...";
    if (iRandom == 1) strSay = "*BRACK*";
    if (iRandom == 2) strSay = "AWE CRIPES!";
    if (iRandom == 3) strSay = "Gonna PUKE!!!";
    FloatingTextStringOnCreature(strSay, oTarget);
}

// This function is responsible for creating the actual vomit FX (including audio based on sex).
void FoodSys_Drunk_VomitEffect(object oPC, int iMOD) {
        // Create some barf
        location lLoc = GetLocation(oPC);
        effect eVFXA = EffectVisualEffect(VFX_COM_BLOOD_REG_GREEN);
        effect eVFXB = EffectVisualEffect(VFX_COM_CHUNK_YELLOW_SMALL);
        effect eFX;
        eFX = EffectKnockdown();
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFXA, lLoc, 16.0);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFXB, lLoc, 16.0);
        float fDrunkAnimDur = 8.0 - IntToFloat(iMOD);
        AssignCommand(oPC, DelayCommand(1.8, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, fDrunkAnimDur)));
        AssignCommand(oPC, DelayCommand((1.8+fDrunkAnimDur), ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX, oPC, IntToFloat(d12() - iMOD))));

        // Play audio
        if (GetGender(oPC) == GENDER_FEMALE) FoodSys_Drunk_PlaySoundFemale(oPC);
        else FoodSys_Drunk_PlaySoundMale(oPC);

        // Apply effects from puking!
        if (iMOD >=0 ) {
            int iPenalty = 8 - iMOD;
            if (iPenalty < 0) iPenalty = 1;
            eFX = EffectAbilityDecrease(ABILITY_CONSTITUTION, iPenalty);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX, oPC, IntToFloat(d100(5)));
        }
        else {
            eFX = EffectAbilityDecrease(ABILITY_CONSTITUTION, (-1 * iMOD));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX, oPC, IntToFloat(d100(8)));
        }
}

// Accessor function for the Active state of the area
int FoodSys_GetActiveState(object oArea) {
    return(GetLocalInt(oArea, "ACTIVE_STATE"));
}

// Accessor function for ambient temperature variable
int FoodSys_GetAmbientTemperature(object oArea) {
    return(GetLocalInt(oArea, "AMBIENT_TEMP"));
}

// Takes into account the amount of good/harm the PC's equipment is doing.  Although Season and Time of Day
// were incorporated previously, they are also considered here in relation to the clothing worn as 'influences'.
int FoodSys_GetConAdjPCClothing(object oPC) {
    // Get Area Ambient Temperature; Modify with Season and TOD info.
    int iSeason = GetSeason();
    int iTOD = GetTOD();
    object oArea = GetArea(oPC);
    int iTempFlux = FoodSys_GetTemperatureFlux(oArea);
    int iAmbTemp = FoodSys_GetAmbientTemperature(oArea);

    // Modify the Temperature with the Season
    if (iSeason == SEASON_WINTER) iAmbTemp *= -1;   // Invert the ambient temperature for winter
    if ((iSeason == SEASON_SPRING) || (iSeason == SEASON_FALL)) iAmbTemp -= FloatToInt(IntToFloat(iAmbTemp) / IntToFloat(iTempFlux));   // Decrease the ambient temperature for Spring and Fall

    // Modify the Temperature with the Flux
    int iFlux = Random(iTempFlux);
    if ((iSeason == SEASON_FALL) || (iSeason == SEASON_SPRING)) {
        iFlux /= 2;
        if (Random(100) < 50) iFlux *= -1;  // Decrease the temperature from the seasonal ambient
        iAmbTemp += iFlux;
    }

    // Modify the Temperature with the Windshield
    // Not yet implimented

    // Modify the Temperature with the TOD
    if (iTOD == TOD_NIGHT) iAmbTemp -= Random(iFlux/2);
    if (iTOD == TOD_DAY) iAmbTemp += Random(iFlux/2);
    if ((iTOD == TOD_DUSK) || (iTOD == TOD_DAWN)) {
        if (Random(100) < 50) iAmbTemp -= Random(iFlux/3);
        else iAmbTemp += Random(iFlux/3);
    }

    // Generate a Heat Retension percentage for the PC based on his clothing
    float fHeatRetension = IntToFloat(FoodSys_GetHeatRetension(oPC));

    // What is the apparent temperature for the PC?
    float fAmbTemp = IntToFloat(iAmbTemp);
    float fApparentTemp = fAmbTemp;
    float fAdjust;
    float fSign = 1.0;
    if (iAmbTemp < 0) fSign = -1.0;
    float fHRFactor = fHeatRetension - 50;      // The PC's Heat Retension factor (0 heat loss and heat gain is at 50%, tan(0) = 0 which is why I correct the value with -50, to get a ZERO heat gain/loss)
    float fWarmingFactor = fAmbTemp - 25;       // Represents the players ability to heat themselves as temperature drops (becomes less and less with lower temps). ZERO point for this is 25C.
    if (fWarmingFactor >= 90.0) fWarmingFactor = 89.0;      // Ensure the values are not illegal for the TAN function
    if (fWarmingFactor <= -90.0) fWarmingFactor = -89.0;
    if (fHRFactor >= 90.0) fHRFactor = 89.0;
    if (fHRFactor <= -90.0) fHRFactor = -89.0;
    fApparentTemp += fSign * fAmbTemp * (tan(fWarmingFactor) + tan(fHRFactor));

    // Return an adjustment for the PC's food consumption rate
    int iExtraFoodNeeded = 0;
    if (fApparentTemp <= -25.0)                           iExtraFoodNeeded = 7;
    if (fApparentTemp >= -25.0 && fApparentTemp <= -12.0)   iExtraFoodNeeded = 4;
    if (fApparentTemp >= -11.0 && fApparentTemp <= -5.0)    iExtraFoodNeeded = 2;
    if (fApparentTemp >=  -4.0 && fApparentTemp <=  7.0)    iExtraFoodNeeded = -1;
    if (fApparentTemp >=   8.0 && fApparentTemp <= 25.0)    iExtraFoodNeeded = -2;
    if (fApparentTemp >=  25.0 && fApparentTemp <= 32.0)    iExtraFoodNeeded = 1;
    if (fApparentTemp >=  33.0)                           iExtraFoodNeeded = 2;

    // Let the PC see what his character thinks of the current temperature (low random chance if moving
    // about, high random chance if PC has been standing still for some time)
    FoodSys_CommentOnWeather(oPC, fApparentTemp);

    // Finish up
    if (DEBUG_STATE) SendMessageToPC(oPC, "Current Temperature is at: " + FloatToString(fAmbTemp) + " C, Apparent temperature is at: " + FloatToString(fApparentTemp) + " C");
    return(iExtraFoodNeeded);
}

// Returns the ration consumption adjustment factor for the current season
int FoodSys_GetConAdjSeason() {
    int iMonth = GetCalendarMonth();
    if ((iMonth >= 1 && iMonth <= 2) || iMonth==12) return 3;   // December - February (WINTER)
    if (iMonth >= 3 && iMonth <= 5) return 1;   // March - May (SPRING)
    if (iMonth >= 6 && iMonth <= 8) return 2;   // June - August (SUMMER)
    if (iMonth >= 9 && iMonth <= 11) return 0;  // September - November (FALL)
    return 0;
}

// Returns the ration consumption adjustment factor for the difficult modifier of the current terrain
int FoodSys_GetConAdjTerrainModifier(object oArea) {
    int iTerrainModifier = FoodSys_GetTerrainModifier(oArea);
    if (iTerrainModifier == TERRAIN_MODIFIER_INFRA) return -3;
    if (iTerrainModifier == TERRAIN_MODIFIER_EASY) return -2;
    if (iTerrainModifier == TERRAIN_MODIFIER_NORMAL) return 0;
    if (iTerrainModifier == TERRAIN_MODIFIER_HARD) return 1;
    if (iTerrainModifier == TERRAIN_MODIFIER_ULTRA) return 2;
    return 0;
}

// Returns the ration consumption adjustment factor for the current type of terrain
int FoodSys_GetConAdjTerrainType(object oArea) {
    int iTerrainType = FoodSys_GetTerrainType(oArea);
    if (iTerrainType == TERRAIN_TYPE_DUNGEON) return 2;
    if (iTerrainType == TERRAIN_TYPE_FOREST) return 3;
    if (iTerrainType == TERRAIN_TYPE_GRASSLAND) return 0;
    if (iTerrainType == TERRAIN_TYPE_CITY) return 1;
    if (iTerrainType == TERRAIN_TYPE_CAVERN) return 2;
    if (iTerrainType == TERRAIN_TYPE_HILLS) return 3;
    return 0;
}

// Returns the ration consumption adjustment factor for the current time of day
int FoodSys_GetConAdjTOD() {
    if (GetIsDawn()) return 1;
    if (GetIsDay()) return 0;
    if (GetIsDusk()) return 1;
    if (GetIsNight()) return 2;
    return 0;
}

// Accessor function for the basic food usage value (food used every 24 seconds, or in a HB)
int FoodSys_GetFoodUse() {
    return(GetLocalInt(GetModule(), "BASE_FOOD_USAGE"));
}

// Examines the PC to determine what articles of clothing he's wearing and how well he will therefore
// retain heat.  Can be a good thing, can be a bad thing! A return value of 50% is the ideal level for
// maintaining a constant temperature.
int FoodSys_GetHeatRetension(object oPC) {
    int iHeatRetension = 0;

    // Look for Summer-specific Heat dissipation items (have no effect during winter)
    // Is it Summer?
    if (SEASON_SUMMER == GetSeason()) {
        // Not implimented yet
    }
    // Look for Winter-specific Heat Retension items (large shield, etc.) (have no effect during summer)
    // Is it winter?
    if (SEASON_WINTER == GetSeason()) {
        // Not implimented yet
    }

    // Assess the remaining items for year round heat retention (HR = 65% if all slots are full)
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC))) iHeatRetension += 7;
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BELT, oPC))) iHeatRetension += 1;
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC))) iHeatRetension += 7;
    if ((GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC))) || (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)))) iHeatRetension += 25;    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC))) iHeatRetension += 14;
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC))) iHeatRetension += 10;
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC))) iHeatRetension += 4;
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_NECK, oPC))) iHeatRetension += 7;
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC))) iHeatRetension += 4;
    return(iHeatRetension);
}

// Accessor function for the minimum food rate consumption variable
int FoodSys_GetMinimumFoodRate(object oArea) {
    return(GetLocalInt(oArea, "MIN_FOOD_RATE"));
}

// Calculates how long the PC can last without food
int FoodSys_GetStarvationLimit(object oPC) {
    // Based on PC's CON and STR
    int iCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    int iSTR = GetAbilityModifier(ABILITY_STRENGTH, oPC);

    // Calculate the limit
    return(iCON + (iSTR / 2));
}

// Get the PC's Current starvation level
int FoodSys_GetStarveCounter(object oPC) {
    return(GetLocalInt(oPC, "iStarveCounter"));
}


// Accessor function for the temperature flux variable
int FoodSys_GetTemperatureFlux(object oArea) {
    return(GetLocalInt(oArea, "TEMP_FLUX"));
}


// Accessor function for terrain modifier variable
int FoodSys_GetTerrainModifier(object oArea) {
    return(GetLocalInt(oArea, "TERRAIN_MOD"));
}

// Accessor function for terrain type variable
int FoodSys_GetTerrainType(object oArea) {
    return(GetLocalInt(oArea, "TERRAIN_TYPE"));
}

// Main function for maintaining the FoodSystem_* on all PC's - launched via FoodSystem_Initialize().
void FoodSys_HeartBeat(object oPC, float fHeartBeat) {
    // Exempt from Hunger? Immune to Food Use, Dead, or Close to Dead...
    if ((GetLocalInt(oPC, "iFoodSys_Immune") == TRUE) || (GetCurrentHitPoints(oPC) <= 3)) {
        if (DEBUG_STATE) SendMessageToPC(oPC, "PC is immune to hunger...");
        AssignCommand(oPC, DelayCommand(fHeartBeat, FoodSys_HeartBeat(oPC, fHeartBeat)));         // Make sure the Food System Heart Beat continues to fire
        return;
    }

    // Is the weather system in the current area active?
    object oArea = GetArea(oPC);
    if (!FoodSys_GetActiveState(oArea)) {
        if (DEBUG_STATE) SendMessageToPC(oPC, "Food system not active in this area.");
        AssignCommand(oPC, DelayCommand(fHeartBeat, FoodSys_HeartBeat(oPC, fHeartBeat)));         // Make sure the Food System Heart Beat continues to fire
        return;
    }

    // Get Consumption Adjustment factor for Season
    int iConsumpAdj = FoodSys_GetFoodUse();
    iConsumpAdj += FoodSys_GetConAdjSeason();

    // Get Consumption Adjustment factor for TOD
    iConsumpAdj += FoodSys_GetConAdjTOD();

    // Get Consumption Adjustment factor for Area Terrain Type
    iConsumpAdj += FoodSys_GetConAdjTerrainType(oArea);

    // Get Consumption Adjustment factor for Area Terrain Modifier
    iConsumpAdj += FoodSys_GetConAdjTerrainModifier(oArea);

    // Consumption Adjustment factor for PC's clothing
    iConsumpAdj += FoodSys_GetConAdjPCClothing(oPC);

    // Constitution adjustment factor
    iConsumpAdj -= GetAbilityModifier(ABILITY_CONSTITUTION, oPC);

    // Strength adjustment factor
    iConsumpAdj -= (GetAbilityModifier(ABILITY_STRENGTH, oPC) / 2);

    // Make sure food consumed is NOT less than the Minimum Food Rate consumption for every HeartBeat period
    // (This is the least amount of food that MUST be consumed each food_sys heartbeat, regardless of bonusses)
    int iMinFoodRate = FoodSys_GetMinimumFoodRate(oArea);
    if (iConsumpAdj < iMinFoodRate) iConsumpAdj = iMinFoodRate;
    if (DEBUG_STATE) SendMessageToPC(oPC, "Final Food Usage: " + IntToString(iConsumpAdj));

    // Check starvation counter.
    int iStarveCounter = FoodSys_GetStarveCounter(oPC);
    int iStarveLimit = FoodSys_GetStarvationLimit(oPC);

    // Has PC reached starvation levels of hunger yet?
    if (iStarveCounter > iStarveLimit) {    // YES! U GONNA DIE NOW SENOR!
        // How high is the counter? Output a message indicating PC's severity!
        effect eFX1;
        effect eFX2;
        effect eFX3;
        effect eFX4;
        effect eFX5;
        int iPenalty = iStarveCounter - iStarveLimit;
        int iSeason = GetSeason();
        if (iStarveCounter >= iStarveLimit+1) { // -(STR/CON/DEX - 1; CONC & DISC - 5;)
            FoodSys_SendMessage(oPC, "iStarveMsg01", "I need food... badly!");
            eFX1 = EffectAbilityDecrease(ABILITY_STRENGTH, iPenalty);
            // eFX2 = EffectAbilityDecrease(ABILITY_CONSTITUTION, iPenalty);
            eFX3 = EffectAbilityDecrease(ABILITY_DEXTERITY, iPenalty);
            eFX4 = EffectSkillDecrease(SKILL_CONCENTRATION, iPenalty);
            eFX5 = EffectSkillDecrease(SKILL_DISCIPLINE, iPenalty);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX1, oPC, fHeartBeat);
            // ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX2, oPC, fHeartBeat);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX3, oPC, fHeartBeat);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX4, oPC, fHeartBeat);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX5, oPC, fHeartBeat);
        }
        if (iStarveCounter >= iStarveLimit+2) {     // - Slow
            FoodSys_SendMessage(oPC, "iStarveMsg02", "I'm starving!! Getting weaker... must find food soon...");
            eFX1 = EffectSlow();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX1, oPC, fHeartBeat);
        }
        if (iStarveCounter >= iStarveLimit+3) { // - Reduced Damage; Reduced AC; both increase on how far over the Starve limit we are
            FoodSys_SendMessage(oPC, "iStarveMsg03", "I'm starving to death!! ...must find food or shelter soon...");
            eFX1 = EffectDamageDecrease(iPenalty);
            eFX2 = EffectACDecrease(iPenalty);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX1, oPC, fHeartBeat);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX2, oPC, fHeartBeat);
        }
        if (iStarveCounter >= iStarveLimit+4) { // - Hit points reduced based on how far over Starve limit we are
            if (18 > d20()+GetFortitudeSavingThrow(oPC)) {
                SendMessageToPC(oPC, "Saving throw vs. Primary effects of starvation failed!");
                FoodSys_SendMessage(oPC, "iStarveMsg04", "...can't keep going...");
                eFX1 = EffectSavingThrowDecrease(SAVING_THROW_ALL, 1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX1, oPC, IntToFloat(Random(FloatToInt(fHeartBeat))));
            }
        }
        if (iStarveCounter >= iStarveLimit+5) { // - %Chance Dazed; %Chance Knockdown; %Chance Stunned;
            if (iPenalty+10 > d20()+GetFortitudeSavingThrow(oPC)) { // PC becomes diseased
                SendMessageToPC(oPC, "Saving throw vs. Primary effects of starvation failed!");
                int iRandom = Random(3);
                string strFXMsg;
                if (iRandom == 0) { eFX1 = EffectDazed(); strFXMsg = "...can't think straight..."; }
                if (iRandom == 1) { eFX1 = EffectKnockdown(); strFXMsg = "...dizzy... loosing my balance..."; }
                if (iRandom == 2) { eFX1 = EffectStunned(); strFXMsg = "... who... where am i???..."; }
                FloatingTextStringOnCreature(strFXMsg, oPC);
                SendMessageToPC(oPC, strFXMsg);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX1, oPC, IntToFloat(Random(FloatToInt(fHeartBeat))));
            }
        }
        if (iStarveCounter >= iStarveLimit+8) { // - %Chance Blindness; %Chance Deafness; %Chance Confused
            if (iPenalty+10 > d20()+GetFortitudeSavingThrow(oPC)) { // PC becomes diseased
                SendMessageToPC(oPC, "Saving throw vs. Tertiary effects of starvation failed!");
                int iRandom = Random(3);
                string strFXMsg;
                if (iRandom == 0) { eFX1 = EffectBlindness(); strFXMsg = "...my vision has blacked out from hunger!"; }
                if (iRandom == 1) { eFX1 = EffectDeaf(); strFXMsg = "...i can't hear anything but a buzzing sound from the hunger!"; }
                if (iRandom == 2) { eFX1 = EffectConfused(); strFXMsg = "...where? where am i?? so... hungry..."; }
                FloatingTextStringOnCreature(strFXMsg, oPC);
                SendMessageToPC(oPC, strFXMsg);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX1, oPC, IntToFloat(Random(FloatToInt(fHeartBeat))+iPenalty));
            }
        }
        if (iStarveCounter >= iStarveLimit+10) { // - %Chance of Disease
            if (d100()-GetAbilityModifier(ABILITY_CONSTITUTION, oPC) >= 95-iPenalty) {
                if (iPenalty+12 > d20()+GetFortitudeSavingThrow(oPC)) { // PC becomes diseased
                    SendMessageToPC(oPC, "Saving throw vs. Disease Vulnerability effects of starvation failed!");
                    string strFXMsg;
                    int iRandom = Random(9);
                    if (iRandom == 0) { eFX1 = EffectDisease(DISEASE_BURROW_MAGGOTS); strFXMsg = "... i'm so weak i've contracted burrowing maggots..."; }
                    if (iRandom == 1) { eFX1 = EffectDisease(DISEASE_CACKLE_FEVER); strFXMsg = "... i'm so weak i've contracted cackle fever..."; }
                    if (iRandom == 2) { eFX1 = EffectDisease(DISEASE_DEMON_FEVER); strFXMsg = "... i'm so weak i've contracted demon fever..."; }
                    if (iRandom == 3) { eFX1 = EffectDisease(DISEASE_DEVIL_CHILLS); strFXMsg = "... i'm so weak i've contracted devil chills..."; }
                    if (iRandom == 4) { eFX1 = EffectDisease(DISEASE_DREAD_BLISTERS); strFXMsg = "... i'm so weak i've contracted dread blisters..."; }
                    if (iRandom == 5) { eFX1 = EffectDisease(DISEASE_FILTH_FEVER); strFXMsg = "... i'm so weak i've contracted filth fever..."; }
                    if (iRandom == 6) { eFX1 = EffectDisease(DISEASE_MINDFIRE); strFXMsg = "... i'm so weak i've contracted mindfire..."; }
                    if (iRandom == 7) { eFX1 = EffectDisease(DISEASE_RED_ACHE); strFXMsg = "... i'm so weak i've contracted the red ache..."; }
                    if (iRandom == 8) { eFX1 = EffectDisease(DISEASE_SHAKES); strFXMsg = "... i'm so weak i've contracted the shakes..."; }
                    FloatingTextStringOnCreature(strFXMsg, oPC);
                    SendMessageToPC(oPC, strFXMsg);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX1, oPC, IntToFloat(Random(FloatToInt(fHeartBeat)) * (1+Random(FloatToInt(fHeartBeat)))));
                }
            }
        }
    }

    // How many supply rations are needed? Does the PC have them?
    if (FoodSys_TakeSupplies(oPC, iConsumpAdj)) {
        // Yes, do a debit. Clear starvation counter to ZERO.
        SetLocalInt(oPC, "iStarveMsg00", FALSE);
        FoodSys_ClearMessages(oPC);
        FoodSys_SetStarveCounter(oPC);  // Reset the starvation counter to ZERO
    }
    else {
        // No, indicate PC has run out of food. Start counter.
        FoodSys_SetStarveCounter(oPC, ++iStarveCounter);   // Increment starvation level
        int iStarveMsg00 = GetLocalInt(oPC, "iStarveMsg00");
        if (!iStarveMsg00) {
            FloatingTextStringOnCreature("I've run out of food!!", oPC);
            SetLocalInt(oPC, "iStarveMsg00", TRUE);
        }
    }

    // Make sure the Food System Heart Beat continues to fire
    AssignCommand(oPC, DelayCommand(fHeartBeat, FoodSys_HeartBeat(oPC, fHeartBeat)));

    // Output info for debugging
    FoodSys_ShowTerrainVars(oPC);
}

// Placed in the modules OnClientEnter and used on PC's entering the game.  Used to
// activate the food system for all PC's entering the world.
void FoodSys_Initialize(object oTarget, float fHeartBeat=60.0, int iBaseFoodUse=6) {
    FoodSys_SetFoodUse(iBaseFoodUse);
    AssignCommand(oTarget, FoodSys_HeartBeat(oTarget, fHeartBeat));
}

// Sends the message but ensures it is only seend ONCE by the PC until he has eaten again...
void FoodSys_SendMessage(object oPC, string strMessageID, string strMessage) {
    if (GetLocalInt(oPC, strMessageID)) return;
    SetLocalInt(oPC, strMessageID, TRUE);
    FloatingTextStringOnCreature(strMessage, oPC);
}

// Sets the minimum food requirement per heartbeat of the system
void FoodSys_SetFoodUse(int iBaseFoodUse) {
    SetLocalInt(GetModule(), "BASE_FOOD_USAGE", iBaseFoodUse);
}

// Set the value contained within the PC's starvation counter
void FoodSys_SetStarveCounter(object oPC, int iValue=0) {
    SetLocalInt(oPC, "iStarveCounter", iValue);
}

// Used in an Area's OnEnter callback event to set how much food the area requires from travellers.
// Can also be called in an areas OnHeartBeat - though not recommended. Will only fire once for each
// area that calls it.
//      *Default params are TERRAIN_TYPE_CITY, TEMP=25C, TERRAIN_MODIFIER_NORMAL, MIN_FOOD_RATE=1
void FoodSys_SetTerrainType(int iTerrainType=3, int iAmbientTemperature=25, int iTerrainModifier=2, int iTemperatureFlux=10, int iMinFoodRate=1, int iActive=TRUE) {
    // Be sure Terrain Type is valid
    if ((iTerrainType != TERRAIN_TYPE_DUNGEON) &&
        (iTerrainType != TERRAIN_TYPE_FOREST) &&
        (iTerrainType != TERRAIN_TYPE_GRASSLAND) &&
        (iTerrainType != TERRAIN_TYPE_CITY) &&
        (iTerrainType != TERRAIN_TYPE_CAVERN) &&
        (iTerrainType != TERRAIN_TYPE_HILLS)) iTerrainType = TERRAIN_TYPE_CITY;

    // Be sure Terrain Difficulty Modifier is valid
    if ((iTerrainModifier != TERRAIN_MODIFIER_INFRA) &&
        (iTerrainModifier != TERRAIN_MODIFIER_EASY) &&
        (iTerrainModifier != TERRAIN_MODIFIER_NORMAL) &&
        (iTerrainModifier != TERRAIN_MODIFIER_HARD) &&
        (iTerrainModifier != TERRAIN_MODIFIER_ULTRA)) iTerrainModifier = TERRAIN_MODIFIER_NORMAL;

    // Set the variables
    SetLocalInt(OBJECT_SELF, "TERRAIN_TYPE", iTerrainType);
    SetLocalInt(OBJECT_SELF, "TERRAIN_MOD", iTerrainModifier);
    SetLocalInt(OBJECT_SELF, "AMBIENT_TEMP", iAmbientTemperature);
    SetLocalInt(OBJECT_SELF, "MIN_FOOD_RATE", iMinFoodRate);        // The least amount of food that MUST be consumed each food_sys heartbeat, regardless of bonusses
    SetLocalInt(OBJECT_SELF, "TEMP_FLUX", iTemperatureFlux);
    SetLocalInt(OBJECT_SELF, "ACTIVE_STATE", iActive);
}

// Sends the current terrain variables to a PC
void FoodSys_ShowTerrainVars(object oPC) {
    int iTerrainType = FoodSys_GetTerrainType(GetArea(oPC));
    int iTerrainModifier = FoodSys_GetTerrainModifier(GetArea(oPC));
    int iAmbientTemperature = FoodSys_GetAmbientTemperature(GetArea(oPC));
    // Terrain Type
    string strTerrainType;
    if (iTerrainType == TERRAIN_TYPE_DUNGEON) strTerrainType = "Dungeon";
    if (iTerrainType == TERRAIN_TYPE_FOREST) strTerrainType = "Forest";
    if (iTerrainType == TERRAIN_TYPE_GRASSLAND) strTerrainType = "Grassland";
    if (iTerrainType == TERRAIN_TYPE_CITY) strTerrainType = "City";
    if (iTerrainType == TERRAIN_TYPE_CAVERN) strTerrainType = "Cavern/Mine";
    if (iTerrainType == TERRAIN_TYPE_HILLS) strTerrainType = "Hills";
    string strTerrainModifier;
    // Terrain Modifier
    if (iTerrainModifier == TERRAIN_MODIFIER_INFRA) strTerrainModifier = "Infra";
    if (iTerrainModifier == TERRAIN_MODIFIER_EASY) strTerrainModifier = "Easy";
    if (iTerrainModifier == TERRAIN_MODIFIER_NORMAL) strTerrainModifier = "Normal";
    if (iTerrainModifier == TERRAIN_MODIFIER_HARD) strTerrainModifier = "Hard";
    if (iTerrainModifier == TERRAIN_MODIFIER_ULTRA) strTerrainModifier = "Ultra";
    // Season
    string strSeason = GetSeasonString();
    string strTOD = GetTODString();
    string strTempFlux = IntToString(FoodSys_GetTemperatureFlux(GetArea(oPC)));
    // Active state
    int iActiveState = FoodSys_GetActiveState(GetArea(oPC));

    // Output the values
    if (DEBUG_STATE) SendMessageToPC(oPC, strTerrainType + ", " + strTerrainModifier + ", " + IntToString(iAmbientTemperature) + " C " + "+/- " + strTempFlux + ", " + strTOD + ", " + strSeason + ", active state is " + IntToString(iActiveState));
}

// Debit the PC for the supplies he consumes this 'HeartBeat'
int  FoodSys_TakeSupplies(object oPC, int iQuantity) {
    int iPCHasEnough = FALSE;

    // Count the PC's supplies
    object oItem = GetFirstItemInInventory(oPC);
    int iTotalSupplies = 0;
    while (GetIsObjectValid(oItem)) {
        if (GetTag(oItem) == "supplies") iTotalSupplies += GetNumStackedItems(oItem);
        oItem = GetNextItemInInventory(oPC);
    }

    // Does he have enough?
    if (iTotalSupplies >= iQuantity) {
        iPCHasEnough = TRUE;   // Yes!
        Inventory_RemoveStackedItemQuantity(oPC, "supplies", iQuantity);
    }
    else Inventory_RemoveStackedItemQuantity(oPC, "supplies", iTotalSupplies);
    return iPCHasEnough;
}

// Returns the subjects highest class level
int GetHighestLevel(object oSubject) {
    int iIndex;
    int iHighest = 0;
    int iTemp;
    for (iIndex=1; iIndex<=3; iIndex++) {
        iTemp = GetLevelByPosition(iIndex, oSubject);
        if (iTemp > iHighest) iHighest = iTemp;
    }
    return iHighest;
}

// Returns the PC's combined level from all classes (MAX 3 classes)
int GetLevel(object oSubject) {
    int iIndex;
    int iLevels = 0;
    for (iIndex=1; iIndex<=3; iIndex++) iLevels += GetLevelByPosition(iIndex, oSubject);
    return(iLevels);
}

// Returns the subjects lowest class level
int GetLowestLevel(object oSubject) {
    int iIndex;
    int iLowest = 500;
    int iTemp;
    for (iIndex=1; iIndex<=3; iIndex++) {
        iTemp = GetLevelByPosition(iIndex, oSubject);
        if (iTemp < iLowest) iLowest = iTemp;
    }
    return iLowest;
}

// Returns the subjects middle class level. Only for PC's with 3 classes - otherwise returns a 0.
int GetMiddleLevel(object oSubject) {
    return 0;
}

// Returns the total number of negative effects that the target object has on it
int GetNumberOfNegativeEffects(object oTarget) {
        int iTotalEffects = 0;
        effect eBad = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eBad)) {
            if ((GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
                GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
                GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE)) iTotalEffects++;
            eBad = GetNextEffect(oTarget);
        }
        return iTotalEffects;
}

// Accessor function the current season
int GetSeason() {
    int iMonth = GetCalendarMonth();
    if ((iMonth >= 1 && iMonth <= 2) || iMonth==12) return SEASON_WINTER;
    if (iMonth >= 3 && iMonth <= 5)                 return SEASON_SPRING;
    if (iMonth >= 6 && iMonth <= 8)                 return SEASON_SUMMER;
    if (iMonth >= 9 && iMonth <= 11)                return SEASON_FALL;
    return(0);
}

// Accessor function for the current season text
string GetSeasonString() {
    int iMonth = GetCalendarMonth();
    if ((iMonth >= 1 && iMonth <= 2) || iMonth==12) return "Winter";
    if (iMonth >= 3 && iMonth <= 5)                 return "Spring";
    if (iMonth >= 6 && iMonth <= 8)                 return "Summer";
    if (iMonth >= 9 && iMonth <= 11)                return "Fall";
    return("Unknown");
}

// Accessor function for the Time of Day
int GetTOD() {
    if (GetIsDawn()) return TOD_DAWN;
    if (GetIsDay()) return TOD_DAY;
    if (GetIsDusk()) return TOD_DUSK;
    if (GetIsNight()) return TOD_NIGHT;
    return(0);
}

// Accessor function for the current TOD string
string GetTODString() {
    if (GetIsDawn()) return "Dawn";
    if (GetIsDay()) return "Day";
    if (GetIsDusk()) return "Dusk";
    if (GetIsNight()) return "Night";
    return("Unknown");
}

// Called by an object that is capable of Healing another object (a Priest healing a PC and all his minions).
// iRemoveEffects dictates what Negative Effects will be removed from the targets.
// iAddBlessings allows the caller to add a set of blessings to the targets.
void Heal_BeginHealing(object oPC, int iRemoveEffects = 31, int iAddBlessings = FALSE, int iGiveHenchPotions = TRUE, string strPotionTag = "NW_IT_MPOTION003", int iHealHench = TRUE, int iHealFamil = TRUE, int iHealOthers = TRUE, int iMinHP = 0, int iMaxHP = 0) {
    object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC);
    object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
    object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC);
    object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC);
    ActionPauseConversation();
    // Bless PC if needed
    if (iAddBlessings != 0) Heal_BlessingEffect(oPC, iAddBlessings);

    // Do restorations
    ActionCastFakeSpellAtObject(SPELL_GREATER_RESTORATION, OBJECT_SELF);
    ActionDoCommand(Heal_RestoreEffect(oPC, iRemoveEffects, iMinHP, iMaxHP));
    if (!GetIsObjectValid(GetItemPossessedBy(oHenchman, strPotionTag)) && iGiveHenchPotions) CreateItemOnObject(strPotionTag, oHenchman, 3);
    if(GetIsObjectValid(oHenchman) && iHealHench) ActionDoCommand(Heal_RestoreEffect(oHenchman, iRemoveEffects, iMinHP, iMaxHP));
    if(GetIsObjectValid(oAnimal) && iHealOthers) ActionDoCommand(Heal_RestoreEffect(oAnimal, iRemoveEffects, iMinHP, iMaxHP));
    if(GetIsObjectValid(oFamiliar) && iHealFamil) ActionDoCommand(Heal_RestoreEffect(oFamiliar, iRemoveEffects, iMinHP, iMaxHP));
    if(GetIsObjectValid(oDominated) && iHealOthers) ActionDoCommand(Heal_RestoreEffect(oDominated, iRemoveEffects, iMinHP, iMaxHP));
    if(GetIsObjectValid(oSummoned) && iHealOthers) ActionDoCommand(Heal_RestoreEffect(oSummoned, iRemoveEffects, iMinHP, iMaxHP));
    ActionResumeConversation();
}

// Only the PC may have these (as oppossed to Henchmen, etc.)!!!
// Blocks PC from obtaining multiple blessings while previous ones are still in effect!!
// iAddBlessings *must* contain ONE of the HEAL_BLESS_DURATION_* values, and should have
// one of the 'packages' and perhaps one (or more) of the Blessing Options available. Made available
// through a conversation, these effects can be charged for or specified with a good degree of variety.
void Heal_BlessingEffect(object oPC, int iAddBlessings) {
    if (GetLocalInt(oPC, "iBlessingActive") == 1) {
        FloatingTextStringOnCreature("Blessing fizzled!", oPC);
        return;   // PC has already been blessed!
    }
    float fDuration;
    effect eACBonus;
    effect eATBonus;
    effect eSTBonus;
    effect eOptional;

    // Get duration
    if ((iAddBlessings & 16) == 16) fDuration = 60.0;     // 1 minute
    if ((iAddBlessings & 32) == 32) fDuration = 180.0;    // 3 minutes
    if ((iAddBlessings & 64) == 64) fDuration = 360.0;    // 6 minutes

    // Basic blessing
    if ((iAddBlessings & 1) == 1) {
        eACBonus = EffectACIncrease(1);
        eATBonus = EffectAttackIncrease(1);
        eSTBonus = EffectSavingThrowIncrease(SAVING_THROW_TYPE_ALL, 1);
    }
    // Average blessing
    if ((iAddBlessings & 2) == 2) {
        eACBonus = EffectACIncrease(2);
        eATBonus = EffectAttackIncrease(2);
        eSTBonus = EffectSavingThrowIncrease(SAVING_THROW_TYPE_ALL, 2);
    }
    // High blessing
    if ((iAddBlessings & 4) == 4) {
        eACBonus = EffectACIncrease(3);
        eATBonus = EffectAttackIncrease(3);
        eSTBonus = EffectSavingThrowIncrease(SAVING_THROW_TYPE_ALL, 3);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eACBonus, oPC, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eATBonus, oPC, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSTBonus, oPC, fDuration);

    // 128 = Optional Damage Increase effect (random amount)
    if ((iAddBlessings & 128) == 128) {
        eOptional = EffectDamageIncrease(d12());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 256 = Optional Damage Reduction effect (random)
    if ((iAddBlessings & 256) == 256) {
        eOptional = EffectDamageReduction(d10(), DAMAGE_POWER_PLUS_ONE, d20(10));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 512 = Optional Damage Resistance to ACID effect
    if ((iAddBlessings & 512) == 512) {
        eOptional = EffectDamageResistance(DAMAGE_TYPE_ACID, d10());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 1024 = Optional Damage Resistance to COLD effect
    if ((iAddBlessings & 1024) == 1024) {
        eOptional = EffectDamageResistance(DAMAGE_TYPE_COLD, d10());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 2048 = Optional Damage Resistance to FIRE effect
    if ((iAddBlessings & 2048) == 2048) {
        eOptional = EffectDamageResistance(DAMAGE_TYPE_FIRE, d10());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 4096 = Optional Haste Effect
    if ((iAddBlessings & 4096) == 4096) {
        eOptional = EffectHaste();
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 8192 = Optional Temporary Hit Points (random percent of Target's max HP's)
    if ((iAddBlessings & 8192) == 8192) {
        eOptional = EffectTemporaryHitpoints(Random(GetMaxHitPoints(oPC)));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 16384 = Optional Regeneration effect
    if ((iAddBlessings & 16384) == 16384) {
        eOptional = EffectRegenerate(d4(), 3.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 32768 = Optional Level 1 Spell Absorption Effect
    if ((iAddBlessings & 32768) == 32768) {
        eOptional = EffectSpellLevelAbsorption(1, d6(3));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 65536 = Optional Level 2 Spell Absorption Effect
    if ((iAddBlessings & 65536) == 65536) {
        eOptional = EffectSpellLevelAbsorption(2, d8(4));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }
    // 131072 = Optional Level 3 Spell Absorption Effect
    if ((iAddBlessings & 131072) == 131072) {
        eOptional = EffectSpellLevelAbsorption(3, d8(5));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOptional, oPC, fDuration);
    }

    // Finish up
    SetLocalInt(oPC, "iBlessingActive", 1);
    AssignCommand(oPC, DelayCommand(fDuration, SetLocalInt(oPC, "iBlessingActive", 0)));
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC);
}

// Called from Heal_BeginHealing() function. Does the actual 'healing' involved on the PC and his
// If all HP's should be healed, make iMaxHP = 0. If NO HP's should be healed, make iDoHeal = FALSE
void Heal_RestoreEffect(object oTarget, int iRemoveEffects, int iMinHP, int iMaxHP, int iDoHeal=TRUE) {
    // Search for negative effects
    effect eBad;
    // Remove basic effects
    if ((iRemoveEffects & 1) == 1) {
        eBad = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eBad)) {
            if ((GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE)) RemoveEffect(oTarget, eBad);
            eBad = GetNextEffect(oTarget);
        }
    }
    // Remove sensory impairments
    if ((iRemoveEffects & 2) == 2) {
        eBad = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eBad)) {
            if ((GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF)) RemoveEffect(oTarget, eBad);
            eBad = GetNextEffect(oTarget);
        }
    }
    // Remove constitution impairments
    if ((iRemoveEffects & 4) == 4) {
        eBad = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eBad)) {
            if ((GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
                GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE)) RemoveEffect(oTarget, eBad);
            eBad = GetNextEffect(oTarget);
        }
    }
    // Remove Level Drains
    if ((iRemoveEffects & 8) == 8) {
        eBad = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eBad)) {
            if ((GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)) RemoveEffect(oTarget, eBad);
            eBad = GetNextEffect(oTarget);
        }
    }
    // Remove Advanced impairments
    if ((iRemoveEffects & 16) == 16) {
        eBad = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eBad)) {
            if ((GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                 GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                 GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE)) RemoveEffect(oTarget, eBad);
            eBad = GetNextEffect(oTarget);
        }
    }

    // Heal the target object
    if (iDoHeal) {
        if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD) {
            // Determine amount to heal
            int nHeal;
            if (iMaxHP == 0) nHeal = GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget);
            else nHeal = iMinHP + Random(iMaxHP);
            // Apply the Healing effect
            effect eHeal = EffectHeal(nHeal);
            if (nHeal > 0) ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        }
    }
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

// Searches the targets inventory for the item with the passed tag and returns the total count for that
// item (including stacked items).
int Inventory_CountItem(object oTarget, string strItemTag) {
    int iCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);
    while (GetIsObjectValid(oItem)) {
        if (strItemTag == GetTag(oItem)) iCount += GetNumStackedItems(oItem);
        oItem = GetNextItemInInventory(oTarget);
    }
    return iCount;
}

// Deletes all items in the inventory of the container
void Inventory_DestroyAllItems(object oTarget=OBJECT_SELF) {
    object oItem = GetFirstItemInInventory(oTarget);
    while (GetIsObjectValid(oItem)) {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oTarget);
    }
}

// Returns TRUE or FALSE to indicate whether or not the passed item is equipped on the Object given.
int Inventory_IsEquipped(object oOwner, string strItemTag) {
    int iResult = FALSE;
    string strWork = GetStringLowerCase(strItemTag);
    if ((strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_ARMS, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_ARROWS, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_BELT, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_BOLTS, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_BOOTS, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_BULLETS, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_CHEST, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_CLOAK, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_NECK, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oOwner)))) ||
        (strWork == GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING))))) iResult = TRUE;
    return iResult;
}

// Returns the total number of items in the containers inventory
int Inventory_ItemCount(object oTarget) {
    int iCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);
    while (GetIsObjectValid(oItem)) {
        iCount++;
        oItem = GetNextItemInInventory(oTarget);
    }
    return iCount;
}

// Removes ALL instances of strItemTag from the Targets inventory!!!
void Inventory_RemoveItem(object oTarget, string strItemTag) {
    object oItem = GetFirstItemInInventory(oTarget);
    while (GetIsObjectValid(oItem)) {
        if (strItemTag == GetTag(oItem)) DestroyObject(oItem);
        oItem = GetNextItemInInventory(oTarget);
    }
}

// Removes iTake instances of strItemTag from the Targets inventory.  Should only be used on
// unstackable items as it will take the entire stack!!
int Inventory_RemoveItemNumber(object oTarget, string strItemTag, int iTake=1) {
    int iCount=0;
    object oItem = GetFirstItemInInventory(oTarget);
    while (GetIsObjectValid(oItem)) {
        if (strItemTag == GetTag(oItem)) { iCount++; DestroyObject(oItem); }
        if (iCount >= iTake) return(iCount);
        oItem = GetNextItemInInventory(oTarget);
    }
    return(iCount);
}

// Used on items that are stacked to take -some- items from the stack, but not
// all.
void Inventory_RemoveStackedItemQuantity(object oTarget, string strItemTag, int iRemoveNum) {
    object oItem = GetFirstItemInInventory(oTarget);
    int iCount = 0;
    int iTotalEmpties = 0;

    while ((iCount <= iRemoveNum) && GetIsObjectValid(oItem)) {
        if (GetTag(oItem) == strItemTag) {
            int iStackSize = GetNumStackedItems(oItem);
            iCount += iStackSize;
            if (iCount <= iRemoveNum) DestroyObject(oItem);
            else {
                int iGiveBack = iCount - iRemoveNum;
                AssignCommand(oTarget, DelayCommand(1.0, CreateItem(oTarget, strItemTag, iGiveBack)));
                DestroyObject(oItem);
            }
        }
        oItem = GetNextItemInInventory(oTarget);
    }
}

// Hurls down a flurry of lightning strikes!
void Lightning_DivineFury(object oObject, float fRadius, int iTotalStrikes, int iDoesDamage=FALSE, float fDelayWindow=14.0) {
    effect eStrike = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    int iIndex=0;
    for (iIndex=0; iIndex < iTotalStrikes; iIndex++) {
        // Get a location near the effect center
        location lLoc = Location_GetLocationNearObject(oObject, fRadius, fRadius);
        float fDelay = 1.0 + Math_RandomFloat(fDelayWindow);
        AssignCommand(GetArea(oObject), DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc)));
        if (iDoesDamage) Lightning_DamageCreatures(lLoc, 12, 3.5);
    }
}

// Damage all creatures within range of the strike (if they fail a save)
void Lightning_DamageCreatures(location lStrike, int iDifficulty=15, float fRange=8.0, int iMaxDamage=26, int iMinDamage=6) {    // Get the effects
    int iDamage = iMinDamage + Random(iMaxDamage - iMinDamage);
    effect eREALA = EffectDamage(iDamage, DAMAGE_TYPE_ELECTRICAL);
    effect eREALB = EffectKnockdown();
    effect eREALC = EffectDeaf();
    effect eREALD = EffectACDecrease(12);

    // Begin searching for nearby objects that can take damage
    object oObject = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lStrike);
    while (oObject != OBJECT_INVALID) {
        // Only PC's get saving throws... because I like them =)
        int iApplyDamage=TRUE;
        if (GetIsPC(oObject)) {
            int iFortSave = GetFortitudeSavingThrow(oObject) + d20();
            if (iFortSave >= iDifficulty) {
                SendMessageToPC(oObject, "Lightning Strike! Save (roll: " + IntToString(iFortSave) + ") vs. Fortitude (" + IntToString(iDifficulty) + ") *success*");
                // If the PC was too close, takes partial damage anyway
                if (GetDistanceBetweenLocations(lStrike, GetLocation(oObject)) <= 1.0) {
                    SendMessageToPC(oObject, "Too close to the lightning bolt!!!");
                    eREALA = EffectDamage(d6(3), DAMAGE_TYPE_ELECTRICAL);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eREALA, oObject);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREALB, oObject, IntToFloat(d6()));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREALC, oObject, IntToFloat(d20()));
                    if (!GetIsPC(oObject)) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREALD, oObject, IntToFloat(d10()));
                } // end if
                oObject = GetNextObjectInShape(SHAPE_SPHERE, fRange, lStrike);
                iApplyDamage = FALSE;
            } // end if
            else SendMessageToPC(oObject, "Save (roll: " + IntToString(iFortSave) + ") vs. Fortitude (" + IntToString(iDifficulty) + ") *failure*");
        }  // end if

        // Apply effects and damage to creatures
        if (iApplyDamage) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eREALA, oObject);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREALB, oObject, IntToFloat(d10()+d4()));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREALC, oObject, IntToFloat(d10()+d4()));
            oObject = GetNextObjectInShape(SHAPE_SPHERE, fRange, lStrike);
        }
    }
}

// Creates a lightning strike in the target area at a random location. Recurses back into itself!
// If any creatures are nearby, they must make a saving throw or suffer effects.
void Lightning_DoStrike(int iLightning, object oSelf) {
    // Get the effect
    effect eVFX = EffectVisualEffect(iLightning);
    float fRange = GetLocalFloat(oSelf, "fLightningRange");
    int iDifficulty = GetLocalInt(oSelf, "iLightningDC");
    int iAreaSizeX = GetLocalInt(oSelf, "XSIZE");    // X-Size of the area
    int iAreaSizeY = GetLocalInt(oSelf, "YSIZE");    // Y-Size of the area
    int iRandmFrequency = GetLocalInt(oSelf, "iLightningRandFreq");   // Interval between strikes, randomized.
    int iConstFrequency = GetLocalInt(oSelf, "iLightningConstFreq");    // Interval between strikes - this is the minimum period.

    // Generate a random location to do a lightning strike
    location lStrike = Location_GetRandomLocation(GetArea(OBJECT_SELF), iAreaSizeX, iAreaSizeY);

    // Do a lightning strike visual effect and prepare additional effects if Saving Throws for nearby creatures are failed
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lStrike);

    // Check for nearby creatures
    Lightning_DamageCreatures(lStrike);

    // Do another lightning strike
    DelayCommand(IntToFloat(Random(iRandmFrequency) + iConstFrequency), Lightning_DoStrike(iLightning, oSelf));    // Strikes
}

// Entry function for the perpetual Lightning Strike system. The X and Y parameters must be the
// size of the area the lightning will be striking inside of - that information can be found
// in the Toolset.  Place in the OnEnter of an Area with a Code-Block command.
void Lightning_Initialize(object oSelf, int iXSize, int iYSize, int iLightningDC=15, float fLightningRange=6.0, int iLightningRandFreq=20, int iLightningConstFreq=9) {
    SetLocalInt(oSelf, "XSIZE", iXSize);
    SetLocalInt(oSelf, "YSIZE", iYSize);
    SetLocalInt(oSelf, "iLightningDC", iLightningDC);
    SetLocalFloat(oSelf, "fLightningRange", fLightningRange);
    SetLocalInt(oSelf, "iLightningRandFreq", iLightningRandFreq);
    SetLocalInt(oSelf, "iLightningConstFreq", iLightningRandFreq);
    Lightning_DoStrike(VFX_IMP_LIGHTNING_M, oSelf);
}

// Adds the vector data passed to the position passed and returns a location
location Location_AddVectors(vector vCurrentPosition, float fVectorX, float fVectorY, float fVectorZ, object oObject=OBJECT_SELF) {
    float fVX = vCurrentPosition.x + fVectorX;
    float fVY = vCurrentPosition.y + fVectorY;
    float fVZ = vCurrentPosition.z + fVectorZ;
    vector vNewPosition = Vector(fVX, fVY, fVZ);
    return(Location(GetArea(oObject), vNewPosition, IntToFloat(Random(180))));
}

// Uses the X and Y ranges passed to determine a random point near the waypoint supplied.
location  Location_GetLocationNearObject(object oObject, float fXRange=1.0, float fYRange=1.0) {
    // Get the position of the Waypoint
    vector vCenter = GetPosition(oObject);

    // Generate a new location nearby
    float fNewX = vCenter.x + (Math_RandomFloatSign() * Math_RandomFloat(fXRange));
    float fNewY = vCenter.y + (Math_RandomFloatSign() * Math_RandomFloat(fYRange));
    vector vNewPosition = Vector(fNewX, fNewY, vCenter.z);
    return(Location(GetArea(oObject), vNewPosition, IntToFloat(Random(180))));
}

// Uses the X and Y ranges passed to determine a random point near the waypoint supplied.
location  Location_GetLocationNearWaypoint(string strWaypointTag, float fXRange=1.0, float fYRange=1.0) {
    // Get the position of the Waypoint
    object oWaypoint = GetObjectByTag(strWaypointTag);
    vector vCenter = GetPosition(oWaypoint);
    // Generate a new location nearby
    float fNewX = vCenter.x + (Math_RandomFloatSign() * Math_RandomFloat(fXRange));
    float fNewY = vCenter.y + (Math_RandomFloatSign() * Math_RandomFloat(fYRange));
    vector vNewPosition = Vector(fNewX, fNewY, vCenter.z);
    return(Location(GetArea(oWaypoint), vNewPosition, IntToFloat(Random(180))));
}

// Returns a random location within the range of 0->iXSize and 0->iYSize
location Location_GetRandomLocation(object oArea, int iXSize, int iYSize, int iXMargin=0, int iYMargin=0, int iHeight=0) {
    float fX = IntToFloat(Random(iXSize - iXMargin) + iXMargin);
    float fY = IntToFloat(Random(iYSize - iYMargin) + iYMargin);
    float fZ = IntToFloat(iHeight);
    vector vStrike = Vector(fX, fY, fZ);
    location lStrike = Location(oArea, vStrike, IntToFloat(Random(180)));
    return lStrike;
}

// Ensures that fValue is within range of (fPoint +/- fRange); if not, it will return a corrected
// value that is.
float Math_FitFloatToBoundaries(float fValue, float fPoint, float fRange) {
    // Check the value is in bounds
    if (fValue > fPoint + fRange) fValue = (fPoint + fRange) - Math_RandomFloat(0.5);
    if (fValue < fPoint - fRange) fValue = (fPoint - fRange) + Math_RandomFloat(0.5);

    // Return final value
    return fValue;
}

// Computes a random float value, including the decimal portion (2-digits only)
float Math_RandomFloat(float fMaxValue) {
    float fWhole = fabs(fMaxValue);
    int iWhole = Random(FloatToInt(fWhole));
    int iDecimal = FloatToInt(100.0 * (fMaxValue - fWhole));
    if (iDecimal == 0) iDecimal = 100;
    float fDecimal = IntToFloat(Random(iDecimal)) / 100.0;
    float fFinal = IntToFloat(iWhole) + fDecimal;
    return fFinal;
}

// Returns a -1.0 or 1.0 which can be multiplied to another value to randomly determine the sign of the result.
float Math_RandomFloatSign() {
    if (d100() > 50) return 1.0;
    return -1.0;
}

// Returns a -1 or 1 which can be multiplied to another value to randomly determine the sign of the result.
int Math_RandomIntSign() {
    if (d100() > 50) return 1;
    return -1;
}

// Use this (called typically from OnSpawn) function to add a regular effect to an object permanently (a
// minor distinction I make between an effect and a property is that properties are perm.)
void Object_AddProperty(int iEffect, int iParamA=1, int iParamB=4, int iParamC=1, object oObject=OBJECT_SELF) {
    effect eFX;
    if (iEffect == EFFECT_TYPE_REGENERATE)                                                                          eFX = EffectRegenerate(iParamA, IntToFloat(iParamB));
    if (iEffect == EFFECT_TYPE_TEMPORARY_HITPOINTS)                                                                 eFX = EffectTemporaryHitpoints(iParamA);
    if ((iEffect == EFFECT_TYPE_ABILITY_INCREASE || iEffect == EFFECT_TYPE_ABILITY_DECREASE) && iParamB > 0)        eFX = EffectAbilityIncrease(iParamA, iParamB);
    if ((iEffect == EFFECT_TYPE_ABILITY_INCREASE || iEffect == EFFECT_TYPE_ABILITY_DECREASE) && iParamB < 0)        eFX = EffectAbilityDecrease(iParamA, abs(iParamB));
    if (iEffect == EFFECT_TYPE_TRUESEEING)                                                                          eFX = EffectTrueSeeing();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFX, oObject);
}

// Object_CheckDamageVsResistances() - Called from the obects 'On Damaged' slot. This function processes the results of a successful attack on a monster versus
//                              the creatures resistances, which are passed in the params.  Determines if the
//                              (and how much) damage the creature takes and if it can be destroyed by the attack.
//      1) Minimum HP's to allow going down
//      2) Amount of Special Damage needed to effect creature.  Will only count if creature is 'down'.
//      3) When creature is down, only massive damage will effect it. Damage done by PC's is REDUCED by this amount.
//      4) Period that creature will be down for
//      5) Bitwise AND specifying ABSENT resistances as follows:
//          1       DAMAGE_TYPE_ACID
//          2       DAMAGE_TYPE_BLUDGEONING
//          4       DAMAGE_TYPE_COLD
//          8       DAMAGE_TYPE_DIVINE
//          16      DAMAGE_TYPE_ELECTRICAL
//          32      DAMAGE_TYPE_FIRE
//          64      DAMAGE_TYPE_MAGICAL
//          128     DAMAGE_TYPE_NEGATIVE
//          256     DAMAGE_TYPE_PIERCING
//          512     DAMAGE_TYPE_POSITIVE
//          1024    DAMAGE_TYPE_SLASHING
//          2048    DAMAGE_TYPE_SONIC
//         Specifying '41' indicates the creature IS NOT IMMUNE to Acid, Divine, or Fire damage, but is resistant
//         to all other types of damage.
//      6) The final parameter passed is the object ID of the calling object.
//
void Object_CheckDamageVsResistances(int iDown, int iSpecDam, int iDReduction, float fDur, int iResistances, object oSelf=OBJECT_SELF) {
    // Test object for a knock-down
    if ((GetCurrentHitPoints(oSelf) <= iDown) && (!GetLocalInt(oSelf, "iDown"))) { // The creature is near death, put him down
        ClearAllActions();
        SetLocalInt(oSelf , "iDown", TRUE);   // Set flag on creature to avoid this code again until object gets up

        // Apply resistances
        if ((iResistances & 1) == FALSE)    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_ACID, iDReduction), oSelf, fDur);
        if ((iResistances & 2) == FALSE)    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING, iDReduction), oSelf, fDur);
        if ((iResistances & 4) == FALSE)    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_COLD, iDReduction), oSelf, fDur);
        if ((iResistances & 8) == FALSE)    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_DIVINE, iDReduction), oSelf, fDur);
        if ((iResistances & 16) == FALSE)   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, iDReduction), oSelf, fDur);
        if ((iResistances & 32) == FALSE)   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_FIRE, iDReduction), oSelf, fDur);
        if ((iResistances & 64) == FALSE)   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_MAGICAL, iDReduction), oSelf, fDur);
        if ((iResistances & 128) == FALSE)  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, iDReduction), oSelf, fDur);
        if ((iResistances & 256) == FALSE)  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_PIERCING, iDReduction), oSelf, fDur);
        if ((iResistances & 512) == FALSE)  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_POSITIVE, iDReduction), oSelf, fDur);
        if ((iResistances & 1024) == FALSE) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_SLASHING, iDReduction), oSelf, fDur);
        if ((iResistances & 2048) == FALSE) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(DAMAGE_TYPE_SONIC, iDReduction), oSelf, fDur);

        // Apply Knockdown FX
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oSelf, fDur);

        // Set delay for Knockdown to be lifted
        DelayCommand(fDur, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints()), oSelf, fDur));
        DelayCommand(fDur, SetLocalInt(oSelf, "knee", 0));
    }
    // If knocked down, we can apply special damages (those creature is NOT resistant too) and kill the critter
    if ((GetLocalInt(oSelf, "iDown") == 1)) {
        location lLoc = GetLocation(oSelf);
        // ON ACID DAMAGE Spew the object
        if (GetDamageDealtByType(DAMAGE_TYPE_ACID) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(0.3, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_GREEN_SMALL), lLoc,5.0));
            DelayCommand(0.4, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_BLOOD_LRG_GREEN), lLoc,5.0));
            DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_HIT_ACID), lLoc,5.0));
            DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
         }
        // ON BLUDGEON DAMAGE Smash the object
        if (GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(0.3, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), lLoc,5.0));
            DelayCommand(0.4, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM), lLoc,5.0));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON COLD DAMAGE Freeze the object
        if (GetDamageDealtByType(DAMAGE_TYPE_COLD) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(0.3, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL), lLoc,5.0));
            DelayCommand(0.4, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FROST_L), lLoc));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON DIVINE DAMAGE Strike the object
        if (GetDamageDealtByType(DAMAGE_TYPE_DIVINE) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(0.3, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE), lLoc));
            DelayCommand(0.4, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_BLOOD_LRG_RED), lLoc, 8.0));
            DelayCommand(0.8, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY), lLoc));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON ELECTRICAL DAMAGE Fry the object
        if (GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(0.3, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_ELECTRICAL), lLoc));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON FIRE DAMAGE Immolate the object
        if (GetDamageDealtByType(DAMAGE_TYPE_FIRE) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_FLAME_M), lLoc, 5.5));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON MAGICAL DAMAGE Fireworks on the object
        if (GetDamageDealtByType(DAMAGE_TYPE_MAGICAL) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_BLOOD_REG_GREEN), lLoc, 4.5));
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_BLOOD_CRT_RED), lLoc, 5.5));
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM), lLoc, 6.0));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON NEGATIVE DAMAGE Neg effect
        if (GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_NEGATIVE), lLoc));
            DelayCommand(1.8, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), lLoc));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON PIERCE DAMAGE Do some gore
        if (GetDamageDealtByType(DAMAGE_TYPE_PIERCING) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL), lLoc, 5.5));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON POSITIVE DAMAGE Pos effect
        if (GetDamageDealtByType(DAMAGE_TYPE_POSITIVE) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_NEGATIVE), lLoc));
            DelayCommand(1.8, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), lLoc));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON SLASH DAMAGE Slash it up
        if (GetDamageDealtByType(DAMAGE_TYPE_PIERCING) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL), lLoc, 5.5));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
        // ON SONIC
        if (GetDamageDealtByType(DAMAGE_TYPE_PIERCING) >= iSpecDam) {
            ClearAllActions();
            DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_SONIC), lLoc));
            DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oSelf));
        }
    }
}

// Search the object's inventory and return true if the item passed was found inside.  False otherwise...
int Object_CheckInventoryForItem(string strResource, object oObject) {
    object oItem = GetFirstItemInInventory();
    string strItemTag;
    while (GetIsObjectValid(oItem)) {
        strItemTag = GetTag(oItem);
        if (strItemTag == strResource) return (TRUE);
        oItem = GetNextItemInInventory();
    }
    return (FALSE);
}

// Counts the number of objects that are of the same type as the caller from a specified center point
int Object_CountSameAtLocation(object oObject, location lCenter, float fSize=5.0, int iShape=SHAPE_SPHERE) {
    string strName = GetName(oObject);
    int iCount = 0;

    // Search for similair objects
    object oFound = GetFirstObjectInShape(iShape, fSize, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oFound)) {
        if (strName == GetName(oFound)) iCount++;
        oFound = GetNextObjectInShape(iShape, fSize, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    }

    // Return count
    return iCount;
}

// Create an object (similair to CreateObject()) - useful for creating objects with DelayCommand().
void Object_CreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE) {
    CreateObject(nObjectType, sTemplate, lLocation, bUseAppearAnimation);
}

// Called (usually from an OnSpawn) to determine if a creature is a regenerating monster
void Object_EnableRegenerators(object oObject=OBJECT_SELF) {
    float fCR = GetChallengeRating(oObject);

    // Check for undead
    if (Object_IsClassAndRace(CLASS_TYPE_UNDEAD, oObject)) {
        if (fCR < 4.0)                  Object_AddProperty(EFFECT_TYPE_REGENERATE);
        if (fCR >= 4.0 && fCR < 6.0)    Object_AddProperty(EFFECT_TYPE_REGENERATE, 1, 3);
        if (fCR == 6.0)                 Object_AddProperty(EFFECT_TYPE_REGENERATE, 1, 2);
        if (fCR >= 7.0 && fCR < 10.0)   Object_AddProperty(EFFECT_TYPE_REGENERATE, 2, 3);
        if (fCR >= 10.0)                Object_AddProperty(EFFECT_TYPE_REGENERATE, 2, 2);
    }

    // Check for trolls
    if (Object_IsClassAndRace(CLASS_TYPE_GIANT, OBJECT_SELF, FALSE, "troll")) {
        if      (fCR <= 7.0)                Object_AddProperty(EFFECT_TYPE_REGENERATE, 1, 2);
        else if (fCR  < 9.0)                Object_AddProperty(EFFECT_TYPE_REGENERATE, 2, 3);
        else if (fCR >= 9.0)                Object_AddProperty(EFFECT_TYPE_REGENERATE, 3, 3);
    }

    // Check for lycanthropes
    if (Object_IsClassAndRace(CLASS_TYPE_SHAPECHANGER, oObject, FALSE, "were")) {
        if (fCR < 8.0)                  Object_AddProperty(EFFECT_TYPE_REGENERATE);
        if (fCR >= 8.0 && fCR < 14.0)   Object_AddProperty(EFFECT_TYPE_REGENERATE, 1, 3);
        if (fCR >= 14.0)                Object_AddProperty(EFFECT_TYPE_REGENERATE, 2, 4);
    }

    // Check for regular animals
    if (Object_IsClassAndRace(CLASS_TYPE_ANIMAL, oObject, TRUE)) Object_AddProperty(EFFECT_TYPE_REGENERATE, 1, 8);
}

// Causes the object calling the function to stop combat
void Object_ForceEndCombat(object oAttacker) {
    AssignCommand(oAttacker, ClearAllActions());
    AssignCommand(oAttacker, SurrenderToEnemies());
    ClearPersonalReputation(oAttacker);
}

// Places iStack instances of strItemTag onto the object if the function has NOT already been called for
// the object
void Object_InitializeInventory(string strItemTag, int iStack=4, object oObject=OBJECT_SELF) {
    if (GetLocalInt(oObject, "iInventoryInit")) return;
    SetLocalInt(oObject, "iInventoryInit", TRUE);
    int i;
    for (i=0; i<iStack; i++) CreateItemOnObject(strItemTag);
}


// Intended for animals only - determines if the creature is prey or predator. Returns TRUE if it's a prey
// item.
int Object_IsPrey(object oObject=OBJECT_SELF) {
    string strAnimalName = GetStringLowerCase(GetName(oObject));
    if (String_IsSubString(strAnimalName, "chicken") ||
        String_IsSubString(strAnimalName, "raven") ||
        String_IsSubString(strAnimalName, "boar") ||
        String_IsSubString(strAnimalName, "cow") ||
        String_IsSubString(strAnimalName, "deer") ||
        String_IsSubString(strAnimalName, "ox") ||
        String_IsSubString(strAnimalName, "stag")) return TRUE; // Prey
    return FALSE;   // Predator
}

// Checks too see if the object passed in has levels in iClassType; if the race of a class is needed
// then pass strName (eg. "hill" for CLASS_TYPE_GIANT, to return whether or not the object is a Hill
// Giant) - note that strName must be part of the object's name as specified in the Toolset.
// If the creature can have NO other classes than iClassType, pass iExclusive as TRUE.
int Object_IsClassAndRace(int iClassType, object oObject=OBJECT_SELF, int iExclusive=FALSE, string strName="") {
    // Check too see if they have any levels in the given class
    int iLevel = GetLevelByClass(iClassType, oObject);
    if (!iExclusive) {
        if (iLevel > 0) {
            // If no Race is needed, return the level
            if (GetStringLength(strName) == 0) return iLevel;
            else {
                // Race is needed, so try and get a match from the objects given name.
                string strLName = GetStringLowerCase(strName);
                string strOName = GetStringLowerCase(GetName(oObject));
                if (String_IsSubString(strOName, strLName)) return iLevel;
            }
        }
    }
    else { // iExclusive was TRUE, so creature can have ONLY levels in iClassType
        int iAllLevels = GetLevel(oObject);
        if (iAllLevels == iLevel) { // All Levels are in iClassType
            // If no Race is needed, return the level
            if (GetStringLength(strName) == 0) return iLevel;
            else {
                // Race is needed, so try and get a match from the objects given name.
                string strLName = GetStringLowerCase(strName);
                string strOName = GetStringLowerCase(GetName(oObject));
                if (String_IsSubString(strOName, strLName)) return iLevel;
            }
        }
    }
    return FALSE;
}

// Checks to see if a PC is near the calling object, returns TRUE if a PC is within fDist.
int Object_IsPCNear(object oObject=OBJECT_SELF, float fDist=20.0) {
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    float fDistance = GetDistanceBetween(oObject, oPC);
    if (fDistance < fDist) return TRUE;
    return FALSE;
}

// Returns the object inside the shape centered at lCenter that is the same species as the caller and is
// closest than any other candidates.
object Object_GetClosestSameInLocationShape(location lCenter, object oObject=OBJECT_SELF, float fSize=5.0, int iShape=SHAPE_SPHERE) {
    string strName = GetName(oObject);
    object oTemp;
    float fTemp;
    float fDistance = 1000.0;   // Arbitrarily high (no meaning)

    // Search for similair objects
    object oFound = GetFirstObjectInShape(iShape, fSize, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oFound)) {
        if (strName == GetName(oFound)) {
            fTemp = GetDistanceBetween(oObject, oFound);
            if (fTemp < fDistance) { fDistance = fTemp; oTemp = oFound; }
        }
        oFound = GetNextObjectInShape(iShape, fSize, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    }

    // Return nearest object
    return oTemp;

}

vector Object_GetDensityCenter(location lCenter, object oObject=OBJECT_SELF, float fSize=5.0, int iShape=SHAPE_SPHERE) {
    vector vAverage;
    vector vFinal;
    vector vFound;
    float fCount = 0.0;

    // Search for similair objects
    object oFound = GetFirstObjectInShape(iShape, fSize, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    string strName = GetName(oObject);
    while (GetIsObjectValid(oFound)) {
        if (strName == GetName(oFound)) {
            fCount += 1.0;
            vFound = GetPosition(oFound);
            vAverage.x += vFound.x;
            vAverage.y += vFound.y;
            vAverage.z += vFound.z;
        }
        oFound = GetNextObjectInShape(iShape, fSize, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    }
    vFinal.x = vAverage.x / fCount;
    vFinal.y = vAverage.y / fCount;
    vFinal.z = vAverage.z / fCount;
    return vFinal;
}

// Examines all the DC's for the object and returns a difficulty (a.k.a 'quality') rating.
// Pass with iReturnRaw as TRUE and get the sum of all the object's DC's instead of a QUALITY_* constant.
int Object_GetDifficulty(object oObject, int iReturnRaw=FALSE) {
    int iTotal   = GetLockUnlockDC(oObject);
    iTotal      += GetTrapDetectDC(oObject);
    iTotal      += GetTrapDisarmDC(oObject);
    if (iReturnRaw) return iTotal;
    if (iTotal  < 19)                   return FloatToInt(QUALITY_LOW);
    if (iTotal >= 19 && iTotal < 28)    return FloatToInt(QUALITY_MEDIUM);
    return FloatToInt(QUALITY_HIGH);
}

// Returns the first object found, inside a circle of fDistance meters that is
// of the same species as the object passed in.
object Object_GetNearestSame(object oObject=OBJECT_SELF, float fDistance=5.0) {
    location lCenter = GetLocation(oObject);
    object oFound;
    object oNearest = GetFirstObjectInShape(SHAPE_SPHERE, fDistance, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oNearest)) {
        if ((GetName(oObject) == GetName(oNearest)) && (oObject != oNearest)) { oFound = oNearest; break; }
        oNearest = GetNextObjectInShape(SHAPE_SPHERE, fDistance, lCenter, TRUE, OBJECT_TYPE_CREATURE);
    }
    return oFound;
}

// Returns one of the OBJECT_TYPE_* constants for the object that was passed
int Object_GetType(object oObject) {
    string strTag = GetStringLowerCase(GetName(oObject));
    if (String_IsSubString(strTag, "barrel"))   return OBJECT_TYPE_BARREL;
    if (String_IsSubString(strTag, "book"))    return OBJECT_TYPE_BOOKS;
    if (String_IsSubString(strTag, "chest"))    return OBJECT_TYPE_CHEST;
    if (String_IsSubString(strTag, "crate") || String_IsSubString(strTag, "box"))   return OBJECT_TYPE_CRATE;
    if (String_IsSubString(strTag, "treasure")) return OBJECT_TYPE_GOLD_PILE;
    if (String_IsSubString(strTag, "loot"))     return OBJECT_TYPE_LOOTBAG;
    if (String_IsSubString(strTag, "supply"))   return OBJECT_TYPE_WIZARD_CABINET;
    return(OBJECT_TYPE_MISCELLANEOUS);
}

// Changes the creatures stats so that they are unique to the individual; changes are not large
// enough to constitute differentiation to a 'new species'.
void Object_GiveUniqueAbilities(object oObject=OBJECT_SELF) {
    // All creatures receive a MOD from their basic stats
    Object_AddProperty(EFFECT_TYPE_ABILITY_INCREASE, ABILITY_STRENGTH,      Math_RandomIntSign() * d2());
    Object_AddProperty(EFFECT_TYPE_ABILITY_INCREASE, ABILITY_CONSTITUTION,  Math_RandomIntSign() * d2());
    Object_AddProperty(EFFECT_TYPE_ABILITY_INCREASE, ABILITY_INTELLIGENCE,  Math_RandomIntSign() * d2());
    Object_AddProperty(EFFECT_TYPE_ABILITY_INCREASE, ABILITY_CHARISMA,      Math_RandomIntSign() * d2());
    Object_AddProperty(EFFECT_TYPE_ABILITY_INCREASE, ABILITY_WISDOM,        Math_RandomIntSign() * d2());
    Object_AddProperty(EFFECT_TYPE_ABILITY_INCREASE, ABILITY_DEXTERITY,     Math_RandomIntSign() * d2());
    Object_AddProperty(EFFECT_TYPE_TEMPORARY_HITPOINTS, d8(GetHitDice(OBJECT_SELF))); // Give critters unique hit points
}

// Usually called from the OnSpawn of a creature in order to change its faction to common (if it's an
// animal)
void Object_MakeAnimalsCommon(object oObject=OBJECT_SELF) {
    // Check to be sure the creature passed in was an animal
    if (!Object_IsClassAndRace(CLASS_TYPE_ANIMAL, oObject, TRUE)) return;

    ////////////////////////////////////////////////////////////////////////////
    // Creatures that are exempt from faction changes (remain hostile) /////////
    ////////////////////////////////////////////////////////////////////////////
    // All dire creatures are hostile
    string strCritterName = GetStringLowerCase(GetName(oObject));
    if (String_IsSubString(strCritterName, "dire") ||
        String_IsSubString(strCritterName, "rat")  ||
        String_IsSubString(strCritterName, "badger")) return;

    // Check if the animal was a non-prey item. If so, change to Defender.
    string strAnimalName = GetName(oObject);
    if (!Object_IsPrey(oObject)) ChangeToStandardFaction(oObject, STANDARD_FACTION_DEFENDER);    // No need to worry about 'prey' item factions since they're common by default
}

// Respawns the passed item onto the passed object but only if the object's inventory does not already
// have an instance of the item.
void Object_RespawnContents(string strResource, int iStack=1, object oObject=OBJECT_SELF) {
    if (Object_CheckInventoryForItem(strResource, oObject)) return; // If object already has special item in it, don't create a new one
    int i;
    for (i=0; i<iStack; i++) CreateItemOnObject(strResource, oObject);
}

// Creates the items contained in strInventoryArray on the object passed
void Object_RespawnSpecialInventory(object oObject, string strInventoryArray) {
    int iElements = Array_GetTotalElements(strInventoryArray);
    int iIndex;
    for (iIndex=0; iIndex<iElements; iIndex+=2) {
        string strItemTag = Array_GetElement(iIndex, strInventoryArray);
        string strStack   = Array_GetElement(iIndex+1, strInventoryArray);
        CreateItemOnObject(strItemTag, oObject, StringToInt(strStack));
    }
}

// Very dirty method of getting a Spell ID from the PC... don't try this at home, kids.
// Returns a -1 if the list was exhausted without finding a matching spell!
int Object_SelectMemorizedSpell(object oCaster) {
    int iIndex;
    for (iIndex=0; iIndex<1000; iIndex++) {
        if (GetHasSpell(iIndex, oCaster)) return iIndex;
    }
    return -1;
}

// Creates a monster at the location of the PC's death - called from "nw_o0_death"
void Object_SpawnMonsterFromPC(object oPlayer) {
    object oCreature = GetLastHostileActor(oPlayer);
    if (GetIsObjectValid(oCreature)) {
        // If PC was killed by an undead - create another one!
        if (Object_IsClassAndRace(CLASS_TYPE_UNDEAD, oCreature)) {
            location lLoc = GetLocation(oPlayer);
            string strResRef = GetResRef(oCreature);
            float fDelay = IntToFloat(d6());
            effect eFX = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
            AssignCommand(GetArea(oPlayer), DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX, lLoc)));
            AssignCommand(GetArea(oPlayer), DelayCommand(fDelay, Object_CreateObject(OBJECT_TYPE_CREATURE, strResRef, lLoc)));
        }
    }
}

// If any items are in the container, this function will store them. Upon Respawn of the object,
// the items can be recreated.
string Object_StoreSpecialInventory(object oObject=OBJECT_SELF) {
    // Count and store the tags of the items in the object's inventory (presumably these
    // were present -before- treasure was generated.
    int iCount=0;
    object oItem = GetFirstItemInInventory(oObject);
    string strInventoryArray="";
    while (GetIsObjectValid(oItem)) {
        string strItemTag = GetTag(oItem);
        int iStackSize = GetNumStackedItems(oItem);
        strInventoryArray = Array_AddElement(strItemTag, strInventoryArray);
        strInventoryArray = Array_AddElement(IntToString(iStackSize), strInventoryArray);
        oItem = GetNextItemInInventory(oObject);
        iCount++;
    }
    // Store the Array
    SetLocalString(oObject, "strInventoryArray", strInventoryArray);
    return(strInventoryArray);
}

// Ring of Blinking
void OnActivate_Jewelry_RingOfBlinking(object oItem, object oActivator, object oTarget) {
    string strLRing = GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oActivator)));
    string strRRing = GetStringLowerCase(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oActivator)));
    string strItemTag = GetStringLowerCase(GetTag(oItem));

    // Abort if the PC is not wearing the ring
    if (("cu_jewel106" != strLRing) && ("cu_jewel106" != strRRing)) { FloatingTextStringOnCreature("The ring must be worn!", oActivator); return; }

    // Abort if the PC has used the ring recently
    if (BlockMultiActivation(strItemTag, oActivator, nDurLong)) return;

    // Apply the effects for the duration
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE), oActivator, nDurLong);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(4), oActivator, nDurLong);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageReduction(5, DAMAGE_POWER_PLUS_ONE), oActivator, nDurLong);
}


void Effect_Visual_LifeRip(object oObject, int iDelayed=TRUE) {
    location lCenter = GetLocation(oObject);
    effect eFX1 = EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM);
    effect eFX2 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    effect eFX3 = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    if (!iDelayed) {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX1, lCenter);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX2, lCenter);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX3, lCenter);
    }
    else {
        AssignCommand(GetArea(oObject), DelayCommand(IntToFloat(d3()), ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX1, lCenter)));
        AssignCommand(GetArea(oObject), DelayCommand(IntToFloat(d3()), ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX2, lCenter)));
        AssignCommand(GetArea(oObject), DelayCommand(IntToFloat(d3(3)), ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFX3, lCenter)));
    }
}

// Mask of Talquin
void OnActivate_Misc_MaskOfTalquin(object oItem, object oActivator, object oTarget) {
    // Check for eyepieces
    if (!Inventory_CountItem(oActivator, "cu_miscothr070")) return;
    if (!Inventory_CountItem(oActivator, "cu_miscothr072")) return;

    // Check for headpiece
    if (!Inventory_CountItem(oActivator, "cu_miscothr071")) return;

    // Make sure item is not charging up from a previous use
    float fBlockPeriod = 760.0 + Math_RandomFloat(760.0);
    if (BlockMultiActivation(GetTag(oItem), oActivator, fBlockPeriod)) return;

    // Apply effects to target creature and surrounding creatures of faction hostile
    effect eFX4 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    location lCenter = GetLocation(oTarget);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eFX4, lCenter, 10.0);

    // oTarget dies automatically!
    Effect_AbsorbHitPoints(oActivator, oTarget);
    Effect_Visual_LifeRip(oTarget, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oTarget);

    // Search for remaining souls to suck
    object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, lCenter);
    while (GetIsObjectValid(oVictim)) {
        if (GetIsEnemy(oVictim, oActivator)) {
            int iSave = GetWillSavingThrow(oVictim) + d20();
            Effect_AbsorbHitPoints(oActivator, oVictim);
            if (iSave < 27) {
                Effect_Visual_LifeRip(oVictim);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oVictim);
            }
        }
        oVictim = GetNextObjectInShape(SHAPE_SPHERE, 15.0, lCenter);
    }
}

// On active process for the Deaught of Life Potion
void OnActivate_Potion_DraughtOfLife(object oItem, object oActivator, object oTarget) {
    effect eVFX = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oTarget);
}

// On active process for the Elixir of Health potion
void OnActivate_Potion_ElixirOfHealth(object oItem, object oActivator, object oTarget) {
    effect eVFX = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oActivator);

    // Look for negative effects covered by this potion
    effect eFX = GetFirstEffect(oActivator);
    int iType = GetEffectType(eFX);
    while (GetIsEffectValid(eFX)) {
        if (iType == EFFECT_TYPE_BLINDNESS ||
            iType == EFFECT_TYPE_DEAF ||
            iType == EFFECT_TYPE_DISEASE ||
            iType == EFFECT_TYPE_FRIGHTENED ||
            iType == EFFECT_TYPE_POISON) RemoveEffect(oActivator, eFX);
        eFX = GetNextEffect(oActivator);
    }
}

// Elixir of Health OnActivate Process
void OnActivate_Potion_OilOfResistance(object oItem, object oActivator, object oTarget, int iDamageType) {
    effect eVFX = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oActivator);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageResistance(iDamageType, 15), oActivator, nDurSupr + Math_RandomFloat(nDurSupr));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, 20), oActivator, nDurSupr);
}

// Shrine of Ptah code, able to regenerate the charges on items with appropriate sacrafice.
// Should be in the OnClose slot for a placeable object with inventory.  Works for just one
// item in inventory.
void Placeable_Altar_ShrineOfPtah(object oCloser, object oObject=OBJECT_SELF) {
    // Any items in container?
    if (!Inventory_ItemCount(oObject)) return;

    // Get the tag of the last non-gem item in container
    object oItem = GetFirstItemInInventory(oObject);
    object oAntique;
    string strItemTag;
    int iOffering = 0;
    float fGold;
    while (GetIsObjectValid(oItem)) {
        if (GetBaseItemType(oItem) != BASE_ITEM_GEM) {
            oAntique = oItem;
            strItemTag = GetTag(oItem);
            fGold = IntToFloat(GetGoldPieceValue(oItem));  // Determine what the object is worth
        }
        else iOffering += GetGoldPieceValue(oItem); // Total the value of the gem-offering
        oItem = GetNextItemInInventory(oObject);
    }
    int iLen = GetStringLength(strItemTag);
    if (iLen == 0 || iLen == -1) return;

    // Is it stacked? If so, do nothing.
    if (GetNumStackedItems(oItem) > 1) return;

    // Check if the offering is accepted
    float fLevel = IntToFloat(GetLevel(oCloser));
    fGold *= 0.15 + (0.01 * fLevel) + (0.005 * fLevel);
    float fOffering = IntToFloat(iOffering);
    if (fGold > fOffering) return;

    // Exit if the Shrine has been used successfully recently
    float fDelay = 1200.0 + Math_RandomFloat(1200.0);
    if (BlockMultiActivation(GetTag(oObject), oObject, fDelay)) return;

    // Take the offering and restore the item!
    Inventory_DestroyAllItems(oObject);
    object oNew = CreateItemOnObject(strItemTag, oObject);
    SetIdentified(oNew, TRUE);

    // Do lightning effect!
    Lightning_DivineFury(oObject, 10.0, 20);

    // Do the normal FX!
    effect eVFXC = EffectVisualEffect(VFX_IMP_HOLY_AID);        // For shrine
    effect eVFXE = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eVFXD = EffectVisualEffect(VFX_FNF_HOWL_ODD);        // For shrine
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFXE, GetLocation(oObject));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXC, oObject);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFXD, oObject);
}

// Gets the state of the lever specified
int Placeable_Lever_GetState(object oLever) {
    return(GetLocalInt(oLever, "iState"));
}

// Switches the state of the lever that was pulled, stores the state variable
// on it and returns that state to the caller. BE SURE to set the default state
// of the Lever to DEACTIVATED from the toolset!!!
int Placeable_Lever_SwitchState(object oLever) {
    int iState = GetLocalInt(oLever, "iState");
    if (iState == TRUE) {
        iState = FALSE;
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        AssignCommand(oLever, SpeakString("Off"));
    }
    else {
        iState = TRUE;
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oLever, SpeakString("On"));
    }
    // Store the lever's state
    SetLocalInt(oLever, "iState", iState);
    return iState;
}

// Allows the player a chance to revive if a temple is not in range
void Player_HeartBeat_Raise(object oPC, float fHeartBeat=6.0, int iReviveDC = 25) {
    int iFortSave = GetFortitudeSavingThrow(oPC) + d20();
    int iWillSave = GetWillSavingThrow(oPC) + d20();
    int iDeathDC = 23;
    int iWillDC  = 24;
    if (GetLevel(oPC) < 5) { iDeathDC -= 8; iWillDC -= 7; }
    else if (GetLevel(oPC) < 10) { iDeathDC -= 4; iWillDC -= 3; }
    else if (GetLevel(oPC) < 15) { iDeathDC -= 2; iWillDC -=1; }
    if (iFortSave >= iDeathDC) {
        SendMessageToPC(oPC, "Save (roll: " + IntToString(iFortSave) + ") vs. Death (" + IntToString(iDeathDC) + ") *success*");
        if (iWillSave >= iWillDC) {
            SendMessageToPC(oPC, "Save (roll: " + IntToString(iWillSave) + ") vs. Will (" + IntToString(iWillDC) + ") *success*");
            Player_RestoreToLife(oPC);
            return;
        }
        else SendMessageToPC(oPC, "Save (roll: " + IntToString(iWillSave) + ") vs. Will (" + IntToString(iWillDC) + ") *failure*");
    }
    else SendMessageToPC(oPC, "Save (roll: " + IntToString(iFortSave) + ") vs. Death (" + IntToString(iDeathDC) + ") *failure*");
    AssignCommand(oPC, DelayCommand(fHeartBeat, Player_HeartBeat_Revive(oPC)));
}

// Called from the modules OnPlayerDeath event.  In case the PC is out of range of a Temple and cannot
// respawn, he should have the chance of reviving in time
void Player_HeartBeat_Revive(object oPC, float fHeartBeat=6.0, int iReviveDC = 25) {
    // If PC is alive, stop checking his saving throws!!!!
    if (!GetIsDead(oPC)) return;

    // Adjust the DC for PC's level
    int iLevel = GetLevel(oPC);
    if      (iLevel <  5) iReviveDC -= 10;
    else if (iLevel < 10) iReviveDC -= 5;
    else if (iLevel < 15) iReviveDC -= 2;

    // Make the saving throw for life!
    int iSave = GetFortitudeSavingThrow(oPC) + d20();
    if (iSave > iReviveDC) {
        SendMessageToPC(oPC, "Save (roll: " + IntToString(iSave) + ") vs. Fortitude (" + IntToString(iReviveDC) + ") *success*");
        FloatingTextStringOnCreature("Your heart has begun to pump again... faintly...", oPC);
        effect eFX = EffectRegenerate(d4(), 1.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFX, oPC, fHeartBeat);
        AssignCommand(oPC, DelayCommand(fHeartBeat, Player_HeartBeat_Raise(oPC, fHeartBeat, iReviveDC)));
    }
    else AssignCommand(oPC, DelayCommand(fHeartBeat, Player_HeartBeat_Revive(oPC, fHeartBeat, iReviveDC)));
}

// Raise the PC
void Player_RestoreToLife(object oPC) {
    FloatingTextStringOnCreature("The fates are with you! Your heart refuses to quit and you regain consciousness!", oPC);
    effect eFX = EffectResurrection();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oPC);
    eFX = EffectHeal(d12());
    AssignCommand(GetArea(oPC), DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX, oPC)));
}

// Returns the default portal tag for the module
string Recall_GetDefaultPortalTag() {
    return(GetLocalString(GetModule(), "strDefaultPortal"));
}
// Called from Recall_IsRecall() in order to determine the location to recall a PC to for an area
string Recall_GetPortalTag(object oArea=OBJECT_SELF) {
    string strRecallPortal = GetLocalString(oArea, "strRecallPortal");

    if (GetStringLength(strRecallPortal) < 1) {
        // Check if a default portal is available
        if (Recall_IsDefaultPortalActive()) {
            if (!Recall_IsDefaultPortalBlocked()) {  // Check too see if area is blocking the default portal
                strRecallPortal = Recall_GetDefaultPortalTag();
            }
        }
    }
    return(strRecallPortal);
}

// Called in the OnEnter event for an area to set the location tag that will be used for recalls
void Recall_InitializeArea(string strRecallPortal, string strDefaultPortal="NULL", object oArea=OBJECT_SELF) {
    // Check to make sure that the portal tag string passed in was valid
    object oPortal = GetObjectByTag(strRecallPortal);
    if (!GetIsObjectValid(oPortal)) return;

    // Set the recall variables for the area if all is good
    SetLocalInt(oArea, "iRecallActive", TRUE);
    SetLocalString(oArea, "strRecallPortal", strRecallPortal);

    // If a default portal was passed in, set it for the module
    if (strDefaultPortal != "NULL") Recall_SetDefaultPortal(strDefaultPortal);
}

// Called to determine if the recall stone is active for the given area
int Recall_IsAreaActive(object oArea=OBJECT_SELF) {
    if (GetLocalInt(oArea, "iRecallActive")) {
        return TRUE; // Yes, area was initialized
    }
    if (Recall_IsDefaultPortalActive() && !Recall_IsDefaultPortalBlocked(oArea)) return TRUE;   // Yes, area was initialized with a default portal and is not blocked
    return FALSE;   // No, area not initialized
}

// Checks too see if there is a default portal
int Recall_IsDefaultPortalActive() {
    return(GetLocalInt(GetModule(), "iDefaultActive"));
}

// If the default portal is active for the module, an area can see if it's blocked (PCs are not permitted to
// transport out) by calling this function.
int Recall_IsDefaultPortalBlocked(object oArea=OBJECT_SELF) {
    return(GetLocalInt(oArea, "iBlockValue"));
}

// Called from the modules OnActivateItem script to determine if the item used was a Recall Stone
// Hope you kept it from the original campaign, fucka!  When adding a portal to an area, be sure to
// use the CUSTOM | VISUAL EFFECTS | Portal placeable and to give it a UNIQUE name!
int Recall_IsRecall() {
    if (GetTag(GetItemActivated()) == "NW_IT_RECALL") {

        object oPC = GetItemActivator();
        object oArea = GetArea(oPC);

        // Check the area's Stone global too see if player can transport from the area
        if (!Recall_IsAreaActive(oArea)) {
                // No idea what the following is, so just leave it... couldn't find the 'string table'
                AssignCommand(GetItemActivator(), ActionSpeakStringByStrRef(10611));
                return TRUE;
        }

        // Continue with transport
        string strPortal = Recall_GetPortalTag(oArea);
        object oPortal = GetObjectByTag(strPortal);
        if (GetIsObjectValid(oPortal) == TRUE) {
            // Set the last used location flag and value
            SetLocalInt(GetItemActivator(), "NW_L_USED_RECALL", 1);
            SetLocalLocation(GetItemActivator(), "NW_L_LOC_RECALL", GetLocation(GetItemActivator()));

            // Carry out the transport command
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, PlaySound("as_mg_telepout1"));
            AssignCommand(oPC, JumpToLocation(GetLocation(oPortal)));
            AssignCommand(oPC, ActionDoCommand(ClearAllActions()));
            return TRUE;
        }
        else {  // Error string, no temple is nearby!
                AssignCommand(GetItemActivator(), ActionSpeakStringByStrRef(10614));
                return TRUE;
        }
    } // end If (GetTag())
    return FALSE;
}

// Called once from an area's OnEnter slot to set whether the Stone of Recall can be used in that area.
// Normally, this is used to block retrieval to the Default Recall Portal for the module, set with
// Recall_SetDefaultPortal().
void Recall_SetAreaBlocked(int iBlockValue=TRUE, object oArea=OBJECT_SELF) {
    SetLocalInt(oArea, "iBlockValue", iBlockValue);
}

// Called from a modules OnModuleLoad or once from the OnClientEnter events to allow one portal
// to be associated with all areas of the module.  The portal assigned to an area with Recall_InitializeArea()
// takes precedence over the default portal.
void Recall_SetDefaultPortal(string strDefaultPortal) {
    SetLocalString(GetModule(), "strDefaultPortal", strDefaultPortal);
    SetLocalInt(GetModule(), "iDefaultActive", TRUE);
}

// Adds iValue to the Item Tag passed in - assumes there are suppossed to be 3
// digits trailing!!!!
string String_AddDigits(string strItemTag, int iValue, int iDigits=2) {
    string strDigits = IntToString(iValue);
    int iIndex;
    for (iIndex=GetStringLength(strDigits); iIndex<iDigits; iIndex++) strItemTag += "0";
    strItemTag += strDigits;
    return(strItemTag);
}

// Returns the text string naming an ability score
string String_GetAbilityText(int iAbility) {
    string strAbility;
    if (iAbility == ABILITY_CHARISMA)       strAbility = "Charisma";
    if (iAbility == ABILITY_CONSTITUTION)   strAbility = "Constitution";
    if (iAbility == ABILITY_DEXTERITY)      strAbility = "Dexterity";
    if (iAbility == ABILITY_INTELLIGENCE)   strAbility = "Intelligence";
    if (iAbility == ABILITY_STRENGTH)       strAbility = "Strength";
    if (iAbility == ABILITY_WISDOM)         strAbility = "Wisdom";
    return(strAbility);
}

// Returns TRUE if the string 'strFindThis' was found in 'strOriginal'.
int String_IsSubString(string strOriginal, string strFindThis) {
    if (-1 != FindSubString(strOriginal, strFindThis)) return TRUE;
    return FALSE;
}

// Called to have the Area respawn an object.  The final parameter is optional - if it's "",
// no action will be taken.  If it contains an array of item tags with stack sizes, the items will
// be created on the new object.
void Respawn_ByResrefWithDelay(object oObject, float fDelay, string strInventoryArray="") {
    string strResRef = GetResRef(oObject);
    int iType = GetObjectType(oObject);
    location lLoc = GetLocation(oObject);
    object oArea = GetArea(oObject);
    AssignCommand(oArea, DestroyObject(oObject, fDelay-1.0));
    AssignCommand(oArea, DelayCommand(fDelay, Respawn_DoRespawn(iType, strResRef, lLoc, strInventoryArray)));
}

// Create an object in the area
void Respawn_DoRespawn(int iType, string strResRef, location lLoc, string strInventoryArray="") {
    object oObject = CreateObject(iType, strResRef, lLoc);
    Object_RespawnSpecialInventory(oObject, strInventoryArray);
}

// Rolls a 'die' against the chance passed in and returns 'TRUE' if the roll was LESS than iPercent.
int RollChance(int iPercent) {
    int iRand = Random(100);
    if (iRand <= iPercent) return TRUE;
    return FALSE;
}

// Function Version 1.00 - 12/31/02
// Returns TRUE if the spell is offensive (can be used to attack an enemy), FALSE if it
// is defensive and -1 if it was not found in the list.
// *DOES NOT* cover all spells in the game yet!
int Spell_IsOffensive(int iSpellID) {
    if (iSpellID == SPELL_ACID_FOG) return TRUE;
    if (iSpellID == SPELL_AID) return FALSE;
    if (iSpellID == SPELL_BARKSKIN) return FALSE;
    if (iSpellID == SPELL_BESTOW_CURSE) return TRUE;
    if (iSpellID == SPELL_BLESS) return FALSE;
    if (iSpellID == SPELL_BLINDNESS_AND_DEAFNESS) return TRUE;
    if (iSpellID == SPELL_BULLS_STRENGTH) return FALSE;
    if (iSpellID == SPELL_BURNING_HANDS) return TRUE;
    if (iSpellID == SPELL_CALL_LIGHTNING) return TRUE;
    if (iSpellID == SPELL_CHAIN_LIGHTNING) return TRUE;
    if (iSpellID == SPELL_CHARM_PERSON) return TRUE;
    if (iSpellID == SPELL_CLARITY) return FALSE;
    if (iSpellID == SPELL_CLOUDKILL) return TRUE;
    if (iSpellID == SPELL_COLOR_SPRAY) return TRUE;
    if (iSpellID == SPELL_CONE_OF_COLD) return TRUE;
    if (iSpellID == SPELL_CONFUSION) return TRUE;
    if (iSpellID == SPELL_CREATE_GREATER_UNDEAD) return FALSE;
    if (iSpellID == SPELL_CREATE_UNDEAD) return FALSE;
    if (iSpellID == SPELL_CREEPING_DOOM) return FALSE;
    if (iSpellID == SPELL_CURE_CRITICAL_WOUNDS) return FALSE;
    if (iSpellID == SPELL_CURE_LIGHT_WOUNDS) return FALSE;
    if (iSpellID == SPELL_CURE_MINOR_WOUNDS) return FALSE;
    if (iSpellID == SPELL_CURE_MODERATE_WOUNDS) return FALSE;
    if (iSpellID == SPELL_CURE_SERIOUS_WOUNDS) return FALSE;
    if (iSpellID == SPELL_DARKNESS) return TRUE;
    if (iSpellID == SPELL_DARKVISION) return FALSE;
    if (iSpellID == SPELL_DAZE) return TRUE;
    if (iSpellID == SPELL_DEATH_WARD) return FALSE;
    if (iSpellID == SPELL_DISMISSAL) return TRUE;
    if (iSpellID == SPELL_DISPEL_MAGIC) return TRUE;
    if (iSpellID == SPELL_DIVINE_POWER) return FALSE;
    if (iSpellID == SPELL_DOMINATE_PERSON) return TRUE;
    if (iSpellID == SPELL_DOOM) return TRUE;
    if (iSpellID == SPELL_ENDURANCE) return FALSE;
    if (iSpellID == SPELL_ENDURE_ELEMENTS) return FALSE;
    if (iSpellID == SPELL_ENERGY_BUFFER) return FALSE;
    if (iSpellID == SPELL_ENERGY_DRAIN) return TRUE;
    if (iSpellID == SPELL_ENTANGLE) return TRUE;
    if (iSpellID == SPELL_FEAR) return TRUE;
    if (iSpellID == SPELL_FEEBLEMIND) return TRUE;
    if (iSpellID == SPELL_FINGER_OF_DEATH) return TRUE;
    if (iSpellID == SPELL_FIRE_STORM) return TRUE;
    if (iSpellID == SPELL_FIREBALL) return TRUE;
    if (iSpellID == SPELL_FLAME_ARROW) return TRUE;
    if (iSpellID == SPELL_FLAME_LASH) return TRUE;
    if (iSpellID == SPELL_FLAME_STRIKE) return TRUE;
    if (iSpellID == SPELL_FOXS_CUNNING) return FALSE;
    if (iSpellID == SPELL_FREEDOM_OF_MOVEMENT) return FALSE;
    if (iSpellID == SPELL_GHOUL_TOUCH) return TRUE;
    if (iSpellID == SPELL_GHOSTLY_VISAGE) return FALSE;
    if (iSpellID == SPELL_GLOBE_OF_INVULNERABILITY) return FALSE;
    if (iSpellID == SPELL_GREASE) return FALSE;
    if (iSpellID == SPELL_GREATER_STONESKIN) return FALSE;
    if (iSpellID == SPELL_GREATER_BULLS_STRENGTH) return FALSE;
    if (iSpellID == SPELL_GREATER_CATS_GRACE) return FALSE;
    if (iSpellID == SPELL_GREATER_DISPELLING) return TRUE;
    if (iSpellID == SPELL_GREATER_ENDURANCE) return FALSE;
    if (iSpellID == SPELL_GREATER_FOXS_CUNNING) return FALSE;
    if (iSpellID == SPELL_GREATER_MAGIC_WEAPON) return FALSE;
    if (iSpellID == SPELL_GREATER_OWLS_WISDOM) return FALSE;
    if (iSpellID == SPELL_HARM) return TRUE;
    if (iSpellID == SPELL_HASTE) return FALSE;
    if (iSpellID == SPELL_HEAL) return FALSE;
    if (iSpellID == SPELL_HORRID_WILTING) return TRUE;
    if (iSpellID == SPELL_ICE_STORM) return TRUE;
    if (iSpellID == SPELL_IMPLOSION) return TRUE;
    if (iSpellID == SPELL_IMPROVED_INVISIBILITY) return TRUE;
    if (iSpellID == SPELL_INCENDIARY_CLOUD) return TRUE;
    if (iSpellID == SPELL_INVISIBILITY) return FALSE;
    if (iSpellID == SPELL_INVISIBILITY_PURGE) return TRUE;
    if (iSpellID == SPELL_LESSER_DISPEL) return TRUE;
    if (iSpellID == SPELL_LESSER_RESTORATION) return FALSE;
    if (iSpellID == SPELL_LESSER_SPELL_BREACH) return TRUE;
    if (iSpellID == SPELL_LIGHT) return TRUE;
    if (iSpellID == SPELL_LIGHTNING_BOLT) return TRUE;
    if (iSpellID == SPELL_MAGE_ARMOR) return FALSE;
    if (iSpellID == SPELL_MAGIC_MISSILE) return TRUE;
    if (iSpellID == SPELL_MASS_CHARM) return TRUE;
    if (iSpellID == SPELL_MASS_HASTE) return FALSE;
    if (iSpellID == SPELL_MASS_HEAL) return FALSE;
    if (iSpellID == SPELL_MELFS_ACID_ARROW) return TRUE;
    if (iSpellID == SPELL_METEOR_SWARM) return TRUE;
    if (iSpellID == SPELL_MIND_BLANK) return TRUE;
    if (iSpellID == SPELL_MIND_FOG) return TRUE;
    if (iSpellID == SPELL_MINOR_GLOBE_OF_INVULNERABILITY) return FALSE;
    if (iSpellID == SPELL_MORDENKAINENS_DISJUNCTION) return TRUE;
    if (iSpellID == SPELL_MORDENKAINENS_SWORD) return FALSE;
    if (iSpellID == SPELL_NEGATIVE_ENERGY_BURST) return TRUE;
    if (iSpellID == SPELL_NEGATIVE_ENERGY_PROTECTION) return FALSE;
    if (iSpellID == SPELL_NEGATIVE_ENERGY_RAY) return TRUE;
    if (iSpellID == SPELL_NEUTRALIZE_POISON) return FALSE;
    if (iSpellID == SPELL_OWLS_WISDOM) return FALSE;
    if (iSpellID == SPELL_PHANTASMAL_KILLER) return FALSE;
    if (iSpellID == SPELL_POISON) return TRUE;
    if (iSpellID == SPELL_POWER_WORD_KILL) return TRUE;
    if (iSpellID == SPELL_POWER_WORD_STUN) return TRUE;
    if (iSpellID == SPELL_PRAYER) return FALSE;
    if (iSpellID == SPELL_PREMONITION) return FALSE;
    if (iSpellID == SPELL_PRISMATIC_SPRAY) return TRUE;
    if (iSpellID == SPELL_RAY_OF_ENFEEBLEMENT) return TRUE;
    if (iSpellID == SPELL_RAY_OF_FROST) return TRUE;
    if (iSpellID == SPELL_REGENERATE) return FALSE;
    if (iSpellID == SPELL_RESIST_ELEMENTS) return FALSE;
    if (iSpellID == SPELL_RESISTANCE) return FALSE;
    if (iSpellID == SPELL_RESTORATION) return FALSE;
    if (iSpellID == SPELL_SANCTUARY) return FALSE;
    if (iSpellID == SPELL_SCARE) return FALSE;
    if (iSpellID == SPELL_SHADOW_SHIELD) return FALSE;
    if (iSpellID == SPELL_SILENCE) return FALSE;
    if (iSpellID == SPELL_SLAY_LIVING) return TRUE;
    if (iSpellID == SPELL_SLEEP) return TRUE;
    if (iSpellID == SPELL_SLOW) return TRUE;
    if (iSpellID == SPELL_SOUND_BURST) return TRUE;
    if (iSpellID == SPELL_SPELL_RESISTANCE) return FALSE;
    if (iSpellID == SPELL_SPHERE_OF_CHAOS) return FALSE;
    if (iSpellID == SPELL_STINKING_CLOUD) return TRUE;
    if (iSpellID == SPELL_STONESKIN) return FALSE;
    if (iSpellID == SPELL_STORM_OF_VENGEANCE) return TRUE;
    if (iSpellID == SPELL_SUMMON_CREATURE_I) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_II) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_III) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_IV) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_IX) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_V) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_VI) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_VII) return FALSE;
    if (iSpellID == SPELL_SUMMON_CREATURE_VIII) return FALSE;
    if (iSpellID == SPELL_SUNBEAM) return TRUE;
    if (iSpellID == SPELL_TIME_STOP) return FALSE;
    if (iSpellID == SPELL_TRUE_SEEING) return FALSE;
    if (iSpellID == SPELL_VIRTUE) return FALSE;
    if (iSpellID == SPELL_WAIL_OF_THE_BANSHEE) return TRUE;
    if (iSpellID == SPELL_WALL_OF_FIRE) return TRUE;
    if (iSpellID == SPELL_WAR_CRY) return FALSE;
    if (iSpellID == SPELL_WEB) return TRUE;
    if (iSpellID == SPELL_WEIRD) return TRUE;
    if (iSpellID == SPELL_WORD_OF_FAITH) return FALSE;
    return -1;
}

void Sunlight_CheckForSunriseInArea(object oArea, float fHeartBeat=12.0) {
    // Set an integer on the area to indicate to other Sunlight checking scripts
    // that the area calling this function has sunlight periods.
    SetLocalInt(oArea, "iHasSunlight", TRUE);

    // FALSE for Night and Dusk, TRUE for Day and Dawn.
    int iLastLight      = GetLocalInt(oArea, "iLastLight");
    int iCurrentLight;
    if (GetIsDay() || GetIsDawn()) iCurrentLight = TRUE;
    else iCurrentLight = FALSE;

    // The sun has come up, destroy undead
    if (iLastLight == FALSE && iCurrentLight == TRUE) Sunlight_DestroyUndeadInArea(oArea);

    // Save the current light condition to the last light condition
    SetLocalInt(oArea, "iLastLight", iCurrentLight);

    // Schedule another check
    AssignCommand(oArea, DelayCommand(fHeartBeat, Sunlight_CheckForSunriseInArea(oArea, fHeartBeat)));
}

void Sunlight_CheckForSunlightOnUndead(object oUndead) {
    // Do not continue if the area does not receive sunlight
    if (!GetLocalInt(GetArea(oUndead), "iHasSunlight")) return;

    // Only apply sunlight effects to undead during dawn and day periods
    if (Object_IsClassAndRace(CLASS_TYPE_UNDEAD, oUndead)) {
        if (GetIsDawn()) Sunlight_DamageUndead(oUndead);
        else if (GetIsDay()) AssignCommand(GetArea(oUndead), DelayCommand(6.0 + IntToFloat(d10()), Sunlight_DestroyUndead(oUndead)));
    }
}

void Sunlight_DamageUndead(object oUndead, int iMaxDamage=12, int iMinDamage=6, float fFrequency=2.0, int iRepeats=20) {
    iMaxDamage -= iMinDamage;
    if (iMaxDamage <= 1) iMaxDamage=1;
    int iTotalDamage = iMinDamage + Random(iMaxDamage);
    effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDamage = EffectDamage(iTotalDamage, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_PLUS_FIVE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oUndead);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oUndead);
    iRepeats-=1;
    if (!GetIsDead(oUndead) && iRepeats > 0) AssignCommand(GetArea(oUndead), DelayCommand(fFrequency, Sunlight_DamageUndead(oUndead, iMaxDamage, iMinDamage, fFrequency, iRepeats)));
}

void Sunlight_DestroyUndead(object oUndead) {
    effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_M);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oUndead);
    DestroyObject(oUndead, 0.5);
}

// Called from Sunlight_CheckLight() to kill all Undead in the area that was passed. Any undead found
// will explode into flames!!!!
void Sunlight_DestroyUndeadInArea(object oArea) {
    object oObject = GetFirstObjectInArea(oArea);
    effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_M);

    // Find a zombie!
    while (GetIsObjectValid(oObject)) {
        if (Object_IsClassAndRace(CLASS_TYPE_UNDEAD, oObject)) AssignCommand(oArea, DelayCommand(6.0 + IntToFloat(d10()), Sunlight_DestroyUndead(oObject)));
        oObject = GetNextObjectInArea(oArea);
    }
}

// Calculates the fuel left remaining on the torch. Does not stop executing until
// the PC leaves the game!
void TorchLight_Heartbeat(object oPC, float fHeartBeat, float fBurnLimit, float fBurnRate) {
    int iHoldingTorchNow = TorchLight_IsHoldingTorch(oPC);
    float fTorchFuelRemaining = GetLocalFloat(oPC, "fTorchFuelRemaining");

    // If torch is depleted, destroy it and reset the Fuel value to the BurnLimit
    if (fTorchFuelRemaining <= 1.0) {
            object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
            string strItemTag = GetTag(oTorch);
            SetLocalFloat(oPC, "fTorchFuelRemaining", fBurnLimit);
            if (strItemTag == "NW_IT_TORCH001") {
                DestroyObject(oTorch, 1.5);
                FloatingTextStringOnCreature("My torch has run out of fuel...", oPC);
            }
    }

    // Check to see if the PC is using a torch...
    if (iHoldingTorchNow) {
        fTorchFuelRemaining -= fBurnRate; // Consume some fuel for the torch
        SetLocalFloat(oPC, "fTorchFuelRemaining", fTorchFuelRemaining);
    }

    // Check what the PC's status is again in fHeartBeat seconds
    AssignCommand(oPC, DelayCommand(fHeartBeat, TorchLight_Heartbeat(oPC, fHeartBeat, fBurnLimit, fBurnRate)));
}

// Initializes the Torch Light System on the PC that has just entered the game.
// Care should be taken to ensure the object specified is, in fact, a PC. The burn limit is
// set to 2880, which is 48 minutes Real time given that the burn rate stays at 6.0. 48 minutes
// Real time is about equal to 1 day in the game. This is a *generous* setting...
void TorchLight_Initialize(object oPC, float fHeartBeat=6.0, float fBurnLimit=2880.0, float fBurnRate=6.0) {
    AssignCommand(oPC, DelayCommand(fHeartBeat, TorchLight_Heartbeat(oPC, fHeartBeat, fBurnLimit, fBurnRate)));
}

// Returns TRUE if the PC is holding his torch, FALSE otherwise.
int TorchLight_IsHoldingTorch(object oPC) {
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    string strItemTag = GetTag(oItem);
    if (strItemTag == "NW_IT_TORCH001") return TRUE;
    return FALSE;
}

// Places the custom meat item on the body once it's dead
int Treasure_Death_CreateMeat(int iProb=45, int iMax=3) {
    if (Random(100) <= iProb) return (Random(iMax)+1);
    return (0);
}

// Returns TRUE if the item was placed, false if not
int Treasure_Death_DecideOnBodyParts(int nPercentChance, int nQuant, string strTemplate, object oMonster) {
    if (nQuant == 0) nQuant = 1;
    int nRand;
    int nResult = FALSE;
    int nIndex;
    for (nIndex=0; nIndex<nQuant; nIndex++) {
        nRand = Random(100);
        if (nRand <= nPercentChance) {  // Place Item
            object oReagent = CreateItemOnObject(strTemplate, oMonster, nQuant);
            SetIdentified(oReagent, TRUE);
            nResult = TRUE;
        }
    }
    return nResult;
}

void Treasure_Death_DecideOnMeat(object oMonster) {
    int iChance = 4 * GetHitDice(oMonster);
    int iStack = Random(GetHitDice(oMonster)+1);
    int iIndex;
    for (iIndex=0; iIndex<iStack; iIndex++) {
        if (d100() < iChance) CreateItemOnObject("cu_food000", oMonster, 1);
    }
}

// This function decides what (if any) body parts to place on the corpse given what was killed
void Treasure_Death_PlaceBodyParts(object oMonster=OBJECT_SELF) {
    // Prevent this code from running on a creature more than once
    if (GetLocalInt(oMonster, "NW_DO_ONCE")) return;
    SetLocalInt(oMonster, "NW_DO_ONCE", TRUE);

    // Get the name of the creature
    string strName = GetStringLowerCase(GetName(oMonster));

    // Animals
    if (Object_IsClassAndRace(CLASS_TYPE_ANIMAL, oMonster, TRUE)) Treasure_Death_DecideOnMeat(oMonster);

    // Balor Demons
    if (Object_IsClassAndRace(CLASS_TYPE_OUTSIDER, oMonster, FALSE, "balor")) Treasure_Death_DecideOnBodyParts(25, 2, "cu_reag200", oMonster);

    // Bodak
    if (Object_IsClassAndRace(CLASS_TYPE_UNDEAD, oMonster, FALSE, "bodak")) {
        Treasure_Death_DecideOnBodyParts(30, 1, "cu_reag100", oMonster);            // head?
        Treasure_Death_DecideOnBodyParts(20, 1, "NW_IT_MSMLMISC06", oMonster);      // tooth?
    }

    // Beetles
    if (Object_IsClassAndRace(CLASS_TYPE_VERMIN, oMonster, FALSE, "weevil") ||
        Object_IsClassAndRace(CLASS_TYPE_VERMIN, oMonster, FALSE, "beetle") ||
        Object_IsClassAndRace(CLASS_TYPE_VERMIN, oMonster, FALSE, "hive") ||
        Object_IsClassAndRace(CLASS_TYPE_VERMIN, oMonster, FALSE, "earwig"))
                Treasure_Death_DecideOnBodyParts(30, 1, "cu_reag002", oMonster);    // Beetle Carapace?

    // Brain Weevil
    if (Object_IsClassAndRace(CLASS_TYPE_VERMIN, oMonster, FALSE, "weevil"))
                Treasure_Death_DecideOnBodyParts(15, 1, "cu_reag201", oMonster);

    // Bear parts
    if (Object_IsClassAndRace(CLASS_TYPE_ANIMAL, oMonster, TRUE, "bear")) {
        // Dire Bear?
        if (String_IsSubString(strName, "dire")) Treasure_Death_DecideOnBodyParts(30, 2, "cu_reag102", oMonster);
    }

    // Ettercaps
    if (String_IsSubString(strName, "ettercap")) Treasure_Death_DecideOnBodyParts(15, 1, "cu_reag204", oMonster);  // Spine and brain?

    // Falcons
    if (String_IsSubString(strName, "raptor")) {
        Treasure_Death_DecideOnBodyParts(35, 1, "cu_reag104", oMonster);    // Falcon egg?
        Treasure_Death_DecideOnBodyParts(90, 4, "cu_reag004", oMonster);    // Feather?
    }

    // Giants
    if (Object_IsClassAndRace(CLASS_TYPE_GIANT, oMonster, FALSE, "giant")) {
            Treasure_Death_DecideOnBodyParts(35, 1, "cu_reag310", oMonster);        // Heart?
            if (String_IsSubString(strName, "frost")) Treasure_Death_DecideOnBodyParts(15, 1, "cu_reag309", oMonster);    // // Essence of Frost Giant?
    }

    // Goblins
    if (String_IsSubString(strName, "gob")) {
        Treasure_Death_DecideOnBodyParts(20, 1, "cu_reag105", oMonster);    // Heart?
        Treasure_Death_DecideOnBodyParts(35, 2, "cu_reag106", oMonster);    // Kidneys?
    }

    // Hell-Fiend
    if (String_IsSubString(strName, "fnd")) Treasure_Death_DecideOnBodyParts(45, 2, "cu_reag205", oMonster);    // Eyeball?

    // Iron Golem
    if (String_IsSubString(strName, "goliron")) Treasure_Death_DecideOnBodyParts(70, 1, "cu_reag206", oMonster);    // Spinal cluster?

    // Lich
    if (String_IsSubString(strName, "lich")) Treasure_Death_DecideOnBodyParts(20, 1, "cu_reag207", oMonster); // Lich bones

    // Minotaur
    if (String_IsSubString(strName, "minotaur") || String_IsSubString(strName, "minwiz") || String_IsSubString(strName, "minchief")) {
        Treasure_Death_DecideOnBodyParts(35, 2, "cu_reag313", oMonster);    // Eyeballs?
        Treasure_Death_DecideOnBodyParts(60, 1, "cu_reag314", oMonster);    // Heart?
        Treasure_Death_DecideOnBodyParts(50, 1, "cu_reag315", oMonster);    // Tongue?
    }

    // Nymph
    if (String_IsSubString(strName, "nymph")) Treasure_Death_DecideOnBodyParts(90, 1, "cu_reag208", oMonster);    // Lock of Hair?

    // Orcs
    if (String_IsSubString(strName, "orc")) {
        Treasure_Death_DecideOnBodyParts(25, 2, "cu_reag316", oMonster);    // Ears?
        Treasure_Death_DecideOnBodyParts(15, 2, "cu_reag317", oMonster);    // Eyeballs?
        Treasure_Death_DecideOnBodyParts(35, 1, "cu_reag318", oMonster);    // Head?
    }

    // Succubus
    if (String_IsSubString(strName, "sucubus")) Treasure_Death_DecideOnBodyParts(30, 2, "cu_reag320", oMonster);    // Ears?

    // Tigers
    if (String_IsSubString(strName, "tiger")) Treasure_Death_DecideOnBodyParts(35, 2, "cu_reag321", oMonster);

    // Trolls
    if (String_IsSubString(strName, "troll")) {
        Treasure_Death_DecideOnBodyParts(50, 1, "cu_reag322", OBJECT_SELF);
        Treasure_Death_DecideOnBodyParts(75, 1, "cu_reag323", OBJECT_SELF);
    }

    // Vampires
    if (String_IsSubString(strName, "vampire")) {
        Treasure_Death_DecideOnBodyParts(45, 2, "cu_reag325", oMonster);    // Teeth?
        Treasure_Death_DecideOnBodyParts(40, 1, "cu_reag324", oMonster);    // Heart?
    }

    // Water Elementals
    if (String_IsSubString(strName, "water")) Treasure_Death_DecideOnBodyParts(15, 2, "cu_reag326", oMonster);

    // Wererats
    if (String_IsSubString(strName, "wererat")) Treasure_Death_DecideOnBodyParts(35, 1, "cu_reag319", oMonster);

    // Werewolves
    if (String_IsSubString(strName, "werewolf")) {
        Treasure_Death_DecideOnBodyParts(65, 1, "cu_reag312", oMonster);    // Lock of hair?
        Treasure_Death_DecideOnBodyParts(45, 4, "cu_reag024", oMonster);    // Teeth?
    }

    // Wolves
    if (String_IsSubString(strName, "wolf") && (String_IsSubString(strName, "werewolf") == -1)) {
        Treasure_Death_DecideOnBodyParts(75, 1, "cu_reag212", oMonster);    // Skin?
        Treasure_Death_DecideOnBodyParts(45, 4, "cu_reag024", oMonster);    // Teeth?
    }

    // Zombies
    if (String_IsSubString(strName, "zomb")) Treasure_Death_DecideOnBodyParts(35, 2, "cu_reag111", oMonster);    // Kidnies???
}

// Creates the amount in 'copper' for the quantity of the funds available.
int Treasure_ExchangeFundsForGold(object oPC, object oItem, float fExchangeRate) {
    AssignCommand(oPC, PlaySound("it_coins"));
    int iGoldValue = Treasure_RollCoins(oPC, oItem, fExchangeRate);
    DestroyObject(oItem);
    GiveGoldToCreature(oPC, iGoldValue);
    return(iGoldValue);
}

void Treasure_GenerateBook(object oContainer, object oLastOpener, int iQuality) {
    string strFinal;
    string strItemTag;
    int iMAX;
    // Determine the type of book
    int iType = d100();
    if (iType <= 40)                 { strItemTag = "cu_note"; iMAX = MAX_ALCHEM_NOTES; }
    if (iType  > 40 && iType <= 70)  strItemTag = "cu_recip";
    if (iType  > 70 && iType <= 90)  strItemTag = "cu_book";
    if (iType  > 90)                 strItemTag = "cu_scroll";
    // Determine the Level of the item
    if (iQuality == TREASURE_LOW) {
        if (strItemTag == "cu_recip")   iMAX = MAX_RECIPES_LOW;
        if (strItemTag == "cu_book")    iMAX = MAX_BOOKS_LOW;
        if (strItemTag == "cu_scroll")  iMAX = MAX_SCROLLS_LOW;
        strItemTag += "0";
        strFinal = String_AddDigits(strItemTag, Random(iMAX));
    }
    if (iQuality == TREASURE_MEDIUM) {
        if (strItemTag == "cu_recip")   iMAX = MAX_RECIPES_MEDIUM;
        if (strItemTag == "cu_book")    iMAX = MAX_BOOKS_MEDIUM;
        if (strItemTag == "cu_scroll")  iMAX = MAX_SCROLLS_MEDIUM;
        strItemTag += "1";
        strFinal = String_AddDigits(strItemTag, Random(iMAX));
    }
    if (iQuality == TREASURE_HIGH) {
        if (strItemTag == "cu_recip")   iMAX = MAX_RECIPES_HIGH;
        if (strItemTag == "cu_book")    iMAX = MAX_BOOKS_HIGH;
        if (strItemTag == "cu_scroll")  iMAX = MAX_SCROLLS_HIGH;
        strItemTag += "2";
        strFinal = String_AddDigits(strItemTag, Random(iMAX));
    }
    CreateItemOnObject(strFinal, oContainer);
}

// Creates a random cursed item in the container given
void Treasure_GenerateCursedItem(object oContainer) {
    int iRand = Random(MAX_CURSED_ITEMS);
    string strItemTag = String_AddDigits("cu_cursed", iRand, 3);
    CreateItemOnObject(strItemTag, oContainer, 1);
}

void Treasure_GenerateCustomTreasure(object oContainer, int iWealth=0) {  // Default treasure is from Low, Med, or High
    int iRand;
    string strItemTag;
    int iStack;
    int iProb = d12();  // Probability of a certain category of item to come up
    if (iWealth == TREASURE_LOW) iProb = 1;     //  Treasure is low category
    if (iWealth == TREASURE_MEDIUM) iProb = 8;     // Treasure is medium category
    if (iWealth == TREASURE_HIGH) iProb = 10;     // Treasure is high category

    // Select an item category
    iRand = Random(15);     // Purposely high!!!
    if (iProb <= 6) {
        // Potions
        if (iRand == 0) { iStack = Random(3); strItemTag = String_AddDigits("cu_potion0", Random(MAX_POTIONS_LOW)); }
        // Scrolls
        if (iRand == 1) { iStack = Random(2);  strItemTag = String_AddDigits("cu_scroll0", Random(MAX_SCROLLS_LOW));  }
        // Reagents
        if (iRand == 2) { iStack = Random(5);  strItemTag = String_AddDigits("cu_reag0", Random(MAX_REAGENTS_LOW));  }
        // Ammunitions
        if (iRand == 3) { iStack = Random(50);  strItemTag = String_AddDigits("cu_ammo0", Random(MAX_AMMO_LOW));  }
        // Armors
        if (iRand == 4) { iStack = Random(2); strItemTag = String_AddDigits("cu_armor0", Random(MAX_ARMOR_LOW));  }
        // Books
        if (iRand == 5) { iStack = Random(2); strItemTag = String_AddDigits("cu_book0", Random(MAX_BOOKS_LOW));  }
        // Clothing
        if (iRand == 6) { iStack = Random(2); strItemTag = String_AddDigits("cu_cloth0", Random(MAX_CLOTHING_LOW)); }
        // Jewelry
        if (iRand == 7) { iStack = Random(2); strItemTag = String_AddDigits("cu_jewel0", Random(MAX_JEWELRY_LOW));   }
        // Notes
        if (iRand == 8) { iStack = Random(2); strItemTag = String_AddDigits("cu_note0", Random(MAX_ALCHEM_NOTES-7));  }
        // Recipes
        if (iRand == 9) { iStack = Random(3); strItemTag = String_AddDigits("cu_recip0", Random(MAX_RECIPES_LOW));  }
        // Weapons
        if (iRand == 10) { iStack = Random(2); strItemTag = String_AddDigits("cu_weap0", Random(MAX_WEAPONS_LOW));    }
    }
    else if (iProb <= 9) {
        // Potions
        if (iRand == 0) { iStack = Random(2); strItemTag = String_AddDigits("cu_potion1", Random(MAX_POTIONS_MEDIUM)); }
        // Scrolls
        if (iRand == 1) { iStack = Random(2);  strItemTag = String_AddDigits("cu_scroll1", Random(MAX_SCROLLS_MEDIUM));  }
        // Reagents
        if (iRand == 2) { iStack = Random(3);  strItemTag = String_AddDigits("cu_reag1", Random(MAX_REAGENTS_MEDIUM));  }
        // Ammunitions
        if (iRand == 3) { iStack = Random(15);  strItemTag = String_AddDigits("cu_ammo1", Random(MAX_AMMO_MEDIUM));  }
        // Armors
        if (iRand == 4) { iStack = Random(2); strItemTag = String_AddDigits("cu_armor1", Random(MAX_ARMOR_MEDIUM));  }
        // Books
        if (iRand == 5) { iStack = Random(2); strItemTag = String_AddDigits("cu_book1", Random(MAX_BOOKS_MEDIUM));  }
        // Clothing
        if (iRand == 6) { iStack = Random(2); strItemTag = String_AddDigits("cu_cloth1", Random(MAX_CLOTHING_MEDIUM)); }
        // Jewelry
        if (iRand == 7) { iStack = Random(2); strItemTag = String_AddDigits("cu_jewel1", Random(MAX_JEWELRY_MEDIUM));   }
        // Notes
        if (iRand == 8) { iStack = Random(2); strItemTag = String_AddDigits("cu_note1", Random(MAX_ALCHEM_NOTES-4));  }
        // Recipes
        if (iRand == 9) { iStack = Random(2); strItemTag = String_AddDigits("cu_recip1", Random(MAX_RECIPES_MEDIUM));  }
        // Weapons
        if (iRand == 10) { iStack = Random(2); strItemTag = String_AddDigits("cu_weap1", Random(MAX_WEAPONS_MEDIUM));    }
        // Misc Items
        if (iRand == 11) Treasure_GenerateMiscItem(oContainer);
        // Generate Poison
        if (iRand == 12) Treasure_GeneratePoisonPotion(oContainer);
    }
    else {
        // Potions
        if (iRand == 0) { iStack = Random(2); strItemTag = String_AddDigits("cu_potion2", Random(MAX_POTIONS_HIGH)); }
        // Scrolls
        if (iRand == 1) { iStack = Random(2);  strItemTag = String_AddDigits("cu_scroll2", Random(MAX_SCROLLS_HIGH));  }
        // Reagents
        if (iRand == 2) { iStack = Random(2);  strItemTag = String_AddDigits("cu_reag2", Random(MAX_REAGENTS_HIGH));  }
        // Ammunitions
        if (iRand == 3) { iStack = Random(8);  strItemTag = String_AddDigits("cu_ammo2", Random(MAX_AMMO_HIGH));  }
        // Armors
        if (iRand == 4) { iStack = Random(2); strItemTag = String_AddDigits("cu_armor2", Random(MAX_ARMOR_HIGH));  }
        // Books
        if (iRand == 5) { iStack = Random(2); strItemTag = String_AddDigits("cu_book2", Random(MAX_BOOKS_HIGH));  }
        // Clothing
        if (iRand == 6) { iStack = Random(2); strItemTag = String_AddDigits("cu_cloth2", Random(MAX_CLOTHING_HIGH)); }
        // Jewelry
        if (iRand == 7) { iStack = Random(2); strItemTag = String_AddDigits("cu_jewel2", Random(MAX_JEWELRY_HIGH));   }
        // Notes
        if (iRand == 8) { iStack = Random(3); strItemTag = String_AddDigits("cu_note2", Random(MAX_ALCHEM_NOTES));  }
        // Recipes
        if (iRand == 9) { iStack = Random(2); strItemTag = String_AddDigits("cu_recip2", Random(MAX_RECIPES_HIGH));  }
        // Weapons
        if (iRand == 10) { iStack = Random(2); strItemTag = String_AddDigits("cu_weap2", Random(MAX_WEAPONS_HIGH));    }
        // Misc Items
        if (iRand == 11) Treasure_GenerateMiscItem(oContainer);
    }
    // Create the object in inventory
    // NOTE! iStack -can- be ZERO (by design), which will cause the creation to fail!
    CreateItemOnObject(strItemTag, oContainer, iStack);
}

// Create a custom-misc item on the container
object Treasure_GenerateMiscItem(object oContainer) {
    int iRand = Random(MAX_MISCELLANEOUS);
    string strItemTag = "INVALID";
    int iStack = 0;
    if (iRand == 0) if (RollChance(6))  { strItemTag = "AlchemistsEquipment"; iStack = 1; }
    if (iRand == 1) if (RollChance(8))  { strItemTag = "ScribesKit"; iStack = 1; }
    if (iRand == 2) if (RollChance(85)) { strItemTag = "BlankParchment"; iStack = d8(); }
    if (iRand == 3) if (RollChance(3))  { strItemTag = "BucknardsEverfullPurse"; iStack = 1; }
    if (iRand == 4) if (RollChance(90)) { strItemTag = "EmptyVile"; iStack = d10(); }
    if (iRand == 5) if (RollChance(12)) { strItemTag = "FigurineofWonderousPower"; iStack = 1; }
    if (iRand == 6) if (RollChance(12)) { strItemTag = "figurineofwon002"; iStack = 1; }
    if (iRand == 7) if (RollChance(12)) { strItemTag = "figurineofwonder"; iStack = 1; }
    if (iRand == 8) if (RollChance(60)) { strItemTag = "EmptyBottle"; iStack = d10(); }
    if (iRand == 8) if (RollChance(5))  { strItemTag = "ThievesTools"; iStack = 1; }
    return(CreateItemOnObject(strItemTag, oContainer, iStack));
}

// Creates a book item (book or scroll) from the stock NWN items
void Treasure_GenerateNWNBook(object oContainer, object oLastOpener) {
    if (d100() < 60) CreateBook(oContainer);
    else CreateArcaneScroll(oContainer, oLastOpener);
}

// Create a Poison in the container
object Treasure_GeneratePoisonPotion(object oContainer) {
    string strPoison;
    object oPoison;
    strPoison = String_AddDigits("cu_potion0", Random(MAX_POISONS));
    if (60 <= Random(100)) oPoison = CreateItemOnObject(strPoison, oContainer, d4());     // 40% chance of creating a poison potion to make them fairly rare
    return (oPoison);
}

// Create a custom potion in the container
void Treasure_GeneratePotion(object oContainer, object oAdventurer, int iQuality) {
    string strItemTag;
    if (iQuality == TREASURE_LOW)       strItemTag = String_AddDigits("cu_potion0", Random(MAX_POTIONS_LOW));
    if (iQuality == TREASURE_MEDIUM)    strItemTag = String_AddDigits("cu_potion1", Random(MAX_POTIONS_MEDIUM));
    if (iQuality == TREASURE_HIGH)      strItemTag = String_AddDigits("cu_potion2", Random(MAX_POTIONS_HIGH));
    CreateItemOnObject(strItemTag, oContainer);
}

// Create a reagent item in the container
void Treasure_GenerateReagent(object oContainer, int iQuality) {
    string strReagent = "cu_reag";
    if (iQuality == TREASURE_LOW)    { strReagent += "0"; strReagent = String_AddDigits(strReagent, Random(MAX_REAGENTS_LOW)); };
    if (iQuality == TREASURE_MEDIUM) { strReagent += "1"; strReagent = String_AddDigits(strReagent, Random(MAX_REAGENTS_MEDIUM)); };
    if (iQuality == TREASURE_HIGH)   { strReagent += "2"; strReagent = String_AddDigits(strReagent, Random(MAX_REAGENTS_HIGH)); };
    CreateItemOnObject(strReagent, oContainer);
}

// Generate Custom and Standard treasure on the object with the information passed
void Treasure_GenerateTreasure(object oObject, object oLastOpener, int iQuality, int iType) {
    // Determine difficulty of the object relative to the PC's level
    int iIndex=0;
    int iPCLevel = GetLevel(oLastOpener);
    int iChance = iPCLevel * 3;
    float iQAdj = IntToFloat(iQuality) * ((100.0 - IntToFloat(iPCLevel))/100.0);

    if (iType == OBJECT_TYPE_BARREL) if (d100() < (80 - iPCLevel)) GenerateLowTreasure(oLastOpener, oObject);
    if (iType == OBJECT_TYPE_BOOKS) {
        if (d100() >= 70 - iPCLevel)                            Treasure_GenerateNWNBook(oObject, oLastOpener);
        if (iQAdj <= QUALITY_LOW)                               Treasure_GenerateBook(oObject, oLastOpener, TREASURE_LOW);
        if (iQAdj  > QUALITY_LOW && iQAdj <= QUALITY_MEDIUM)    Treasure_GenerateBook(oObject, oLastOpener, TREASURE_MEDIUM);
        if (iQAdj  > QUALITY_MEDIUM)                            Treasure_GenerateBook(oObject, oLastOpener, TREASURE_HIGH);
    }
    else if (iType == OBJECT_TYPE_GOLD_PILE) {
        if (iQAdj <= QUALITY_LOW)                               Treasure_GenerateValuable(oObject, oLastOpener, TREASURE_LOW);
        if (iQAdj  > QUALITY_LOW && iQAdj <= QUALITY_MEDIUM)    for (iIndex=0; iIndex<d3(); iIndex++) if (d100() < iChance) Treasure_GenerateValuable(oObject, oLastOpener, TREASURE_MEDIUM);
        if (iQAdj  > QUALITY_MEDIUM)                            for (iIndex=0; iIndex<d6(); iIndex++) if (d100() < iChance) Treasure_GenerateValuable(oObject, oLastOpener, TREASURE_HIGH);
    }
    else if (iType == OBJECT_TYPE_LOOTBAG) {
        if (iQAdj <= QUALITY_LOW)                               CreateGold(oObject, oLastOpener, TREASURE_LOW);
        if (iQAdj  > QUALITY_LOW && iQAdj <= QUALITY_MEDIUM)    for (iIndex=0; iIndex<d4(); iIndex++) if (d100() < iChance) CreateGold(oObject, oLastOpener, TREASURE_MEDIUM);
        if (iQAdj  > QUALITY_MEDIUM)                            for (iIndex=0; iIndex<d8(); iIndex++) if (d100() < iChance) CreateGold(oObject, oLastOpener, TREASURE_HIGH);
    }
    else if (iType == OBJECT_TYPE_WIZARD_CABINET) {
        if (iQAdj <= QUALITY_LOW)                               Treasure_GenerateWizardSupplies(oObject, oLastOpener, TREASURE_LOW);
        if (iQAdj  > QUALITY_LOW && iQAdj <= QUALITY_MEDIUM)    for (iIndex=0; iIndex<d4(3); iIndex++) if (d100() < iChance) Treasure_GenerateWizardSupplies(oObject, oLastOpener, TREASURE_MEDIUM);
        if (iQAdj  > QUALITY_MEDIUM)                            for (iIndex=0; iIndex<d8(2); iIndex++) if (d100() < iChance) Treasure_GenerateWizardSupplies(oObject, oLastOpener, TREASURE_HIGH);
    }
    else {  // Generate Generic Treasure
        int iStack;
        int iMod;
        if (iQAdj <= QUALITY_LOW)                               { GenerateLowTreasure(oLastOpener, oObject); iStack = 1; iMod = TREASURE_LOW; }
        if (iQAdj  > QUALITY_LOW && iQAdj <= QUALITY_MEDIUM)    { GenerateMediumTreasure(oLastOpener, oObject); iStack = d3(); iMod = TREASURE_MEDIUM;  }
        if (iQAdj  > QUALITY_MEDIUM)                            { GenerateHighTreasure(oLastOpener, oObject); iStack = d6(); iMod = TREASURE_HIGH; }

        // Include additional treasure?
        int iTreasure = Random(14) + 1;
        int i=0;
        for (i=0; i<iStack; i++) {
            if (d100() < iChance) {
                switch (iTreasure) {
                    case 1:  if (RollChance(70)) CreateJunk(oObject);    // fall through
                    case 2:  if (RollChance(30)) Treasure_GenerateNWNBook(oObject, oLastOpener); // fall through
                    case 3:  if (RollChance(50)) CreatePotion(oObject, oLastOpener, iMod);
                                break;
                    case 4:  if (RollChance(30)) CreateArcaneScroll(oObject, oLastOpener);
                                break;
                    case 5:  if (RollChance(40)) Treasure_GenerateReagent(oObject, iMod);
                                break;
                    case 6:  if (RollChance(60)) CreateGold(oObject, oLastOpener, iMod);
                                break;
                    case 7:  if (RollChance(30)) CreateGem(oObject, oLastOpener, iMod);
                                break;
                    case 8:  if (RollChance(20)) Treasure_GeneratePotion(oObject, oLastOpener, iMod);
                                break;
                    case 9:  if (RollChance(25)) CreateJewel(oObject, oLastOpener, iMod);
                                break;
                    case 10: if (RollChance(25)) Treasure_GenerateBook(oObject, oLastOpener, iMod);
                                break;
                    case 11: if (RollChance(35)) Treasure_GenerateCustomTreasure(oObject, iMod);
                                break;
                    case 12: if (RollChance(10)) Treasure_GenerateMiscItem(oObject);
                                break;
                    case 13: if (RollChance(5))  Treasure_GeneratePoisonPotion(oObject);
                                break;
                    case 14: if (RollChance(5))  Treasure_GenerateCursedItem(oObject);
                                break;
                }
            }
        }
    }
}

// Create Junk, Gold, Gems or Jewels in the container
void Treasure_GenerateValuable(object oContainer, object oAdventurer, int iQuality) {
    int iType = d100();
    int iLevel = GetLevel(oAdventurer);
    if (iQuality == TREASURE_LOW)   iType -= Random(iLevel*2) + iLevel;
    if (iQuality == TREASURE_HIGH)  iType += Random(iLevel);
    if (iType  < 40)                CreateJunk(oContainer);
    if (iType >= 40 && iType < 70)  CreateGold(oContainer, oAdventurer, iQuality);
    if (iType >= 70 && iType < 95)  CreateGem(oContainer, oAdventurer, iQuality);
    if (iType >= 95)                CreateJewel(oContainer, oAdventurer, iQuality);
}

// Create Reagents, Books, Potions, Gems or Jewels in the container
void Treasure_GenerateWizardSupplies(object oContainer, object oAdventurer, int iQuality) {
    int iType = d100();
    int iIndex;
    int iMaxReag;
    if (iQuality == TREASURE_LOW) iMaxReag = d6();
    if (iQuality == TREASURE_MEDIUM) iMaxReag = d12();
    if (iQuality == TREASURE_HIGH) iMaxReag = d20();
    if (iType  < 80)                for (iIndex=0; iIndex<iMaxReag; iIndex++) Treasure_GenerateReagent(oContainer, iQuality);
    if (iType >= 80 && iType < 82)  Treasure_GenerateNWNBook(oContainer, oAdventurer);
    if (iType >= 82 && iType < 90)  Treasure_GenerateBook(oContainer, oAdventurer, iQuality);
    if (iType >= 90 && iType < 93)  CreatePotion(oContainer, oAdventurer, iQuality);
    if (iType >= 93 && iType < 96)  Treasure_GeneratePotion(oContainer, oAdventurer, iQuality);
    if (iType >= 96 && iType < 98)  CreateGem(oContainer, oAdventurer, iQuality);
    if (iType >= 98)                CreateJewel(oContainer, oAdventurer, iQuality);
}

// When a character enters the module and is low-level, his gold should be converted
// to copper with consideration given to his character class. Called from the modules
// OnClientEnter() event slot.
void Treasure_GoldForClassAdjust(object oTarget) {
    // Convert gold to copper if at a low level
    int iLevel = GetLevel(oTarget);
    int iGold  = GetGold(oTarget);
    if (iGold > 100) return;
    if (iLevel > 2) return;

    // Award more gold depending on class
    int iMaxClassValue;
    if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oTarget)) iMaxClassValue = 200;
    else if (GetLevelByClass(CLASS_TYPE_BARD, oTarget)) iMaxClassValue = 400;
    else if (GetLevelByClass(CLASS_TYPE_CLERIC, oTarget)) iMaxClassValue = 500;
    else if (GetLevelByClass(CLASS_TYPE_DRUID, oTarget)) iMaxClassValue = 200;
    else if (GetLevelByClass(CLASS_TYPE_FIGHTER, oTarget)) iMaxClassValue = 750;
    else if (GetLevelByClass(CLASS_TYPE_MONK, oTarget)) iMaxClassValue = 100;
    else if (GetLevelByClass(CLASS_TYPE_PALADIN, oTarget)) iMaxClassValue = 150;
    else if (GetLevelByClass(CLASS_TYPE_RANGER, oTarget)) iMaxClassValue = 100;
    else if (GetLevelByClass(CLASS_TYPE_ROGUE, oTarget)) iMaxClassValue = 500;
    else if (GetLevelByClass(CLASS_TYPE_SORCERER, oTarget)) iMaxClassValue = 200;
    else if (GetLevelByClass(CLASS_TYPE_WIZARD, oTarget)) iMaxClassValue = 750;
    else iMaxClassValue = 550;

    // Give the new gold amount in copper
    int iCopper = iGold * 25 + Random(iMaxClassValue); // ~ 1/4 of the Gold -> Copper exchange rate
    AssignCommand(oTarget, GiveGoldToCreature(oTarget, iCopper));
}

// Returns the equivalent value of the passed coin in gold.  Outputs the amount of 'change'
// PC has on his person.
int Treasure_RollCoins(object oPC, object oItem, float fExchangeRate) {
    int iStack = GetNumStackedItems(oItem);
    if (iStack > 1) iStack++;

    // Get the PC's change for this coin type
    string strCoinTag = GetStringLowerCase(GetTag(oItem));
    float fCoins = IntToFloat(GetLocalInt(oPC, strCoinTag));

    // Add the current change to the new change
    fCoins += IntToFloat(iStack);

    // Convert to gold with exchange rate
    int iGoldCoins = 0;
    while (fCoins >= fExchangeRate) {
        iGoldCoins++;
        fCoins -= fExchangeRate;
    }

    // Store remaining change
    SetLocalInt(oPC, strCoinTag, FloatToInt(fCoins));

    // Output remaining change
    string strCoinName;
    if (strCoinTag == "cu_gold001") strCoinName = "copper";
    if (strCoinTag == "cu_gold002") strCoinName = "silver";
    if (strCoinTag == "cu_gold003") strCoinName = "electrum";
    if (strCoinTag == "cu_gold004") strCoinName = "gold";
    if (strCoinTag == "cu_gold005") strCoinName = "platinum";
    SendMessageToPC(oPC, "Your " + strCoinName + " was worth " + IntToString(iGoldCoins) + " gold pieces. You have " + IntToString(FloatToInt(fCoins)) + " " + strCoinName + " pieces remaining in change.");

    // Return the amount that was exchanged to gold
    return iGoldCoins;
}

// Entry function for treasure generating library. Place in the OnOpen() of a container.
void Treasure_StockContainerByDCAndRespawn(object oObject) {
    // Run code only once
    if (BlockCodeExecution(oObject, "NW_DO_ONCE")) return;

    // Store the tags of any items in the chest so they can be recalled later if need
    string strInventoryArray = Object_StoreSpecialInventory();

    // Determine information needed to create treasure
    object oLastOpener      = GetLastOpener();                          // PC's level
    int iContainerQuality   = Object_GetDifficulty(oObject, TRUE);      // Difficulty of container
    int iContainerType      = Object_GetType(oObject);                  // The type of the container

    // Place the treasure
    Treasure_GenerateTreasure(oObject, oLastOpener, iContainerQuality, iContainerType);

    // Respawn the chest on a delay
    float fRespawnDelay = 1200.0 + IntToFloat(iContainerQuality*40);
    Respawn_ByResrefWithDelay(oObject, fRespawnDelay, strInventoryArray);

    // Finish up
    ShoutDisturbed();
}

// The OnUse code for a Ballista that can fire fireballs, level 6
void Weapon_FireBallista(object oWeapon, object oPC, int iPower=6) {
    // Find nearest hostile within range
    object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
    if (GetIsObjectValid(oCreature)) {
        if (60 <  GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oCreature)) {
            float iDist = GetDistanceToObject(oCreature);
            if (iDist < 35.0) {
                if (BlockMultiActivation("iFired", oWeapon, 2.0, "Waiting for reload!!")) return;
                ActionCastSpellAtObject(SPELL_FIREBALL, oCreature, METAMAGIC_ANY, TRUE, iPower);
            }
        }
    }
    else AssignCommand(oPC, SpeakString("No enemies in range!"));
}







