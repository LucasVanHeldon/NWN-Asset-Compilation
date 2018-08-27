void main()
{
object oPC = GetLastUsedBy();
AssignCommand(oPC, ClearAllActions());
DelayCommand(05.0, AssignCommand(oPC, SpeakString("Look at me Dance Baby!", 5)));
DelayCommand(12.0, AssignCommand(oPC, SpeakString("...Do the twist again, Like we did last summer...", 5)));
DelayCommand(22.0, AssignCommand(oPC, SpeakString("Shake that Boogie... Oh Yeah!", 5)));

AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BARD_SONG), OBJECT_SELF, 20.0));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW, 0.5));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 0.5));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 0.5));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 0.5));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 0.5));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 0.5));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 0.5));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 0.5));
//SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
//SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
}

