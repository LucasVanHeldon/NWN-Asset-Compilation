////////////////////////////////////////////////////////////////////////////////
// Tint'eina Petals                                                           //
// Adds 6 to bluff, intimidate, appraise, persuade and perform skills         //
// The effects last one hour                                                  //
// Copyright (c) 2003 Bioware Corp.                                           //
////////////////////////////////////////////////////////////////////////////////
/*
    This is an example of how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works if
    the following scripts are set in your
    module events

    OnEquip      - x2_mod_def_equ   (or mi_zep_onequip)
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Georg Zoeller                                                  //
// Created On: 2003-09-10                                                     //
// Modified By: Grimlar and Arikel Tolifen                                    //
// Modified On: July 2005                                                     //
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();    //Which event triggered this
    object oPC;                                                           //The player character using the item
    object oItem;                                                        //The item being used
    object oSpellOrigin;                                               //The origin of the spell
    object oSpellTarget;                                              //The target of the spell
    int iSpell;                                                             //The Spell ID number
    effect eEffect;
    effect eVis;
    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {

        case X2_ITEM_EVENT_ACTIVATE:
// * This code runs when the Unique Power property of the item is used or the item
// * is activated. Note that this event fires for PCs only

            oPC   = GetItemActivator();                 // The player who activated the item
            oItem = GetItemActivated();               // The item that was activated

            //Your code goes here
            if (!GetIsPC(GetItemActivatedTarget())
            ){

            SendMessageToPC(GetItemActivator(), "Improper use of item!");
            return;}


            eEffect = EffectSkillIncrease(SKILL_BLUFF, 6); //Increases Bluff Skill by 6
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);

            eEffect = EffectSkillIncrease(SKILL_APPRAISE, 6); //Increases Appraise Skill by 6
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);

            eEffect = EffectSkillIncrease(SKILL_INTIMIDATE, 6); //Increases Intimidate Skill by 6
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);

            eEffect = EffectSkillIncrease(SKILL_PERSUADE, 6); //Increases Persuade Skill by 6
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);

            eEffect = EffectSkillIncrease(SKILL_PERFORM, 6); //Increases Perform Skill by 6
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);

            eVis = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE); //Applies Etheral Visage Effect for 1 hour
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oPC, 60.0f);

            break;
    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

