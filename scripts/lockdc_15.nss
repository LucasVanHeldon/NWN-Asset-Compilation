void main()
{
object oChest = GetNearestObjectByTag("Locked");
 SetLockLockDC(oChest, 15);
 SetCustomToken(101, "15");
}
