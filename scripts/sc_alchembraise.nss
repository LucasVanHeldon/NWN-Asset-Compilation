#include "g_common"

int     CheckBraiseSuccess(int iDifficulty, int iBaseChance, object oPC);
void    DoBraiseFailedEffect(object oPC);
void    DoBraiseSuccesEffect(object oPC);
int     HashSum(string strReagentCode, int iReagentValue);
int     HashReagents();
void    HashMatched(int nRecipe, object oPC);
void    ProcessBraiseAction(int iDifficulty, int iBaseChance, object oPC, string strItemTag, int iYieldOnSuccess);
void    ProcessBadBraiseAction(int iHashCode, object oPC);
void    ApproximateHashMatch(int iHashCode, object oPC);
void    CheckEnchantment(string strVarName, object oPC, int nSpellID);
int     RemoveItemQuantityFromPC(object oPC, string strItemTag, int iRemoveNum);
void    Inventory_RemoveStackedItemQuantityFromPC(object oPC, string strItemTag, int iRemoveNum);
string  NormalizeString(string strItemTag, int iValue);
void    CreateBottles(object oPC, int iGiveBack);

void main() {
    object oPC = GetPCSpeaker();

    // Map the reagents to a hash key... well, kinda...
    int iRecipe = HashReagents();
    if (iRecipe == 0) { FloatingTextStringOnCreature("No reagents in cauldron!", oPC, FALSE); return; }

    // Matches a Recipe?
    HashMatched(iRecipe, oPC); // Found a recipe!

    // Remove reagents from PC's inventory (except empty vials)
    // Enchantments - SPELL ID's
    CheckEnchantment("Aid", oPC, SPELL_AID);
    CheckEnchantment("Barkskin", oPC, SPELL_BARKSKIN);
    CheckEnchantment("Bless", oPC, SPELL_BLESS);
    CheckEnchantment("BullsStrength", oPC, SPELL_BULLS_STRENGTH);
    CheckEnchantment("CatsGrace", oPC, SPELL_CATS_GRACE);
    CheckEnchantment("Clarity", oPC, SPELL_CLARITY);
    CheckEnchantment("CureCritical", oPC, SPELL_CURE_CRITICAL_WOUNDS);
    CheckEnchantment("CureLight", oPC, SPELL_CURE_LIGHT_WOUNDS);
    CheckEnchantment("CureModerate", oPC, SPELL_CURE_MODERATE_WOUNDS);
    CheckEnchantment("CureSerious", oPC, SPELL_CURE_SERIOUS_WOUNDS);
    CheckEnchantment("EaglesSplendor", oPC, SPELL_EAGLE_SPLEDOR);
    CheckEnchantment("Endurance", oPC, SPELL_ENDURANCE);
    CheckEnchantment("FoxsCunning", oPC, SPELL_FOXS_CUNNING);
    CheckEnchantment("Haste", oPC, SPELL_HASTE);
    CheckEnchantment("Heal", oPC, SPELL_HEAL);
    CheckEnchantment("Invisibility", oPC, SPELL_INVISIBILITY);
    CheckEnchantment("LesserRestoration", oPC, SPELL_LESSER_RESTORATION);
    CheckEnchantment("Lore", oPC, SPELL_IDENTIFY);
    CheckEnchantment("Lore", oPC, SPELL_LEGEND_LORE);
    CheckEnchantment("OwlsWisdom", oPC, SPELL_OWLS_WISDOM);
    CheckEnchantment("Stoneskin", oPC, SPELL_STONESKIN);

}

void CreateBottles(object oPC, int iGiveBack) {
    CreateItemOnObject("EmptyBottle", oPC, iGiveBack);
}

