#include "g_common"
#include "g_wands"
void Wand_WandOfArrays(object oPC);
void Wand_WandOfAbsorption(object oAbsorber, object oVictim);

////////////////////////////////////////////////////////////////////////////////
// Main OnActivate Handler /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void OnActivateProc() {
    object oItem    = GetItemActivated();            // What item?
    object oPC      = GetItemActivator();            // What PC?
    object oTarget  = GetItemActivatedTarget();      // What target PC?
    string strItem  = GetTag(oItem);                 // Get the game-tag for the item
    effect eVisualA;                                 // For any visual effects that may be needed
    effect eVisualB;                                 // For any visual effects that may be needed
    effect eVisualC;                                 // For any visual effects that may be needed
    effect eRealA;                                   // For any effects meants to modify something
    effect eRealB;                                   // For any effects meants to modify something
    effect eRealC;                                   // For any effects meants to modify something
    effect eRealD;                                   // For any effects meants to modify something
    effect eRealE;                                   // For any effects meants to modify something
    effect eRealF;                                   // For any effects meants to modify something
    effect eRealG;                                   // For any effects meants to modify something
    effect eRealH;                                   // For any effects meants to modify something
    effect eRealI;                                   // For any effects meants to modify something
    effect eRealJ;                                   // For any effects meants to modify something

    // KEEP THESE AT THE TOP!!!!!
    if (strItem == "WandofAbsorp") Wand_WandOfAbsorption(oPC, oPC);
    if (strItem == "WandofArrays") Wand_WandOfArrays(oPC);

    // Mask of Talquin
    if (strItem == "cu_miscothr068") OnActivate_Misc_MaskOfTalquin(oItem, oPC, oTarget);

    // Ring of blinking
    if (strItem == "cu_jewel106") OnActivate_Jewelry_RingOfBlinking(oItem, oPC, oTarget);

    // Oil of Acid Resistance
    if (strItem == "cu_potion111") if (!BlockMultiActivation(strItem, oTarget, nDurMega)) OnActivate_Potion_OilOfResistance(oItem, oPC, oTarget, DAMAGE_TYPE_ACID);

    // Oil of Frost Resistance
    if (strItem == "cu_potion112") if (!BlockMultiActivation(strItem, oTarget, nDurMega)) OnActivate_Potion_OilOfResistance(oItem, oPC, oTarget, DAMAGE_TYPE_COLD);

    // Oil of Electrical Resistance
    if (strItem == "cu_potion113") if (!BlockMultiActivation(strItem, oTarget, nDurMega)) OnActivate_Potion_OilOfResistance(oItem, oPC, oTarget, DAMAGE_TYPE_ELECTRICAL);

    // Oil of Divine Resistance
    if (strItem == "cu_potion114") if (!BlockMultiActivation(strItem, oTarget, nDurMega)) OnActivate_Potion_OilOfResistance(oItem, oPC, oTarget, DAMAGE_TYPE_DIVINE);

    // Draught of Life
    if (strItem == "cu_potion218") OnActivate_Potion_DraughtOfLife(oItem, oPC, oTarget);

    // Elixir of Health
    if (strItem == "cu_potion110") OnActivate_Potion_ElixirOfHealth(oItem, oPC, oTarget);

    // Copper Coins
    if (strItem == "cu_gold001") Treasure_ExchangeFundsForGold(oPC, oItem, EXCHANGE_RATE_COPPER);

    // Silver Coins
    if (strItem == "cu_gold002") Treasure_ExchangeFundsForGold(oPC, oItem, EXCHANGE_RATE_SILVER);

    // Electrum Coins
    if (strItem == "cu_gold003") Treasure_ExchangeFundsForGold(oPC, oItem, EXCHANGE_RATE_ELECTRUM);

    // Gold Coins
    if (strItem == "cu_gold004") Treasure_ExchangeFundsForGold(oPC, oItem, EXCHANGE_RATE_GOLD);

    // Platinum Coins
    if (strItem == "cu_gold005") Treasure_ExchangeFundsForGold(oPC, oItem, EXCHANGE_RATE_PLATINUM);

    // Thectus Spider Bite (Special Ability on its Hide)
    if (strItem == "it_creitem008") {
        FloatingTextStringOnCreature("Activating", oPC);
    }
    // Drunkards Aid
    if(strItem == "cu_potion027") {
        if (BlockMultiActivation(strItem, oTarget, nDurLong)) return;
        SetLocalInt(oTarget, "iAlcohol_Immune", TRUE);
        AssignCommand(oTarget, DelayCommand(nDurLong, SetLocalInt(oTarget, "iAlcohol_Immune", FALSE)));
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);

        // Apply the FX
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
    }
    // Travellers Aid
    if(strItem == "cu_potion026") {
        if (BlockMultiActivation(strItem, oTarget, nDurGiga)) return;
        SetLocalInt(oTarget, "iFoodSys_Immune", TRUE);
        AssignCommand(oTarget, DelayCommand(nDurGiga, SetLocalInt(oTarget, "iFoodSys_Immune", FALSE)));
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);

        // Apply the FX
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
    }
    // Nostrum of Verdure
    if(strItem == "cu_potion109") {
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
        eRealA = EffectAbilityIncrease(ABILITY_CONSTITUTION, 1);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMega);   //  12 minutes
    }
    // Potion of Bodily Health
    if(strItem == "cu_potion025") {
        if (BlockMultiActivation(strItem, oTarget, nDurGiga)) return;
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
        eRealA = EffectAbilityIncrease(ABILITY_CONSTITUTION, 1);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurGiga);   //  24 minutes
    }
    // Wand of Levels
    if(strItem == "wandoflevels") {
        int iIndex;
        int iLevel = 0;
        for(iIndex=1; iIndex<=3; iIndex++) iLevel += GetLevelByPosition(iIndex, oPC);
        int iXP = iLevel * 1000;
        GiveXPToCreature(oPC, iXP);
    }
    // Potion of Cloud Giant Strength
    if(strItem == "cu_potion102") {
        if (BlockMultiActivation(strItem, oTarget, nDurSupr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_FROST_L);
        eRealA = EffectAbilityIncrease(ABILITY_STRENGTH, 6);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurSupr);   //  6 minutes
    }
    // Potion of Storm Giant Strength
    if(strItem == "cu_potion215") {
        if (BlockMultiActivation(strItem, oTarget, nDurSupr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_PULSE_WIND);
        eRealA = EffectAbilityIncrease(ABILITY_STRENGTH, 7);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurSupr);   //  6 minutes
    }
    // Lesser Potion of Striking
    if(strItem == "cu_potion001") {
        if (BlockMultiActivation(strItem, oTarget, nDurUltr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_BREACH);
        eRealA = EffectAttackIncrease(3, ATTACK_BONUS_MISC);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurUltr);   //  3 minutes
    }
    // Potion of Striking
    if(strItem == "cu_potion216") {
        if (BlockMultiActivation(strItem, oTarget, nDurSupr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_BREACH);
        eRealA = EffectAttackIncrease(6, ATTACK_BONUS_MISC);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurSupr);   //  6 minutes
    }
    if(strItem == "cu_weap108") {
        if (BlockMultiActivation(strItem, oTarget, nDurLong)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_DESTRUCTION);
        eRealA = EffectAttackIncrease(12, ATTACK_BONUS_MISC);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurLong);   //  3 minutes
    }
    // Lesser Ripping Potion
    if(strItem == "cu_potion002") {
        if (BlockMultiActivation(strItem, oTarget, nDurLong)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_DESTRUCTION);
        eRealA = EffectDamageIncrease(3);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurLong);   //  1.5 minutes
    }
    // Ripping Potion
    if(strItem == "cu_potion217") {
        if (BlockMultiActivation(strItem, oTarget, nDurUltr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_DESTRUCTION);
        eRealA = EffectDamageIncrease(8);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurUltr);   //  3 minutes
    }
    // Bucknard's Everfull Purse
    if(strItem == "BucknardsEverfullPurse") {
        if (BlockMultiActivation(strItem, oTarget, nDurGiga)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_MAGBLUE);

        // Apply them
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        int nRand = Random(100);
        if (nRand <= 80) GiveGoldToCreature(oPC, (d100() + Random(300)));   // Give gold
        else {      // Give Gems
            nRand = Random(15);
            string strItemTag = String_AddDigits("NW_IT_GEM0", nRand);
            CreateItemOnObject(strItemTag, oPC, d6());
        }
    }
    // Thieves Tools
    if (strItem == "ThievesTools") {
        SendMessageToPC(oPC, "Thieves Tools - Revision 1.00");

        // Create the Tools
        object oInvis = CreateObjectAtDistance(OBJECT_TYPE_PLACEABLE, oPC, "thievestools", 1.5);
        AssignCommand(oInvis, DelayCommand(1.0, ActionStartConversation(oPC)));
    }
    // Scribe's Kit (Wizards Only)
    if (strItem == "ScribesKit") {
        SendMessageToPC(oPC, "Scribes Kit - Revision 1.30");

        // Create the Invis Scribe Kit
        location lPC = GetLocation(oPC);
        // object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "scribeskit", lPC);
        object oInvis = CreateObjectAtDistance(OBJECT_TYPE_PLACEABLE, oPC, "scribeskit", 1.0);
        AssignCommand(oInvis, DelayCommand(1.0, ActionStartConversation(oPC)));
    }
    // Alchemists Equipment
    if (strItem == "AlchemistsEquipment") {
        SendMessageToPC(oPC, "Alchemists Equipment - Revision 1.14");

        // Create the Alchem Kit
        object oInvis = CreateObjectAtDistance(OBJECT_TYPE_PLACEABLE, oPC, "alchemistsequipm", 1.5);
        AssignCommand(oInvis, DelayCommand(1.0, ActionStartConversation(oPC)));
    }
    // Potion of Regeneration
    if (strItem == "cu_potion107") {
        if (BlockMultiActivation(strItem, oTarget, nDurMega)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_GOOD_HELP);
        eRealA = EffectRegenerate(3, nDurMega);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMega);   //  12 minutes
    }
    // Potion of Distortion
    if (strItem == "cu_potion212") {
        if (BlockMultiActivation(strItem, oTarget, nDurSupr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_DUR_BLUR);
        eRealA = EffectACIncrease((4 + d4()));

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisualA, oTarget, nDurSupr);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurSupr);   //  6 minutes
    }
    if (strItem == "cu_potion201") {
        if (BlockMultiActivation(strItem, oTarget, nDurMega)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        int nHitPoints = 20 + Random(5 * (GetLevelByPosition(1, oPC)));
        eRealA = EffectTemporaryHitpoints(nHitPoints);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMega);   //  12 minutes
    }
    if (strItem == "cu_potion206") {
        if (BlockMultiActivation(strItem, oTarget, nDurLong)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_MAGIC_PROTECTION);
        eRealA = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 90);
        eRealB = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 90);
        eRealC = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 90);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurLong);   //  90 seconds
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurLong);   //  90 seconds
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, nDurLong);   //  90 seconds
    }
    if (strItem == "cu_potion205") {
        if (BlockMultiActivation(strItem, oTarget, nDurMedm)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_FLAME_M);
        eRealA = EffectAttackIncrease(5);
        eRealB = EffectDamageIncrease(DAMAGE_BONUS_1d10, DAMAGE_TYPE_PIERCING);
        eRealC = EffectACIncrease(5, AC_DODGE_BONUS, DAMAGE_TYPE_PIERCING);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMedm);   //  30 seconds
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurMedm);   //  30 seconds
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, nDurMedm);   //  30 seconds
    }
    if (strItem == "cu_potion200") {
        if (BlockMultiActivation(strItem, oTarget, nDurUltr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
        eRealA = EffectSpellResistanceIncrease(55);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisualA, oTarget, nDurUltr);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealA, oTarget, nDurUltr);   //  3 minutes
    }
    if (strItem == "cu_potion207") {
        if (BlockMultiActivation(strItem, oTarget, nDurSupr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        eRealA = EffectMovementSpeedIncrease(99);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealA, oTarget, nDurSupr);   //  6 minutes
    }
    if (strItem == "cu_potion204") {
        if (BlockMultiActivation(strItem, oTarget, nDurMega)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_HEAD_MIND);
        eRealA = Effect_SetAbilityScore(21, oTarget, ABILITY_INTELLIGENCE);
        eRealB = EffectImmunity(IMMUNITY_TYPE_CHARM);
        eRealC = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
        eRealD = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealA, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealB, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealC, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealD, oTarget, nDurMega);   //  12 minutes
    }
    if (strItem == "cu_potion202") {
        if (BlockMultiActivation(strItem, oTarget, nDurMega)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_DEATH_L);
        eRealA = EffectAbilityIncrease(ABILITY_STRENGTH, 3);
        eRealB = EffectImmunity(IMMUNITY_TYPE_ATTACK_DECREASE);
        eRealC = EffectImmunity(IMMUNITY_TYPE_CRITICAL_HIT);
        eRealD = EffectImmunity(IMMUNITY_TYPE_STUN);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealA, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealB, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealC, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealD, oTarget, nDurMega);   //  12 minutes
    }
    if (strItem == "cu_potion100") {
        if (BlockMultiActivation(strItem, oTarget, nDurMega)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
        eRealA = EffectAbilityIncrease(ABILITY_WISDOM, 3);
        eRealB = EffectImmunity(IMMUNITY_TYPE_CONFUSED);
        eRealC = EffectImmunity(IMMUNITY_TYPE_DEATH);
        eRealD = EffectImmunity(IMMUNITY_TYPE_TRAP);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealA, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealB, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealC, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRealD, oTarget, nDurMega);   //  12 minutes
    }
    if (strItem == "cu_potion208") {
        if (BlockMultiActivation(strItem, oTarget, nDurMega)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        int nHitPoints = Random(25 * (GetLevelByPosition(1, oPC)));
        eRealA = EffectTemporaryHitpoints(nHitPoints);
        eRealB = EffectSavingThrowIncrease(SAVING_THROW_ALL, 5);
        eRealC = EffectACIncrease(3);
        eRealD = EffectSkillIncrease(SKILL_ALL_SKILLS, 2);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMega);   //  12 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurUltr);   //  3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, nDurUltr);   //  3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealD, oTarget, nDurLong);   //  1.5 minutes
    }
    if (strItem == "cu_potion213") {
        if (BlockMultiActivation(strItem, oTarget, nDurSupr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_EVIL_HELP);
        eRealA = EffectSkillIncrease(SKILL_HIDE, 5);
        eRealB = EffectSkillIncrease(SKILL_LISTEN, 5);
        eRealC = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 5);
        eRealD = EffectSkillIncrease(SKILL_OPEN_LOCK, 5);
        eRealE = EffectSkillIncrease(SKILL_DISABLE_TRAP, 5);
        eRealF = EffectSkillIncrease(SKILL_SPOT, 5);
        eRealG = EffectSkillIncrease(SKILL_PICK_POCKET, 5);
        eRealH = EffectSkillIncrease(SKILL_SEARCH, 5);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMedm);   //  90 seconds
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurMedm);   //  90 seconds
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, nDurLong);   //  1.5 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealD, oTarget, nDurLong);   //  1.5 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealE, oTarget, nDurUltr);   //  3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealF, oTarget, nDurUltr);   //  3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealG, oTarget, nDurUltr);   //  3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealH, oTarget, nDurSupr);   //  6 minutes
    }
    if (strItem == "cu_potion104") {
        if (BlockMultiActivation(strItem, oTarget, nDurUltr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_HEAD_ODD);
        eRealA = EffectSkillIncrease(SKILL_SPOT, 3);
        eRealB = EffectSkillIncrease(SKILL_SEARCH, 3);
        eRealC = EffectSkillIncrease(SKILL_LISTEN, 6);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        AssignCommand(oPC, ActionCastSpellAtObject(SPELL_FIND_TRAPS, oPC, METAMAGIC_ANY, TRUE, 0, TRUE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurUltr);   //  6 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurUltr);   //  6 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, nDurUltr);   //  6 minutes
    }
    if (strItem == "cu_potion203") {
        if (BlockMultiActivation(strItem, oTarget, nDurUltr)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_MAGBLUE);
        eRealA = EffectSkillIncrease(SKILL_CONCENTRATION, 4);
        eRealB = EffectSkillIncrease(SKILL_LORE, 15);
        eRealC = EffectSkillIncrease(SKILL_SPELLCRAFT, 7);
        eRealD = EffectSpellImmunity(SPELL_ALL_SPELLS);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurSupr);   //  3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurUltr);   //  6 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, nDurSupr);   //  3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealD, oTarget, nDurShrt);   //  15 seconds
    }
    if (strItem == "cu_potion000") {
        if (BlockMultiActivation(strItem, oTarget, nDurExxa)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
        eRealA = EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, 7);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurExxa);   //  78 minutes
    }
    if (strItem == "cu_potion209") {
        if (BlockMultiActivation(strItem, oTarget, nDurGiga)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_DUR_MAGIC_RESISTANCE);
        eRealA = EffectSpellImmunity(SPELL_ALL_SPELLS);
        eRealB = EffectSpellResistanceIncrease(30);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisualA, oTarget, nDurGiga);  // 24 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurLong);   //  1.5 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurGiga);   //  24 minutes
    }
    if (strItem == "cu_potion210") {
        if (BlockMultiActivation(strItem, oTarget, nDurGiga)) return;
        // Get effects
        int nPCHits = GetMaxHitPoints(oPC);
        eVisualA = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
        eVisualB = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
        eRealA = EffectDamageReduction(15, DAMAGE_POWER_PLUS_FIVE, 250 + (2 * Random(nPCHits)));
        eRealB = EffectACIncrease(6);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisualA, oTarget, nDurGiga);  // 24 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisualB, oTarget, nDurGiga);  // 24 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurGiga);  // 24 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurGiga);  // 24 minutes
    }
    if (strItem == "cu_potion214") {
        if (BlockMultiActivation(strItem, oTarget, nDurMega)) return;
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_SONIC);
        eRealA = EffectSpellResistanceIncrease(10);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisualA, oTarget, nDurMega);  // 12 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMega);  // 12 minutes
    }
    if (strItem == "cu_potion106") {
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_POISON_L);
        eRealA = EffectImmunity(IMMUNITY_TYPE_POISON);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurMega);  // 12 minutes
    }
    if (strItem == "cu_potion108") {
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION);
        eRealA = EffectImmunity(IMMUNITY_TYPE_BLINDNESS);
        eRealB = EffectImmunity(IMMUNITY_TYPE_DEAFNESS);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurSupr);  // 6 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurSupr);  // 6 minutes
    }
    if (strItem == "cu_potion105") {
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        eRealA = EffectImmunity(IMMUNITY_TYPE_DAZED);
        eRealB = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
        eRealC = EffectImmunity(IMMUNITY_TYPE_STUN);

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurUltr);  // 3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, nDurUltr);  // 3 minutes
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, nDurUltr);  // 3 minutes
    }
    if (strItem == "cu_scroll009") {
        // Read the scroll
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
        eVisualB = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oPC);

        // 8 hit dice of monsters for three rounds per level of the caster
        float nDur = IntToFloat(18 * GetLevelByPosition(1, oPC));     // 1 round = 6 seconds; 3 rounds per level = 18 * Level
        int nTHP = 64;
        location lLoc = GetItemActivatedTargetLocation(); // GetLocation(oPC);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisualB, lLoc);
        int nSpecies = Random(3);
        int nType;
        object oMonster;
        if (nSpecies == 0) {    // Goblins
            while (nTHP > 3) {
                if (nTHP > 17) {
                    nType = Random(2);
                    if (nType == 0) { nTHP = nTHP-18; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_gobchiefa", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                    if (nType == 1) { nTHP = nTHP-18; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_gobwiza", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                }
                if (nTHP > 3) {
                    nTHP = nTHP-4; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_gobchiefa", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur));
                }
            }
         }
        else if (nSpecies == 1) {   // Bugbears
            while (nTHP > 17) {
                nType = Random(3);
                if (nType == 0 && nTHP > 29) { nTHP = nTHP-30; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugchiefa", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 20) { nTHP = nTHP-21; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugwiza", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 17) { nTHP = nTHP-18; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugbeara", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 2) {   // Orcs
            while (nTHP > 3) {
                nType = Random(3);
                if (nType == 0 && nTHP > 20) { nTHP = nTHP-21; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_orca", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 17) { nTHP = nTHP-18; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_orcchiefb", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 4) { nTHP = nTHP-4; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_orcwiza", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
    }
    if (strItem == "cu_scroll010") {
        // Read the scroll
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
        eVisualB = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oPC);

        // 16 hit dice of monsters for three rounds per level of the caster
        float nDur = IntToFloat(18 * GetLevelByPosition(1, oPC));     // 1 round = 6 seconds; 3 rounds per level = 18 * Level
        int nTHP = 128;
        location lLoc = GetItemActivatedTargetLocation(); // GetLocation(oPC);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisualB, lLoc);
        int nSpecies = Random(3);
        int nType;
        object oMonster;
        if (nSpecies == 0) {    // Bugbears
            while (nTHP > 17) {
                nType = Random(3);
                if (nType == 0 && nTHP > 29) { nTHP = nTHP-30; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugchiefa", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 20) { nTHP = nTHP-21; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugwiza", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 17) { nTHP = nTHP-18; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugbeara", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 1) {   // Lizard Folk
            nTHP = nTHP-28; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldchiefa", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur));
            while (nTHP > 8) {
                nType = Random(3);
                if (nType == 0 && nTHP > 21) { nTHP = nTHP-22; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldmageb", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 15) { nTHP = nTHP-16; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldmagea", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 8) { nTHP = nTHP-9; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldwarb", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 2) {   // Minotaurs
            while (nTHP > 3) {
                nType = Random(3);
                if (nType == 0 && nTHP > 26) { nTHP = nTHP-27; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minotaur", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 65) { nTHP = nTHP-66; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minchief", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 57) { nTHP = nTHP-58; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minwiz", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
    }
    if (strItem == "cu_scroll101") {
        // Read the scroll
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION);
        eVisualB = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oPC);

        // 24 hit dice of monsters for three rounds per level of the caster
        float nDur = IntToFloat(18 * GetLevelByPosition(1, oPC));     // 1 round = 6 seconds; 3 rounds per level = 18 * Level
        int nTHP = 200;
        location lLoc = GetItemActivatedTargetLocation(); // GetLocation(oPC);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisualB, lLoc);
        int nSpecies = Random(3);
        int nType;
        object oMonster;
        if (nSpecies == 0) {    // Bugbears
            while (nTHP > 17) {
                nType = Random(3);
                if (nType == 0 && nTHP > 29) { nTHP = nTHP-30; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugchiefa", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 20) { nTHP = nTHP-21; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugwiza", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 17) { nTHP = nTHP-18; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_bugbeara", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
       else if (nSpecies == 1) {   // Lizard Folk
            nTHP = nTHP-28; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldchiefa", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur));
            while (nTHP > 8) {
                nType = Random(3);
                if (nType == 0 && nTHP > 21) { nTHP = nTHP-22; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldmageb", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 15) { nTHP = nTHP-16; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldmagea", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 8) { nTHP = nTHP-9; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_oldwarb", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 2) {   // Minotaurs
            while (nTHP > 3) {
                nType = Random(3);
                if (nType == 0 && nTHP > 26) { nTHP = nTHP-27; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minotaur", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 65) { nTHP = nTHP-66; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minchief", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 57) { nTHP = nTHP-58; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minwiz", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
    }
    if (strItem == "cu_scroll200") {
        // Read the scroll
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION);
        eVisualB = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oPC);

        // 32 hit dice of monsters for three rounds per level of the caster
        float nDur = IntToFloat(18 * GetLevelByPosition(1, oPC));     // 1 round = 6 seconds; 3 rounds per level = 18 * Level
        int nTHP = 256;
        location lLoc = GetItemActivatedTargetLocation(); // GetLocation(oPC);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisualB, lLoc);
        int nSpecies = Random(3);
        int nType;
        object oMonster;
        if (nSpecies == 0) {    // Minotaurs
            while (nTHP > 3) {
                nType = Random(3);
                if (nType == 0 && nTHP > 26) { nTHP = nTHP-27; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minotaur", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 65) { nTHP = nTHP-66; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minchief", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 57) { nTHP = nTHP-58; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minwiz", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 1) {   // Ogres
            while (nTHP > 21) {
                nType = Random(4);
                if (nType == 0 && nTHP > 43) { nTHP = nTHP-44; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogrechief01", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 99) { nTHP = nTHP-100; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogreboss", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 21) { nTHP = nTHP-22; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogremage01", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 3;
                if (nType == 3 && nTHP > 187) { nTHP = nTHP-188; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogremageboss", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 2) {   // Bears
            while (nTHP > 35) {
                nType = Random(3);
                if (nType == 0 && nTHP > 53) { nTHP = nTHP-54; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogrechief01", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 35) { nTHP = nTHP-36; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogreboss", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 249) { nTHP = nTHP-250; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogremage01", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 3;
            }
        }
    }
    if (strItem == "cu_scroll100") {
        // Read the scroll
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
        eVisualB = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oPC);

        // 48 hit dice of monsters for three rounds per level of the caster
        float nDur = IntToFloat(18 * GetLevelByPosition(1, oPC));     // 1 round = 6 seconds; 3 rounds per level = 18 * Level
        int nTHP = 384;
        location lLoc = GetItemActivatedTargetLocation(); // GetLocation(oPC);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisualB, lLoc);
        int nSpecies = Random(3);
        int nType;
        object oMonster;
        if (nSpecies == 0) {    // Ogres
            while (nTHP > 21) {
                nType = Random(4);
                if (nType == 0 && nTHP > 43) { nTHP = nTHP-44; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogrechief01", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 99) { nTHP = nTHP-100; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogreboss", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 21) { nTHP = nTHP-22; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogremage01", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 3;
                if (nType == 3 && nTHP > 187) { nTHP = nTHP-188; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_ogremageboss", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 1) {   // Giants
            while (nTHP > 53) {
                nType = Random(3);
                if (nType == 0 && nTHP > 62) { nTHP = nTHP-63; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_gntfrost", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 66) { nTHP = nTHP-67; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_gntfire", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 53) { nTHP = nTHP-54; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_gntmount", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
            }
        }
        else if (nSpecies == 2) {   // Powerful Minotaurs
            while (nTHP > 43) {
                nType = Random(3);
                if (nType == 0 && nTHP > 225) { nTHP = nTHP-226; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minotaurboss", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 1;
                if (nType == 1 && nTHP > 43) { nTHP = nTHP-44; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minogon", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 2;
                if (nType == 2 && nTHP > 65) { nTHP = nTHP-66; oMonster = CreateObject(OBJECT_TYPE_CREATURE, "nw_minchief", lLoc); ChangeToStandardFaction(oMonster, STANDARD_FACTION_DEFENDER); AssignCommand(GetArea(oPC), DestroyObject(oMonster, nDur)); }
                else nType = 3;
            }
        }
    }
    if (strItem == "WandofScrying") WandofScrying(oPC, oTarget);
    if (strItem == "WandofXRays") WandofXRays(oPC, oTarget);
    if (strItem == "WandofRemoval") WandofRemoval(oPC, oTarget);
    if (strItem == "cu_scroll001") {
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION);

        // Get the alignment of the target
        string strFormat;
        int nTempA = GetAlignmentLawChaos(oTarget);
        int nTempB = GetAlignmentGoodEvil(oTarget);
        if (nTempA == ALIGNMENT_NEUTRAL && nTempB == ALIGNMENT_NEUTRAL) strFormat = "I sense... True Neutral";
        else {
            if (nTempA == ALIGNMENT_LAWFUL)  strFormat = "I sense... Lawful ";
            if (nTempA == ALIGNMENT_CHAOTIC) strFormat = "I sense... Chaotic ";
            if (nTempA == ALIGNMENT_NEUTRAL) strFormat = "I sense... Neutral ";
            if (nTempB == ALIGNMENT_GOOD) strFormat += "good";
            if (nTempB == ALIGNMENT_EVIL) strFormat += "evil";
            if (nTempB == ALIGNMENT_NEUTRAL) strFormat += "neutral";
        }

        // Apply effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        FloatingTextStringOnCreature(strFormat, oPC, FALSE);
    }
    if (strItem == "cu_scroll002") {
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);

        // Get the alignment of the target
        string strFormat;
        int nTempB = GetAlignmentGoodEvil(oTarget);
        if (nTempB == ALIGNMENT_GOOD) strFormat = "I sense... goodness";
        if (nTempB == ALIGNMENT_EVIL) strFormat = "I sense... evil";
        if (nTempB == ALIGNMENT_NEUTRAL) strFormat = "I sense... neutrality";

        // Apply effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        FloatingTextStringOnCreature(strFormat, oPC, FALSE);
    }
    if (strItem == "cu_scroll003") {
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);

        // Get the alignment of the target
        string strFormat;
        int nTempA = GetAlignmentLawChaos(oTarget);
        if (nTempA == ALIGNMENT_LAWFUL)  strFormat = "I sense... lawfulness";
        if (nTempA == ALIGNMENT_CHAOTIC) strFormat = "I sense... chaos";
        if (nTempA == ALIGNMENT_NEUTRAL) strFormat = "I sense... neutrality";

        // Apply effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        FloatingTextStringOnCreature(strFormat, oPC, FALSE);
    }
    ////////////////////////////////////////////////////////////////////////////
    // Poison potions                                                         //
    ////////////////////////////////////////////////////////////////////////////
    if (FindSubString(strItem, "cu_poison") != -1) {   // Actually do the script now!!!
        // Get effects
        eVisualA = EffectVisualEffect(VFX_IMP_RESTORATION_LESSER);
        int nRand = Random(6);
        if (nRand == 0) {
            nRand = Random(10);
            if (nRand == 0) eRealA = EffectPoison(POISON_BLUE_WHINNIS);
            if (nRand == 1) eRealA = EffectPoison(POISON_GIANT_WASP_POISON);
            if (nRand == 2) eRealA = EffectPoison(POISON_LARGE_SPIDER_VENOM);
            if (nRand == 3) eRealA = EffectPoison(POISON_NIGHTSHADE);
            if (nRand == 4) eRealA = EffectPoison(POISON_BLOODROOT);
            if (nRand == 5) eRealA = EffectPoison(POISON_ARSENIC);
            if (nRand == 6) eRealA = EffectPoison(POISON_ARANEA_VENOM);
            if (nRand == 7) eRealA = EffectPoison(POISON_PIT_FIEND_ICHOR);
            if (nRand == 8) eRealA = EffectPoison(POISON_SASSONE_LEAF_RESIDUE);
            if (nRand == 9) eRealA = EffectPoison(POISON_SMALL_CENTIPEDE_POISON);
        }
        if (nRand == 1) {
            nRand = Random(17);
            if (nRand == 0) eRealA = EffectDisease(DISEASE_BLINDING_SICKNESS);
            if (nRand == 1) eRealA = EffectDisease(DISEASE_BURROW_MAGGOTS);
            if (nRand == 2) eRealA = EffectDisease(DISEASE_CACKLE_FEVER);
            if (nRand == 3) eRealA = EffectDisease(DISEASE_DEMON_FEVER);
            if (nRand == 4) eRealA = EffectDisease(DISEASE_DEVIL_CHILLS);
            if (nRand == 5) eRealA = EffectDisease(DISEASE_DREAD_BLISTERS);
            if (nRand == 6) eRealA = EffectDisease(DISEASE_FILTH_FEVER);
            if (nRand == 7) eRealA = EffectDisease(DISEASE_GHOUL_ROT);
            if (nRand == 8) eRealA = EffectDisease(DISEASE_MINDFIRE);
            if (nRand == 9) eRealA = EffectDisease(DISEASE_MUMMY_ROT);
            if (nRand == 10) eRealA = EffectDisease(DISEASE_RED_ACHE);
            if (nRand == 11) eRealA = EffectDisease(DISEASE_RED_SLAAD_EGGS);
            if (nRand == 12) eRealA = EffectDisease(DISEASE_SHAKES);
            if (nRand == 13) eRealA = EffectDisease(DISEASE_SLIMY_DOOM);
            if (nRand == 14) eRealA = EffectDisease(DISEASE_SOLDIER_SHAKES);
            if (nRand == 15) eRealA = EffectDisease(DISEASE_VERMIN_MADNESS);
            if (nRand == 16) eRealA = EffectDisease(DISEASE_ZOMBIE_CREEP);
        }
        if (nRand == 2) eRealA = EffectBlindness();
        if (nRand == 3) eRealA = EffectDeaf();
        if (nRand == 4) eRealA = EffectNegativeLevel(d8());
        if (nRand == 5) {
            nRand = Random(11);
            if (nRand == 0) eRealA = EffectPolymorph(POLYMORPH_TYPE_BADGER);
            if (nRand == 1) eRealA = EffectPolymorph(POLYMORPH_TYPE_BOAR);
            if (nRand == 2) eRealA = EffectPolymorph(POLYMORPH_TYPE_COW);
            if (nRand == 3) eRealA = EffectPolymorph(POLYMORPH_TYPE_DIRE_BOAR);
            if (nRand == 4) eRealA = EffectPolymorph(POLYMORPH_TYPE_IMP);
            if (nRand == 5) eRealA = EffectPolymorph(POLYMORPH_TYPE_PENGUIN);
            if (nRand == 6) eRealA = EffectPolymorph(POLYMORPH_TYPE_PIXIE);
            if (nRand == 7) eRealA = EffectPolymorph(POLYMORPH_TYPE_QUASIT);
            if (nRand == 8) eRealA = EffectPolymorph(POLYMORPH_TYPE_TROLL);
            if (nRand == 9) eRealA = EffectPolymorph(POLYMORPH_TYPE_WOLF);
            if (nRand == 10) eRealA = EffectPolymorph(POLYMORPH_TYPE_ZOMBIE);
        }

        // Apply them
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, nDurUltr);  // 3 minutes
        FloatingTextStringOnCreature("GAH! It was foul!!!", oTarget, FALSE);
    }
    if (strItem == "FeniasCharm") {
        // Get max hits
        int iMaxHP = GetMaxHitPoints(oPC) * 2;

        // Get duration for effects
        int iTotalLevels = 0;
        int iIndex;
        for (iIndex = 1; iIndex<4; iIndex++) iTotalLevels += GetLevelByPosition(iIndex, oPC);
        float fFCDur = IntToFloat(iTotalLevels);
        fFCDur *= 2.0;  // 2 seconds extra per level
        fFCDur += nDurLong;

        // Do visual effects
        eVisualA = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        eVisualB = EffectVisualEffect(VFX_IMP_MAGIC_PROTECTION);
        eVisualC = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualB, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualC, oTarget);

        // Double HP's and Heal User
        eRealA = EffectACIncrease(iTotalLevels, AC_ARMOUR_ENCHANTMENT_BONUS);
        eRealB = EffectAttackIncrease(4);;
        eRealC = EffectTemporaryHitpoints(iMaxHP);
        eRealD = EffectHeal(iMaxHP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oTarget, fFCDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oTarget, fFCDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oTarget, fFCDur);
    }
    // Potion of Divine Intervention
    if(strItem == "cu_potion024") {
        // Get Effects
        int iLevel = GetLevelByPosition(1, oPC);
        float fDur = 45.0 + (IntToFloat(Random(6 * iLevel)));
        eVisualA = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
        eVisualB = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        eVisualC = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
        eRealA = Effect_SetAbilityScore(20, oPC, ABILITY_STRENGTH);  // Effect for setting strength to a given value
        eRealB = EffectTemporaryHitpoints(d8(iLevel));
        eRealC = EffectAttackIncrease(2);
        eRealD = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_FEAR);
        eRealE = EffectDamageIncrease(1);
        eRealF = EffectSkillIncrease(SKILL_SPOT, 10);
        eRealG = EffectSkillIncrease(SKILL_LISTEN, 10);
        eRealH = EffectSkillIncrease(SKILL_LORE, 10);
        eRealI = EffectHeal(40 + d10(4));
        eRealJ = EffectRegenerate(2, 1.0);
        // Apply the Visual effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualA, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualB, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualB, oPC);
        // Apply the Real effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealA, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealB, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealC, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealD, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealE, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealF, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealG, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealH, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealI, oPC, fDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRealJ, oPC, fDur);
    }
    // Was it a food item???
    int iPlaySound = 0;
    if (strItem == "cu_food000") { iPlaySound = 2; CreateItemOnObject("supplies", oPC, (d20(2) + d4(10))); }   // Meat
    if (strItem == "cu_food001") { iPlaySound = 1; CreateItemOnObject("supplies", oPC, d4());}                 // Garlic
    if (strItem == "cu_food002") { iPlaySound = 2; CreateItemOnObject("supplies", oPC, (d20() + d4(8))); }     // Fish
    if (strItem == "cu_food003") { iPlaySound = 3; CreateItemOnObject("supplies", oPC, d8()); FoodSys_Drunk_EffectDrunk(oPC); }                 // Ale
    if (strItem == "cu_food004") { iPlaySound = 3; CreateItemOnObject("supplies", oPC, d10()); FoodSys_Drunk_EffectDrunk(oPC); }               // Spirits
    if (strItem == "cu_food005") { iPlaySound = 3; CreateItemOnObject("supplies", oPC, d6());  FoodSys_Drunk_EffectDrunk(oPC); }               // Wine
    if (strItem == "cu_food006") { iPlaySound = 2; CreateItemOnObject("supplies", oPC, d10(4)); }              // Bread
    if (strItem == "cu_food007" || strItem == "cu_reag021") { iPlaySound = 3; CreateItemOnObject("supplies", oPC, d2());}                 // Water
    if (strItem == "cu_reag000") { iPlaySound = 1; CreateItemOnObject("supplies", oPC, d4());  }               // Acorns
    if (strItem == "cu_reag104") { iPlaySound = 2; CreateItemOnObject("supplies", oPC, d4(2)); }              // Falcon's Egg
    if (strItem == "cu_reag007") { iPlaySound = 2; CreateItemOnObject("supplies", oPC, d2()); }                // Hollyhock Petals
    if (strItem == "cu_reag005") { iPlaySound = 1; CreateItemOnObject("supplies", oPC, d4()); }                // Fenberry
    if (strItem == "cu_reag008") { iPlaySound = 3; CreateItemOnObject("supplies", oPC, d2(2)); }               // Holy Water
    if (strItem == "cu_reag009") { iPlaySound = 3; CreateItemOnObject("supplies", oPC, d2(2)); }               // Holy Water
    if (strItem == "cu_reag010") { iPlaySound = 1; CreateItemOnObject("supplies", oPC, d4()); }                // Milkweed Pod
    if (strItem == "cu_reag314") { iPlaySound = 2; CreateItemOnObject("supplies", oPC, d20(2)); }              // Minotaur Heart
    if (strItem == "cu_reag315") { iPlaySound = 2; CreateItemOnObject("supplies", oPC, d20(2)); }              // Minotaur Tongue
    if (strItem == "cu_reag012") { iPlaySound = 1; CreateItemOnObject("supplies", oPC, d4(3)); }               // Ruc'Tara Fruit
    if (strItem == "cu_reag022") { iPlaySound = 1; CreateItemOnObject("supplies", oPC, d2(4)); }               // Volcanis Oak Seed
    if (strItem == "cu_reag025") { iPlaySound = 1; CreateItemOnObject("supplies", oPC, d8(10)); }              // Yaxy Fruit
    if (iPlaySound == 1) AssignCommand(oPC, PlaySound("eatcrnch"));
    if (iPlaySound == 2) AssignCommand(oPC, PlaySound("Eatsoft"));
    if (iPlaySound == 3) AssignCommand(oPC, PlaySound("gui_potiondrink"));
}

////////////////////////////////////////////////////////////////////////////////
// Wand of Arrays Main Function ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void Wand_WandOfArrays(object oPC) {
    string strArray;
        // Build the array
        strArray = Array_AddElement("One", strArray);
        strArray = Array_AddElement("Two", strArray);
        strArray = Array_AddElement("Three", strArray);
        strArray = Array_AddElement("Four", strArray);
        strArray = Array_AddElement("Five", strArray);
        AssignCommand(oPC, SpeakString(strArray));
        // Count the elements
        int iSize = Array_GetTotalElements(strArray);
        AssignCommand(oPC, SpeakString("There are " + IntToString(iSize) + " array elements."));
        // Read the elements
        int iIndex;
        for (iIndex=0; iIndex<iSize; iIndex++) {
            string strElement = Array_GetElement(iIndex, strArray);
            AssignCommand(oPC, SpeakString("Element #" + IntToString(iIndex) + " is " + strElement));
        }
        // Remove some elements
        int iRand = Random(iSize);
        SendMessageToPC(oPC, "Removing element " + IntToString(iRand) + ": ('" + strArray + "')");
        strArray = Array_RemoveElement(iRand, strArray);
        SendMessageToPC(oPC, "After removal: ('" + strArray + "')");
        iSize = Array_GetTotalElements(strArray);
        SendMessageToPC(oPC, "Size now: " + IntToString(iSize));

        iRand = Random(iSize);
        SendMessageToPC(oPC, "Removing element " + IntToString(iRand) + ": ('" + strArray + "')");
        strArray = Array_RemoveElement(iRand, strArray);
        SendMessageToPC(oPC, "After removal: ('" + strArray + "')");
        iSize = Array_GetTotalElements(strArray);
        SendMessageToPC(oPC, "Size now: " + IntToString(iSize));
}

////////////////////////////////////////////////////////////////////////////////
// Wand of Absorption Main Function ////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void Wand_WandOfAbsorption(object oAbsorber, object oVictim) {
    Effect_AbsorbSpellMemory(oAbsorber, oVictim);
    string strAbsorbedSpells = GetLocalString(oAbsorber, "strAbsorbedSpells");
    SendMessageToPC(oVictim, "Array of Absorbed Spell IDs: '" + strAbsorbedSpells + "'");
}




