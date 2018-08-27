void main()
{
object oChest = GetNearestObjectByTag("Locked");
 SetLockLockDC(oChest, 30);
 SetCustomToken(101, "30");
}