// Removes the specified number of the passed item from the PC's inventory
int RemoveItemQuantityFromPC(object oPC, string strItemTag, int iRemoveNum) {
    object oItem = GetFirstItemInInventory(oPC);
    int nCount = 0;
    while (nCount < iRemoveNum && GetIsObjectValid(oItem)) {
        if (GetTag(oItem) == strItemTag)  {
            nCount++;
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return(nCount);
}

void Inventory_RemoveStackedItemQuantityFromPC(object oPC, string strItemTag, int iRemoveNum) {
    object oItem = GetFirstItemInInventory(oPC);
    int iCount = 0;
    int iTotalEmpties = 0;

    while ((iCount <= iRemoveNum) && GetIsObjectValid(oItem)) {
        if (GetTag(oItem) == "EmptyBottle") {
            int iStackSize = GetNumStackedItems(oItem);
            iCount += iStackSize;
            if (iCount <= iRemoveNum) DestroyObject(oItem);
            else {
                int iGiveBack = iCount - iRemoveNum;
                AssignCommand(oPC, DelayCommand(1.0, CreateBottles(oPC, iGiveBack)));
                DestroyObject(oItem);
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
}


// PC didn't know a good recipe, but can he succeed anyhow??!
void ProcessBadBraiseAction(int iHashCode, object oPC) {
    int iDifficulty = 20 + d20();
    if (CheckBraiseSuccess(iDifficulty, 0, oPC)) {    // Success! (Amazingly Enough!)
        ApproximateHashMatch(iHashCode, oPC);
    }
    else {      // Failure
        DoBraiseFailedEffect(oPC);
    }
}

// Carry out success or failure on a recipe if matched
void ProcessBraiseAction(int iDifficulty, int iBaseChance, object oPC, string strItemTag, int iYieldOnSuccess) {
    int nQuant;
    int nIndex;
    int nCount = 0;
    // Count how many empty vials PC has
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        if (GetTag(oItem) == "EmptyVile") nCount++;
        else if (GetTag(oItem) == "EmptyBottle") nCount += GetNumStackedItems(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    if (nCount < iYieldOnSuccess) { nQuant = nCount; FloatingTextStringOnCreature("I ran out of empty vials!!", oPC, FALSE); }
    else nQuant = iYieldOnSuccess;

    //  Determine Braising Success/Failure and take appropriate action
    if (CheckBraiseSuccess(iDifficulty, iBaseChance, oPC)) {
        SetIdentified(CreateItemOnObject(strItemTag, oPC, nQuant), TRUE);
        DoBraiseSuccesEffect(oPC);
    }
    else DoBraiseFailedEffect(oPC);

    // Remove the vials that were filled with potions
    nQuant -= RemoveItemQuantityFromPC(oPC, "EmptyVile", nQuant);
    Inventory_RemoveStackedItemQuantityFromPC(oPC, "EmptyBottle", nQuant);
}

// Check to see if the hash code is close to a recipe
void HashMatched(int iRecipe, object oPC) {
    // Recipes
    /* AID Yield: 4             HashCode: 759
       1 x Aid Spell
       1 x Elemental Water */
    if (iRecipe == 759) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION016", 4); return; }

    /* BARKSKIN Yield: 8        HashCode: 776
        1 x Barkskin Spell
        1 x Elemental Water   */
    if (iRecipe == 776) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION005", 8); return; }

    /* BULL'S STRENGTH
        Yield: 2        HashCode: 804
        1 x Bull's Strength Spell
        1 x Elemental Water     */
    if (iRecipe == 804) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION015", 2); return; }

    /* CAT'S GRACE
        Yield: 2        HashCode: 830
        1 x Cat's Grace Spell
        1 x Elemental Water    */
    if (iRecipe == 830) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION014", 2); return; }

    /* CLARITY
        Yield: 4        HashCode: 894
        1 x Clarity Spell
        1 x Elemental Water     */
    if (iRecipe == 894) { ProcessBraiseAction(7, 25, oPC, "NW_IT_MPOTION007", 4); return; }

    /* ENDURANCE
        Yield: 4        HashCode: 986
        1 x Endurance Spell
        1 x Elemental Water      */
    if (iRecipe == 986) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION013", 4); return; }

    /* FOX'S CUNNING
        Yield: 4        HashCode: 1040
        1 x Fox's Cunning Spell
        1 x Elemental Water     */
    if (iRecipe == 1040) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION017", 4); return; }

    /* SPEED
        Yield: 4        HashCode: 1070
        1 x Haste Spell
        1 x Elemental Water */
    if (iRecipe == 1070) { ProcessBraiseAction(5, 25, oPC, "NW_IT_MPOTION004", 4); return; }

    /* INVISIBILITY
        Yield: 4        HashCode: 1094
        1 x Invisibility Spell
        1 x Elemental Water       */
    if (iRecipe == 1094) { ProcessBraiseAction(5, 25, oPC, "NW_IT_MPOTION008", 4); return; }

    /* LORE
        Yield: 4        HashCode: 1116
        1 x Lore Spell
        1 x Elemental Water */
    if (iRecipe == 1116) { ProcessBraiseAction(1, 25, oPC, "NW_IT_MPOTION019", 1); return; }

    /* OWL'S WISDOM
        Yield: 4        HashCode: 1140
        1 x Owl's Wisdom Spell
        1 x Elemental Water        */
    if (iRecipe == 1140) { ProcessBraiseAction(1, 35, oPC, "NW_IT_MPOTION018", 4); return; }

    /* CURE LIGHT WOUNDS
        Yield: 4        HashCode: 1194
        1 x Cure Light Spell
        1 x Holy Water              */
    if (iRecipe == 1194) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION001", 4); return; }

    /* STONESKIN
        Yield: 2        HashCode: 1196
        1 x Stoneskin Spell
        1 x Elemental Water          */
    if (iRecipe == 1196) { ProcessBraiseAction(15, 5, oPC, "cu_potion004", 2); return; }

    /* OWL'S WISDOM
        Yield: 16       HashCode: 1236
        1 x Acorns
        1 x Elemental Water           */
    if (iRecipe == 1236) { ProcessBraiseAction(10, 30, oPC, "NW_IT_MPOTION018", 16); return; }

    /* HEAL
        Yield: 2        HashCode: 1362
        1 x Heal Spell
        1 x Holy Water      */
    if (iRecipe == 1362) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION012", 2); return; }

    /* LESSER RESTORATION
        Yield: 3        HashCode: 1380
        1 x Lesser Restoration Spell
        1 x Holy Water                 */
    if (iRecipe == 1380) { ProcessBraiseAction(8, 20, oPC, "NW_IT_MPOTION011", 3); return; }

    /* AID
        Yield: 1        HashCode: 1569
        1 x Aid Spell
        1 x Water                */
    if (iRecipe == 1569) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION016", 1); return; }

    /* BARKSKIN
        Yield: 1        HashCode: 1586
        1 x Barkskin Spell
        1 x Vial of Water         */
    if (iRecipe == 1586) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION005", 1); return; }

    /* INVISIBILITY
        Yield: 8        HashCode: 1596
        1 x Fairy Dust
        1 x Elemental Water      */
    if (iRecipe == 1596) { ProcessBraiseAction(8, 25, oPC, "NW_IT_MPOTION008", 8); return; }

    /* BULL'S STRENGTH
        Yield: 1        HashCode: 1614
        1 x Bull's Strength Spell
        1 x Vial of Water */
    if (iRecipe == 1614) { ProcessBraiseAction(3, 30, oPC, "NW_IT_MPOTION015", 1); return; }

    /* CAT'S GRACE
        Yield: 1        HashCode: 1640
        1 x Cat's Grace Spell
        1 x Vial of Water      */
    if (iRecipe == 1640) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION014", 1); return; }

    /* LESSER RESTORATION
        Yield: 3        HashCode: 1665
        1 x Garlic
        1 x Belladonna
        1 x Vial of Water */
    if (iRecipe == 1665) { ProcessBraiseAction(15, 25, oPC, "NW_IT_MPOTION011", 3); return; }

    /* ENDURANCE
        Yield: 12       HashCode: 1698
        1 x Garlic
        1 x Elemental Water    */
    if (iRecipe == 1698) { ProcessBraiseAction(7, 30, oPC, "NW_IT_MPOTION013", 12); return; }

    /* CLARITY
        Yield: 1        HashCode: 1704
        1 x Clarity Spell
        1 x Vial of Water        */
    if (iRecipe == 1704) { ProcessBraiseAction(4, 25, oPC, "NW_IT_MPOTION007", 1); return; }

    /* CURE LIGHT WOUNDS
        Yield: 1        HashCode: 1730
        1 x Cure Light Spell
        1 x Vial of Water        */
    if (iRecipe == 1730) { ProcessBraiseAction(0, 40, oPC, "NW_IT_MPOTION001", 1); return; }

    /* CURE MODERATE WOUNDS
        Yield: 1        HashCode: 1748
        1 x Cure Moderate Wounds Spell
        1 x Vial of Water          */
    if (iRecipe == 1748) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION020", 1); return; }

    /* EAGLE'S SPLENDOR
        Yield: 1        HashCode: 1778
        1 x Eagle's Splendor Spell
        1 x Vial of Water          */
    if (iRecipe == 1778) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION010", 1); return; }

    /* ENDURANCE
        Yield: 1        HashCode: 1796
        1 x Endurance Spell
        1 x Vial of Water         */
    if (iRecipe == 1796) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION013", 1); return; }

    /* BARKSKIN
        Yield: 12       HashCode: 1837
        1 x Ironwood
        1 x Barkskin Spell
        1 x Elemental Water    */
    if (iRecipe == 1837) { ProcessBraiseAction(5, 25, oPC, "NW_IT_MPOTION005", 12); return; }

    /* FOX'S CUNNING
        Yield: 1        HashCode: 1850
        1 x Fox's Cunning Spell
        1 x Vial of Water       */
    if (iRecipe == 1850) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION017", 1); return; }

    /* SPEED
        Yield: 1        HashCode: 1880
        1 x Haste Spell
        1 x Vial of Water */
    if (iRecipe == 1880) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION004", 1); return; }

    /* HEAL
        Yield: 1        HashCode: 1898
        1 x Heal Spell
        1 x Vial of Water     */
    if (iRecipe == 1898) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION012", 1); return; }

    /* INVISIBILITY
        Yield: 1        HashCode: 1904
        1 x Invisibility Spell
        1 x Vial of Water         */
    if (iRecipe == 1904) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION008", 1); return; }

    /* LESSER RESTORATION
        Yield: 1        HashCode: 1916
        1 x Lesser Restoration Spell
        1 x Vial of Water      */
    if (iRecipe == 1916) { ProcessBraiseAction(4, 25, oPC, "NW_IT_MPOTION011", 1); return; }

    /* BULL'S STRENGTH
        Yield: 2        HashCode: 1920
        1 x Minotaur Eyeball
        1 x Elemental Water      */
    if (iRecipe == 1920) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION015", 2); return; }

    /* LORE
        Yield: 1        HashCode: 1926
        1 x Lore Spell
        1 x Vial of Water      */
    if (iRecipe == 1926) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION019", 1); return; }

    /* BULL'S STRENGTH
        Yield: 4        HashCode: 1938
        1 x Minotaur Heart
        1 x Elemental Water     */
    if (iRecipe == 1938) { ProcessBraiseAction(4, 30, oPC, "NW_IT_MPOTION015", 4); return; }

    /* OWL'S WISDOM
        Yield: 1        HashCode: 1950
        1 x Owl's Wisdom Spell
        1 x Vial of Water      */
    if (iRecipe == 1950) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION018", 1); return; }

    /* STONESKIN
        Yield: 1        HashCode: 2006
        1 x Stoneskin Spell
        1 x Vial of Water      */
    if (iRecipe == 2006) { ProcessBraiseAction(10, 5, oPC, "cu_potion004", 1); return; }

    /* CLARITY
        Yield: 6        HashCode: 2034
        1 x Quartz Crystal
        1 x Elemental Water      */
    if (iRecipe == 2034) { ProcessBraiseAction(8, 25, oPC, "NW_IT_MPOTION007", 6); return; }

    /* CLARITY
        Yield: 2        HashCode: 2130
        1 x Smokey Quartz
        1 x Elemental Water     */
    if (iRecipe == 2130) { ProcessBraiseAction(6, 25, oPC, "NW_IT_MPOTION007", 2); return; }

    /* CURE CRITICAL WOUNDS
        Yield: 8        HashCode: 2133
        1 x Giant Oak Leaf
        1 x Cure Critical Spell
        1 x Holy Water          */
    if (iRecipe == 2133) { ProcessBraiseAction(10, 20, oPC, "NW_IT_MPOTION003", 8); return; }

    /* CAT'S GRACE
        Yield: 6        HashCode: 2180
        1 x Tiger Eyeball
        1 x Elemental Water     */
    if (iRecipe == 2180) { ProcessBraiseAction(3, 30, oPC, "NW_IT_MPOTION014", 6); return; }

    /* OWL'S WISDOM
        Yield: 12       HashCode: 2310
        1 x Vial of Smoke
        1 x Elemental Water    */
    if (iRecipe == 2310) { ProcessBraiseAction(8, 30, oPC, "NW_IT_MPOTION018", 12); return; }

    /* INVISIBILITY
        Yield: 2        HashCode: 2406
        1 x Fairy Dust
        1 x Vial of Water     */
    if (iRecipe == 2406) { ProcessBraiseAction(1, 25, oPC, "NW_IT_MPOTION008", 2); return; }

    /* FOX'S CUNNING
        Yield: 12       HashCode: 2414
        1 x Wolf Tooth
        1 x Elemental Water */
    if (iRecipe == 2414) { ProcessBraiseAction(8, 25, oPC, "NW_IT_MPOTION017", 12); return; }

    /* ENDURANCE
        Yield: 3        HashCode: 2508
        1 x Garlic
        1 x Vial of Water    */
    if (iRecipe == 2580) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION013", 3); return; }

    /* OWL'S WISDOM
        Yield: 4        HashCode: 2525
        1 x Acorns
        1 x Vial of Water     */
    if (iRecipe == 2525) { ProcessBraiseAction(4, 30, oPC, "NW_IT_MPOTION018", 4); return; }

    /* LESSER RESTORATION
        Yield: 6        HashCode: 2529
        1 x Garlic
        1 x Belladonna
        1 x Holy Water      */
    if (iRecipe == 2529) { ProcessBraiseAction(18, 20, oPC, "NW_IT_MPOTION011", 6); return; }

    /* BARKSKIN
        Yield: 3        HashCode: 2647
        1 x Ironwood
        1 x Barkskin Spell
        1 x Vial of Water   */
    if (iRecipe == 2647) { ProcessBraiseAction(3, 30, oPC, "NW_IT_MPOTION005", 3); return; }

    /* LIFE
        Yield: 7        HashCode: 2665
        1 x Garlic
        1 x Giant Heart
        1 x Elemental Water   */
    if (iRecipe == 2665) { ProcessBraiseAction(30, 5, oPC, "cu_potion201", 7); return; }

    /* CURE CRITICAL WOUNDS
        Yield: 1        HashCode: 2669
        1 x Giant Oak Leaf
        1 x Cure Critical Spell
        1 x Vial of Water    */
    if (iRecipe == 2669) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION003", 1); return; }

    /* ANTIMAGIC FIZZ
        Yield: 4        HashCode: 2675
        1 x Succubi Ear
        1 x Balor Eye
        1 x Elemental Water    */
    if (iRecipe == 2675) { ProcessBraiseAction(25, 8, oPC, "cu_potion200", 4); return; }

    /* BULL'S STRENGTH
        Yield: 1        HashCode: 2730
        1 x Minotaur Eyeball
        1 x Vial of Water      */
    if (iRecipe == 2730) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION015", 1); return; }

    /* BULL'S STRENGTH
        Yield: 2        HashCode: 2748
        1 x Minotaur Heart
        1 x Vial of Water */
    if (iRecipe == 2748) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION015", 2); return; }

    /* CURE LIGHT WOUNDS
        Yield: 10       HashCode: 2749
        1 x Cure Light Spell
        1 x Hollyhock Petals
        1 x Vial of Water      */
    if (iRecipe == 2749) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION001", 10); return; }

    /* LIFE
        Yield: 10       HashCode: 2767
        1 x Dead Baby
        1 x Troll Head
        1 x Elemental Water */
    if (iRecipe == 2767) { ProcessBraiseAction(30, 2, oPC, "cu_potion201", 10); return; }

    /* CLARITY
        Yield: 3        HashCode: 2844
        1 x Quartz Crystal
        1 x Vial of Water     */
    if (iRecipe == 2844) { ProcessBraiseAction(6, 25, oPC, "NW_IT_MPOTION007", 3); return; }

    /* CLARITY
        Yield: 1        HashCode: 2940
        1 x Smokey Quartz
        1 x Vial of Water    */
    if (iRecipe == 2940) { ProcessBraiseAction(4, 25, oPC, "NW_IT_MPOTION007", 1); return; }

    /* CAT'S GRACE
        Yield: 14       HashCode: 2953
        1 x Rakshasa Eyeball
        1 x Fenberry
        1 x Elemental Water     */
    if (iRecipe == 2953) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION014", 14); return; }

    /* BARKSKIN
        Yield: 16       HashCode: 2969
        1 x Ironwood
        1 x Milkweed Pod
        1 x Elemental Water    */
    if (iRecipe == 2969) { ProcessBraiseAction(7, 25, oPC, "NW_IT_MPOTION005", 16); return; }

    /* CAT'S GRACE
        Yield: 3        HashCode: 2990
        1 x Tiger Eyeball
        1 x Vial of Water        */
    if (iRecipe == 2990) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION014", 3); return; }

    /* CURE LIGHT WOUNDS
        Yield: 5        HashCode: 3003
        1 x Giant Oak Leaf
        1 x Hollyhock Petals
        1 x Holy Water           */
    if (iRecipe == 3003) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION001", 5); return; }

    /* HEAL
        Yield: 3        HashCode: 3070
        1 x Rosary
        1 x Holy Water          */
    if (iRecipe == 3070) { ProcessBraiseAction(10, 15, oPC, "NW_IT_MPOTION012", 3); return; }

    /* CURE CRITICAL WOUNDS
        Yield: 16       HashCode: 3086
        2 x Giant Oak Leaf
        1 x Cure Critical Spell
        1 x Holy Water         */
    if (iRecipe == 3086) { ProcessBraiseAction(15, 15, oPC, "NW_IT_MPOTION003", 16); return; }

    /* STONESKIN
        Yield: 2        HashCode: 3115
        1 x Ironwood
        1 x Adamantium
        1 x Vial of Water */
    if (iRecipe == 3115) { ProcessBraiseAction(15, 5, oPC, "cu_potion004", 2); return; }

    /* OWL'S WISDOM
        Yield: 3        HashCode: 3120
        1 x Vial of Smoke
        1 x Vial of Water */
     if (iRecipe == 3120) { ProcessBraiseAction(3, 30, oPC, "NW_IT_MPOTION018", 3); return; }

    /* CURE CRITICAL WOUNDS
        Yield: 3        HashCode: 3135
        1 x Giant Oak Leaf
        1 x Milkweed Pod
        1 x Holy Water     */
    if (iRecipe == 3135) { ProcessBraiseAction(6, 27, oPC, "NW_IT_MPOTION003", 3); return; }

    /* CLARITY
        Yield: 16       HashCode: 3157
        1 x Quartz Crystal
        1 x Magnetite Ore
        1 x Elemental Water       */
    if (iRecipe == 3157) { ProcessBraiseAction(15, 20, oPC, "NW_IT_MPOTION007", 16); return; }

    /* NOSTRUM OF ABSORPTION
        Yield: 1        HashCode: 3167
        1 x Prism Blossom
        1 x Milkweed Pod
        1 x Elemental Water   */
    if (iRecipe == 3167) { ProcessBraiseAction(20, 5, oPC, "cu_potion209", 1); return; }

    /* STRIKING
        Yield: 2        HashCode: 3197
        1 x Milkweed Pod
        1 x Rakshasa's Eye
        1 x Elemental Water    */
    if (iRecipe == 3197) { ProcessBraiseAction(15, 15, oPC, "cu_potion216", 2); return; }

    /* CURE SERIOUS WOUNDS
        Yield: 4        HashCode: 3202
        1 x Cure Serious Wounds Spell
        1 x Hollyhock Petals
        1 x Giant Oak Leaf
        1 x Holy Water           */
    if (iRecipe == 3202) { ProcessBraiseAction(5, 25, oPC, "NW_IT_MPOTION002", 4); return; }

    /* INVISIBILITY
        Yield: 16       HashCode: 3203
        1 x Fairy Dust
        1 x Weeping Hemlock
        1 x Elemental Water      */
    if (iRecipe == 3203) { ProcessBraiseAction(15, 15, oPC, "NW_IT_MPOTION008", 16); return; }

    /* FOX'S CUNNING
        Yield: 3        HashCode: 3224
        1 x Wolf Tooth
        1 x Vial of Water      */
    if (iRecipe == 3224) { ProcessBraiseAction(4, 30, oPC, "NW_IT_MPOTION017", 3); return; }

    /* CURE MODERATE WOUNDS
        Yield: 6        HashCode: 3250
        1 x Cure Moderate Wounds Spell
        2 x Hollyhock Petals
        1 x Holy Water          */
    if (iRecipe == 3250) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION020", 6); return; }

    /* LESSER RIPPING
        Yield: 2        HashCode: 3281
        1 x Milkweed Pod
        1 x Smokey Quartz
        1 x Elemental Water    */
    if (iRecipe == 3281) { ProcessBraiseAction(15, 15, oPC, "cu_potion002", 2); return; }

    /* LESSER STRIKING
        Yield: 2        HashCode: 3331
        1 x Milkweed Pod
        1 x Tiger Eye
        1 x Elemental Water */
    if (iRecipe == 3331) { ProcessBraiseAction(15, 15, oPC, "cu_potion001", 2); return; }

    /* CLARITY
    Yield: 10       HashCode: 3457
    1 x Clarity Spell
    1 x Diamond
    1 x Vial of Water     */
    if (iRecipe == 3457) { ProcessBraiseAction(10, 25, oPC, "NW_IT_MPOTION007", 10); return; }

    /* LORE
    Yield: 16       HashCode: 3467
    1 x Malachite
    1 x Ettercap's Spinal Column and Brain
    1 x Elemental Water     */
    if (iRecipe == 3467) { ProcessBraiseAction(10, 20, oPC, "NW_IT_MPOTION019", 16); return; }

    /* LIFE
    Yield: 4        HashCode: 3475
    1 x Garlic
    1 x Giant Heart
    1 x Vial of Water     */
    if (iRecipe == 3475) { ProcessBraiseAction(10, 15, oPC, "cu_potion201", 4); return; }

    /* ANTIMAGIC FIZZ
    Yield: 3        HashCode: 3485
    1 x Succubi Ear
    1 x Balor Eye
    1 x Vial of Water     */
    if (iRecipe == 3485) { ProcessBraiseAction(25, 10, oPC, "cu_potion200", 3); return; }

    /* CURE LIGHT WOUNDS
    Yield: 3        HashCode: 3539
    1 x Giant Oak Leaf
    1 x Hollyhock Petals
    1 x Vial of Water      */
    if (iRecipe == 3539) { ProcessBraiseAction(1, 40, oPC, "NW_IT_MPOTION001", 3); return; }

    /* ELIXIR OF ACUMEN
    Yield: 2        HashCode: 3600
    1 x Ettercap's Spine and Brain
    1 x Vial of Noxious Gas
    1 x Acorn
    1 x Elemental Water       */
    if (iRecipe == 3600) { ProcessBraiseAction(15, 20, oPC, "cu_potion100", 2); return; }

    /* BLESS
    Yield: 20       HashCode: 3608
    1 x Bless Spell
    1 x Giant Oak Leaf
    100+ Gold
    1 x Elemental Water     */
    if (iRecipe == 3608) { ProcessBraiseAction(10, 30, oPC, "NW_IT_MPOTION009", 20); return; }

    /* CURE CRITICAL WOUNDS
    Yield: 2        HashCode: 3622
    2 x Giant Oak Leaf
    1 x Cure Critical Spell
    1 x Vial of Water         */
    if (iRecipe == 3622) { ProcessBraiseAction(10, 30, oPC, "NW_IT_MPOTION003", 2); return; }

    /* REGENERATION
    Yield: 2        HashCode: 3637
    1 x Troll Spine
    1 x Troll Head
    1 x Elemental Water      */
    if (iRecipe == 3637) { ProcessBraiseAction(10, 20, oPC, "cu_potion107", 2); return; }

    /* RIPPING
    Yield: 2        HashCode: 3661
    1 x Milkweed Pod
    1 x Diamond
    1 x Elemental Water       */
    if (iRecipe == 3661) { ProcessBraiseAction(20, 10, oPC, "cu_potion217", 2); return; }

    /* CURE CRITICAL WOUNDS
    Yield: 2        HashCode: 3671
    1 x Giant Oak Leaf
    1 x Milkweed Pod
    1 x Vial of Water         */
    if (iRecipe == 3671) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION003", 2); return; }

    /* CURE SERIOUS WOUNDS
    Yield: 1        HashCode: 3738
    1 x Cure Serious Wounds Spell
    1 x Hollyhock Petals
    1 x Giant Oak Leaf
    1 x Vial of Water       */
    if (iRecipe == 3738) { ProcessBraiseAction(4, 30, oPC, "NW_IT_MPOTION002", 1); return; }

    /* CAT'S GRACE
    Yield: 7        HashCode: 3763
    1 x Rakshasa Eyeball
    1 x Fenberry
    1 x Vial of Water      */
    if (iRecipe == 3763) { ProcessBraiseAction(4, 30, oPC, "NW_IT_MPOTION014", 7); return; }

    /* BARKSKIN
    Yield: 4        HashCode: 3779
    1 x Ironwood
    1 x Milkweed Pod
    1 x Vial of Water       */
    if (iRecipe == 3779) { ProcessBraiseAction(3, 30, oPC, "NW_IT_MPOTION005", 4); return; }

    /* CURE MODERATE WOUNDS
    Yield: 4        HashCode: 3786
    1 x Cure Moderate Wounds Spell
    2 x Hollyhock Petals
    1 x Vial of Water       */
    if (iRecipe == 3786) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION020", 4); return; }

    /* SPEED
    Yield: 5        HashCode: 3964
    1 x Falcon's Feather
    1 x Tiger Eyeball
    1 x Fenberry
    1 x Vial of Water   */
    if (iRecipe == 3964) { ProcessBraiseAction(8, 25, oPC, "NW_IT_MPOTION004", 5); return; }

    /* CLARITY
    Yield: 8        HashCode: 3967
    1 x Quartz Crystal
    1 x Magnetite Ore
    1 x Vial of Water   */
    if (iRecipe == 3967) { ProcessBraiseAction(8, 25, oPC, "NW_IT_MPOTION007", 8); return; }

    /* STRIKING
    Yield: 1        HashCode: 4007
    1 x Milkweed Pod
    1 x Rakshasa's Eye
    1 x Vial of Water    */
    if (iRecipe == 4007) { ProcessBraiseAction(10, 15, oPC, "cu_potion216", 1); return; }

    /* INVISIBILITY
    Yield: 4        HashCode: 4013
    1 x Fairy Dust
    1 x Weeping Hemlock
    1 x Vial of Water     */
    if (iRecipe == 4013) { ProcessBraiseAction(4, 25, oPC, "NW_IT_MPOTION008", 4); return; }

    /* CURE MODERATE WOUNDS
    Yield: 2        HashCode: 4088
    3 x Hollyhock Petals
    1 x Holy Water        */
    if (iRecipe == 4088) { ProcessBraiseAction(4, 30, oPC, "NW_IT_MPOTION020", 2); return; }

    /* HEAL
    Yield: 5        HashCode: 4089
    1 x Hollyhock
    1 x Rosary
    1 x Holy Water        */
    if (iRecipe == 4089) { ProcessBraiseAction(10, 10, oPC, "NW_IT_MPOTION012", 5); return; }

    /* TRUE SIGHT
    Yield: 1        HashCode: 4090
    1 x Sapphire
    1 x Elbaite Tourmaline
    1 x Dragon's Eyeball
    1 x Elemental Water      */
    if (iRecipe == 4090) { ProcessBraiseAction(10, 20, oPC, "cu_potion005", 1); return; }

    /* LESSER RIPPING
    Yield: 1        HashCode: 4091
    1 x Milkweed Pod
    1 x Smokey Quartz
    1 x Vial of Water       */
    if (iRecipe == 4091) { ProcessBraiseAction(10, 15, oPC, "cu_potion002", 1); return; }

    /* LESSER STRIKING
    Yield: 1        HashCode: 4141
    1 x Milkweed Pod
    1 x Tiger Eye
    1 x Vial of Water */
    if (iRecipe == 4141) { ProcessBraiseAction(10, 15, oPC, "cu_potion001", 1); return; }

    /* CURE SERIOUS WOUNDS
    Yield: 7        HashCode: 4155
    1 x Cure Serious Wounds Spell
    1 x Hollyhock Petals
    2 x Giant Oak Leafs
    1 x Holy Water        */
    if (iRecipe == 4155) { ProcessBraiseAction(8, 30, oPC, "NW_IT_MPOTION002", 7); return; }

    /* STONESKIN
    Yield: 3        HashCode: 4238
    1 x Ironwood
    1 x Adamantium
    1 x Magnetite Ore
    1 x Vial of Water     */
    if (iRecipe == 4238) { ProcessBraiseAction(15, 5, oPC, "cu_potion004", 3); return; }

    /* LESSER RESTORATION
    Yield: 8        HashCode: 4270
    1 x Garlic
    1 x Belladonna
    1 x Aventurine
    1 x Holy Water     */
    if (iRecipe == 4270) { ProcessBraiseAction(15, 20, oPC, "NW_IT_MPOTION011", 8); return; }

    /* LORE
    Yield: 4        HashCode: 4277
    1 x Malachite
    1 x Ettercap's Spinal Column and Brain
    1 x Vial of Water     */
    if (iRecipe == 4277) { ProcessBraiseAction(4, 30, oPC, "NW_IT_MPOTION019", 4); return; }

    /* LIFE
    Yield: 3        HashCode: 4312
    1 x Garlic
    1 x Minotaur Heart
    1 x Troll Head
    1 x Elemental Water    */
    if (iRecipe == 4312) { ProcessBraiseAction(20, 5, oPC, "cu_potion201", 3); return; }

    /* STONESKIN
    Yield: 9        HashCode: 4328
    1 x Ironwood
    1 x Adamantium
    1 x Morganite
    1 x Vial of Water       */
    if (iRecipe == 4328) { ProcessBraiseAction(15, 10, oPC, "cu_potion108", 9); return; }

    /* BLESS
    Yield: 16       HashCode: 4357
    1 x Giant Oak Leaf
    1 x Fenberry
    1 x Aventurine
    1 x Bless Spell
    1 x Elemental Water    */
    if (iRecipe == 4357) { ProcessBraiseAction(10, 35, oPC, "NW_IT_MPOTION009", 16); return; }

    /* ELIXIR OF ACUMEN
    Yield: 1        HashCode: 4410
    1 x Ettercap's Spine and Brain
    1 x Vial of Noxious Gas
    1 x Acorn
    1 x Vial of Water     */
    if (iRecipe == 4410) { ProcessBraiseAction(10, 20, oPC, "cu_potion100", 1); return; }

    /* BLESS
    Yield: 5        HashCode: 4418
    1 x Bless Spell
    1 x Giant Oak Leaf
    100 Gold
    1 x Vial of Water    */
    if (iRecipe == 4418) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION009", 5); return; }

    /* REGENERATION
    Yield: 1        HashCode: 4447
    1 x Troll Spine
    1 x Troll Head
    1 x Vial of Water */
    if (iRecipe == 4447) { ProcessBraiseAction(5, 25, oPC, "cu_potion107", 1); return; }

    /* RIPPING
    Yield: 1        HashCode: 4471
    1 x Milkweed Pod
    1 x Diamond
    1 x Vial of Water    */
    if (iRecipe == 4471) { ProcessBraiseAction(10, 10, oPC, "cu_potion217", 1); return; }

    /* STONESKIN
    Yield: 5        HashCode: 4488
    1 x Ironwood
    1 x Adamantium
    1 x Smokey Quartz
    1 x Vial of Water   */
    if (iRecipe == 4488) { ProcessBraiseAction(15, 10, oPC, "cu_potion004", 5); return; }

    /* ULTRAVISION
    Yield: 10       HashCode: 4576
    1 x Fire Agate
    1 x Elbaite Tourmaline
    1 x Rakshasa's Eye
    1 x Elemental Water     */
    if (iRecipe == 4576) { ProcessBraiseAction(10, 25, oPC, "cu_potion006", 10); return; }

    /* CURE MODERATE WOUNDS
    Yield: 1        HashCode: 4624
    3 x Hollyhock Petals
    1 x Vial of Water      */
    if (iRecipe == 4624) { ProcessBraiseAction(4, 28, oPC, "NW_IT_MPOTION020", 1); return; }

    /* CURE SERIOUS WOUNDS
    Yield: 3        HashCode: 4691
    1 x Cure Serious Wounds Spell
    1 x Hollyhock Petals
    2 x Giant Oak Leafs
    1 x Vial of Water       */
    if (iRecipe == 4691) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION002", 3); return; }

    /* NOSTRUM OF DIAMONDSKIN
    Yield: 1        HashCode: 4693
    1 x Diamond
    1 x Smokey Quartz
    1 x Vial of Water      */
    if (iRecipe == 4693) { ProcessBraiseAction(15, 5, oPC, "cu_potion210", 1); return; }

    /* ULTRAVISION
    Yield: 4        HashCode: 4710
    1 x Fire Agate
    1 x Elbaite Tourmaline
    1 x Tiger's Eyeball
    1 x Elemental Water   */
    if (iRecipe == 4710) { ProcessBraiseAction(3, 30, oPC, "cu_potion006", 4); return; }

    /* REGENERATION
    Yield: 10       HashCode: 4724
    1 x Troll Spine
    1 x Troll Head
    1 x Lich Bones
    1 x Elemental Water   */
    if (iRecipe == 4724) { ProcessBraiseAction(15, 18, oPC, "cu_potion107", 10); return; }

    /* SPEED
    Yield: 20       HashCode: 4774
    1 x Falcon's Feather
    1 x Tiger Eyeball
    1 x Fenberry
    1 x Elemental Water     */
    if (iRecipe == 4774) { ProcessBraiseAction(15, 15, oPC, "NW_IT_MPOTION004", 20); return; }

    /* LESSER RESTORATION
    Yield: 5        HashCode: 4806
    1 x Garlic
    1 x Belladonna
    1 x Aventurine
    1 x Vial of Water     */
    if (iRecipe == 4806) { ProcessBraiseAction(15, 28, oPC, "NW_IT_MPOTION011", 5); return; }

    /* DEATH WARD
    Yield: 2        HashCode: 4881
    1 x Belladonna
    1 x Garlic
    1 x Shards of Silver
    1 x Saintsblood Pearl
    1 x Elemental Water     */
    if (iRecipe == 4881) { ProcessBraiseAction(15, 13, oPC, "cu_potion211", 2); return; }

    /* TRUE SIGHT
    Yield: 1        HashCode: 4900
    1 x Sapphire
    1 x Elbaite Tourmaline
    1 x Dragon's Eyeball
    1 x Vial of Water       */
    if (iRecipe == 4900) { ProcessBraiseAction(10, 20, oPC, "cu_potion005", 1); return; }

    /* DISTORT
    Yield: 2        HashCode: 4972
    1 x Smokey Quartz
    1 x Vial of Smoke
    1 x Rakshasa's Eye
    1 x Elemental Water    */
    if (iRecipe == 4972) { ProcessBraiseAction(13, 20, oPC, "cu_potion212", 2); return; }

    /* AID
    Yield: 8        HashCode: 5058
    1 x Aventurine
    1 x Oak Leaf
    1 x Weeping Hemlock Needle
    1 x Elemental Water        */
    if (iRecipe == 5058) { ProcessBraiseAction(3, 30, oPC, "NW_IT_MPOTION016", 8); return; }

    /* HEAL
    Yield: 7        HashCode: 5042
    1 x Hollyhock
    1 x Giant Oak Leaf
    1 x Rosary
    1 x Holy Water             */
    if (iRecipe == 5042) { ProcessBraiseAction(15, 10, oPC, "NW_IT_MPOTION012", 7); return; }

    /* GOD'S TEAR
    Yield: 2        HashCode: 5092
    1 x Rosary
    1 x Vial of Smoke
    1 x Elbaite Tourmaline
    1 x Elemental Water */
    if (iRecipe == 5092) { ProcessBraiseAction(30, 0, oPC, "cu_potion208", 2); return; }

    /* REGENERATION
    Yield: 4        HashCode: 5096
    1 x Troll Spine
    1 x Troll Head
    1 x Vampire's Tooth
    1 x Elemental Water    */
    if (iRecipe == 5096) { ProcessBraiseAction(8, 25, oPC, "cu_potion107", 4); return; }

    /*IMPROVED BULLS STRENGTH
    Yield: 2        HashCode: 5104
    1 x Minotaur Heart
    1 x Minotaur Eyeball
    1 x Minotaur Tongue
    1 x Vial of Water      */
    if (iRecipe == 5104) { ProcessBraiseAction(12, 25, oPC, "cu_potion003", 2); return; }

    /* CURE MODERATE WOUNDS
    Yield: 4        HashCode: 5107
    4 x Hollyhock Petals
    1 x Holy Water         */
    if (iRecipe == 5107) { ProcessBraiseAction(6, 25, oPC, "NW_IT_MPOTION020", 4); return; }

    /* LIFE
    Yield: 1        HashCode: 5122
    1 x Garlic
    1 x Minotaur Heart
    1 x Troll Head
    1 x Vial of Water      */
    if (iRecipe == 5122) { ProcessBraiseAction(15, 10, oPC, "cu_potion201", 1); return; }

    /* BLESS
    Yield: 4        HashCode: 5167
    1 x Giant Oak Leaf
    1 x Fenberry
    1 x Aventurine
    1 x Bless Spell
    1 x Vial of Water     */
    if (iRecipe == 5167) { ProcessBraiseAction(2, 30, oPC, "NW_IT_MPOTION009", 4); return; }

    /* ANIMAL AFFINITY
    Yield: 3        HashCode: 5225
    1 x Garlic
    1 x Ruc'Tara Fruit
    1 x Giant Oak Leaf
    1 x Quartz Crystal
    1 x Elemental Water       */
    if (iRecipe == 5225) { ProcessBraiseAction(10, 20, oPC, "cu_potion000", 3); return; }

    /* CURE CRITICAL WOUNDS
    Yield: 5        HashCode: 5239
    2 x Giant Oak Leaf
    2 x Milkweed Pod
    1 x Holy Water */
    if (iRecipe == 5239) { ProcessBraiseAction(7, 28, oPC, "NW_IT_MPOTION003", 5); return; }

    /* HEAL
    Yield: 14       HashCode: 5373
    1 x Heal Spell
    1 x Hollyhock
    1 x Giant Oak Leaf
    1 x Rosary
    1 x Holy Water            */
    if (iRecipe == 5373) { ProcessBraiseAction(18, 8, oPC, "NW_IT_MPOTION012", 14); return; }

    /* ULTRAVISION
    Yield: 5        HashCode: 5386
    1 x Fire Agate
    1 x Elbaite Tourmaline
    1 x Rakshasa's Eye
    1 x Vial of Water         */
    if (iRecipe == 5386) { ProcessBraiseAction(5, 25, oPC, "cu_potion006", 5); return; }

    /* ULTRAVISION
    Yield: 1        HashCode: 5520
    1 x Fire Agate
    1 x Elbaite Tourmaline
    1 x Tiger's Eyeball
    1 x Vial of Water */
    if (iRecipe == 5520) { ProcessBraiseAction(0, 30, oPC, "cu_potion006", 1); return; }

    /* BOWMANS TONIC
    Yield: 1        HashCode: 5534
    1 x Falcon's Feather
    1 x Tiger's Eye
    1 x Yaxy Fruit
    1 x Vial of Water       */
    if (iRecipe == 5534) { ProcessBraiseAction(45, 0, oPC, "cu_potion205", 1); return; }

    /* IMPROVED BULLS STRENGTH
    Yield: 8        HashCode: 5475
    2 x Minotaur Heart
    1 x Minotaur Eyeball
    1 x Minotaur Tongue
    1 x Elemental Water        */
    if (iRecipe == 5475) { ProcessBraiseAction(15, 20, oPC, "cu_potion003", 8); return; }

    /* PARALYSIS PROOFING
    Yield: 2        HashCode: 5481
    1 x Giant Oak Leaf
    1 x Fenberry
    1 x Aventurine
    1 x Magnetite
    1 x Elemental Water         */
    if (iRecipe == 5481) { ProcessBraiseAction(10, 18, oPC, "cu_potion105", 2); return; }

    /* NOSTRUM OF DIAMONDSKIN
    Yield: 2        HashCode: 5636
    2 x Diamond
    1 x Smokey Quartz
    1 x Elemental Water */
    if (iRecipe == 5636) { ProcessBraiseAction(17, 0, oPC, "NostrumofDiamondskin", 2); return; }

    /* REGENERATION
    Yield: 6        HashCode: 6567
    1 x Troll Spine
    1 x Troll Head
    1 x Vampire's Tooth
    1 x Vampire's Heart
    1 x Elemental Water     */
    if (iRecipe == 6567) { ProcessBraiseAction(9, 22, oPC, "cu_potion210", 6); return; }

    /* DEATH WARD
    Yield: 1        HashCode: 5691
    1 x Belladonna
    1 x Garlic
    1 x Shards of Silver
    1 x Saintsblood Pearl
    1 x Vial of Water        */
    if (iRecipe == 5691) { ProcessBraiseAction(10, 15, oPC, "cu_potion211", 1); return; }

    /* SENSORY PROOFING
    Yield: 2        HashCode: 5737
    1 x Hollyhock Petals
    1 x Ironwood
    1 x Emerald
    1 x Magnetite Ore
    1 x Elemental Water     */
    if (iRecipe == 5737) { ProcessBraiseAction(10, 15, oPC, "cu_potion108", 2); return; }

    /* SPELL RESISTANCE
    Yield: 2        HashCode: 5762
    1 x Ettercap's Silk Gland
    1 x Ettercap's Spine and Brain
    1 x Fairy Dust
    1 x Prism Blossom
    1 x Rakshasa's Eye
    1 x Elemental Water      */
    if (iRecipe == 5762) { ProcessBraiseAction(20, 15, oPC, "cu_potion214", 2); return; }

    /* CURE CRITICAL WOUNDS
    Yield: 4        HashCode: 5775
    2 x Giant Oak Leaf
    2 x Milkweed Pod
    1 x Vial of Water      */
    if (iRecipe == 5775) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION003", 4); return; }

    /* DISTORT
    Yield: 1        HashCode: 5782
    1 x Smokey Quartz
    1 x Vial of Smoke
    1 x Rakshasa's Eye
    1 x Vial of Water      */
    if (iRecipe == 5782) { ProcessBraiseAction(5, 20, oPC, "cu_potion212", 1); return; }

    /* RESTORATION
    Yield: 1        HashCode: 5860
    2 x Belladonna
    2 x Garlic
    1 x Ruc'Tara Fruit
    1 x Vial of Water */
    if (iRecipe == 5860) { ProcessBraiseAction(1, 30, oPC, "cu_potion007", 1); return; }

    /* AID
    Yield: 2        HashCode: 5868
    1 x Aventurine
    1 x Oak Leaf
    1 x Weeping Hemlock Needle
    1 x Water              */
    if (iRecipe == 5868) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION016", 2); return; }

    /* GOD'S TEAR
    Yield: 1        HashCode: 5902
    1 x Rosary
    1 x Vial of Smoke
    1 x Elbaite Tourmaline
    1 x Vial of Water       */
    if (iRecipe == 5902) { ProcessBraiseAction(30, 5, oPC, "cu_potion208", 1); return; }

    /* REGENERATION
    Yield: 2        HashCode: 5906
    1 x Troll Spine
    1 x Troll Head
    1 x Vampire's Tooth
    1 x Vial of Water         */
    if (iRecipe == 5906) { ProcessBraiseAction(10, 25, oPC, "cu_potion107", 2); return; }

    /* ESSENCE OF THE PHANTOM
    Yield: 1        HashCode: 5920
    1 x Dragon Scale
    1 x Vial of Poison
    1 x Wolf's Hide
    1 x Vial of Water        */
    if (iRecipe == 5920) { ProcessBraiseAction(20, 0, oPC, "cu_potion206", 1); return; }

    /* CURE SERIOUS WOUNDS
    Yield: 4        HashCode: 5933
    2 x Hollyhock Petals
    2 x Giant Oak Leaf
    2 x Acorn
    1 x Holy Water          */
    if (iRecipe == 5933) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION002", 4); return; }

    /* STONESKIN
    Yield: 15       HashCode: 6014
    1 x Ironwood
    1 x Adamantium
    1 x Magnetite Ore
    1 x Morganite
    1 x Smokey Quartz
    1 x Elemental Water    */
    if (iRecipe == 6014) { ProcessBraiseAction(25, 0, oPC, "cu_potion004", 15); return; }

    /* ANIMAL AFFINITY
    Yield: 1        HashCode: 6035
    1 x Garlic
    1 x Ruc'Tara Fruit
    1 x Giant Oak Leaf
    1 x Quartz Crystal
    1 x Vial of Water        */
    if (iRecipe == 6035) { ProcessBraiseAction(5, 20, oPC, "cu_potion000", 1); return; }

    /* BLESS
    Yield: 12       HashCode: 6099
    1 x Giant Oak Leaf
    1 x Fenberry
    2 x Aventurine
    1 x Elemental Water     */
    if (iRecipe == 6099) { ProcessBraiseAction(5, 30, oPC, "NW_IT_MPOTION009", 12); return; }

    /* ANTIMAGIC FIZZ
    Yield: 2        HashCode: 6101
    1 x Prism Blossom Seed
    1 x Skeleton's Knuckle
    1 x Milkweed Pod
    1 x Weeping Hemlock Needles
    1 x Elemental Water */
    if (iRecipe == 6101) { ProcessBraiseAction(15, 10, oPC, "cu_potion200", 2); return; }

    /* PARALYSIS PROOFING
    Yield: 1        HashCode: 6291
    1 x Giant Oak Leaf
    1 x Fenberry
    1 x Aventurine
    1 x Magnetite
    1 x Vial of Water       */
    if (iRecipe == 6291) { ProcessBraiseAction(5, 15, oPC, "cu_potion105", 1); return; }

    /* CURE SERIOUS WOUNDS
    Yield: 1        HashCode: 6469
    2 x Hollyhock Petals
    2 x Giant Oak Leaf
    2 x Acorn
    1 x Vial of Water     */
    if (iRecipe == 6469) { ProcessBraiseAction(1, 30, oPC, "NW_IT_MPOTION002", 1); return; }

    /* SENSORY PROOFING
    Yield: 1        HashCode: 6547
    1 x Hollyhock Petals
    1 x Ironwood
    1 x Emerald
    1 x Magnetite Ore
    1 x Vial of Water         */
    if (iRecipe == 6547) { ProcessBraiseAction(5, 15, oPC, "cu_potion108", 1); return; }

    /* SPELL RESISTANCE
    Yield: 1        HashCode: 6572
    1 x Ettercap's Silk Gland
    1 x Ettercap's Spine and Brain
    1 x Fairy Dust
    1 x Prism Blossom
    1 x Rakshasa's Eye
    1 x Vial of Water        */
    if (iRecipe == 6572) { ProcessBraiseAction(5, 20, oPC, "cu_potion214", 1); return; }

    /* MIGHT
    Yield: 2        HashCode: 6642
    1 x Giants Heart
    1 x Minotaurs Heart
    1 x Morganite
    1 x Smokey Quartz
    1 x Milkweed Pod
    1 x Elemental Water */
    if (iRecipe == 6642) { ProcessBraiseAction(20, 5, oPC, "cu_potion202", 2); return; }

    /* CURE MODERATE WOUNDS
    Yield: 2        HashCode: 6662
    5 x Hollyhock Petals
    1 x Vial of Water       */
    if (iRecipe == 6662) { ProcessBraiseAction(3, 30, oPC, "NW_IT_MPOTION020", 2); return; }

    /* LIFE PROTECTION
    Yield: 2        HashCode: 6694
    1 x Giant Oak Leaf
    1 x Alexandrite
    1 x Belladonna
    1 x Emerald
    1 x Garlic
    1 x Elemental Water */
    if (iRecipe == 6694) { ProcessBraiseAction(15, 5, oPC, "cu_potion101", 2); return; }

    /* DISTORT
    Yield: 3        HashCode: 6895
    1 x Diamond
    1 x Vial of Smoke
    1 x Vial of Noxious Gas
    1 x Rakshasa's Eye
    1 x Elemental Water       */
    if (iRecipe == 6895) { ProcessBraiseAction(15, 20, oPC, "cu_potion212", 3); return; }

    /* BLESS
    Yield: 3        HashCode: 6909
    1 x Giant Oak Leaf
    1 x Fenberry
    2 x Aventurine
    1 x Vial of Water */
    if (iRecipe == 6909) { ProcessBraiseAction(0, 30, oPC, "NW_IT_MPOTION009", 3); return; }

    /* ANTIMAGIC FIZZ
    Yield: 1        HashCode: 6911
    1 x Prism Blossom Seed
    1 x Skeleton's Knuckle
    1 x Milkweed Pod
    1 x Weeping Hemlock Needles
    1 x Vial of Water      */
    if (iRecipe == 6911) { ProcessBraiseAction(15, 10, oPC, "cu_potion200", 1); return; }

    /* OBSERVATION
    Yield: 3        HashCode: 6619
    1 x Rakshasa's Eyeball
    1 x Tiger's Eyeball
    1 x Minotaur's Eyeball
    1 x Fiendish Eyeball
    1 x Elemental Water    */
    if (iRecipe == 6619) { ProcessBraiseAction(10, 11, oPC, "cu_potion104", 3); return; }

    /* MASTER THIEVERY
    Yield: 2        HashCode: 7246
    1 x Minotaur's Eyeball
    1 x Dragon's Eyeball
    1 x Succubi Ear
    1 x Fiendish Eyeball
    1 x Rakshasa's Eye
    1 x Elemental Water   */
    if (iRecipe == 7246) { ProcessBraiseAction(30, 15, oPC, "cu_potion213", 2); return; }

    /* REGENERATION
    Yield: 3        HashCode: 7377
    1 x Troll Spine
    1 x Troll Head
    1 x Vampire's Tooth
    1 x Vampire's Heart
    1 x Vial of Water */
    if (iRecipe == 7377) { ProcessBraiseAction(10, 20, oPC, "cu_potion107", 3); return; }

    /* OBSERVATION
    Yield: 2        HashCode: 7429
    1 x Rakshasa's Eyeball
    1 x Tiger's Eyeball
    1 x Minotaur's Eyeball
    1 x Fiendish Eyeball
    1 x Vial of Water */
    if (iRecipe == 7429) { ProcessBraiseAction(10, 13, oPC, "cu_potion104", 2); return; }

    /* MIGHT
    Yield: 1        HashCode: 7452
    1 x Giants Heart
    1 x Minotaurs Heart
    1 x Morganite
    1 x Smokey Quartz
    1 x Milkweed Pod
    1 x Vial of Water*/
    if (iRecipe == 7452) { ProcessBraiseAction(10, 15, oPC, "cu_potion202", 1); return; }

    /* LIFE PROTECTION
    Yield: 1        HashCode: 7504
    1 x Giant Oak Leaf
    1 x Alexandrite
    1 x Belladonna
    1 x Emerald
    1 x Garlic
    1 x Vial of Water        */
    if (iRecipe == 7504) { ProcessBraiseAction(15, 18, oPC, "cu_potion101", 1); return; }

    /* MYSTIC TALENT
    Yield: 2        HashCode: 7515
    1 x Fairy Dust
    1 x Diamond
    1 x Ettercap's Spine and Brain
    1 x Ettercap's Silk Gland
    1 x Prism Blossom
    1 x Rakshasa's Eye
    1 x Elemental Water      */
    if (iRecipe == 7515) { ProcessBraiseAction(25, 0, oPC, "cu_potion203", 2); return; }

    /* RESTORATION
    Yield: 2       HashCode: 7601
    2 x Belladonna
    2 x Garlic
    1 x Aventurine
    1 x Ruc'Tara Fruit
    1 x Vial of Water        */
    if (iRecipe == 7601) { ProcessBraiseAction(3, 30, oPC, "cu_potion007", 2); return; }

    /* CURE SERIOUS WOUNDS
    Yield: 13       HashCode: 7972
    2 x Hollyhock Petals
    2 x Giant Oak Leaf
    2 x Acorn
    1 x Rosary
    1 x Holy Water        */
    if (iRecipe == 7972) { ProcessBraiseAction(10, 30, oPC, "NW_IT_MPOTION002", 13); return; }

    /* MASTER THIEVERY
    Yield: 1        HashCode: 8056
    1 x Minotaur's Eyeball
    1 x Dragon's Eyeball
    1 x Succubi Ear
    1 x Fiendish Eyeball
    1 x Rakshasa's Eye
    1 x Vial of Water     */
    if (iRecipe == 8056) { ProcessBraiseAction(15, 15, oPC, "cu_potion213", 1); return; }

    /* MYSTIC TALENT
    Yield: 1        HashCode: 8325
    1 x Fairy Dust
    1 x Diamond
    1 x Ettercap's Spine and Brain
    1 x Ettercap's Silk Gland
    1 x Prism Blossom
    1 x Rakshasa's Eye
    1 x Vial of Water        */
    if (iRecipe == 8325) { ProcessBraiseAction(20, 0, oPC, "cu_potion203", 1); return; }

    /* CURE SERIOUS WOUNDS
    Yield: 7        HashCode: 8508
    2 x Hollyhock Petals
    2 x Giant Oak Leaf
    2 x Acorn
    1 x Rosary
    1 x Vial of Water      */
    if (iRecipe == 8508) { ProcessBraiseAction(9, 30, oPC, "NW_IT_MPOTION002", 7); return; }

    /* MASTER THIEVERY
    Yield: 4        HashCode: 10266
    1 x Minotaur's Eyeball
    1 x Dragon's Eyeball
    1 x Succubi Ear
    1 x Fiendish Eyeball
    1 x Rakshasa's Eye
    1 x Water Elemental's Eyeball
    1 x Tiger's Eyeball
    1 x Elemental Water     */
    if (iRecipe == 10266) { ProcessBraiseAction(30, 20, oPC, "cu_potion213", 4); return; }

    /* CLARITY
    Yield: 40       HashCode: 10416
    1 x Clarity Spell
    5 x Diamond
    2 x Elemental Water */
    if (iRecipe == 10416) { ProcessBraiseAction(20, 5, oPC, "NW_IT_MPOTION007", 40); return; }

    /* ELEMENTAL SHIELD
    Yield: 3        HashCode: 10748
    1 x Fairy Dust
    1 x Shards of Silver
    1 x Prism Blossom Seeds
    1 x Vial of Smoke
    1 x Vial of Acid
    1 x Vial of Poison
    1 x Vial of Noxious Gas
    1 x Elemental Water */
    if (iRecipe == 10748) { ProcessBraiseAction(20, 10, oPC, "cu_potion103", 3); return; }

    /* GOD'S TEAR
    Yield: 3        HashCode: 11006
    2 x Rosary
    2 x Vial of Smoke
    2 x Elbaite Tourmaline
    1 x Volcanis Oak Seed
    1 x Elemental Water    */
    if (iRecipe == 11006) { ProcessBraiseAction(40, 0, oPC, "cu_potion208", 3); return; }

    // PC doesn't know a recipe... does he succeed anyway??!
    ProcessBadBraiseAction(iRecipe, oPC);
}

void ProcessAprxHashMatch(string strItemTag, object oPC, int nYield) {
    int nQuant;
    int nIndex;
    int nCount = 0;

    // Count how many empty vials PC has
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        if (GetTag(oItem) == "EmptyVile") nCount++;
        oItem = GetNextItemInInventory(oPC);
    }
    if (nCount < nYield) { nQuant = nCount; FloatingTextStringOnCreature("I ran out of empty vials!!", oPC, FALSE); }
    else nQuant = nYield;

    // Create the item(s) in the PC's Inventory
    SetIdentified(CreateItemOnObject(strItemTag, oPC, nQuant), TRUE);
    DoBraiseSuccesEffect(oPC);

    // Remove the vials that were filled with potions
    nQuant -= RemoveItemQuantityFromPC(oPC, "EmptyVile", nQuant);
    Inventory_RemoveStackedItemQuantityFromPC(oPC, "EmptyBottle", nQuant);
}

// See what recipes best fits the generated hash code
void ApproximateHashMatch(int iHashCode, object oPC) {
    // Hashcodes
    if (iHashCode <= 759) { ProcessAprxHashMatch("NW_IT_MPOTION016", oPC, d4());  return; }
    if (iHashCode <= 776) { ProcessAprxHashMatch("NW_IT_MPOTION005", oPC, d8()); return; }
    if (iHashCode <= 804) { ProcessAprxHashMatch("NW_IT_MPOTION015", oPC, 1); return; }
    if (iHashCode <= 830) { ProcessAprxHashMatch( "NW_IT_MPOTION014",oPC, 1); return; }
    if (iHashCode <= 894) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, d4()); return; }
    if (iHashCode <= 986) { ProcessAprxHashMatch("NW_IT_MPOTION013", oPC, d4()); return; }
    if (iHashCode <= 1040) { ProcessAprxHashMatch("NW_IT_MPOTION017", oPC, d4()); return; }
    if (iHashCode <= 1070) { ProcessAprxHashMatch("NW_IT_MPOTION004", oPC, d4()); return; }
    if (iHashCode <= 1094) { ProcessAprxHashMatch("NW_IT_MPOTION008", oPC, d4()); return; }
    if (iHashCode <= 1116) { ProcessAprxHashMatch("NW_IT_MPOTION019", oPC, 1); return; }
    if (iHashCode <= 1140) { ProcessAprxHashMatch("NW_IT_MPOTION018", oPC, d4()); return; }
    if (iHashCode <= 1194) { ProcessAprxHashMatch("NW_IT_MPOTION001", oPC, d4()); return; }
    if (iHashCode <= 1196) { ProcessAprxHashMatch("cu_potion004", oPC, 1); return; }
    if (iHashCode <= 1236) { ProcessAprxHashMatch("NW_IT_MPOTION018", oPC, d8(2)); return; }
    if (iHashCode <= 1362) { ProcessAprxHashMatch("NW_IT_MPOTION012", oPC, 1); return; }
    if (iHashCode <= 1380) { ProcessAprxHashMatch("NW_IT_MPOTION011", oPC, d4()); return; }
    if (iHashCode <= 1569) { ProcessAprxHashMatch("NW_IT_MPOTION016", oPC, 1); return; }
    if (iHashCode <= 1586) { ProcessAprxHashMatch("NW_IT_MPOTION005", oPC, 1); return; }
    if (iHashCode <= 1596) { ProcessAprxHashMatch("NW_IT_MPOTION008", oPC, d8()); return; }
    if (iHashCode <= 1614) { ProcessAprxHashMatch("NW_IT_MPOTION015", oPC, 1); return; }
    if (iHashCode <= 1640) { ProcessAprxHashMatch("NW_IT_MPOTION014", oPC, 1); return; }
    if (iHashCode <= 1665) { ProcessAprxHashMatch("NW_IT_MPOTION011", oPC, d4()); return; }
    if (iHashCode <= 1698) { ProcessAprxHashMatch("NW_IT_MPOTION013", oPC, d6(2)); return; }
    if (iHashCode <= 1704) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, 1); return; }
    if (iHashCode <= 1730) { ProcessAprxHashMatch("NW_IT_MPOTION001", oPC, 1); return; }
    if (iHashCode <= 1748) { ProcessAprxHashMatch("NW_IT_MPOTION020", oPC, 1); return; }
    if (iHashCode <= 1778) { ProcessAprxHashMatch("NW_IT_MPOTION010", oPC, 1); return; }
    if (iHashCode <= 1796) { ProcessAprxHashMatch("NW_IT_MPOTION013", oPC, 1); return; }
    if (iHashCode <= 1837) { ProcessAprxHashMatch("NW_IT_MPOTION005", oPC, d6(2)); return; }
    if (iHashCode <= 1850) { ProcessAprxHashMatch("NW_IT_MPOTION017", oPC, 1); return; }
    if (iHashCode <= 1880) { ProcessAprxHashMatch("NW_IT_MPOTION004", oPC, 1); return; }
    if (iHashCode <= 1898) { ProcessAprxHashMatch("NW_IT_MPOTION012", oPC, 1); return; }
    if (iHashCode <= 1904) { ProcessAprxHashMatch("NW_IT_MPOTION008", oPC, 1); return; }
    if (iHashCode <= 1916) { ProcessAprxHashMatch("NW_IT_MPOTION011", oPC, 1); return; }
    if (iHashCode <= 1920) { ProcessAprxHashMatch("NW_IT_MPOTION015", oPC, 1); return; }
    if (iHashCode <= 1926) { ProcessAprxHashMatch("NW_IT_MPOTION019", oPC, 1); return; }
    if (iHashCode <= 1938) { ProcessAprxHashMatch("NW_IT_MPOTION015", oPC, d4()); return; }
    if (iHashCode <= 1950) { ProcessAprxHashMatch("NW_IT_MPOTION018", oPC, 1); return; }
    if (iHashCode <= 2006) { ProcessAprxHashMatch("cu_potion004", oPC, 1); return; }
    if (iHashCode <= 2034) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, d6()); return; }
    if (iHashCode <= 2130) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, 1); return; }
    if (iHashCode <= 2133) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, d8()); return; }
    if (iHashCode <= 2180) { ProcessAprxHashMatch("NW_IT_MPOTION014", oPC, d6()); return; }
    if (iHashCode <= 2310) { ProcessAprxHashMatch("NW_IT_MPOTION018", oPC, d12()); return; }
    if (iHashCode <= 2406) { ProcessAprxHashMatch("NW_IT_MPOTION008", oPC, 1); return; }
    if (iHashCode <= 2414) { ProcessAprxHashMatch("NW_IT_MPOTION017", oPC, d12()); return; }
    if (iHashCode <= 2580) { ProcessAprxHashMatch("NW_IT_MPOTION013", oPC, d4()); return; }
    if (iHashCode <= 2525) { ProcessAprxHashMatch("NW_IT_MPOTION018", oPC, d4()); return; }
    if (iHashCode <= 2529) { ProcessAprxHashMatch("NW_IT_MPOTION011", oPC, d6()); return; }
    if (iHashCode <= 2647) { ProcessAprxHashMatch("NW_IT_MPOTION005", oPC, d4()); return; }
    if (iHashCode <= 2665) { ProcessAprxHashMatch("cu_potion201", oPC, d8()); return; }
    if (iHashCode <= 2669) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, 1); return; }
    if (iHashCode <= 2675) { ProcessAprxHashMatch("cu_potion200", oPC, d4()); return; }
    if (iHashCode <= 2730) { ProcessAprxHashMatch("NW_IT_MPOTION015", oPC, 1); return; }
    if (iHashCode <= 2748) { ProcessAprxHashMatch("NW_IT_MPOTION015", oPC, 1); return; }
    if (iHashCode <= 2749) { ProcessAprxHashMatch("NW_IT_MPOTION001", oPC, d10()); return; }
    if (iHashCode <= 2767) { ProcessAprxHashMatch("cu_potion201", oPC, d10()); return; }
    if (iHashCode <= 2844) { ProcessAprxHashMatch("NW_IT_MPOTION007",oPC, d4()); return; }
    if (iHashCode <= 2940) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, 1); return; }
    if (iHashCode <= 2953) { ProcessAprxHashMatch("NW_IT_MPOTION014", oPC, d12()); return; }
    if (iHashCode <= 2969) { ProcessAprxHashMatch("NW_IT_MPOTION005", oPC, d8(2)); return; }
    if (iHashCode <= 2990) { ProcessAprxHashMatch("NW_IT_MPOTION014", oPC, d4()); return; }
    if (iHashCode <= 3003) { ProcessAprxHashMatch("NW_IT_MPOTION001", oPC, d6()); return; }
    if (iHashCode <= 3070) { ProcessAprxHashMatch("NW_IT_MPOTION012", oPC, d4()); return; }
    if (iHashCode <= 3086) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, d6()); return; }
    if (iHashCode <= 3115) { ProcessAprxHashMatch("cu_potion004", oPC, 1); return; }
    if (iHashCode <= 3120) { ProcessAprxHashMatch("NW_IT_MPOTION018", oPC, d4()); return; }
    if (iHashCode <= 3135) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, d4()); return; }
    if (iHashCode <= 3157) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, d8(2)); return; }
    if (iHashCode <= 3167) { ProcessAprxHashMatch("cu_potion209", oPC, 1); return; }
    if (iHashCode <= 3197) { ProcessAprxHashMatch("cu_potion216 ", oPC, 1); return; }
    if (iHashCode <= 3202) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, d4()); return; }
    if (iHashCode <= 3203) { ProcessAprxHashMatch("NW_IT_MPOTION008", oPC, d8(2)); return; }
    if (iHashCode <= 3224) { ProcessAprxHashMatch("NW_IT_MPOTION017", oPC, d4()); return; }
    if (iHashCode <= 3250) { ProcessAprxHashMatch("NW_IT_MPOTION020", oPC, d6()); return; }
    if (iHashCode <= 3281) { ProcessAprxHashMatch("cu_potion002", oPC, 1); return; }
    if (iHashCode <= 3331) { ProcessAprxHashMatch("cu_potion001", oPC, 1); return; }
    if (iHashCode <= 3457) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, d10()); return; }
    if (iHashCode <= 3467) { ProcessAprxHashMatch("NW_IT_MPOTION019", oPC, d8(2)); return; }
    if (iHashCode <= 3475) { ProcessAprxHashMatch("cu_potion201", oPC, d4()); return; }
    if (iHashCode <= 3485) { ProcessAprxHashMatch("cu_potion200", oPC, d4()); return; }
    if (iHashCode <= 3539) { ProcessAprxHashMatch("NW_IT_MPOTION001", oPC, d4()); return; }
    if (iHashCode <= 3600) { ProcessAprxHashMatch("cu_potion100", oPC, 1); return; }
    if (iHashCode <= 3608) { ProcessAprxHashMatch("NW_IT_MPOTION009", oPC, d20()); return; }
    if (iHashCode <= 3622) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, 1); return; }
    if (iHashCode <= 3637) { ProcessAprxHashMatch("cu_potion107", oPC, 1); return; }
    if (iHashCode <= 3661) { ProcessAprxHashMatch("cu_potion217", oPC, 1); return; }
    if (iHashCode <= 3671) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, 1); return; }
    if (iHashCode <= 3738) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, 1); return; }
    if (iHashCode <= 3763) { ProcessAprxHashMatch("NW_IT_MPOTION014", oPC, d8()); return; }
    if (iHashCode <= 3779) { ProcessAprxHashMatch("NW_IT_MPOTION005", oPC, d4()); return; }
    if (iHashCode <= 3786) { ProcessAprxHashMatch("NW_IT_MPOTION020", oPC, d4()); return; }
    if (iHashCode <= 3964) { ProcessAprxHashMatch("NW_IT_MPOTION004", oPC, d6()); return; }
    if (iHashCode <= 3967) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, d8()); return; }
    if (iHashCode <= 4007) { ProcessAprxHashMatch("cu_potion216 ", oPC, 1); return; }
    if (iHashCode <= 4013) { ProcessAprxHashMatch("NW_IT_MPOTION008", oPC, d4()); return; }
    if (iHashCode <= 4088) { ProcessAprxHashMatch("NW_IT_MPOTION020", oPC, 1); return; }
    if (iHashCode <= 4089) { ProcessAprxHashMatch("NW_IT_MPOTION012", oPC, d6()); return; }
    if (iHashCode <= 4090) { ProcessAprxHashMatch("cu_potion005", oPC, 1); return; }
    if (iHashCode <= 4091) { ProcessAprxHashMatch("cu_potion002", oPC, 1); return; }
    if (iHashCode <= 4141) { ProcessAprxHashMatch("cu_potion001", oPC, 1); return; }
    if (iHashCode <= 4155) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, d8()); return; }
    if (iHashCode <= 4238) { ProcessAprxHashMatch("cu_potion004", oPC, d4()); return; }
    if (iHashCode <= 4270) { ProcessAprxHashMatch("NW_IT_MPOTION011", oPC, d8()); return; }
    if (iHashCode <= 4277) { ProcessAprxHashMatch("NW_IT_MPOTION019", oPC, d4()); return; }
    if (iHashCode <= 4312) { ProcessAprxHashMatch("cu_potion201", oPC, d4()); return; }
    if (iHashCode <= 4328) { ProcessAprxHashMatch("cu_potion004", oPC, d8()); return; }
    if (iHashCode <= 4357) { ProcessAprxHashMatch("NW_IT_MPOTION009", oPC, d8(2)); return; }
    if (iHashCode <= 4410) { ProcessAprxHashMatch("cu_potion100", oPC, 1); return; }
    if (iHashCode <= 4418) { ProcessAprxHashMatch("NW_IT_MPOTION009", oPC, d6()); return; }
    if (iHashCode <= 4447) { ProcessAprxHashMatch("cu_potion107", oPC, 1); return; }
    if (iHashCode <= 4471) { ProcessAprxHashMatch("cu_potion217", oPC, 1); return; }
    if (iHashCode <= 4488) { ProcessAprxHashMatch("cu_potion004", oPC, d6()); return; }
    if (iHashCode <= 4576) { ProcessAprxHashMatch("cu_potion006", oPC, d10()); return; }
    if (iHashCode <= 4624) { ProcessAprxHashMatch("NW_IT_MPOTION020", oPC, 1); return; }
    if (iHashCode <= 4691) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, d4()); return; }
    if (iHashCode <= 4693) { ProcessAprxHashMatch("cu_potion210", oPC, 1); return; }
    if (iHashCode <= 4710) { ProcessAprxHashMatch("cu_potion006", oPC, d4()); return; }
    if (iHashCode <= 4724) { ProcessAprxHashMatch("cu_potion107", oPC, d10()); return; }
    if (iHashCode <= 4774) { ProcessAprxHashMatch("NW_IT_MPOTION004", oPC, d20()); return; }
    if (iHashCode <= 4806) { ProcessAprxHashMatch("NW_IT_MPOTION011", oPC, d6()); return; }
    if (iHashCode <= 4881) { ProcessAprxHashMatch("cu_potion211", oPC, 1); return; }
    if (iHashCode <= 4900) { ProcessAprxHashMatch("cu_potion005", oPC, 1); return; }
    if (iHashCode <= 4972) { ProcessAprxHashMatch("cu_potion212", oPC, 1); return; }
    if (iHashCode <= 5026) { ProcessAprxHashMatch("NW_IT_MPOTION016", oPC, d8()); return; }
    if (iHashCode <= 5042) { ProcessAprxHashMatch("NW_IT_MPOTION012", oPC, d8()); return; }
    if (iHashCode <= 5092) { ProcessAprxHashMatch("cu_potion208", oPC, 1); return; }
    if (iHashCode <= 5096) { ProcessAprxHashMatch("cu_potion107", oPC, d4()); return; }
    if (iHashCode <= 5104) { ProcessAprxHashMatch("cu_potion003", oPC, 1); return; }
    if (iHashCode <= 5107) { ProcessAprxHashMatch("NW_IT_MPOTION020", oPC, d4()); return; }
    if (iHashCode <= 5122) { ProcessAprxHashMatch("cu_potion000", oPC, 1); return; }
    if (iHashCode <= 5167) { ProcessAprxHashMatch("NW_IT_MPOTION009", oPC, d4()); return; }
    if (iHashCode <= 5225) { ProcessAprxHashMatch("cu_potion000", oPC, d4()); return; }
    if (iHashCode <= 5239) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, d6()); return; }
    if (iHashCode <= 5373) { ProcessAprxHashMatch("NW_IT_MPOTION012", oPC, d12()); return; }
    if (iHashCode <= 5386) { ProcessAprxHashMatch("cu_potion006", oPC, d6()); return; }
    if (iHashCode <= 5520) { ProcessAprxHashMatch("cu_potion006", oPC, 1); return; }
    if (iHashCode <= 5534) { ProcessAprxHashMatch("cu_potion205", oPC, 1); return; }
    if (iHashCode <= 5475) { ProcessAprxHashMatch("cu_potion003", oPC, d8()); return; }
    if (iHashCode <= 5481) { ProcessAprxHashMatch("cu_potion105", oPC, 1); return; }
    if (iHashCode <= 5636) { ProcessAprxHashMatch("cu_potion210", oPC, 1); return; }
    if (iHashCode <= 6567) { ProcessAprxHashMatch("cu_potion107", oPC, d6()); return; }
    if (iHashCode <= 5691) { ProcessAprxHashMatch("cu_potion211", oPC, 1); return; }
    if (iHashCode <= 5737) { ProcessAprxHashMatch("cu_potion108", oPC, 1); return; }
    if (iHashCode <= 5762) { ProcessAprxHashMatch("cu_potion214", oPC, 2); return; }
    if (iHashCode <= 5775) { ProcessAprxHashMatch("NW_IT_MPOTION003", oPC, 4); return; }
    if (iHashCode <= 5782) { ProcessAprxHashMatch("cu_potion212", oPC, 1); return; }
    if (iHashCode <= 5836) { ProcessAprxHashMatch("NW_IT_MPOTION016", oPC, 1); return; }
    if (iHashCode <= 5860) { ProcessAprxHashMatch("cu_potion007", oPC, 1); return; }
    if (iHashCode <= 5902) { ProcessAprxHashMatch("cu_potion208", oPC, 1); return; }
    if (iHashCode <= 5906) { ProcessAprxHashMatch("cu_potion107", oPC, 1); return; }
    if (iHashCode <= 5920) { ProcessAprxHashMatch("cu_potion206", oPC, 1); return; }
    if (iHashCode <= 5933) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, d4()); return; }
    if (iHashCode <= 6014) { ProcessAprxHashMatch("cu_potion004", oPC, d12()); return; }
    if (iHashCode <= 6035) { ProcessAprxHashMatch("cu_potion000", oPC, 1); return; }
    if (iHashCode <= 6099) { ProcessAprxHashMatch("NW_IT_MPOTION009", oPC, d12()); return; }
    if (iHashCode <= 6101) { ProcessAprxHashMatch("cu_potion200", oPC, 1); return; }
    if (iHashCode <= 6291) { ProcessAprxHashMatch("cu_potion105", oPC, 1); return; }
    if (iHashCode <= 6469) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, 1); return; }
    if (iHashCode <= 6547) { ProcessAprxHashMatch("cu_potion108", oPC, 1); return; }
    if (iHashCode <= 6572) { ProcessAprxHashMatch("cu_potion214", oPC, 1); return; }
    if (iHashCode <= 6642) { ProcessAprxHashMatch("cu_potion202", oPC, 1); return; }
    if (iHashCode <= 6662) { ProcessAprxHashMatch("NW_IT_MPOTION020", oPC, 1); return; }
    if (iHashCode <= 6694) { ProcessAprxHashMatch("cu_potion101", oPC, 1); return; }
    if (iHashCode <= 6895) { ProcessAprxHashMatch("cu_potion212", oPC, d4()); return; }
    if (iHashCode <= 6909) { ProcessAprxHashMatch("NW_IT_MPOTION009", oPC, d4()); return; }
    if (iHashCode <= 6911) { ProcessAprxHashMatch("cu_potion200", oPC, 1); return; }
    if (iHashCode <= 6619) { ProcessAprxHashMatch("cu_potion104", oPC, d4()); return; }
    if (iHashCode <= 7246) { ProcessAprxHashMatch("cu_potion213", oPC, 1); return; }
    if (iHashCode <= 7377) { ProcessAprxHashMatch("cu_potion107", oPC, d4()); return; }
    if (iHashCode <= 7429) { ProcessAprxHashMatch("cu_potion104", oPC, 1); return; }
    if (iHashCode <= 7452) { ProcessAprxHashMatch("cu_potion202", oPC, 1); return; }
    if (iHashCode <= 7504) { ProcessAprxHashMatch("cu_potion101", oPC, 1); return; }
    if (iHashCode <= 7601) { ProcessAprxHashMatch("cu_potion007", oPC, 1); return; }
    if (iHashCode <= 7515) { ProcessAprxHashMatch("cu_potion203", oPC, 1); return; }
    if (iHashCode <= 7972) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, d12()); return; }
    if (iHashCode <= 8056) { ProcessAprxHashMatch("cu_potion213", oPC, 1); return; }
    if (iHashCode <= 8325) { ProcessAprxHashMatch("cu_potion203", oPC, 1); return; }
    if (iHashCode <= 8508) { ProcessAprxHashMatch("NW_IT_MPOTION002", oPC, d8()); return; }
    if (iHashCode <= 10266) { ProcessAprxHashMatch("cu_potion213", oPC, d4()); return; }
    if (iHashCode <= 10416) { ProcessAprxHashMatch("NW_IT_MPOTION007", oPC, d20(2)); return; }
    if (iHashCode <= 10748) { ProcessAprxHashMatch("cu_potion103", oPC, d4()); return; }
    if (iHashCode <= 11006) { ProcessAprxHashMatch("cu_potion208", oPC, d4()); return; }
    iHashCode -= 11006;
    ApproximateHashMatch(iHashCode, oPC);
}

