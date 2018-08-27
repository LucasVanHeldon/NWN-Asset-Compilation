////////////////////////////////////////////////////////////////////////////////
// Halfling Leaf Script                                                       //
// Adds +1 to Cha for 1 hour.                                                 //
// Non Halflings must make DC(24), or get -1 to Int and effect dazed for dur. //
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
    effect eEffect;                                                  // Effect
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
            || (GetObjectType(GetItemActivatedTarget())!=OBJECT_TYPE_CREATURE)
            ){

            SendMessageToPC(GetItemActivator(), "You can't smoke right now!");
            return;}

                if ((GetRacialType(oPC)==RACIAL_TYPE_HALFLING))
                {
                effect eVis = EffectVisualEffect(VFX_FNF_SMOKE_PUFF); //Sets up Visual Effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
                eEffect = EffectAbilityIncrease(ABILITY_CHARISMA, 1);
                eEffect = ExtraordinaryEffect(eEffect);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);
                }
                else if (FortitudeSave(oPC, 24))
                {
                effect eVis = EffectVisualEffect(VFX_FNF_SMOKE_PUFF); //Sets up Visual Effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
                eEffect = EffectAbilityIncrease(ABILITY_CHARISMA, 1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);
                }
            else
            {
            effect eVis = EffectVisualEffect(VFX_FNF_SMOKE_PUFF); //Sets up Visual Effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            eEffect = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);
            eEffect = EffectAbilityIncrease(ABILITY_CHARISMA, 1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 60.0f);
            eEffect = EffectDazed();
            eEffect = ExtraordinaryEffect(eEffect);
            effect eVis1 = EffectVisualEffect(VFX_IMP_DAZED_S); //Sets up Visual Effect
            effect eLink = EffectLinkEffects(eEffect, eVis1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 60.0f);
            }

            break;

    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

