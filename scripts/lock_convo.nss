/*
   If not speaking to anyone
   Start default conversation file.
   OnUsed Placeable Event - Floor Lever
*/

string CheckLock(object oChest)
{
int iStatus = GetLocked(oChest);
    if (iStatus != TRUE)
    {
    string sLock = "Unlocked.";
    return sLock;
     }
    else
      {
       string sLock = "Locked.";
       return sLock;
       }

}
void main()
{
//string sLock;
object oPC = GetLastUsedBy();
if(IsInConversation(OBJECT_SELF)) return;
  object oChest = GetNearestObjectByTag("Locked");
    int iLock = GetLockLockDC(oChest);
    int iUnlock = GetLockUnlockDC(oChest);
    int iStatus = GetLocked(oChest);

       SetLocalObject(OBJECT_SELF, "Locked", oChest);
       SetLocalInt(OBJECT_SELF, "LockDC", iLock);
       SetLocalInt(OBJECT_SELF, "UnlockDC", iUnlock);
       SetCustomToken(101, IntToString(iLock));
       SetCustomToken(102, IntToString(iUnlock));
       SetCustomToken(103, CheckLock(oChest));
  if ( GetLocalInt( oChest, "Activated" ) == TRUE )
  {
    SetLocalInt( oChest, "Activated", FALSE );
    PlayAnimation( ANIMATION_PLACEABLE_DEACTIVATE );
    ActionStartConversation(oPC);
  }
  else
  {
    SetLocalInt( oChest, "Activated", TRUE );
    PlayAnimation( ANIMATION_PLACEABLE_ACTIVATE );
    ActionStartConversation(oPC);
  }
}
