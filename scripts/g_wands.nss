// Wand Versions ///////////////////////////////////////////////////////////////
string strWScryeVer = "1.03";
string strWXRaysVer = "1.02";
string strWRemovVer = "1.00";
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Support function prototypes
void    QueryAbilities(object oPC, object oCreature);
void    QueryMiscTraits(object oPC, object oTPC);
string  QueryClassByPosition(int nTemp, object oTPC);
void    QueryRacialType(object oPC, object oTPC);
void    QueryIPAddress(object oPC, object oTPC);
void    QueryVitals(object oPC, object oTPC);
void    QueryTotalInventory(object oPC, object oTPC);
void    QueryInventory(object oPC, object oTPC);
void    QueryEquippedItems(object oPC, object oTPC);
string  QuerySlot(int nSlot, object oTPC, string oBodyArea);
void    QueryEffects(object oPC, object oTPC);
void    QueryTotalEffects(object oPC, object oTPC);
string  RetrieveEffectString(int nType);
string  RetrieveDurationString(effect eEffect);
void    QueryWizardMemory(object oPC, object oTPC);
void    QueryClericMemory(object oPC, object oTPC);
void    QuerySkills(object oPC, object oTPC);
void    QuerySkill(int nSkill, string strSkillText, object oPC, object oTPC);
void    QueryFeats(object oPC, object oTPC);
void    KillItemInSlot(int nSlot, object oTPC, string strBodyArea);

////////////////////////////////////////////////////////////////////////////////
// Main function for the Wand of XRays
void WandofXRays(object oPC, object oTPC) {
        // Query Inventory
        SendMessageToPC(oPC, "Wand of XRays " + strWXRaysVer);
        SendMessageToPC(oPC, "---INVENTORY-----------------");
        QueryTotalInventory(oPC, oTPC);
        QueryInventory(oPC, oTPC);
}

// Main function for the Wand of Scrying
void WandofScrying(object oPC, object oTPC) {
        SendMessageToPC(oPC, "Wand of Scrying revision " + strWScryeVer);
        SendMessageToPC(oPC, "-----------------------------");
        SendMessageToPC(oPC, "Name: " + GetName(oTPC));

        // Get IP Address
        QueryIPAddress(oPC, oTPC);

        // Get Ability Scores
        SendMessageToPC(oPC, "---ABILITIES-----------------");
        QueryAbilities(oPC, oTPC);

        // Query Vital Stats
        SendMessageToPC(oPC, "---VITALS--------------------");
        QueryVitals(oPC, oTPC);

        // Get Miscellaneous Info
        SendMessageToPC(oPC, "---MISC TRAITS---------------");
        QueryMiscTraits(oPC, oTPC);

        // Get inventory slot info
        SendMessageToPC(oPC, "---EQUIPPED ITEMS------------");
        QueryEquippedItems(oPC, oTPC);

        // Get inventory slot info
        SendMessageToPC(oPC, "---EFFECTS-------------------");
        QueryTotalEffects(oPC, oTPC);
        QueryEffects(oPC, oTPC);

        // Get the spells in memory
        SendMessageToPC(oPC, "---MEMORIZED WIZARD SPELLS---");
        QueryWizardMemory(oPC, oTPC);
        SendMessageToPC(oPC, "---MEMORIZED CLERIC SPELLS---");
        QueryClericMemory(oPC, oTPC);

        // Skills
        SendMessageToPC(oPC, "---SKILLS--------------------");
        QuerySkills(oPC, oTPC);

        // Feats
        SendMessageToPC(oPC, "---FEATS---------------------");
        QueryFeats(oPC, oTPC);
}

