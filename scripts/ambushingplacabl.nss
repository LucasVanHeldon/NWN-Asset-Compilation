//:://////////////////////////////////////////////
//:: Ambushing Placable
//:: Created By: Tolkus the Loremaster
//:://////////////////////////////////////////////

void main()
{

  object oPC = GetEnteringObject();
  if (!GetIsPC(oPC)) return;
  string sAmbush = "An Ambush!";
  int nVisualEffectId = VFX_FNF_FIREBALL;
  int nMissEffect=FALSE;
  effect eEffect = EffectVisualEffect(nVisualEffectId, nMissEffect);
  object oCloset = GetNearestObjectByTag("TrollChest"); // change this to your custom placeable tag
  int nVoiceChatID = VOICE_CHAT_BATTLECRY3;
  int nObjectType = OBJECT_TYPE_CREATURE;
  string sTemplate = "TROLL001"; // change this to your creature tag (Blueprint ResRef)
  location oLoc = GetLocation(oCloset);

  if (GetObjectType(oCloset) == OBJECT_TYPE_PLACEABLE)
    {
      FloatingTextStringOnCreature(sAmbush, oPC, TRUE);
      ApplyEffectToObject (DURATION_TYPE_TEMPORARY, eEffect, oCloset, 1.0);
      DestroyObject(oCloset);

//      if (GetHitDice(oPC) >= 5 || GetFactionAverageXP(oPC) >= 3000) // change these values as appropriate
//        {
//          CreateObject(nObjectType,sTemplate,oLoc,TRUE);
//          CreateObject(nObjectType,sTemplate,oLoc,TRUE);
//        }
//      else
          {
            CreateObject(nObjectType,sTemplate,oLoc,TRUE);  //this creates object(what kind?Creature, what template?Troll, where?at the Chest, use appear animation?True)
          }
    }

}
