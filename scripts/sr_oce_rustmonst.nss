#include "NW_I0_GENERIC"
// this will check to see if the object is metal or is partly metal
// returns 0 if no metal
// returns 1 if part metal
// returns 2 if mostly metal
// type 16 is armor and needs an extra check
int IsItemMetal(object oItem)
{
    int returnVal = 0;
    int type = GetBaseItemType(oItem);

    if((type<6)||type==9||type==10||type==12||type==13||type==17||type==18
            ||type==22||type==27||type==32||type==33||type==35||type==37||type==28
            ||type==40||type==41||type==42||type==47||type==51||type==52||type==53
            ||type==57||type==59||type==60||type==63||type==65||type==76)
        returnVal=2;// Mostly metal

    if(type==7||type==7||type==19||type==21||type==28||type==31
            ||type==44||type==45||type==46||type==56||type==62||type==78
            ||type==25||type==55||type==58)
        returnVal=1;// Part metal

    if(type==BASE_ITEM_ARMOR) { // this is type 16
        // see what kind of armor
        int ac=GetItemACValue (oItem);
        int limit=3;
        if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_AC_BONUS)) limit=5;
        if (ac>limit)
            returnVal=2;// mostly metal
    }
    return returnVal;
}

void main()
{
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
        DetermineSpecialBehavior();
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
       DetermineCombatRound();

    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));

    // do rust attack against attakee
    if(GetIsInCombat()) {
        string sItem;
        object oItem;
        int x;
        int isMetal;
        object oPC = GetAttackTarget();
        if(oPC == OBJECT_INVALID) oPC = GetAttemptedAttackTarget();
        if(oPC == OBJECT_INVALID || GetDistanceToObject(oPC) > 3.0) {
//            SpeakString("Can't find a target or target out of range!!");
        } else {
            //check slots in order for metal items
//            SpeakString("Target is "+GetName(oPC));
            for(x=0;x<13;x++) {
                oItem = GetItemInSlot(x,oPC);
                isMetal = IsItemMetal(oItem);
//                SpeakString("Item is "+GetName(oItem)+" ("+IntToString(isMetal)+")");
                if(isMetal!=0 && (d20()<16)) break;// got one
            }

            if(x<13) { // we got one
                sItem=GetName(oItem);
                SendMessageToPC(oPC, "The rust monster lashes out at your " + sItem);
                int iDestroy = TRUE;
                if (TouchAttackMelee(oPC) == 0) { // saved
                    iDestroy = FALSE;
                } else {
                    // no way to determine item base properties for enhancement, so giving all saves
                    if (ReflexSave(oPC, 15) > 0)
                        iDestroy=FALSE;
                }

                if (iDestroy) {
                    SendMessageToPC(oPC,"And destroys your "+sItem+"!!!" );
                    DestroyObject(oItem);
                    //VFX_COM_HIT_NEGATIVE
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_SPECIAL_RED_ORANGE),oPC);
                }
            } else {
//                SpeakString(GetName(oPC)+" has no metal");
            }
        }
    }
}