// Lists feats the character possesses
void QueryFeats(object oPC, object oTPC) {
    if (GetHasFeat(FEAT_AIR_DOMAIN_POWER, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_AIR_DOMAIN_POWER");
    if (GetHasFeat(FEAT_ALERTNESS, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_ALERTNESS");
    if (GetHasFeat(FEAT_AMBIDEXTERITY, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_AMBIDEXTERITY");
    if (GetHasFeat(FEAT_ANIMAL_COMPANION, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_ANIMAL_COMPANION");
    if (GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_ANIMAL_DOMAIN_POWER ");
    if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_ARMOR_PROFICIENCY_HEAVY ");
    if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_ARMOR_PROFICIENCY_LIGHT");
    if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_ARMOR_PROFICIENCY_MEDIUM");
    if (GetHasFeat(FEAT_AURA_OF_COURAGE, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_AURA_OF_COURAGE");
    if (GetHasFeat(FEAT_BARBARIAN_ENDURANCE, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BARBARIAN_ENDURANCE");
    if (GetHasFeat(FEAT_BARBARIAN_RAGE, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BARBARIAN_RAGE ");
    if (GetHasFeat(FEAT_BARD_SONGS, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BARD_SONGS");
    if (GetHasFeat(FEAT_BARDIC_KNOWLEDGE, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BARDIC_KNOWLEDGE");
    if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_GIANTS, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BATTLE_TRAINING_VERSUS_GIANTS");
    if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_GOBLINS, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BATTLE_TRAINING_VERSUS_GOBLINS");
    if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_ORCS, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BATTLE_TRAINING_VERSUS_ORCS");
    if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_REPTILIANS, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_BATTLE_TRAINING_VERSUS_REPTILIANS");
    if (GetHasFeat(FEAT_CALLED_SHOT, oTPC)) SendMessageToPC(oPC, "  " + "FEAT_CALLED_SHOT");
    if (GetHasFeat(FEAT_CLEAVE    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_CLEAVE");
    if (GetHasFeat(FEAT_COMBAT_CASTING    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_COMBAT_CASTING");
    if (GetHasFeat(FEAT_CRIPPLING_STRIKE    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_CRIPPLING_STRIKE ");
    if (GetHasFeat(FEAT_DAMAGE_REDUCTION    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DAMAGE_REDUCTION ");
    if (GetHasFeat(FEAT_DARKVISION    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DARKVISION ");
    if (GetHasFeat(FEAT_DEATH_DOMAIN_POWER    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DEATH_DOMAIN_POWER");
    if (GetHasFeat(FEAT_DEFENSIVE_ROLL    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DEFENSIVE_ROLL");
    if (GetHasFeat(FEAT_DEFLECT_ARROWS    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DEFLECT_ARROWS");
    if (GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DESTRUCTION_DOMAIN_POWER");
    if (GetHasFeat(FEAT_DIAMOND_BODY    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DIAMOND_BODY ");
    if (GetHasFeat(FEAT_DIAMOND_SOUL   , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DIAMOND_SOUL");
    if (GetHasFeat(FEAT_DISARM    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DISARM");
    if (GetHasFeat(FEAT_DIVINE_GRACE    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DIVINE_GRACE");
    if (GetHasFeat(FEAT_DIVINE_HEALTH    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DIVINE_HEALTH");
    if (GetHasFeat(FEAT_DODGE    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_DODGE");
    if (GetHasFeat(FEAT_EARTH_DOMAIN_POWER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_EARTH_DOMAIN_POWER");
    if (GetHasFeat(FEAT_ELEMENTAL_SHAPE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_ELEMENTAL_SHAPE");
    if (GetHasFeat(FEAT_EMPOWER_SPELL    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_EMPOWER_SPELL");
    if (GetHasFeat(FEAT_EMPTY_BODY   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_EMPTY_BODY");
    if (GetHasFeat(FEAT_EVASION   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_EVASION");
    if (GetHasFeat(FEAT_EVIL_DOMAIN_POWER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_EVIL_DOMAIN_POWER");
    if (GetHasFeat(FEAT_EXTEND_SPELL   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_EXTEND_SPELL");
    if (GetHasFeat(FEAT_EXTRA_TURNING   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_EXTRA_TURNING");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_FAVORED_ENEMY_ABERRATION");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_ANIMAL");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_BEAST  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_FAVORED_ENEMY_BEAST");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_CONSTRUCT ");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_DRAGON");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_DWARF    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_FAVORED_ENEMY_DWARF ");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_FAVORED_ENEMY_ELEMENTAL");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ELF   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_ELF");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_FEY   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_FEY ");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_GIANT  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_FAVORED_ENEMY_GIANT");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_GNOME   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_GNOME");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_FAVORED_ENEMY_GOBLINOID");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_FAVORED_ENEMY_HALFELF");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_HALFLING");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_HALFORC");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_FAVORED_ENEMY_HUMAN ");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_MAGICAL_BEAST ");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_MONSTROUS");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ORC  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_FAVORED_ENEMY_ORC");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_OUTSIDER");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_REPTILIAN");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_SHAPECHANGER ");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_FAVORED_ENEMY_UNDEAD ");
    if (GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FAVORED_ENEMY_VERMIN");
    if (GetHasFeat(FEAT_FEARLESS   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FEARLESS");
    if (GetHasFeat(FEAT_FIRE_DOMAIN_POWER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FIRE_DOMAIN_POWER");
    if (GetHasFeat(FEAT_FLURRY_OF_BLOWS   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_FLURRY_OF_BLOWS ");
    if (GetHasFeat(FEAT_GOOD_AIM   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_GOOD_AIM ");
    if (GetHasFeat(FEAT_GOOD_DOMAIN_POWER  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_GOOD_DOMAIN_POWER");
    if (GetHasFeat(FEAT_GREAT_FORTITUDE  , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_GREAT_FORTITUDE");
    if (GetHasFeat(FEAT_HARDINESS_VERSUS_ENCHANTMENTS , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_HARDINESS_VERSUS_ENCHANTMENTS");
    if (GetHasFeat(FEAT_HARDINESS_VERSUS_ILLUSIONS   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_HARDINESS_VERSUS_ILLUSIONS");
    if (GetHasFeat(FEAT_HARDINESS_VERSUS_POISONS  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_HARDINESS_VERSUS_POISONS");
    if (GetHasFeat(FEAT_HARDINESS_VERSUS_SPELLS  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_HARDINESS_VERSUS_SPELLS");
    if (GetHasFeat(FEAT_HEALING_DOMAIN_POWER  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_HEALING_DOMAIN_POWER");
    if (GetHasFeat(FEAT_IMMUNITY_TO_SLEEP   , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_IMMUNITY_TO_SLEEP");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_BASTARD_SWORD   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_BASTARD_SWORD");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_BATTLE_AXE   , oTPC)) SendMessageToPC(oPC, "  " + "   FEAT_IMPROVED_CRITICAL_BATTLE_AXE ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_CLUB      , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_CLUB ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_CREATURE  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_CREATURE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DAGGER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_DAGGER");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DART   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_DART ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DIRE_MACE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_DIRE_MACE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_DOUBLE_AXE  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_DOUBLE_AXE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_GREAT_AXE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_GREAT_AXE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_GREAT_SWORD  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_GREAT_SWORD");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HALBERD   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_HALBERD");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HAND_AXE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_HAND_AXE ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HEAVY_CROSSBOW  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_HEAVY_CROSSBOW ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_HEAVY_FLAIL  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_HEAVY_FLAIL");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_KAMA   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_KAMA");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_KATANA  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_KATANA ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_KUKRI  , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_KUKRI");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_CROSSBOW   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_LIGHT_CROSSBOW ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_FLAIL   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_LIGHT_FLAIL ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_HAMMER  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_LIGHT_HAMMER ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LIGHT_MACE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_LIGHT_MACE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LONG_SWORD  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_LONG_SWORD");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_LONGBOW   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_LONGBOW");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_MORNING_STAR , oTPC)) SendMessageToPC(oPC, "  " + "   FEAT_IMPROVED_CRITICAL_MORNING_STAR");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_RAPIER    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_IMPROVED_CRITICAL_RAPIER ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SCIMITAR   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_SCIMITAR ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SCYTHE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_SCYTHE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SHORT_SWORD , oTPC)) SendMessageToPC(oPC, "  " + "   FEAT_IMPROVED_CRITICAL_SHORT_SWORD");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SHORTBOW  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_SHORTBOW");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SHURIKEN  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_SHURIKEN ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SICKLE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_SICKLE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SLING   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_SLING");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_SPEAR   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_SPEAR ");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_STAFF   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_STAFF");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_THROWING_AXE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_THROWING_AXE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_TWO_BLADED_SWORD  , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_CRITICAL_TWO_BLADED_SWORD");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_UNARMED_STRIKE  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_UNARMED_STRIKE");
    if (GetHasFeat(FEAT_IMPROVED_CRITICAL_WAR_HAMMER  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_CRITICAL_WAR_HAMMER");
    if (GetHasFeat(FEAT_IMPROVED_DISARM   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_DISARM ");
    if (GetHasFeat(FEAT_IMPROVED_EVASION   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_EVASION ");
    if (GetHasFeat(FEAT_IMPROVED_KNOCKDOWN , oTPC)) SendMessageToPC(oPC, "  " + "   FEAT_IMPROVED_KNOCKDOWN");
    if (GetHasFeat(FEAT_IMPROVED_PARRY   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_PARRY");
    if (GetHasFeat(FEAT_IMPROVED_POWER_ATTACK  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_POWER_ATTACK");
    if (GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_FIGHTING  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_IMPROVED_TWO_WEAPON_FIGHTING");
    if (GetHasFeat(FEAT_IMPROVED_UNARMED_STRIKE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IMPROVED_UNARMED_STRIKE");
    if (GetHasFeat(FEAT_IRON_WILL   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_IRON_WILL");
    if (GetHasFeat(FEAT_KEEN_SENSE  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_KEEN_SENSE");
    if (GetHasFeat(FEAT_KI_STRIKE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_KI_STRIKE");
    if (GetHasFeat(FEAT_KNOCKDOWN   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_KNOCKDOWN");
    if (GetHasFeat(FEAT_KNOWLEDGE_DOMAIN_POWER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_KNOWLEDGE_DOMAIN_POWER");
    if (GetHasFeat(FEAT_LAY_ON_HANDS   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_LAY_ON_HANDS");
    if (GetHasFeat(FEAT_LIGHTNING_REFLEXES   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_LIGHTNING_REFLEXES");
    if (GetHasFeat(FEAT_LOWLIGHTVISION  , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_LOWLIGHTVISION");
    if (GetHasFeat(FEAT_LUCK_DOMAIN_POWER    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_LUCK_DOMAIN_POWER");
    if (GetHasFeat(FEAT_LUCKY   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_LUCKY");
    if (GetHasFeat(FEAT_MAGIC_DOMAIN_POWER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_MAGIC_DOMAIN_POWER");
    if (GetHasFeat(FEAT_MAXIMIZE_SPELL   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_MAXIMIZE_SPELL");
    if (GetHasFeat(FEAT_MOBILITY    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_MOBILITY");
    if (GetHasFeat(FEAT_MONK_AC_BONUS  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_MONK_AC_BONUS");
    if (GetHasFeat(FEAT_MONK_ENDURANCE  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_MONK_ENDURANCE");
    if (GetHasFeat(FEAT_NATURE_SENSE   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_NATURE_SENSE");
    if (GetHasFeat(FEAT_OPPORTUNIST   , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_OPPORTUNIST");
    if (GetHasFeat(FEAT_PARTIAL_SKILL_AFFINITY_LISTEN   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_PARTIAL_SKILL_AFFINITY_LISTEN");
    if (GetHasFeat(FEAT_PARTIAL_SKILL_AFFINITY_SEARCH  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_PARTIAL_SKILL_AFFINITY_SEARCH");
    if (GetHasFeat(FEAT_PARTIAL_SKILL_AFFINITY_SPOT   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_PARTIAL_SKILL_AFFINITY_SPOT");
    if (GetHasFeat(FEAT_PERFECT_SELF    , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_PERFECT_SELF");
    if (GetHasFeat(FEAT_PLANT_DOMAIN_POWER  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_PLANT_DOMAIN_POWER ");
    if (GetHasFeat(FEAT_POINT_BLANK_SHOT  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_POINT_BLANK_SHOT");
    if (GetHasFeat(FEAT_POWER_ATTACK   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_POWER_ATTACK");
    if (GetHasFeat(FEAT_PROTECTION_DOMAIN_POWER   , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_PROTECTION_DOMAIN_POWER");
    if (GetHasFeat(FEAT_PURITY_OF_BODY  , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_PURITY_OF_BODY");
    if (GetHasFeat(FEAT_QUICK_TO_MASTER  , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_QUICK_TO_MASTER ");
    if (GetHasFeat(FEAT_QUICKEN_SPELL , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_QUICKEN_SPELL ");
    if (GetHasFeat(FEAT_QUIVERING_PALM  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_QUIVERING_PALM ");
    if (GetHasFeat(FEAT_RAPID_SHOT  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_RAPID_SHOT");
    if (GetHasFeat(FEAT_REMOVE_DISEASE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_REMOVE_DISEASE");
    if (GetHasFeat(FEAT_RESIST_NATURES_LURE, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_RESIST_NATURES_LURE");
    if (GetHasFeat(FEAT_SAP , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SAP");
    if (GetHasFeat(FEAT_SHIELD_PROFICIENCY , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SHIELD_PROFICIENCY");
    if (GetHasFeat(FEAT_SILENCE_SPELL , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SILENCE_SPELL");
    if (GetHasFeat(FEAT_SKILL_AFFINITY_CONCENTRATION  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_AFFINITY_CONCENTRATION ");
    if (GetHasFeat(FEAT_SKILL_AFFINITY_LISTEN  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_AFFINITY_LISTEN");
    if (GetHasFeat(FEAT_SKILL_AFFINITY_LORE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_AFFINITY_LORE ");
    if (GetHasFeat(FEAT_SKILL_AFFINITY_MOVE_SILENTLY , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_AFFINITY_MOVE_SILENTLY");
    if (GetHasFeat(FEAT_SKILL_AFFINITY_SEARCH , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_AFFINITY_SEARCH");
    if (GetHasFeat(FEAT_SKILL_AFFINITY_SPOT , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_AFFINITY_SPOT");
    if (GetHasFeat(FEAT_SKILL_FOCUS_ANIMAL_EMPATHY , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_ANIMAL_EMPATHY");
    if (GetHasFeat(FEAT_SKILL_FOCUS_CONCENTRATION  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_CONCENTRATION ");
    if (GetHasFeat(FEAT_SKILL_FOCUS_DISABLE_TRAP  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_DISABLE_TRAP");
    if (GetHasFeat(FEAT_SKILL_FOCUS_DISCIPLINE , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_DISCIPLINE");
    if (GetHasFeat(FEAT_SKILL_FOCUS_HEAL  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_HEAL");
    if (GetHasFeat(FEAT_SKILL_FOCUS_HIDE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_HIDE ");
    if (GetHasFeat(FEAT_SKILL_FOCUS_LISTEN , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_LISTEN");
    if (GetHasFeat(FEAT_SKILL_FOCUS_LORE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_LORE ");
    if (GetHasFeat(FEAT_SKILL_FOCUS_MOVE_SILENTLY , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_MOVE_SILENTLY");
    if (GetHasFeat(FEAT_SKILL_FOCUS_OPEN_LOCK , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_OPEN_LOCK");
    if (GetHasFeat(FEAT_SKILL_FOCUS_PARRY  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_PARRY");
    if (GetHasFeat(FEAT_SKILL_FOCUS_PERFORM  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_PERFORM");
    if (GetHasFeat(FEAT_SKILL_FOCUS_PERSUADE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_PERSUADE");
    if (GetHasFeat(FEAT_SKILL_FOCUS_PICK_POCKET , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_PICK_POCKET");
    if (GetHasFeat(FEAT_SKILL_FOCUS_SEARCH  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_SEARCH");
    if (GetHasFeat(FEAT_SKILL_FOCUS_SET_TRAP  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_SET_TRAP");
    if (GetHasFeat(FEAT_SKILL_FOCUS_SPELLCRAFT , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_SPELLCRAFT");
    if (GetHasFeat(FEAT_SKILL_FOCUS_SPOT  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_SPOT");
    if (GetHasFeat(FEAT_SKILL_FOCUS_TAUNT  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SKILL_FOCUS_TAUNT ");
    if (GetHasFeat(FEAT_SKILL_FOCUS_USE_MAGIC_DEVICE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_FOCUS_USE_MAGIC_DEVICE");
    if (GetHasFeat(FEAT_SKILL_MASTERY , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SKILL_MASTERY");
    if (GetHasFeat(FEAT_SLIPPERY_MIND , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SLIPPERY_MIND ");
    if (GetHasFeat(FEAT_SMITE_EVIL , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SMITE_EVIL");
    if (GetHasFeat(FEAT_SNEAK_ATTACK , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SNEAK_ATTACK");
    if (GetHasFeat(FEAT_SPELL_FOCUS_ABJURATION , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SPELL_FOCUS_ABJURATION");
    if (GetHasFeat(FEAT_SPELL_FOCUS_CONJURATION  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SPELL_FOCUS_CONJURATION");
    if (GetHasFeat(FEAT_SPELL_FOCUS_DIVINATION  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SPELL_FOCUS_DIVINATION");
    if (GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SPELL_FOCUS_ENCHANTMENT");
    if (GetHasFeat(FEAT_SPELL_FOCUS_EVOCATION , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SPELL_FOCUS_EVOCATION");
    if (GetHasFeat(FEAT_SPELL_FOCUS_ILLUSION , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SPELL_FOCUS_ILLUSION");
    if (GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_SPELL_FOCUS_NECROMANCY");
    if (GetHasFeat(FEAT_SPELL_FOCUS_TRANSMUTATION , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SPELL_FOCUS_TRANSMUTATION ");
    if (GetHasFeat(FEAT_SPELL_PENETRATION , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SPELL_PENETRATION ");
    if (GetHasFeat(FEAT_STILL_MIND , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_STILL_MIND");
    if (GetHasFeat(FEAT_STILL_SPELL  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_STILL_SPELL");
    if (GetHasFeat(FEAT_STONECUNNING , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_STONECUNNING");
    if (GetHasFeat(FEAT_STRENGTH_DOMAIN_POWER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_STRENGTH_DOMAIN_POWER");
    if (GetHasFeat(FEAT_STUNNING_FIST , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_STUNNING_FIST");
    if (GetHasFeat(FEAT_SUMMON_FAMILIAR , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_SUMMON_FAMILIAR");
    if (GetHasFeat(FEAT_SUN_DOMAIN_POWER, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_SUN_DOMAIN_POWER");
    if (GetHasFeat(FEAT_TOUGHNESS , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_TOUGHNESS");
    if (GetHasFeat(FEAT_TRACKLESS_STEP , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_TRACKLESS_STEP");
    if (GetHasFeat(FEAT_TRAVEL_DOMAIN_POWER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_TRAVEL_DOMAIN_POWER");
    if (GetHasFeat(FEAT_TRICKERY_DOMAIN_POWER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_TRICKERY_DOMAIN_POWER");
    if (GetHasFeat(FEAT_TURN_UNDEAD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_TURN_UNDEAD");
    if (GetHasFeat(FEAT_TWO_WEAPON_FIGHTING , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_TWO_WEAPON_FIGHTING");
    if (GetHasFeat(FEAT_UNCANNY_DODGE_1, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_UNCANNY_DODGE_1");
    if (GetHasFeat(FEAT_UNCANNY_DODGE_2, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_UNCANNY_DODGE_2");
    if (GetHasFeat(FEAT_UNCANNY_DODGE_3 , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_UNCANNY_DODGE_3");
    if (GetHasFeat(FEAT_UNCANNY_DODGE_4 , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_UNCANNY_DODGE_4");
    if (GetHasFeat(FEAT_UNCANNY_DODGE_5 , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_UNCANNY_DODGE_5");
    if (GetHasFeat(FEAT_UNCANNY_DODGE_6 , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_UNCANNY_DODGE_6");
    if (GetHasFeat(FEAT_UNCANNY_REFLEX , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_UNCANNY_REFLEX");
    if (GetHasFeat(FEAT_VENOM_IMMUNITY , oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_VENOM_IMMUNITY");
    if (GetHasFeat(FEAT_WAR_DOMAIN_POWER, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WAR_DOMAIN_POWER");
    if (GetHasFeat(FEAT_WATER_DOMAIN_POWER, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WATER_DOMAIN_POWER");
    if (GetHasFeat(FEAT_WEAPON_FINESSE  , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FINESSE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_BASTARD_SWORD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_BASTARD_SWORD");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_BATTLE_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_BATTLE_AXE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_CLUB , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_CLUB");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_CREATURE, oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_CREATURE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_DAGGER, oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_DAGGER");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_DART , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_DART");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_DIRE_MACE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_DIRE_MACE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_DOUBLE_AXE, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_FOCUS_DOUBLE_AXE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_GREAT_AXE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_SWORD, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_FOCUS_GREAT_SWORD");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_HALBERD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_HALBERD");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_HAND_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_HAND_AXE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_HEAVY_FLAIL , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_HEAVY_FLAIL");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_KAMA , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_KAMA");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_KATANA , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_KATANA");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_KUKRI , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_KUKRI");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_FLAIL, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_FOCUS_LIGHT_FLAIL");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_HAMMER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_LIGHT_HAMMER");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_LIGHT_MACE, oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_LIGHT_MAC");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_LONG_SWORD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_LONG_SWORD");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_LONGBOW , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_LONGBOW");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_MORNING_STAR , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_MORNING_STAR");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_RAPIER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_RAPIER");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SCIMITAR , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_SCIMITAR");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SCYTHE , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_FOCUS_SCYTHE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SHORT_SWORD, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_FOCUS_SHORT_SWORD");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SHORTBOW , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_SHORTBOW");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SHURIKEN, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_FOCUS_SHURIKEN");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SICKLE, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_FOCUS_SICKLE ");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SLING , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_SLING");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_SPEAR , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_SPEAR");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_STAFF , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_STAFF");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_THROWING_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_THROWING_AXE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_UNARMED_STRIKE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_UNARMED_STRIKE");
    if (GetHasFeat(FEAT_WEAPON_FOCUS_WAR_HAMMER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_FOCUS_WAR_HAMMER");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_CREATURE, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_PROFICIENCY_CREATURE");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_PROFICIENCY_DRUID");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_PROFICIENCY_ELF");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_EXOTIC , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_PROFICIENCY_EXOTIC");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_PROFICIENCY_MARTIAL");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_PROFICIENCY_MONK ");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_PROFICIENCY_ROGUE");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE, oTPC)) SendMessageToPC(oPC, "  " + "  FEAT_WEAPON_PROFICIENCY_SIMPLE");
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_WIZARD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_PROFICIENCY_WIZARD");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_BASTARD_SWORD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_BASTARD_SWORD ");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_BATTLE_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_BATTLE_AXE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_CLUB , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_CLUB");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_CREATURE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_CREATURE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DAGGER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_DAGGER");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DART , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_DART ");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DIRE_MACE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_DIRE_MACE ");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_DOUBLE_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_DOUBLE_AXE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_GREAT_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_GREAT_AXE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HALBERD  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_HALBERD");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HAND_AXE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_HAND_AXE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HEAVY_CROSSBOW , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_HEAVY_CROSSBOW");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_HEAVY_FLAIL , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_HEAVY_FLAIL");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_KAMA , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_KAMA");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_KATANA, oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_KATANA");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_KUKRI , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_KUKRI");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_CROSSBOW  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_LIGHT_CROSSBOW");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_FLAIL , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_LIGHT_FLAIL");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_HAMMER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_LIGHT_HAMMER");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LIGHT_MACE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_LIGHT_MACE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONG_SWORD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_LONG_SWORD");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_LONGBOW , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_LONGBOW");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_MORNING_STAR , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_MORNING_STAR");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_RAPIER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_RAPIER");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SCIMITAR  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_SCIMITAR");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SCYTHE , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_SCYTHE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORTBOW  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_SHORTBOW");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHURIKEN , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_SHURIKEN");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SICKLE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_SICKLE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SLING  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_SLING");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SPEAR , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_SPEAR");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_STAFF , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_STAFF ");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_THROWING_AXE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_THROWING_AXE ");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_TWO_BLADED_SWORD  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_TWO_BLADED_SWORD");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE");
    if (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER ");
    if (GetHasFeat(FEAT_WHOLENESS_OF_BODY , oTPC)) SendMessageToPC(oPC, "  " + " FEAT_WHOLENESS_OF_BODY");
    if (GetHasFeat(FEAT_WILD_SHAPE  , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WILD_SHAPE");
    if (GetHasFeat(FEAT_WOODLAND_STRIDE , oTPC)) SendMessageToPC(oPC, "  " + "FEAT_WOODLAND_STRIDE");
}


// Checks if PC has the skill and outputs with rank
void QuerySkill(int nSkill, string strSkillText, object oPC, object oTPC) {
    int nRank;
    string strFormat;
    if (GetHasSkill(nSkill, oTPC)) {
        nRank = GetSkillRank(nSkill, oTPC);
        strFormat = "  (" + IntToString(nRank) + ") " + strSkillText;
        SendMessageToPC(oPC, strFormat);
    }
}

// Lists skills the character possesses
void QuerySkills(object oPC, object oTPC) {
    QuerySkill(SKILL_ANIMAL_EMPATHY, "Animal Empathy", oPC, oTPC);
    QuerySkill(SKILL_CONCENTRATION, "Concentration", oPC, oTPC);
    QuerySkill(SKILL_DISABLE_TRAP, "Disable Trap", oPC, oTPC);
    QuerySkill(SKILL_DISCIPLINE, "Discipline", oPC, oTPC);
    QuerySkill(SKILL_HEAL, "Heal", oPC, oTPC);
    QuerySkill(SKILL_HIDE, "Hide", oPC, oTPC);
    QuerySkill(SKILL_LISTEN, "Listen", oPC, oTPC);
    QuerySkill(SKILL_LORE, "Lore", oPC, oTPC);
    QuerySkill(SKILL_MOVE_SILENTLY, "Move Silently", oPC, oTPC);
    QuerySkill(SKILL_OPEN_LOCK, "Open Lock", oPC, oTPC);
    QuerySkill(SKILL_PARRY, "Parry", oPC, oTPC);
    QuerySkill(SKILL_PERFORM, "Perform", oPC, oTPC);
    QuerySkill(SKILL_PERSUADE, "Persuade", oPC, oTPC);
    QuerySkill(SKILL_PICK_POCKET, "Pick Pocket", oPC, oTPC);
    QuerySkill(SKILL_SEARCH, "Search", oPC, oTPC);
    QuerySkill(SKILL_SET_TRAP, "Set Trap", oPC, oTPC);
    QuerySkill(SKILL_SPELLCRAFT, "Spellcraft", oPC, oTPC);
    QuerySkill(SKILL_SPOT, "Spot", oPC, oTPC);
    QuerySkill(SKILL_TAUNT, "Taunt", oPC, oTPC);
    QuerySkill(SKILL_USE_MAGIC_DEVICE, "Use Magic Device", oPC, oTPC);
    QuerySkill(SUBSKILL_EXAMINETRAP, "Examine Trap", oPC, oTPC);
    QuerySkill(SUBSKILL_FLAGTRAP, "Flag Trap", oPC, oTPC);
    QuerySkill(SUBSKILL_RECOVERTRAP, "Recover Trap", oPC, oTPC);
}

// Get the total number of effects
void QueryTotalEffects(object oPC, object oTPC) {
   effect eEffect = GetFirstEffect(GetFirstPC());
   int nTotalEffects = 0;
   string strFormat;
   while(GetIsEffectValid(eEffect)) {
      nTotalEffects++;
      eEffect = GetNextEffect(GetFirstPC());
   }
   strFormat = "TOTAL EFFECTS: " + IntToString(nTotalEffects);
   SendMessageToPC(oPC, strFormat);
}

// Returns the text-string for the type of duration on the effect
string RetrieveDurationString(effect eEffect) {
    int nEffType = GetEffectDurationType(eEffect);
    string strFormat;
    if (nEffType == -1) strFormat = " (INVALID DURATION)";
    if (nEffType == DURATION_TYPE_INSTANT) strFormat = "instant";
    if (nEffType == DURATION_TYPE_PERMANENT) strFormat = "permanent";
    if (nEffType == DURATION_TYPE_TEMPORARY) strFormat = "temporary";
    return strFormat;
}


// Returns the text-string name of the effect found
string RetrieveEffectString(int nType) {
    string strFormat;
    if (nType == EFFECT_TYPE_ABILITY_DECREASE) strFormat = "Ability Decrease";
    if (nType == EFFECT_TYPE_ABILITY_INCREASE) strFormat = "Ability Increase";
    if (nType == EFFECT_TYPE_AC_DECREASE) strFormat = "AC Decrease";
    if (nType == EFFECT_TYPE_AC_INCREASE) strFormat = "AC Increase";
    if (nType == EFFECT_TYPE_ARCANE_SPELL_FAILURE) strFormat = "Arcane Spell Failure";
    if (nType == EFFECT_TYPE_AREA_OF_EFFECT) strFormat = "Area of Effect";
    if (nType == EFFECT_TYPE_ATTACK_DECREASE) strFormat = "Attack Decrease";
    if (nType == EFFECT_TYPE_ATTACK_INCREASE ) strFormat = "Attack Increase";
    if (nType == EFFECT_TYPE_BLINDNESS) strFormat = "Blindness";
    if (nType == EFFECT_TYPE_CHARMED) strFormat = "Charmed";
    if (nType == EFFECT_TYPE_BEAM) strFormat = "Beam";
    if (nType == EFFECT_TYPE_CONCEALMENT) strFormat = "Concealment";
    if (nType == EFFECT_TYPE_CONFUSED) strFormat = "Confused";
    if (nType == EFFECT_TYPE_CURSE) strFormat = "Curse";
    if (nType == EFFECT_TYPE_DAMAGE_DECREASE) strFormat = "Damage Decrease";
    if (nType == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE) strFormat = "Damage Immunity Decrease";
    if (nType == EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE) strFormat = "Damage Immunity Increase";
    if (nType == EFFECT_TYPE_DAMAGE_INCREASE) strFormat = "Damage Increase";
    if (nType == EFFECT_TYPE_DAMAGE_REDUCTION) strFormat = "Damage Reduction";
    if (nType == EFFECT_TYPE_DAMAGE_RESISTANCE) strFormat = "Damage Resistance";
    if (nType == EFFECT_TYPE_DARKNESS) strFormat = "Darkness";
    if (nType == EFFECT_TYPE_DAZED) strFormat = "Dazed";
    if (nType == EFFECT_TYPE_DEAF) strFormat = "Deaf";
    if (nType == EFFECT_TYPE_DISEASE) strFormat = "Disease";
    if (nType == EFFECT_TYPE_DISPELMAGICALL) strFormat = "Dispell Magic All";
    if (nType == EFFECT_TYPE_DISPELMAGICBEST) strFormat = "Dispell Magic Best";
    if (nType == EFFECT_TYPE_DOMINATED) strFormat = "Dominated";
    if (nType == EFFECT_TYPE_ELEMENTALSHIELD) strFormat = "Elemental Shield";
    if (nType == EFFECT_TYPE_ENEMY_ATTACK_BONUS) strFormat = "Enemy Attack Bonus";
    if (nType == EFFECT_TYPE_ENTANGLE) strFormat = "Entangle";
    if (nType == EFFECT_TYPE_FRIGHTENED) strFormat = "Frightened";
    if (nType == EFFECT_TYPE_HASTE) strFormat = "Haste";
    if (nType == EFFECT_TYPE_IMMUNITY) strFormat = "Immunity";
    if (nType == EFFECT_TYPE_IMPROVEDINVISIBILITY) strFormat = "Improved Invisibility";
    if (nType == EFFECT_TYPE_INVALIDEFFECT) strFormat = "Invalid Effect";
    if (nType == EFFECT_TYPE_INVISIBILITY) strFormat = "Invisibility";
    if (nType == EFFECT_TYPE_INVULNERABLE) strFormat = "Invulnerable";
    if (nType == EFFECT_TYPE_MISS_CHANCE) strFormat = "Miss Chance";
    if (nType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE) strFormat = "Movement Speed Decrease";
    if (nType == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE) strFormat = "Movement Speed Increase";
    if (nType == EFFECT_TYPE_NEGATIVELEVEL) strFormat = "Negative Level";
    if (nType == EFFECT_TYPE_PARALYZE) strFormat = "Paralyze";
    if (nType == EFFECT_TYPE_POISON) strFormat = "Poison";
    if (nType == EFFECT_TYPE_POLYMORPH ) strFormat = "Polymorph";
    if (nType == EFFECT_TYPE_REGENERATE) strFormat = "Regenerate";
    if (nType == EFFECT_TYPE_RESURRECTION) strFormat = "Resurrection";
    if (nType == EFFECT_TYPE_SANCTUARY) strFormat = "Sanctuary";
    if (nType == EFFECT_TYPE_SAVING_THROW_DECREASE) strFormat = "Saving Throw Decrease";
    if (nType == EFFECT_TYPE_SAVING_THROW_INCREASE) strFormat = "Saving Throw Increase";
    if (nType == EFFECT_TYPE_SEEINVISIBLE) strFormat = "See Invisibile";
    if (nType == EFFECT_TYPE_SILENCE) strFormat = "Silence";
    if (nType == EFFECT_TYPE_SKILL_DECREASE) strFormat = "Skill Decrease";
    if (nType == EFFECT_TYPE_SKILL_INCREASE) strFormat = "Skill Increase";
    if (nType == EFFECT_TYPE_SLEEP) strFormat = "Sleep";
    if (nType == EFFECT_TYPE_SLOW) strFormat = "Slow";
    if (nType == EFFECT_TYPE_SPELL_IMMUNITY) strFormat = "Spell Immunity";
    if (nType == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE) strFormat = "Spell Resistance Decrease";
    if (nType == EFFECT_TYPE_SPELL_RESISTANCE_INCREASE) strFormat = "Spell Resistance Increase";
    if (nType == EFFECT_TYPE_SPELLLEVELABSORPTION) strFormat = "Spell Level Absorption";
    if (nType == EFFECT_TYPE_STUNNED) strFormat = "Stunned";
    if (nType == EFFECT_TYPE_TEMPORARY_HITPOINTS) strFormat = "Temporary Hitpoints";
    if (nType == EFFECT_TYPE_TIMESTOP) strFormat = "Timestop";
    if (nType == EFFECT_TYPE_TRUESEEING) strFormat = "Trueseeing";
    if (nType == EFFECT_TYPE_TURNED) strFormat = "Turned";
    if (nType == EFFECT_TYPE_ULTRAVISION) strFormat = "Ultravision";
    return strFormat;
}

// List the effects that the player has active
void QueryEffects(object oPC, object oTPC) {
   effect eEffect = GetFirstEffect(GetFirstPC());
   string strFormat;
   int nType;
   while(GetIsEffectValid(eEffect)) {
        nType = GetEffectType(eEffect);
        strFormat = " " + RetrieveEffectString(nType);
        strFormat += " set to " + RetrieveDurationString(eEffect);
        SendMessageToPC(oPC, strFormat);
        eEffect = GetNextEffect(GetFirstPC());
   }
}

void KillItemInSlot(int nSlot, object oTPC, string strBodyArea) {
    object oItem = GetItemInSlot(nSlot, oTPC);
    DestroyObject(oItem);
}

// Returns the number and name of items in an equip slot
string QuerySlot(int nSlot, object oTPC, string strBodyArea) {
    string strFormat;
    object oItem = GetItemInSlot(nSlot, oTPC);
    if (oItem == OBJECT_INVALID) return strFormat;
    string strName = GetName(oItem);
    int nItems = GetNumStackedItems(oItem);
    strFormat = strBodyArea + ": " + IntToString(nItems) + " x " + strName + " (" + GetTag(oItem) + ")";
    return strFormat;
}

// Outputs the currently equipped items
void QueryEquippedItems(object oPC, object oTPC) {
    string strFormat;

    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_ARMS, oTPC, "ARMS"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_ARROWS, oTPC, "ARROWS"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_BELT, oTPC, "BELT"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_BOLTS, oTPC, "BOLTS"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_BOOTS, oTPC, "BOOTS"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_BULLETS, oTPC, "BULLETS"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_CARMOUR, oTPC, "CARMOUR"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_CHEST, oTPC, "CHEST"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_CLOAK, oTPC, "CLOAK"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_CWEAPON_B, oTPC, "CWEAPON_B"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_CWEAPON_L, oTPC, "CWEAPON_L"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_CWEAPON_R, oTPC, "CWEAPON_R"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_HEAD, oTPC, "HEAD"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_LEFTHAND, oTPC, "LEFT HAND"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_LEFTRING, oTPC, "LEFT RING"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_NECK, oTPC, "NECK"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_RIGHTHAND, oTPC, "RIGHT HAND"));
    SendMessageToPC(oPC, QuerySlot(INVENTORY_SLOT_RIGHTRING, oTPC, "RIGHT RING"));
}

// Outputs the number of items in inventory
void QueryTotalInventory(object oPC, object oTPC) {
    int nItems = 0;
    object oItem = GetFirstItemInInventory(oTPC);
    while (GetIsObjectValid(oItem) == TRUE) {
        nItems = nItems + GetNumStackedItems(oItem);
        oItem = GetNextItemInInventory(oTPC);
    }
    string strTotal = "TOTAL ITEMS: " + IntToString(nItems);
    SendMessageToPC(oPC, strTotal);
}

// Outputs all of the equipment in Inventory
void QueryInventory(object oPC, object oTPC) {
    int nItems = 0;
    string strItem;
    object oItem = GetFirstItemInInventory(oTPC);
    while (GetIsObjectValid(oItem) == TRUE) {
        nItems = GetNumStackedItems(oItem);
        strItem = "  " + IntToString(nItems) + " x " + GetName(oItem) + "  (" + GetTag(oItem) + ")";
        SendMessageToPC(oPC, strItem);
        oItem = GetNextItemInInventory(oTPC);
    }
}

// Gets the connection and game key information
void QueryIPAddress(object oPC, object oTPC) {
    string strIPAddy = "IP ADDRESS: " + GetPCIPAddress(oTPC);
    SendMessageToPC(oPC, strIPAddy);
    strIPAddy = "CD KEY: " + GetPCPublicCDKey(oTPC);
    SendMessageToPC(oPC, strIPAddy);
}

// Outputs Ability Scores with their modifiers
void QueryAbilities(object oPC, object oCreature) {
        string strFormat;
        int nTemp;
        // Show Ability scores with modifiers
        int i;
        for (i=0; i<6; i++) {
            strFormat = "";
            if (i == ABILITY_STRENGTH) strFormat += "STR: ";
            if (i == ABILITY_DEXTERITY) strFormat += "DEX: ";
            if (i == ABILITY_CONSTITUTION) strFormat += "CON: ";
            if (i == ABILITY_INTELLIGENCE) strFormat += "INT: ";
            if (i == ABILITY_WISDOM) strFormat += "WIS: ";
            if (i == ABILITY_CHARISMA) strFormat += "CHA: ";
            nTemp = GetAbilityScore(oCreature, i);
            strFormat += IntToString(nTemp);
            strFormat += "  Mod: ";
            nTemp = GetAbilityModifier(i, oCreature);
            if (nTemp > 0) strFormat += "+";
            strFormat += IntToString(nTemp);
            SendMessageToPC(oPC, strFormat);
        }
}

void QueryVitals(object oPC, object oTPC) {
    string strFormat;
    string strTemp;
    int nTempA;
    int nTempB;

    // Armor Class
    nTempA = GetAC(oTPC);
    strFormat = "ARMOR CLASS: " + IntToString(nTempA);
    SendMessageToPC(oPC, strFormat);

    // Hitpoints
    nTempA = GetCurrentHitPoints(oTPC);
    nTempB = GetMaxHitPoints(oTPC);
    strFormat = "HIT POINTS: " + IntToString(nTempA) + " / " + IntToString(nTempB);
    SendMessageToPC(oPC, strFormat);

    // Alignment
    strFormat = "ALIGNMENT: ";
    nTempA = GetAlignmentLawChaos(oTPC);
    nTempB = GetAlignmentGoodEvil(oTPC);
    if (nTempA == ALIGNMENT_NEUTRAL && nTempB == ALIGNMENT_NEUTRAL) strFormat += "True Neutral";
    else {
        if (nTempA == ALIGNMENT_LAWFUL)  strFormat += "Lawful ";
        if (nTempA == ALIGNMENT_CHAOTIC) strFormat += "Chaotic ";
        if (nTempA == ALIGNMENT_NEUTRAL) strFormat += "Neutral ";
        if (nTempB == ALIGNMENT_GOOD) strFormat += "Good";
        if (nTempB == ALIGNMENT_EVIL) strFormat += "Evil";
        if (nTempB == ALIGNMENT_NEUTRAL) strFormat += "Neutral";
    }
    SendMessageToPC(oPC, strFormat);

    // Classes and Levels
    int nTotalLevels = 0;
    int nIndex;
    for (nIndex=1; nIndex<=3; nIndex++) nTotalLevels += GetLevelByPosition(nIndex, oTPC);
    strFormat = "TOTAL LEVELS: " + IntToString(nTotalLevels);
    SendMessageToPC(oPC, strFormat);
    for (nTempA = 1; nTempA <=3; nTempA++) {
        strFormat = "CLASS " + IntToString(nTempA) + ": ";
        strTemp = QueryClassByPosition(nTempA, oTPC);
        if (strTemp != "INVALID") { strFormat += strTemp; SendMessageToPC(oPC, strFormat); }
    }

    // Experience Points
    nTempA = GetXP(oTPC);
    strFormat = "XP: " + IntToString(nTempA);
    SendMessageToPC(oPC, strFormat);

    // Get Gold
    nTempA = GetGold(oTPC);
    strFormat = "GOLD: " + IntToString(nTempA);
    SendMessageToPC(oPC, strFormat);
}

// Outputs PC's Age, Alignment, Character Levels, Challenge Rating, Deity, Gender
// racial type, AC, movement rate, xp, gold.
void QueryMiscTraits(object oPC, object oTPC) {
    string strFormat;
    int nTempA;
    int nTempB;
    float fFloatA;

    // Age
    nTempA = GetAge(oTPC);
    strFormat = "AGE: " + IntToString(nTempA);
    SendMessageToPC(oPC, strFormat);

    // Challenge Rating
    fFloatA = GetChallengeRating(oTPC);
    SendMessageToPC(oPC, "RATED: " + FloatToString(fFloatA));

    // Movement Rate
    strFormat = "MOVE RATE: ";
    nTempA = GetMovementRate(oTPC);
    strFormat += IntToString(nTempA);
    SendMessageToPC(oPC, strFormat);

    // Diety and Gender
    strFormat = "DEITY: " + GetDeity(oTPC);
    strFormat += "GENDER: ";
    nTempA = GetGender(oTPC);
    if (nTempA == GENDER_MALE) strFormat += "Male";
    else if (nTempA == GENDER_FEMALE) strFormat += "Female";
    else strFormat += "Other";

    // Racial Type
    QueryRacialType(oPC, oTPC);
}

string QueryClassByPosition(int nPos, object oTPC) {
    int nTemp = GetClassByPosition(nPos, oTPC);
    int nLev = GetLevelByPosition(nPos, oTPC);
    string strClassLev;
    if (nTemp == CLASS_TYPE_ABERRATION) strClassLev = ("Aberration, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_ANIMAL) strClassLev = ("Animal, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_BARBARIAN) strClassLev = ("Barbarian, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_BARD) strClassLev = ("Bard, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_BEAST) strClassLev = ("Beast, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_CLERIC) strClassLev = ("Cleric, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_COMMONER) strClassLev =  ("Commoner, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_CONSTRUCT) strClassLev =  ("Construct, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_DRAGON) strClassLev =  ("Dragon, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_DRUID) strClassLev =  ("Druid, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_ELEMENTAL) strClassLev =  ("Elemental, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_FEY) strClassLev =  ("Fey, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_FIGHTER) strClassLev =  ("Fighter, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_GIANT) strClassLev =  ("Giant, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_HUMANOID) strClassLev =  ("Humanoid, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_INVALID) return "INVALID";
    if (nTemp == CLASS_TYPE_MAGICAL_BEAST) strClassLev =  ("Magical Beast, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_MONK) strClassLev =  ("MONK, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_MONSTROUS) strClassLev =  ("Monstrous, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_OUTSIDER) strClassLev =  ("Outsider, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_PALADIN) strClassLev =  ("Paladin, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_RANGER) strClassLev =  ("Ranger, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_ROGUE) strClassLev =  ("Rogue, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_SHAPECHANGER) strClassLev =  ("Shapechanger, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_SORCERER) strClassLev = ("Sorcerer, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_UNDEAD) strClassLev = ("Undead, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_VERMIN) strClassLev = ("Vermin, Level: " + IntToString(nLev));
    if (nTemp == CLASS_TYPE_WIZARD) strClassLev = ("Wizard, Level: " + IntToString(nLev));
    return strClassLev;
}

// Outputs race
void QueryRacialType(object oPC, object oTPC) {
    int nTemp = GetRacialType(oTPC);
    string strRace = "RACE: ";
    if (nTemp == RACIAL_TYPE_ABERRATION) strRace += "Aberration";
    if (nTemp == RACIAL_TYPE_ALL) strRace += "All";
    if (nTemp == RACIAL_TYPE_ANIMAL) strRace += "Animal";
    if (nTemp == RACIAL_TYPE_BEAST) strRace += "Beast";
    if (nTemp == RACIAL_TYPE_CONSTRUCT) strRace += "Construct";
    if (nTemp == RACIAL_TYPE_DRAGON) strRace += "Dragon";
    if (nTemp == RACIAL_TYPE_DWARF) strRace += "Dwarf";
    if (nTemp == RACIAL_TYPE_ELEMENTAL) strRace += "Elemental";
    if (nTemp == RACIAL_TYPE_ELF) strRace += "Elf";
    if (nTemp == RACIAL_TYPE_FEY) strRace += "Fey";
    if (nTemp == RACIAL_TYPE_GIANT) strRace += "Giant";
    if (nTemp == RACIAL_TYPE_GNOME) strRace += "Gnome";
    if (nTemp == RACIAL_TYPE_HALFELF) strRace += "Half-Elf";
    if (nTemp == RACIAL_TYPE_HALFLING) strRace += "Halfling";
    if (nTemp == RACIAL_TYPE_HALFORC) strRace += "Orc";
    if (nTemp == RACIAL_TYPE_HUMAN) strRace += "Human";
    if (nTemp == RACIAL_TYPE_HUMANOID_GOBLINOID) strRace += "Goblinoid";
    if (nTemp == RACIAL_TYPE_HUMANOID_MONSTROUS) strRace += "Monstrous";
    if (nTemp == RACIAL_TYPE_HUMANOID_ORC) strRace += "Orc";
    if (nTemp == RACIAL_TYPE_HUMANOID_REPTILIAN) strRace += "Reptilian";
    if (nTemp == RACIAL_TYPE_INVALID) strRace += "INVALID!";
    if (nTemp == RACIAL_TYPE_MAGICAL_BEAST) strRace += "Magical Beast";
    if (nTemp == RACIAL_TYPE_OUTSIDER) strRace += "Outsider";
    if (nTemp == RACIAL_TYPE_SHAPECHANGER) strRace += "Shapechanger";
    if (nTemp == RACIAL_TYPE_UNDEAD) strRace += "Undead";
    if (nTemp == RACIAL_TYPE_VERMIN) strRace += "Vermin";
    SendMessageToPC(oPC, strRace);
}

void QueryWizardMemory(object oPC, object oTPC) {
        // Cantrips
        if (GetHasSpell(SPELL_DAZE, oTPC)) SendMessageToPC(oPC, " Level 0, Daze");
        if (GetHasSpell(SPELL_LIGHT, oTPC)) SendMessageToPC(oPC, " Level 0, Light");
        if (GetHasSpell(SPELL_RAY_OF_FROST, oTPC)) SendMessageToPC(oPC, " Level 0, Ray of Frost");
        if (GetHasSpell(SPELL_RESISTANCE, oTPC)) SendMessageToPC(oPC, " Level 0, Resistance");


        // 1st Level
        if (GetHasSpell(SPELL_BURNING_HANDS, oTPC)) SendMessageToPC(oPC, " Level 1, Burning Hands");
        if (GetHasSpell(SPELL_CHARM_PERSON, oTPC)) SendMessageToPC(oPC, " Level 1, Charm Person");
        if (GetHasSpell(SPELL_COLOR_SPRAY, oTPC)) SendMessageToPC(oPC, " Level 1, Color Spray");
        if (GetHasSpell(SPELL_GREASE, oTPC)) SendMessageToPC(oPC, " Level 1, Grease");
        if (GetHasSpell(SPELL_IDENTIFY, oTPC)) SendMessageToPC(oPC, " Level 1, Identify");
        if (GetHasSpell(SPELL_MAGE_ARMOR, oTPC)) SendMessageToPC(oPC, " Level 1, Mage Armor");
        if (GetHasSpell(SPELL_MAGIC_MISSILE, oTPC)) SendMessageToPC(oPC, " Level 1, Magic Missle");
        if (GetHasSpell(SPELL_NEGATIVE_ENERGY_RAY, oTPC)) SendMessageToPC(oPC, " Level 1, Negative Energy Ray");
        if (GetHasSpell(SPELL_RAY_OF_ENFEEBLEMENT, oTPC)) SendMessageToPC(oPC, " Level 1, Ray of Enfeeblement");
        if (GetHasSpell(SPELL_SCARE, oTPC)) SendMessageToPC(oPC, " Level 1, Scare");
        if (GetHasSpell(SPELL_SLEEP, oTPC)) SendMessageToPC(oPC, " Level 1, Sleep");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_I, oTPC)) SendMessageToPC(oPC, " Level 1, Summon Creature I");

        // 2nd Level
        if (GetHasSpell(SPELL_BLINDNESS_AND_DEAFNESS, oTPC)) SendMessageToPC(oPC, " Level 2, Blindness/Deafness");
        if (GetHasSpell(SPELL_BULLS_STRENGTH, oTPC)) SendMessageToPC(oPC, " Level 2, Bulls Strength");
        if (GetHasSpell(SPELL_CATS_GRACE, oTPC)) SendMessageToPC(oPC, " Level 2, Cats Grace");
        if (GetHasSpell(SPELL_DARKNESS, oTPC)) SendMessageToPC(oPC, " Level 2, Darkness");
        if (GetHasSpell(SPELL_EAGLE_SPLEDOR, oTPC)) SendMessageToPC(oPC, " Level 2, Eagles Splendor");
        if (GetHasSpell(SPELL_ENDURANCE, oTPC)) SendMessageToPC(oPC, " Level 2, Endurance");
        if (GetHasSpell(SPELL_FOXS_CUNNING, oTPC)) SendMessageToPC(oPC, " Level 2, Foxs Cunning");
        if (GetHasSpell(SPELL_GHOSTLY_VISAGE, oTPC)) SendMessageToPC(oPC, " Level 2, Ghostly Visage");
        if (GetHasSpell(SPELL_GHOUL_TOUCH, oTPC)) SendMessageToPC(oPC, " Level 2, Ghoul Touch");
        if (GetHasSpell(SPELL_INVISIBILITY, oTPC)) SendMessageToPC(oPC, " Level 2, Inivisibility");
        if (GetHasSpell(SPELL_KNOCK, oTPC)) SendMessageToPC(oPC, " Level 2, Knock");
        if (GetHasSpell(SPELL_LESSER_DISPEL, oTPC)) SendMessageToPC(oPC, " Level 2, Lesser Dispel");
        if (GetHasSpell(SPELL_MELFS_ACID_ARROW, oTPC)) SendMessageToPC(oPC, " Level 2, Melfs Acid Arrow");
        if (GetHasSpell(SPELL_OWLS_WISDOM, oTPC)) SendMessageToPC(oPC, " Level 2, Owls Wisdom");
        if (GetHasSpell(SPELL_RESIST_ELEMENTS, oTPC)) SendMessageToPC(oPC, " Level 2, Resist Elements");
        if (GetHasSpell(SPELL_SEE_INVISIBILITY, oTPC)) SendMessageToPC(oPC, " Leve 2, See Invisibility");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_II, oTPC)) SendMessageToPC(oPC, " Level 2, Summon Creature II");
        if (GetHasSpell(SPELL_WEB, oTPC)) SendMessageToPC(oPC, " Level 2, Web");

        // 3rd Level
        if (GetHasSpell(SPELL_ANIMATE_DEAD, oTPC)) SendMessageToPC(oPC, " Level 3, Animate Dead");
        if (GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oTPC)) SendMessageToPC(oPC, " Level 3, Clairaudience/Clairvoyance");
        if (GetHasSpell(SPELL_CLARITY, oTPC)) SendMessageToPC(oPC, " Level 3, Clarity");
        if (GetHasSpell(SPELL_DISPEL_MAGIC, oTPC)) SendMessageToPC(oPC, " Level 3, Dispel Magic");
        if (GetHasSpell(SPELL_FIREBALL, oTPC)) SendMessageToPC(oPC, " Level 3, Fireball");
        if (GetHasSpell(SPELL_FLAME_ARROW, oTPC)) SendMessageToPC(oPC, " Level 3, Flame Arrow");
        if (GetHasSpell(SPELL_FIND_TRAPS, oTPC)) SendMessageToPC(oPC, " Level 3, Find Traps");
        if (GetHasSpell(SPELL_HASTE, oTPC)) SendMessageToPC(oPC, " Level 3, Haste");
        if (GetHasSpell(SPELL_HOLD_PERSON, oTPC)) SendMessageToPC(oPC, " Level 3, Hold Person");
        if (GetHasSpell(SPELL_INVISIBILITY_SPHERE, oTPC)) SendMessageToPC(oPC, " Level 3, Invisibility Sphere");
        if (GetHasSpell(SPELL_LIGHTNING_BOLT, oTPC)) SendMessageToPC(oPC, " Level 3, Lightning Bolt");
        if (GetHasSpell(SPELL_NEGATIVE_ENERGY_BURST, oTPC)) SendMessageToPC(oPC, " Level 3, Negative Energy Burst");
        if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS, oTPC)) SendMessageToPC(oPC, " Level 3, Protection from Elements");
        if (GetHasSpell(SPELL_SLOW, oTPC)) SendMessageToPC(oPC, " Level 3, Slow");
        if (GetHasSpell(SPELL_STINKING_CLOUD, oTPC)) SendMessageToPC(oPC, " Level 3, Stinking Cloud");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_III, oTPC)) SendMessageToPC(oPC, " Level 3, Summon Creature III");
        if (GetHasSpell(SPELL_VAMPIRIC_TOUCH, oTPC)) SendMessageToPC(oPC, " Level 3, Vampiric Touch");

        // 4th Level
        if (GetHasSpell(SPELL_BESTOW_CURSE, oTPC)) SendMessageToPC(oPC, " Level 4, Bestow Curse");
        if (GetHasSpell(SPELL_CHARM_MONSTER, oTPC)) SendMessageToPC(oPC, " Level 4, Charm Monster");
        if (GetHasSpell(SPELL_CONFUSION, oTPC)) SendMessageToPC(oPC, " Level 4, Confusion");
        if (GetHasSpell(SPELL_CONTAGION, oTPC)) SendMessageToPC(oPC, " Level 4, Contagion");
        if (GetHasSpell(SPELL_ENERVATION, oTPC)) SendMessageToPC(oPC, " Level 4, Enervation");
        if (GetHasSpell(SPELL_FEAR, oTPC)) SendMessageToPC(oPC, " Level 4, Fear");
        if (GetHasSpell(SPELL_ICE_STORM, oTPC)) SendMessageToPC(oPC, " Level 4, Icestorm");
        if (GetHasSpell(SPELL_IMPROVED_INVISIBILITY, oTPC)) SendMessageToPC(oPC, " Level 4, Improved Invisibility");
        if (GetHasSpell(SPELL_LESSER_SPELL_BREACH, oTPC)) SendMessageToPC(oPC, " Level 4, Lesser Spell Breach");
        if (GetHasSpell(SPELL_MINOR_GLOBE_OF_INVULNERABILITY, oTPC)) SendMessageToPC(oPC, " Level 4, Minor Globe of Invulnerability");
        if (GetHasSpell(SPELL_PHANTASMAL_KILLER, oTPC)) SendMessageToPC(oPC, " Level 4, Phantasmal Killer");
        if (GetHasSpell(SPELL_POLYMORPH_SELF, oTPC)) SendMessageToPC(oPC, " Level 4, Polymorph Self");
        if (GetHasSpell(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oTPC)) SendMessageToPC(oPC, " Level 4, Remmove Blindness/Deafness");
        if (GetHasSpell(SPELL_REMOVE_CURSE, oTPC)) SendMessageToPC(oPC, " Level 4, Remove Curse");
        if (GetHasSpell(SPELL_STONESKIN, oTPC)) SendMessageToPC(oPC, " Level 4, Stoneskin");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_IV, oTPC)) SendMessageToPC(oPC, " Level 4, Summon Creature IV");
        if (GetHasSpell(SPELL_WALL_OF_FIRE, oTPC)) SendMessageToPC(oPC, " Level 4, Wall of Fire");

        // 5th Level
        if (GetHasSpell(SPELL_CLOUDKILL, oTPC)) SendMessageToPC(oPC, " Level 5, Cloudkill");
        if (GetHasSpell(SPELL_CONE_OF_COLD, oTPC)) SendMessageToPC(oPC, " Level 5, Cone of Cold");
        if (GetHasSpell(SPELL_DISMISSAL, oTPC)) SendMessageToPC(oPC, " Level 5, Dismissal");
        if (GetHasSpell(SPELL_DOMINATE_PERSON, oTPC)) SendMessageToPC(oPC, " Level 5, Dominate Person");
        if (GetHasSpell(SPELL_ELEMENTAL_SHIELD, oTPC)) SendMessageToPC(oPC, " Level 5, Elemental Shield");
        if (GetHasSpell(SPELL_ENERGY_BUFFER, oTPC)) SendMessageToPC(oPC, " Level 5, Energy Buffer");
        if (GetHasSpell(SPELL_FEEBLEMIND, oTPC)) SendMessageToPC(oPC, " Level 5, Feeblemind");
        if (GetHasSpell(SPELL_HOLD_MONSTER , oTPC)) SendMessageToPC(oPC, " Level 5, Hold Monster");
        if (GetHasSpell(SPELL_LESSER_MIND_BLANK, oTPC)) SendMessageToPC(oPC, " Level 5, Lesser Mind Blank");
        if (GetHasSpell(SPELL_LESSER_PLANAR_BINDING, oTPC)) SendMessageToPC(oPC, " Level 5, Lesser Planar Binding");
        if (GetHasSpell(SPELL_LESSER_SPELL_MANTLE, oTPC)) SendMessageToPC(oPC, " Level 5, Lesser Spell Mantle");
        if (GetHasSpell(SPELL_MIND_FOG, oTPC)) SendMessageToPC(oPC, " Level 5, Mind Fog");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_V, oTPC)) SendMessageToPC(oPC, " Level 5, Summon Creature V");

        // 6th Level
        if (GetHasSpell(SPELL_ACID_FOG, oTPC)) SendMessageToPC(oPC, " Level 6, Acid Fod");
        if (GetHasSpell(SPELL_CHAIN_LIGHTNING, oTPC)) SendMessageToPC(oPC, " Level 6, Chain Lightning");
        if (GetHasSpell(SPELL_CIRCLE_OF_DEATH, oTPC)) SendMessageToPC(oPC, " Level 6, Circle of Death");
        if (GetHasSpell(SPELL_ETHEREAL_VISAGE, oTPC)) SendMessageToPC(oPC, " Level 6, Ethereal Visage");
        if (GetHasSpell(SPELL_GLOBE_OF_INVULNERABILITY, oTPC)) SendMessageToPC(oPC, " Level 6, Globe of Invulnerability");
        if (GetHasSpell(SPELL_GREATER_DISPELLING, oTPC)) SendMessageToPC(oPC, " Level 6, Greater Dispelling");
        if (GetHasSpell(SPELL_GREATER_SPELL_BREACH, oTPC)) SendMessageToPC(oPC, " Level 6, Spell Breach");
        if (GetHasSpell(SPELL_GREATER_STONESKIN, oTPC)) SendMessageToPC(oPC, " Level 6, Stoneskin");
        if (GetHasSpell(SPELL_LEGEND_LORE, oTPC)) SendMessageToPC(oPC, " Level 6, Legend Lore");
        if (GetHasSpell(SPELL_MASS_HASTE, oTPC)) SendMessageToPC(oPC, " Level 6, Mast Haste");
        if (GetHasSpell(SPELL_PLANAR_BINDING, oTPC)) SendMessageToPC(oPC, " Level 6, Planar Binding");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_VI, oTPC)) SendMessageToPC(oPC, " Level 6, Summon Creature VI");
        if (GetHasSpell(SPELL_TENSERS_TRANSFORMATION, oTPC)) SendMessageToPC(oPC, " Level 6, Tensers Transformation");
        if (GetHasSpell(SPELL_TRUE_SEEING , oTPC)) SendMessageToPC(oPC, " Level 6, True Seeing");

        // 7th Level
        if (GetHasSpell(SPELL_CONTROL_UNDEAD, oTPC)) SendMessageToPC(oPC, " Level 7, Control Undead");
        if (GetHasSpell(SPELL_DELAYED_BLAST_FIREBALL, oTPC)) SendMessageToPC(oPC, " Level 7, Delayed Blast Fireball");
        if (GetHasSpell(SPELL_FINGER_OF_DEATH, oTPC)) SendMessageToPC(oPC, " Level 7, Finger of Death");
        if (GetHasSpell(SPELL_MORDENKAINENS_SWORD, oTPC)) SendMessageToPC(oPC, " Level 7, Mordenkainens Sword");
        if (GetHasSpell(SPELL_POWER_WORD_STUN, oTPC)) SendMessageToPC(oPC, " Level 7, Power Word Stun");
        if (GetHasSpell(SPELL_PRISMATIC_SPRAY, oTPC)) SendMessageToPC(oPC, " Level 7, Prismatic Spray");
        if (GetHasSpell(SPELL_PROTECTION_FROM_SPELLS, oTPC)) SendMessageToPC(oPC, " Level 7, Protection from Spells");
        if (GetHasSpell(SPELL_SHADOW_SHIELD, oTPC)) SendMessageToPC(oPC, " Level 7, Shadow Shield");
        if (GetHasSpell(SPELL_SPELL_MANTLE , oTPC)) SendMessageToPC(oPC, " Level 7, Spell Mantle");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_VII, oTPC)) SendMessageToPC(oPC, " Level 7, Summon Creature VII");

        // 8th Level
        if (GetHasSpell(SPELL_CREATE_UNDEAD, oTPC)) SendMessageToPC(oPC, " Level 8, Create Undead");
        if (GetHasSpell(SPELL_GREATER_PLANAR_BINDING, oTPC)) SendMessageToPC(oPC, " Level 8, Greater Planar Binding");
        if (GetHasSpell(SPELL_HORRID_WILTING, oTPC)) SendMessageToPC(oPC, " Level 8, Horrid Wilting");
        if (GetHasSpell(SPELL_INCENDIARY_CLOUD, oTPC)) SendMessageToPC(oPC, " Level 8, Incendiary Cloud");
        if (GetHasSpell(SPELL_MASS_BLINDNESS_AND_DEAFNESS, oTPC)) SendMessageToPC(oPC, " Level 8, Mass Blindness/Deafness");
        if (GetHasSpell(SPELL_MASS_CHARM, oTPC)) SendMessageToPC(oPC, " Level 8, Charm");
        if (GetHasSpell(SPELL_MIND_BLANK, oTPC)) SendMessageToPC(oPC, " Level 8, Blank");
        if (GetHasSpell(SPELL_PREMONITION , oTPC)) SendMessageToPC(oPC, " Level 8, Premonition");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_VIII, oTPC)) SendMessageToPC(oPC, " Level 8, Summon Creature VIII");

        // 9th Level
        if (GetHasSpell(SPELL_DOMINATE_MONSTER, oTPC)) SendMessageToPC(oPC, " Level 9, Dominate Monster");
        if (GetHasSpell(SPELL_ENERGY_DRAIN, oTPC)) SendMessageToPC(oPC, " Level 9, Energy Drain");
        if (GetHasSpell(SPELL_GATE, oTPC)) SendMessageToPC(oPC, " Level 9, Gate");
        if (GetHasSpell(SPELL_GREATER_SPELL_MANTLE, oTPC)) SendMessageToPC(oPC, " Level 9, Greater Spell Mantle");
        if (GetHasSpell(SPELL_METEOR_SWARM, oTPC)) SendMessageToPC(oPC, " Level 9, Meteor Swarm");
        if (GetHasSpell(SPELL_MORDENKAINENS_DISJUNCTION, oTPC)) SendMessageToPC(oPC, " Level 9, Mordenkainens Disjunction");
        if (GetHasSpell(SPELL_POWER_WORD_KILL, oTPC)) SendMessageToPC(oPC, " Level 9, Power Word Kill");
        if (GetHasSpell(SPELL_SHAPECHANGE, oTPC)) SendMessageToPC(oPC, " Level 9, Shapechange");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_IX, oTPC)) SendMessageToPC(oPC, " Level 9, Summon Creature IX");
        if (GetHasSpell(SPELL_TIME_STOP, oTPC)) SendMessageToPC(oPC, " Level 9, Time Stop");
        if (GetHasSpell(SPELL_WAIL_OF_THE_BANSHEE, oTPC)) SendMessageToPC(oPC, " Level 9, Wail of the Banshee");
        if (GetHasSpell(SPELL_WEIRD, oTPC)) SendMessageToPC(oPC, " Level 9, Weird");
}

void QueryClericMemory(object oPC, object oTPC) {
        // Cantrips
        if (GetHasSpell(SPELL_CURE_MINOR_WOUNDS, oTPC)) SendMessageToPC(oPC, " Level 0, Cure Minor Wounds");
        if (GetHasSpell(SPELL_LIGHT, oTPC)) SendMessageToPC(oPC, " Level 0, Light");
        if (GetHasSpell(SPELL_RESISTANCE, oTPC)) SendMessageToPC(oPC, " Level 0, Resistance");
        if (GetHasSpell(SPELL_VIRTUE, oTPC)) SendMessageToPC(oPC, " Level 0, Virtue");

        // Level 1
        if (GetHasSpell(SPELL_BLESS, oTPC)) SendMessageToPC(oPC, " Level 1, Bless");
        if (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, oTPC)) SendMessageToPC(oPC, " Level 1, Cure Light Wounds");
        if (GetHasSpell(SPELL_DOOM, oTPC)) SendMessageToPC(oPC, " Level 1, Doom");
        if (GetHasSpell(SPELL_REMOVE_FEAR, oTPC)) SendMessageToPC(oPC, " Level 1, Remove Fear");
        if (GetHasSpell(SPELL_SANCTUARY, oTPC)) SendMessageToPC(oPC, " Level 1, Sanctuary");
        if (GetHasSpell(SPELL_SCARE, oTPC)) SendMessageToPC(oPC, " Level 1, Scare");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_I, oTPC)) SendMessageToPC(oPC, " Level 1, Summon Creature I");

        // Level 2
        if (GetHasSpell(SPELL_AID, oTPC)) SendMessageToPC(oPC, " Level 2, Aid");
        if (GetHasSpell(SPELL_BULLS_STRENGTH, oTPC)) SendMessageToPC(oPC, " Level 2, Bless");
        if (GetHasSpell(SPELL_DARKNESS, oTPC)) SendMessageToPC(oPC, " Level 2, Darkness");
        if (GetHasSpell(SPELL_EAGLE_SPLEDOR, oTPC)) SendMessageToPC(oPC, " Level 2, Eagle Splendor");
        if (GetHasSpell(SPELL_ENDURANCE, oTPC)) SendMessageToPC(oPC, " Level 2, Endurance");
        if (GetHasSpell(SPELL_FIND_TRAPS, oTPC)) SendMessageToPC(oPC, " Level 2, Find Traps");
        if (GetHasSpell(SPELL_FOXS_CUNNING, oTPC)) SendMessageToPC(oPC, " Level 2, Foxs Cunning");
        if (GetHasSpell(SPELL_HOLD_PERSON, oTPC)) SendMessageToPC(oPC, " Level 2, Hold Person");
        if (GetHasSpell(SPELL_LESSER_DISPEL, oTPC)) SendMessageToPC(oPC, " Level 2, Lesser Dispel");
        if (GetHasSpell(SPELL_LESSER_RESTORATION, oTPC)) SendMessageToPC(oPC, " Level 2, Lesser Restoration");
        if (GetHasSpell(SPELL_NEGATIVE_ENERGY_RAY, oTPC)) SendMessageToPC(oPC, " Level 2, Negative Energy");
        if (GetHasSpell(SPELL_OWLS_WISDOM, oTPC)) SendMessageToPC(oPC, " Level 2, Owls Wisdom");
        if (GetHasSpell(SPELL_REMOVE_PARALYSIS, oTPC)) SendMessageToPC(oPC, " Level 2, Remove Paralysis");
        if (GetHasSpell(SPELL_RESIST_ELEMENTS, oTPC)) SendMessageToPC(oPC, " Level 2, Resist Elements");
        if (GetHasSpell(SPELL_SILENCE, oTPC)) SendMessageToPC(oPC, " Level 2, Silence");
        if (GetHasSpell(SPELL_SOUND_BURST, oTPC)) SendMessageToPC(oPC, " Level 2, Sound Burst");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_II, oTPC)) SendMessageToPC(oPC, " Level 2, Summon Creature II");

        // Level 3
        if (GetHasSpell(SPELL_ANIMATE_DEAD, oTPC)) SendMessageToPC(oPC, " Level 3, Animate Dead");
        if (GetHasSpell(SPELL_BESTOW_CURSE, oTPC)) SendMessageToPC(oPC, " Level 3, Bestow Curse");
        if (GetHasSpell(SPELL_BLINDNESS_AND_DEAFNESS, oTPC)) SendMessageToPC(oPC, " Level 3, Blindness/Deafness");
        if (GetHasSpell(SPELL_CLARITY, oTPC)) SendMessageToPC(oPC, " Level 3, Clarity");
        if (GetHasSpell(SPELL_CONTAGION, oTPC)) SendMessageToPC(oPC, " Level 3, Contagion");
        if (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS, oTPC)) SendMessageToPC(oPC, " Level 3, Cure Serious Wounds");
        if (GetHasSpell(SPELL_DISPEL_MAGIC, oTPC)) SendMessageToPC(oPC, " Level 3, Dispel Magic");
        if (GetHasSpell(SPELL_INVISIBILITY_PURGE, oTPC)) SendMessageToPC(oPC, " Level 3, Invisibility Purge");
        if (GetHasSpell(SPELL_NEGATIVE_ENERGY_PROTECTION, oTPC)) SendMessageToPC(oPC, " Level 3, Negative Energy Protection");
        if (GetHasSpell(SPELL_PRAYER, oTPC)) SendMessageToPC(oPC, " Level 3, Prayer");
        if (GetHasSpell(SPELL_PROTECTION_FROM_ELEMENTS, oTPC)) SendMessageToPC(oPC, " Leve 3, Protection from Elements");
        if (GetHasSpell(SPELL_REMOVE_BLINDNESS_AND_DEAFNESS, oTPC)) SendMessageToPC(oPC, " Level 3, Remove Blindness/Deafness");
        if (GetHasSpell(SPELL_REMOVE_CURSE, oTPC)) SendMessageToPC(oPC, " Level 3, Remove Curse");
        if (GetHasSpell(SPELL_REMOVE_DISEASE, oTPC)) SendMessageToPC(oPC, " Level 3, Remove Disease");
        if (GetHasSpell(SPELL_SEARING_LIGHT, oTPC)) SendMessageToPC(oPC, " Level 3, Searing Light");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_III, oTPC)) SendMessageToPC(oPC, " Level 3, Summon Creature III");

        // Level 4
        if (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS, oTPC)) SendMessageToPC(oPC, " Level 4, Cure Critical Wounds");
        if (GetHasSpell(SPELL_DEATH_WARD, oTPC)) SendMessageToPC(oPC, " Level 4, Death Ward");
        if (GetHasSpell(SPELL_DISMISSAL, oTPC)) SendMessageToPC(oPC, " Level 4, Dismissal");
        if (GetHasSpell(SPELL_DIVINE_POWER, oTPC)) SendMessageToPC(oPC, " Level 4, Divine Power");
        if (GetHasSpell(SPELL_FLAME_STRIKE, oTPC)) SendMessageToPC(oPC, " Level 4, Flame Strike");
        if (GetHasSpell(SPELL_FREEDOM_OF_MOVEMENT, oTPC)) SendMessageToPC(oPC, " Level 4, Freedom of Movement");
        if (GetHasSpell(SPELL_NEUTRALIZE_POISON, oTPC)) SendMessageToPC(oPC, " Level 4, Neutralize Poison");
        if (GetHasSpell(SPELL_POISON, oTPC)) SendMessageToPC(oPC, " Level 4, Poison");
        if (GetHasSpell(SPELL_RESTORATION, oTPC)) SendMessageToPC(oPC, " Level 4, Restoration");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_IV, oTPC)) SendMessageToPC(oPC, " Level 4, Summon Creature IV");

        // Level 5
        if (GetHasSpell(SPELL_HEALING_CIRCLE, oTPC)) SendMessageToPC(oPC, " Level 5, Healing Circle");
        if (GetHasSpell(SPELL_RAISE_DEAD, oTPC)) SendMessageToPC(oPC, " Level 5, Raise Dead");
        if (GetHasSpell(SPELL_SLAY_LIVING, oTPC)) SendMessageToPC(oPC, " Level 5, Slay Living");
        if (GetHasSpell(SPELL_SPELL_RESISTANCE, oTPC)) SendMessageToPC(oPC, " Leve 5, Spell Resistance");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_V, oTPC)) SendMessageToPC(oPC, " Level 5, Summon Creature V");
        if (GetHasSpell(SPELL_SHADOW_CONJURATION_SUMMON_SHADOW, oTPC)) SendMessageToPC(oPC, " Level 5, Summon Shadow");

        // Level 6
        if (GetHasSpell(SPELL_BLADE_BARRIER, oTPC)) SendMessageToPC(oPC, " Level 6, Blade Barrier");
        if (GetHasSpell(SPELL_CREATE_UNDEAD, oTPC)) SendMessageToPC(oPC, " Level 6, Create Undead");
        if (GetHasSpell(SPELL_GREATER_DISPELLING, oTPC)) SendMessageToPC(oPC, " Level 6, Greater Dispelling");
        if (GetHasSpell(SPELL_HARM, oTPC)) SendMessageToPC(oPC, " Level 6, Harm");
        if (GetHasSpell(SPELL_HEAL, oTPC)) SendMessageToPC(oPC, " Level 6, Heal");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_VI, oTPC)) SendMessageToPC(oPC, " Level 6, Summon Creature VI");

        // Level 7
        if (GetHasSpell(SPELL_DESTRUCTION, oTPC)) SendMessageToPC(oPC, " Level 7, Destruction");
        if (GetHasSpell(SPELL_REGENERATE, oTPC)) SendMessageToPC(oPC, " Level 7, Regenerate");
        if (GetHasSpell(SPELL_RESURRECTION, oTPC)) SendMessageToPC(oPC, " Level 7, Resurrection");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_VII, oTPC)) SendMessageToPC(oPC, " Level 7, Summon Creature VII");
        if (GetHasSpell(SPELL_WORD_OF_FAITH, oTPC)) SendMessageToPC(oPC, " Level 7, Word of Faith");

        // Level 8
        if (GetHasSpell(SPELL_AURA_OF_VITALITY, oTPC)) SendMessageToPC(oPC, " Level 8, Aura of Vitality");
        if (GetHasSpell(SPELL_CREATE_GREATER_UNDEAD, oTPC)) SendMessageToPC(oPC, " Level 8, Create Greater Undead");
        if (GetHasSpell(SPELL_FIRE_STORM, oTPC)) SendMessageToPC(oPC, " Level 8, Fire Storm");
        if (GetHasSpell(SPELL_MASS_HEAL, oTPC)) SendMessageToPC(oPC, " Level 8, Mass Heal");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_VIII, oTPC)) SendMessageToPC(oPC, " Level 8, Summon Creature VIII");
        if (GetHasSpell(SPELL_SUNBEAM, oTPC)) SendMessageToPC(oPC, " Level 8, Sunbeam");

        // Level 9
        if (GetHasSpell(SPELL_ENERGY_DRAIN, oTPC)) SendMessageToPC(oPC, " Level 9, Energy Drain");
        if (GetHasSpell(SPELL_GATE, oTPC)) SendMessageToPC(oPC, " Level 9, Gate");
        if (GetHasSpell(SPELL_IMPLOSION, oTPC)) SendMessageToPC(oPC, " Level 9, Implosion");
        if (GetHasSpell(SPELL_STORM_OF_VENGEANCE, oTPC)) SendMessageToPC(oPC, " Level 9, Storm of Vengeance");
        if (GetHasSpell(SPELL_SUMMON_CREATURE_IX, oTPC)) SendMessageToPC(oPC, " Level 9, Summon Creature IX");
}

void WandofRemoval(object oPC, object oTarget) {
        SendMessageToPC(oPC, "Wand of Removal - revision " + strWRemovVer);
        SendMessageToPC(oPC, "-----------------------------");
        // Remove every item from the target player
        object oItem = GetFirstItemInInventory(oTarget);
        while (GetIsObjectValid(oItem)) {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory(oTarget);
        }
        // Destroy equipped items
        KillItemInSlot(INVENTORY_SLOT_ARMS, oTarget, "ARMS");
        KillItemInSlot(INVENTORY_SLOT_ARROWS, oTarget, "ARROWS");
        KillItemInSlot(INVENTORY_SLOT_BELT, oTarget, "BELT");
        KillItemInSlot(INVENTORY_SLOT_BOLTS, oTarget, "BOLTS");
        KillItemInSlot(INVENTORY_SLOT_BOOTS, oTarget, "BOOTS");
        KillItemInSlot(INVENTORY_SLOT_BULLETS, oTarget, "BULLETS");
        KillItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget, "CARMOUR");
        KillItemInSlot(INVENTORY_SLOT_CHEST, oTarget, "CHEST");
        KillItemInSlot(INVENTORY_SLOT_CLOAK, oTarget, "CLOAK");
        KillItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget, "CWEAPON_B");
        KillItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget, "CWEAPON_L");
        KillItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget, "CWEAPON_R");
        KillItemInSlot(INVENTORY_SLOT_HEAD, oTarget, "HEAD");
        KillItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget, "LEFT HAND");
        KillItemInSlot(INVENTORY_SLOT_LEFTRING, oTarget, "LEFT RING");
        KillItemInSlot(INVENTORY_SLOT_NECK, oTarget, "NECK");
        KillItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget, "RIGHT HAND");
        KillItemInSlot(INVENTORY_SLOT_RIGHTRING, oTarget, "RIGHT RING");

        // Take all gold
        AssignCommand(oTarget, TakeGoldFromCreature(GetGold(oTarget), oTarget, TRUE));

        // Handout some basic equipment
        SetIdentified(CreateItemOnObject("NW_IT_MPOTION003", oTarget, 10), TRUE);
        SetIdentified(CreateItemOnObject("NW_IT_MPOTION012", oTarget, 3), TRUE);
        SetIdentified(CreateItemOnObject("NW_IT_MPOTION004", oTarget, 5), TRUE);
        SetIdentified(CreateItemOnObject("PotionofStoneskin", oTarget, 2), TRUE);
        SetIdentified(CreateItemOnObject("NW_IT_RECALL", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_IT_MEDKIT004", oTarget, 8), TRUE);
        SetIdentified(CreateItemOnObject("NW_IT_TRAP006", oTarget, 3), TRUE);
        SetIdentified(CreateItemOnObject("NW_IT_TRAP007", oTarget, 2), TRUE);
        SetIdentified(CreateItemOnObject("NW_MAARCL079", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_CLOTH005", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_ASHMSW009", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WAMMAR002", oTarget, 99), TRUE);
        SetIdentified(CreateItemOnObject("NW_WAMMBO005", oTarget, 99), TRUE);
        SetIdentified(CreateItemOnObject("NW_WAXMGR009", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WBWMSH009", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WBWMXL009", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WSWMLS012", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WBLMFL011", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WMGWN002", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WMGWN009", oTarget, 1), TRUE);
        SetIdentified(CreateItemOnObject("NW_WSWMDG009", oTarget, 1), TRUE);
        ExportAllCharacters();
}


