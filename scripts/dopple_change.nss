void main()
{
    ClearAllActions ();
    location lDoppSpawnPoint = GetLocation(OBJECT_SELF); //So we know where to spawn the doppleganger
    SpeakString ("Your time is done, primate!",TALKVOLUME_TALK); //Talk smack
    EffectVisualEffect (VFX_IMP_HOLY_AID,FALSE); // Go out with a bang!
    DestroyObject (OBJECT_SELF,0.0);
    CreateObject (OBJECT_TYPE_CREATURE, "Doppleganger", lDoppSpawnPoint, TRUE);
}