// NOTE: Recipe #0 is 'INVALID_RECIPE' - just check for
//       skills on the PC against a preset difficulty
// NOTE: fTotalChance factors have been amplified to allow for a 210% TOTAL chance of success, plus bonusses.
//
int CheckBraiseSuccess(int iDifficulty, int iBaseChance, object oPC) {
    // Get PC's total levels and adjust difficulty accordingly
    float fTotalChance = 0.0;
    int nPCLevel = 0;
    int nIndex;
    for (nIndex=1;nIndex<4;nIndex++) nPCLevel += GetLevelByPosition(nIndex, oPC);
    iDifficulty -= nPCLevel;  // Negative values permitted

    // Factor in the Base Chance of success for the recipe
    fTotalChance += IntToFloat(iBaseChance) + (IntToFloat(Random(iBaseChance)) * 0.20); // Small random boost

    // Add in Ability bonusi   =)
    int iInt = GetAbilityModifier(ABILITY_INTELLIGENCE);
    int iWis = GetAbilityModifier(ABILITY_WISDOM);
    if (iInt > 2) iInt *= 3;    // Bonus for good Int
    if (iWis > 2) iWis *= 2;    // Bonus for good Wis
    fTotalChance += IntToFloat(iWis);
    fTotalChance += IntToFloat(GetAbilityModifier(ABILITY_DEXTERITY));
    fTotalChance += IntToFloat(iInt);

    // Query the PC's skills according to the weights
    fTotalChance += IntToFloat(GetSkillRank(SKILL_CONCENTRATION, oPC)) * 0.30;
    fTotalChance += IntToFloat(GetSkillRank(SKILL_DISCIPLINE, oPC)) * 0.20;
    fTotalChance += IntToFloat(GetSkillRank(SKILL_LISTEN, oPC)) * 0.10;
    fTotalChance += IntToFloat(GetSkillRank(SKILL_SPOT, oPC)) * 0.12;
    fTotalChance += IntToFloat(GetSkillRank(SKILL_LORE, oPC)) * 0.40;
    fTotalChance += IntToFloat(GetSkillRank(SKILL_SPELLCRAFT, oPC)) * 0.08;
    fTotalChance += IntToFloat(GetSkillRank(SKILL_USE_MAGIC_DEVICE)) * 0.08;

    // Query PC Feats
    if (GetHasFeat(FEAT_ALERTNESS, oPC)) fTotalChance += IntToFloat((4 * nPCLevel)) * 0.20;
    if (GetHasFeat(FEAT_LIGHTNING_REFLEXES, oPC)) fTotalChance += IntToFloat((3 * nPCLevel)) * 0.15;
    if (GetHasFeat(FEAT_QUICK_TO_MASTER, oPC)) fTotalChance += IntToFloat((4 * nPCLevel)) * 0.10;
    if (GetHasFeat(FEAT_KNOWLEDGE_DOMAIN_POWER, oPC)) fTotalChance += IntToFloat((4 * nPCLevel)) * 0.04;
    if (GetHasFeat(FEAT_STILL_MIND, oPC)) fTotalChance += 2.0;
    if (GetHasFeat(FEAT_STILL_SPELL, oPC)) fTotalChance += 2.0;
    if (GetHasFeat(FEAT_MAXIMIZE_SPELL, oPC)) fTotalChance += 2.0;
    if (GetHasFeat(FEAT_AMBIDEXTERITY) || GetHasFeat(FEAT_BARDIC_KNOWLEDGE) ||
        GetHasFeat(FEAT_DISARM) || GetHasFeat(FEAT_FEARLESS) ||
        GetHasFeat(FEAT_KEEN_SENSE) || GetHasFeat(FEAT_NATURE_SENSE)) fTotalChance += IntToFloat((8 * nPCLevel)) * 0.15;

    // Determine success on d100
    float fResult = IntToFloat(d100()) + IntToFloat(iDifficulty);
    if (fTotalChance >= fResult) return TRUE;
    return FALSE;
}

