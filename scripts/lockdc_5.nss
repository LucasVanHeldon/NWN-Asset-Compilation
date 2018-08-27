void main()
{
object oChest = GetNearestObjectByTag("Locked");
 SetLockLockDC(oChest, 5);
 SetCustomToken(101, "5");
}
