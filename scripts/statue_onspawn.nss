//
//Creating Statues
//Date Last Modified: 06/24/02 12:13 AM
//By: Morgosha
//Modified By: JayAre on 09/16/03 10:31 PM
//

void main()
{
 // Target NPC
 object oTarget = OBJECT_SELF;

 // Don't want this wearing off now, do we?
 int nDurationType = DURATION_TYPE_PERMANENT;

 // Declare effect1, the Petrify.
 effect eEffect1 = EffectParalyze();

 // Declare effect2, the Paralyze. For some odd reason, in this module, the Petrify effect doesn't work right.
 effect eEffect2 = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);

 // Declare effect3, the Stoneskin effect. For some odd reason, in this module, the Petrify effect doesn't work right.
 effect eEffect3 = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);

 ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT);// Play Animation to get "life-like" poses
 DelayCommand(1.0,ApplyEffectToObject (nDurationType, eEffect1, oTarget));
 DelayCommand(1.0,ApplyEffectToObject (nDurationType, eEffect2, oTarget));
 DelayCommand(1.0,ApplyEffectToObject (nDurationType, eEffect3, oTarget));
 SetLocalInt(OBJECT_SELF, "X1_L_IMMUNE_TO_DISPEL", 10);

}