void CheckEnchantment(string strVarName, object oPC, int nSpellID) {
    int iVar = GetLocalInt(OBJECT_SELF, strVarName);
    if (iVar == 0) return;

    // Discharge the spell
    AssignCommand(oPC, ActionCastSpellAtObject(nSpellID, oPC));
}

// Randomly select something to happen if the PC ruins the potion
void DoBraiseFailedEffect(object oPC) {
    // Generate an effect on failure
    int iRand = Random(10);
    int iCreate;
    effect eVFX;
    effect eREAL;

    // Explosion
    if (iRand == 0) {
        eVFX = EffectVisualEffect(VFX_FNF_FIREBALL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);
        eVFX = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
        eREAL = EffectDamage(d6(6), DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eREAL, oPC);
        DelayCommand(1.5, FloatingTextStringOnCreature("I ruined the brew!!", oPC, FALSE));
        return;
    }
    // Gas cloud
    if (iRand == 1) {
        eVFX = EffectVisualEffect(VFX_IMP_ACID_L);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);
        eVFX = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
        eREAL = EffectDamage(d4(6), DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eREAL, oPC);
        DelayCommand(1.5, FloatingTextStringOnCreature("I ruined the brew!!", oPC, FALSE));
        return;
    }
    // Puff of smoke
    if (iRand == 2) {
        eVFX = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);
        DelayCommand(1.5, FloatingTextStringOnCreature("I ruined the brew!!", oPC, FALSE));
        return;
    }
    // Lightning strike
    if (iRand == 3) {
        eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        eREAL = EffectDamage(d6(5), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eREAL, oPC);
        eREAL = EffectKnockdown();
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREAL, oPC, (10.0 + IntToFloat(Random(30))));
        DelayCommand(1.5, FloatingTextStringOnCreature("I ruined the brew!!", oPC, FALSE));
        return;
    }
    // 'Poison' potion
    if (iRand == 4) {
        iCreate = d6(); // err... how many empty vials does PC have??!
        string strItemTag = "cu_poison0";
        NormalizeString(strItemTag, Random(MAX_POISONS));
        // Create the poison-potion
        if (iRand == 52) CreateItemOnObject(strItemTag, oPC, iCreate);
        eVFX = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
        // Delete the empty viles
        iCreate -= RemoveItemQuantityFromPC(oPC, "EmptyVile", iCreate);
        Inventory_RemoveStackedItemQuantityFromPC(oPC, "EmptyBottle", iCreate);
        return;
    }
    // Disappear/Reappear for a while
    if (iRand == 5) {
        eVFX = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        eREAL = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREAL, oPC, IntToFloat(d20() + Random(180)));
        DelayCommand(1.5, FloatingTextStringOnCreature("I ruined the brew!!", oPC, FALSE));
        return;
    }
    // Create some Ale, Spirits, Wine or Water
    if (iRand >= 6 && iRand <= 10) {
        iRand = Random(3);
        if (iRand == 0) CreateItemOnObject("cu_food003", oPC, d10());   // Create Ale
        if (iRand == 1) CreateItemOnObject("cu_food004", oPC, d10());   // Spirits
        if (iRand == 2) CreateItemOnObject("cu_food005", oPC, d10());   // Wine

    }
    // Darkness (default)
    eVFX = EffectVisualEffect(VFX_FNF_IMPLOSION);
    eREAL = EffectDarkness();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eREAL, oPC, IntToFloat(d20() + Random(180)));
    FloatingTextStringOnCreature("I ruined the brew!!", oPC, FALSE);
    return;
}

