/*
   If not speaking to anyone
   Start default conversation file.
   OnUsed Placeable Event - Floor Lever
*/

void main()
{
//string sLock;
object oPC = GetLastUsedBy();
if(IsInConversation(OBJECT_SELF)) return;
  object oPercep = GetNearestObjectByTag("Percep");
int iListen = GetSkillRank(SKILL_LISTEN, oPercep);
int iSpot = GetSkillRank(SKILL_SPOT, oPercep);
       SetLocalObject(OBJECT_SELF, "Percep", oPercep);
       SetLocalInt(OBJECT_SELF, "Listen", iListen);
       SetLocalInt(OBJECT_SELF, "Spot", iSpot);
       SetCustomToken(104, IntToString(iListen));
       SetCustomToken(105, IntToString(iSpot));
  if ( GetLocalInt( oPercep, "Activated" ) == TRUE )
  {
    SetLocalInt( oPercep, "Activated", FALSE );
    PlayAnimation( ANIMATION_PLACEABLE_DEACTIVATE );
    ActionStartConversation(oPC);
  }
  else
  {
    SetLocalInt( oPercep, "Activated", TRUE );
    PlayAnimation( ANIMATION_PLACEABLE_ACTIVATE );
    ActionStartConversation(oPC);
  }
}
