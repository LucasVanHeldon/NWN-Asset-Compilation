//::///////////////////////////////////////////////
//:: Henchman Death Script
//::
//:: NW_CH_AC7.nss
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: <description>
//:://////////////////////////////////////////////
//::
//:: Created By:
//:: Modified by:   Brent, April 3 2002
//::                Removed delay in respawning
//::                the henchman - caused bugs
//:://////////////////////////////////////////////

#include "nw_i0_generic"
#include "nw_i0_plot"
#include "sr_constants_inc"

void BringBack()
{
    SetLocalObject(OBJECT_SELF,"NW_L_FORMERMASTER", GetMaster());
    // : REMINDER: The delay is here   for a reason
    DelayCommand(0.1, RemoveEffects(OBJECT_SELF));
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectResurrection(), OBJECT_SELF));
    DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHeal(GetMaxHitPoints(OBJECT_SELF)), OBJECT_SELF));
    DelayCommand(5.1, SetIsDestroyable(TRUE, TRUE, TRUE));
    object oWay = GetObjectByTag("RaiseDead_WP");
    if (GetIsObjectValid(oWay) == TRUE)
    {
        // * if in Source stone area, respawn at opening to area
        if (GetTag(GetArea(OBJECT_SELF)) == "M4Q1D2")
        {
            DelayCommand(0.2, JumpToObject(GetObjectByTag("M4QD07_ENTER"), FALSE));
        }
        else
            DelayCommand(0.2, JumpToObject(oWay, FALSE));
        SendMessageToPC(GetMaster(), "Your henchman died and can be found in the chapel.");
    }
    else
        DelayCommand(0.3, ActionSpeakString("UT: No place to go"));


}
void main()
{
    // * This is used by the advanced henchmen
    // * Let Brent know if it interferes with animal
    // * companions et cetera
    if (GetIsObjectValid(GetMaster()) == TRUE)
    {
        object oMe = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster());
        if (oMe == OBJECT_SELF
            // * this is to prevent 'double hits' from stopping
            // * the henchmen from moving to the temple of tyr
            // * I.e., henchmen dies 'twice', once after leaving  your party
            || GetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED") == TRUE)
        {
           SetPlotFlag(oMe, TRUE);
           SetAssociateState(NW_ASC_IS_BUSY, TRUE);
//           AddJournalQuestEntry("Henchman", 99, GetMaster(), FALSE, FALSE, FALSE);
           SetIsDestroyable(FALSE, TRUE, TRUE);
           SetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED", TRUE);
       //     RemoveHenchman(GetMaster());
           // effect eRaise = EffectResurrection();
            ClearAllActions();
            DelayCommand(0.5, ActionDoCommand(SetCommandable(TRUE)));
            DelayCommand(5.0, ActionDoCommand(SetAssociateState(NW_ASC_IS_BUSY, FALSE)));

            DelayCommand(5.0, SetPlotFlag(oMe, FALSE));

            BringBack();
            SetCommandable(FALSE);


        }
        else
        // * I am a familiar, give 1d6 damage to my master
        if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, GetMaster()) == OBJECT_SELF) {
            object oMaster = GetMaster();
            // April 2002: Made it so that familiar death can never kill the player
            // only wound them.
            int nDam =d6();
            if (nDam >= GetCurrentHitPoints(oMaster))
                nDam = GetCurrentHitPoints(oMaster) - 1;
            effect eDam = EffectDamage(nDam);
            FloatingTextStrRefOnCreature(63489, oMaster, FALSE);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, oMaster);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oMaster, 6.0);

            int nXPPen = FAMDEATH * GetHitDice(oMaster);
            if (FortitudeSave(GetMaster(), 15)>0)
               nXPPen = FAMDEATH/2 * GetHitDice(oMaster);
            if (nXPPen > GetXP(oMaster))
               nXPPen = GetXP(oMaster);
            SetXP(oMaster, GetXP(oMaster) - nXPPen);
        } // Familiar Death
    }
}
