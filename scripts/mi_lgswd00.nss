////////////////////////////////////////////////////////////////////////////////
// The Answerer Script                                                        //
// On hit, decrease AC by -2 and lower magical resistances by 5               //
//                                                                            //
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

    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {
        case X2_ITEM_EVENT_ONHITCAST:
            // * This code runs when the item has the 'OnHitCastSpell: Unique power' property
            // * and it hits a target(if it is a weapon) or is being hit (if it is a piece of armor)
            // * Note that this event fires for non PC creatures as well.

            oItem  =  GetSpellCastItem();               // The item triggering this spellscript
            oPC = OBJECT_SELF;                            // The player triggering it
            oSpellOrigin = OBJECT_SELF ;               // Where the spell came from
            oSpellTarget = GetSpellTargetObject();  // What the spell is aimed at

            //Your code goes here
            effect eEffect;
            eEffect = EffectACDecrease(2);
            effect eVis = EffectVisualEffect(VFX_IMP_AURA_NEGATIVE_ENERGY); //Sets up Visual Effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oSpellTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oSpellTarget); // Decreases AC by 2
            eEffect = EffectSpellResistanceDecrease(5);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oSpellTarget); // Decreases Spell Resistance by 5

            break;

    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