// Do a VFX_IMP_RESTORATION_LESSER effect on the PC
void DoBraiseSuccesEffect(object oPC) {
    effect eVFX;
    eVFX = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oPC);
}

// Check the alchem kit for value of each variable
int HashSum(string strReagentCode, int iReagentValue) {
    int nTemp = GetLocalInt(OBJECT_SELF, strReagentCode);
    nTemp *= iReagentValue;
    return nTemp;
}

// Detect what variables have been set and sum the prime numbers indexed to them
int HashReagents() {

    // Highest Code: 2053

    int iHash = 0;
    iHash += HashSum("Aid", 2);
    iHash += HashSum("Barkskin", 19);
    iHash += HashSum("Bless", 31);
    iHash += HashSum("BullsStrength", 47);
    iHash += HashSum("CatsGrace", 73);
    iHash += HashSum("Clarity", 137);
    iHash += HashSum("CureCritical", 149);
    iHash += HashSum("CureLight", 163);
    iHash += HashSum("CureModerate", 181);
    iHash += HashSum("CureSerious", 199);
    iHash += HashSum("EaglesSplendor", 211);
    iHash += HashSum("Endurance", 229);
    iHash += HashSum("FoxsCunning", 283);
    iHash += HashSum("Haste", 313);
    iHash += HashSum("Heal", 331);
    iHash += HashSum("Invisibility", 337);
    iHash += HashSum("LesserRestoration", 349);
    iHash += HashSum("Lore", 359);
    iHash += HashSum("OwlsWisdom", 383);
    iHash += HashSum("Stoneskin", 439);
    iHash += HashSum("Acorns", 479);
    iHash += HashSum("Adamantium", 487);
    iHash += HashSum("Azurite", 499);
    iHash += HashSum("BalorsEyeball", 509);
    iHash += HashSum("BodaksHead", 523);
    iHash += HashSum("BodaksTooth", 541);
    iHash += HashSum("BeetleCarapace", 547);
    iHash += HashSum("Belladonna", 557 );
    iHash += HashSum("BrainWeevilEggs", 563);
    iHash += HashSum("Carrollite", 569);
    iHash += HashSum("Coppervar", 571);
    iHash += HashSum("DeadBaby", 577 );
    iHash += HashSum("DireBearKidney", 587 );
    iHash += HashSum("DragonBlood", 593);
    iHash += HashSum("DragonEggs", 613);
    iHash += HashSum("DragonEyeball", 641);
    iHash += HashSum("DragonHead", 653);
    iHash += HashSum("DragonHeartElder", 673 );
    iHash += HashSum("DragonHeartYoung", 691);
    iHash += HashSum("DragonScale", 719);
    iHash += HashSum("DragonSkull", 739);
    iHash += HashSum("ElbaiteTourmaline", 743);
    iHash += HashSum("ElementalWater", 757);
    iHash += HashSum("EssenceofFrostGiant", 769 );
    iHash += HashSum("EttercapsSilkGland", 797);
    iHash += HashSum("EttercapsSpineandBrain", 821);
    iHash += HashSum("FairyDust", 839);
    iHash += HashSum("FalconsEgg", 857 );
    iHash += HashSum("FalconsFeather", 877);
    iHash += HashSum("Fenberry", 907);
    iHash += HashSum("FiendishEyeball", 1987);
    iHash += HashSum("FireBeetlesBelly", 919);
    iHash += HashSum("GargoyleSkull", 929);
    iHash += HashSum("Garlic", 941);
    iHash += HashSum("GiantOakLeaf", 953);
    iHash += HashSum("GiantsHeart", 967);
    iHash += HashSum("GoblinHeart", 977);
    iHash += HashSum("GoblinKidney", 991);
    iHash += HashSum("GreaterWerewolfTooth", 1009);
    iHash += HashSum("HollyHockPetals", 1019);
    iHash += HashSum("HolyWater", 1031);
    iHash += HashSum("IronGolemSpinalCluster", 1049);
    iHash += HashSum("Ironwood", 1061);
    iHash += HashSum("LichBones", 1087);
    iHash += HashSum("LockofNymphsHair", 1097);
    iHash += HashSum("LockofWerewolfHair", 1109);
    iHash += HashSum("MagnetiteOre", 1123);
    iHash += HashSum("MilkweedPod", 1151);
    iHash += HashSum("MinotaursEyeball", 1163);
    iHash += HashSum("MinotaursHeart", 1181);
    iHash += HashSum("MinotaursTongue", 1193);
    iHash += HashSum("Morganite", 1213);
    iHash += HashSum("OrcsEar", 1223);
    iHash += HashSum("OrcsEyeball", 1231);
    iHash += HashSum("OrcsHead", 1249);
    iHash += HashSum("PrismBlossom", 1259);
    iHash += HashSum("PrismBlossomSeed", 2027);
    iHash += HashSum("QuartzCrystal", 1277);
    iHash += HashSum("RakshasasEyeball", 1289);
    iHash += HashSum("RosaryBeads", 2053);
    iHash += HashSum("RucTaraFruit", 1297);
    iHash += HashSum("SaintsbloodPearl", 1307);
    iHash += HashSum("ShardsofSilver", 1319);
    iHash += HashSum("SkeletonsKnuckle", 1327);
    iHash += HashSum("SlaadsTongue", 1361);
    iHash += HashSum("SmokeyQuartz", 1373);
    iHash += HashSum("SpineandBrainofWererat", 1399);
    iHash += HashSum("SuccubiEar", 1409);
    iHash += HashSum("TigersEyeball", 1423);
    iHash += HashSum("TrollsHead", 1433);
    iHash += HashSum("TrollsSpinalColumn", 1447);
    iHash += HashSum("VampiresTooth", 1459);
    iHash += HashSum("VampiresHeart", 1471);
    iHash += HashSum("VialofAcid", 1481);
    iHash += HashSum("VialofBlood", 1493);
    iHash += HashSum("VialofDragonsBlood", 1511);
    iHash += HashSum("VialofLizardBlood", 1523);
    iHash += HashSum("VialofNoxiousGas", 1543);
    iHash += HashSum("VialofPoison", 1997);
    iHash += HashSum("VialofSmoke", 1553);
    iHash += HashSum("VialofWater", 1567);
    iHash += HashSum("VolcanisOakSeed", 1579);
    iHash += HashSum("WaterElementalsEyeball", 1597);
    iHash += HashSum("WeepingHemlockNeedles", 1607);
    iHash += HashSum("WerewolfsTooth", 1619);
    iHash += HashSum("WolfsHide", 1637);
    iHash += HashSum("WolfsTooth", 1657);
    iHash += HashSum("YaxyFruit", 1667);
    iHash += HashSum("ZombieKidney", 1693);
    iHash += HashSum("Alexandrite", 1709);
    iHash += HashSum("Amethyst", 1723);
    iHash += HashSum("Aventurine", 1741);
    iHash += HashSum("Diamond", 1753);
    iHash += HashSum("Emerald", 1777);
    iHash += HashSum("FireAgate", 1787);
    iHash += HashSum("FireOpal", 1801);
    iHash += HashSum("Fluorspar", 1823);
    iHash += HashSum("Garnet", 1847);
    iHash += HashSum("Gold", 1867);
    iHash += HashSum("Greenstone", 1877);
    iHash += HashSum("Malachite", 1889);
    iHash += HashSum("Phenalope", 1907);
    iHash += HashSum("Ruby", 1931);
    iHash += HashSum("Sapphire", 1949);
    iHash += HashSum("Topaz", 1973);
    return iHash;
}

string NormalizeString(string strItemTag, int iValue) {
    if (iValue < 10) strItemTag += "00";
    else if (iValue < 100) strItemTag += "0";
    strItemTag += IntToString(iValue);
    return(strItemTag);
}

