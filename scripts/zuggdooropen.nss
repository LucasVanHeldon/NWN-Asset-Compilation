void main()
{
object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

if (GetLocalInt(oPC, "zuggdead")== 1)
   {
   object oTarget = GetObjectByTag("x2_doormed3");

   SetLocked(oTarget, FALSE);

   }
}
